<?php


require_once('Backend.php');

class Prebookings extends Backend
{

    public $params;
    public $prebookings_statuses;
    public $prebookings_types;

    public function __construct() {
        $this->params = new stdClass;
        $this->params->prebookings_on_page = 20;


        // Statuses
        $this->prebookings_statuses = [
            1 => (object) [
                'id' => 1,
                'name' => 'New / Inquiry'
            ],
//            2 => (object) [
//                'id' => 2,
//                'name' => 'Booking is being created'
//            ],
            3 => (object) [
                'id' => 3,
                'name' => 'Pending / Pre-Approve'
            ],
            4 => (object) [
                'id' => 4,
                'name' => 'Approve / Confirm'
            ],
            9 => (object) [
                'id' => 9,
                'name' => 'Canceled'
            ]
        ];

        // Types
        $this->prebookings_types = [
            1 => (object) [
                'id' => 1,
                'name' => 'Guesty'
            ]
        ];
    }

    public function getPrebookingStatusByReservationStatus($reservation_status) {
        switch ($reservation_status) {
            // Approve / Confirm
            case 'confirmed':
                $prebooking_status = $this->prebookings_statuses[4];
                break;

            // Pending / Pre-Approve
            case 'inquiry':
            case 'reserved':
            case 'awaiting_payment':
                $prebooking_status = $this->prebookings_statuses[3];
                break;

            // New / Inquiry
            case 'new':
                $prebooking_status = $this->prebookings_statuses[1];
                break;

            // Cancel
            case 'canceled':
            case 'declined':
            case 'closed':
                $prebooking_status = $this->prebookings_statuses[9];
                break;

            default:
                $prebooking_status = false;
        }
        return $prebooking_status;
    }


