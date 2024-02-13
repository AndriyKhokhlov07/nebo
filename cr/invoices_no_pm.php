<?php
ini_set('error_reporting', E_ALL);


session_start();

chdir('..');
require_once('api/Backend.php');



class Test extends Backend
{
	function fetch()
	{

        $query = $this->db->placehold("SELECT 
                o.id,
                o.sku,
                o.date,
                o.payment_date,
                o.paid,
                o.type,
                o.contract_id,
				o.booking_id,
                o.total_price,
                c.sku as contract_sku,
                book.house_id as house_id
            FROM __orders AS o
            LEFT JOIN __contracts c ON c.id = o.contract_id
            LEFT JOIN __bookings book ON book.id = o.booking_id
            WHERE 
                (o.payment_method_id IS NULL OR o.payment_method_id=0)
                AND (o.date>='2021-09-01' AND o.date<'2022-03-01')
                AND (o.status=2 OR o.paid=1)
                AND book.client_type_id!=2
            GROUP BY o.id 
            ORDER BY o.date, o.id
        ");

		$this->db->query($query);
		$invoices = $this->db->results();
        $invoices = $this->request->array_to_key($invoices, 'id');

        if(!empty($invoices)) {
            $houses = Pages::getHouses();

            $invoices_types = $this->orders->types;

            foreach($houses as $h) {
                if(!empty($h->blocks2))
                    $h->blocks2 = unserialize($h->blocks2);
            }
            
            


            header("Content-type: text/csv"); 
            header("Content-Disposition: attachment; filename=invoices_no_pm.csv"); 
            header("Pragma: no-cache"); 
            header("Expires: 0"); 

            $buffer = fopen('php://output', 'w'); 

            fputs($buffer, chr(0xEF) . chr(0xBB) . chr(0xBF));


            $val = [
                'n' => '№',
                'id' => 'ID',
                'url' => 'Link',
                'type' => 'Type',
                'date' => 'Date',
                'price' => 'Price',
                // 'paid_deposit' => 'Paid by Deposit',
                'contract' => 'Contract',
                'booking' => 'Booking',
                'house_name' => 'House',
                'house_address' => 'Address'
            ];
            fputcsv($buffer, $val, ';'); 

            $n = 0;
            foreach($invoices as $i) {
                $n ++;
                if(!empty($i->house_id) && isset($houses[$i->house_id])) {
                    $house = $houses[$i->house_id];
                    $i->house_name = $house->name;
                    if(!empty($house->blocks2['address'])) {
                        $i->house_address = $house->blocks2['address'];
                    }  
                }
                $i->type_name = $invoices_types[$i->type]['name'];

                

                $contract_id = '-';
                if(!empty($i->contract_sku))
                    $contract_id = $i->contract_sku;
                elseif(!empty($i->contract_id))
                    $contract_id = $i->contract_id;


                $val = [
                    'n' => $n,
                    'id' => $i->sku ?? $i->id,
                    'url' => $this->config->root_url.'/backend/?module=OrderAdmin&id='.$i->id,
                    'type' => $i->type_name ?? '-',
                    'date' => $i->date ?? '-',
                    'price' => $i->total_price,
                    // 'paid_deposit' => $i->label>0?'Yes':'No',
                    'contract' => $contract_id,
                    'booking' => $i->booking_id ?? '-',
                    'house_name' => $i->house_name ?? '-',
                    'house_address' => $i->house_address ?? '-'
                ];


                fputcsv($buffer, $val, ';'); 



            }

            fclose($buffer);
		    exit;

        }		
		
	}
}


$test = new Test();
$test->fetch();
