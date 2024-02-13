<?php
ini_set('error_reporting', E_ALL);


// session_start();

chdir('../../');
require_once('api/Backend.php');



class Init extends Backend
{
	function fetch()
	{

        $housesIds = [
            159,  // The Downtown Brooklyn House
            248,  // The Montrose Williamsburg House
            464,
        ];





		$query = $this->db->placehold("SELECT 
					o.id,
					o.sku,
					b.house_id as house_id,
                    b.arrive as booking_arrive
				FROM __orders o
				LEFT JOIN __bookings AS b ON o.booking_id=b.id
				WHERE
					b.house_id in(?@)
				    AND o.status!=3
				    AND o.type in (1,7)
				    AND o.sku LIKE '-%'
				GROUP BY o.id
				ORDER BY b.house_id, o.booking_id, b.arrive, o.date_from, o.id
		", $housesIds);
		$this->db->query($query);

        if ($invoices = $this->db->results()) {
            $n = 0;

            if ($houses = $this->pages->get_pages($housesIds)) {
                $invoicesHouses = [];
                foreach($invoices as $invoice) {
                    $invoicesHouses[$invoice->house_id][$invoice->id] = $invoice;
                }


                foreach($houses as $house) {
                    if (!empty($invoicesHouses[$house->id])) {
                        $company_houses = current($this->companies->get_company_houses(array('house_id' => $house->id)));
                        $company = $this->companies->get_company($company_houses->company_id);
                        if (!empty($company)) {
                            $last_invoice_id = $house->last_invoice;


                            foreach ($invoicesHouses[$house->id] as $invoice) {
                                $house->last_invoice++;
                                $this->pages->update_page($house->id, [
                                    'last_invoice' => $house->last_invoice
                                ]);

                                $new_sku = date('y', strtotime($invoice->booking_arrive)) . '-' . str_pad($company->landlord_id, 2, "0", STR_PAD_LEFT) . '-' . str_pad($house->sku, 3, "0", STR_PAD_LEFT);

                                $new_sku .= '-' . str_pad($house->last_invoice, 4, "0", STR_PAD_LEFT);

                                $this->orders->update_order($invoice->id, [
                                    'sku' => $new_sku
                                ]);
                                $n++;
                                echo $n . '. Invoice ID: ' . $invoice->id . ' house ID: ' . $invoice->house_id . '  sku: "' . $invoice->sku . '" => "' . $new_sku . '"<br>';


                            }
                        }
                    }
                }
            }



        }
	}
}


$init = new Init();
$init->fetch();
