<?php

use Libs\DBHelper\Schema;
use Models\Log;
use Models\ExternalLog;
use Models\Sure;

class Migration_20230628_103326
{
    use Schema;

    public function up(): void
    {
        $logs = Log::queryBuilder()
            ->where('type', '=', 100)
            ->andWhere('subtype', '=', 100)
            ->get();
        foreach ($logs->getItems() as $item){

            if(preg_match('/\srequest data$/', $item->value)){
                $log = ExternalLog::create([
                    'method'        => 'POST',
                    'user_id'       => $item->user_id,
                    'provider'      => ExternalLog::PROVIDER_SURE,
                    'url'           => preg_replace('/\srequest data$/', '', $item->value),
                    'request'  => [
                        'content_type'  => ExternalLog::CONTENT_TYPE_JSON,
                        'data'          => $item->data
                    ],
                    'created_at'    => date($item->date),
                ]);
                $requestLog = $log;
            }elseif(preg_match('/\sresponse data$/', $item->value)){
                $dataFieldName = !isset($item->data->error) ? 'response' : 'error';

                if(
                    !empty($requestLog)
                    && preg_replace('/\sresponse data$/', '', $item->value) === $requestLog->url
                    && (strtotime($item->date) - strtotime($requestLog->created_at)) < 5
                ){
                    $requestLog->{$dataFieldName} = [
                        'content_type'  => ExternalLog::CONTENT_TYPE_JSON,
                        'data'          => $item->data,
                    ];
                    $requestLog->created_at = $item->date;
                    $requestLog->save();
                }else{
                    $requestLog = null;
                    ExternalLog::create([
                        'method'        => 'POST',
                        'user_id'       => $item->user_id,
                        'provider'      => ExternalLog::PROVIDER_SURE,
                        'url'           => preg_replace('/\sresponse data$/', '', $item->value),
                        $dataFieldName  => [
                            'content_type'  => ExternalLog::CONTENT_TYPE_JSON,
                            'data'          => $item->data,
                        ],
                        'created_at'    => date($item->date),
                    ]);
                }
            }
        }
    }

    public function down(): void
    {
        self::addRawSql('truncate table s_external_requests_logs;');
    }
}