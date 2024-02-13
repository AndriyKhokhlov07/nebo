<?php

namespace Models;

use Libs\DBHelper\Model;

class ExternalLog extends Model
{

    protected static string $table = '__external_logs';

    protected array $casts = [
        'request'  => 'object',
        'response' => 'object',
        'error'    => 'object',
        'created_at'    => 'datetime',
    ];

    const CONTENT_TYPE_JSON = 'json';
    const CONTENT_TYPE_XML = 'xml';
    const CONTENT_TYPE_UNKNOWN = 'unknown';

    const PROVIDER_SURE         = 1;
    const PROVIDER_QIRA         = 2;
    const PROVIDER_TRANSUNION   = 3;
    const PROVIDERS = [
        self::PROVIDER_SURE         => 'Sure',
        self::PROVIDER_QIRA         => 'Qira',
        self::PROVIDER_TRANSUNION   => 'TransUnion',
    ];

    public static function createLog(
        ?int $user_id,
        int $provider,
        string $method,
        string $url,
        $statusCode,
        $request,
        $response,
        $exception = null,
        ?object $additional = null
    ) :int
    {
        $getContentType = function($content){
            if(is_array($content)){
                return self::CONTENT_TYPE_JSON;
            }
            if(simplexml_load_string($content)){
                return self::CONTENT_TYPE_XML;
            }
            return self::CONTENT_TYPE_UNKNOWN;
        };

        $requestData = null;
        if(gettype($request) === 'object'){
            $requestData = $request->content;
            $incomingIp = $request->ip();
        }elseif (is_array($request)){
            $requestData = $request;
        }
        $responseData = null;
        if(gettype($response) === 'object'){
            $responseData = $response->content;
        }elseif ($response instanceof stdClass){
            $responseData = $response->json();
        }
        if($exception && is_object($exception)){
            $exception = [
                'content_type' => self::CONTENT_TYPE_JSON,
                'data' => [
                    'message' => $exception->getMessage(),
                    'file' => $exception->getFile(),
                    'line' => $exception->getLine(),
                    'trace' => $exception->getTrace(),
                ],
            ];
        }
        $log = ExternalLog::create([
            'user_id' => $user_id,
            'provider' => $provider,
            'method' => strtoupper($method),
            'url' => $url,
            'status_code' => $statusCode,
            'request' => [
                'content_type'  => $getContentType($requestData),
                'data'          => $requestData
            ],
            'response' => [
                'content_type'  => $getContentType($responseData),
                'data'          => $responseData
            ],
            'exception' => $exception,
            'additional' => $additional,
        ]);

        return $log->id;
    }

    public static function getLogs(array $params = []): array
    {
        $perPage = !empty($params['rec_per_page']) ? (int)$params['rec_per_page'] : 50;
        $page = !empty($params['page']) ? (int)$params['page'] : 1;

        $query = ExternalLog::queryBuilder();
        if(!empty($params['select'])){
            $query->select($params['select']);
        }
        if(!empty($params['date_from'])){
            $query->where('created_at', '>=', $params['date_from']);
        }
        if(!empty($params['date_to'])){
            $query->where('created_at', '<=', $params['date_to']);
        }
        if(!empty($params['method'])){
            $query->where('method', '=', $params['method']);
        }
        if(!empty($params['provider'])){
            $query->where('provider', '=', $params['provider']);
        }
        if(!empty($params['user_id'])){
            $query->where('user_id', '=', $params['user_id']);
        }

        $query->offset($perPage * ($page - 1));
        $query->limit($perPage);
        $query->order('id desc');

        return [
            'pagination' => [
                'rec_per_page' => $perPage,
                'current_page' => $page,
                'total_rec_count' => $query->count(),
            ],
            'data' => $query->get()->toArray(),
        ];
    }
}