	public function get_prebookings($params = [])
	{
		$limit = $this->params->prebookings_on_page;
		$page = 1;


		if(isset($params['limit']))
			$limit = max(1, intval($params['limit']));

		if(isset($params['page']))
			$page = max(1, intval($params['page']));

		$sql_limit = $this->db->placehold(' LIMIT ?, ? ', ($page-1)*$limit, $limit);

        if (isset($params['count']) && $params['count'] == 1) {
            $sql_limit = 'LIMIT 1';
        }

		$order_by = 'p.id DESC';


		$status_filter = '';
		if (!empty($params['status']))
			$status_filter = $this->db->placehold('AND p.status in(?@)', (array)$params['status']);
		elseif (!empty($params['not_status']))
			$status_filter = $this->db->placehold('AND p.status NOT in(?@)', (array)$params['not_status']);


        $id_filter = '';
        if (!empty($params['id']))
            $id_filter = $this->db->placehold('AND p.id in(?@)', (array)$params['id']);


		$reservation_id_filter = '';
		if (!empty($params['reservation_id']))
			$reservation_id_filter = $this->db->placehold('AND p.reservation_id in(?@)', (array)$params['reservation_id']);

        $house_id_filter = '';
        $houses_join = '';
        if (!empty($params['house_id'])) {
            $houses_join = $this->db->placehold('LEFT JOIN __pages h ON h.id=p.house_id');
            $house_id_filter = $this->db->placehold('AND ( ((p.booking_id=0 OR p.booking_id IS NULL) AND p.house_id in(?@)) OR (p.booking_id IS NOT NULL AND p.booking_id>0 AND h.id in(?@) AND h.menu_id=5))', (array)$params['house_id'], (array)$params['house_id']);

            $house_id_filter = $this->db->placehold('AND ( p.house_id in(?@) OR (p.booking_id>0 AND h.id in(?@) AND h.menu_id=5))', (array)$params['house_id'], (array)$params['house_id']);
        }

        $search_filter = '';
        if (!empty($params['search'])) {
            $search_filter = $this->db->placehold('AND p.guest_name LIKE "%'.$this->db->escape(trim($params['search'])).'%"');
        }

        $sql_group_by = "GROUP BY p.id";
        $sql_order_by = "ORDER BY $order_by";

        if (isset($params['query']) && $params['query'] == 'count') {
            // $sql_select = "COUNT(DISTINCT p.id) as count";
            $sql_select = "p.id";
            $sql_order_by = '';
            $sql_limit = '';
        } elseif (!empty($params['selest'])) {
            $sql_select = $params['selest'];
        } else {
            $sql_select = "
                p.*
            ";
        }

		$query = $this->db->placehold("SELECT 
                $sql_select
            FROM __prebookings AS p
                $houses_join
            WHERE 1
                $id_filter
                $status_filter
                $reservation_id_filter
                $house_id_filter
                $search_filter
            $sql_group_by
            $sql_order_by 
            $sql_limit");

        $this->db->query($query);

        if (isset($params['query']) && $params['query'] == 'count') {
            $result = $this->db->results();
            return ($result ? count($result) : 0);
        }

        if ($prebookings = $this->db->results()) {
            $prebookings = $this->request->array_to_key($prebookings, 'id');
            foreach ($prebookings as $k=>$pb) {
                if (!empty($pb->invoice_items)) {
                    $pb->invoice_items = json_decode($pb->invoice_items);
                }
                if (!empty($pb->payments)) {
                    $pb->payments = json_decode($pb->payments);
                }
                if (isset($this->prebookings_statuses[$pb->status])) {
                    $pb->status = $this->prebookings_statuses[$pb->status];
                }

                // Pending
                if (is_null($pb->reservation_status) && $pb->status->id == 3) {
                    $pb->reservation_status = '';
                }
                if (!is_null($pb->reservation_status)) {
                    $pb->status_from_reservation = $this->getPrebookingStatusByReservationStatus($pb->reservation_status);
                }
                if (isset($this->prebookings_types[$pb->type])) {
                    $pb->type = $this->prebookings_types[$pb->type];
                }
                $pb->booking_type = $this->beds->get_booking_type($pb->booking_type);

                if (!empty($params['null_to_empty'])) {
                    foreach ($pb as $pb_name=>$pb_val) {
                        $pb->$pb_name = is_null($pb_val) ? '' : $pb_val;
                    }
                }
            }
        }

		if (isset($params['count']) && $params['count'] == 1) {
			return current($prebookings);
		}
        return $prebookings;
	}


	public function count_prebookings($params)
	{
        $params = (array) $params;
        $params['query'] = 'count';
		return $this->get_prebookings($params);
	}


	public function add_prebooking($data) {
		$data = (array)$data;

		if (empty($data['reservation_id']))
			return false;

		$count_pb = $this->count_prebookings([
			'reservation_id' => $data['reservation_id']
		]);
		if($count_pb > 0)
			return false;


		$set_curr_date = '';
		if(empty($data['created']))
			$set_curr_date = ', created=now()';

		if (!empty($data['invoice_items'])) {
            $data['invoice_items'] = json_encode($data['invoice_items']);
        } else {
            $data['invoice_items'] = null;
        }

		if (!empty($data['payments'])) {
            $data['payments'] = json_encode($data['payments']);
        } else {
            $data['payments'] = null;
        }

		$query = $this->db->placehold("INSERT INTO __prebookings SET ?%$set_curr_date", $data);

		if(!$this->db->query($query))
			return false;

		$id = $this->db->insert_id();

        if (!empty($id)) {
            // Add log
            $this->logs->add_log([
                'parent_id' => $id,
                'type' => 23, // Prebookings
                'subtype' => 1, // Create
                'sender_type' => 1 // System
            ]);
        }

		return $id;
	}


	public function update_prebookings($id, $data)
	{
		$data = (array)$data;

		if(!empty($data['invoice_items']))
			$data['invoice_items'] = json_encode($data['invoice_items']);

		if(!empty($data['payments']))
			$data['payments'] = json_encode($data['payments']);

		$query = $this->db->placehold('UPDATE __prebookings SET ?% WHERE id in (?@)', $data, (array)$id);
		if(!$this->db->query($query))
			return false;
		return $id;
	}

}
