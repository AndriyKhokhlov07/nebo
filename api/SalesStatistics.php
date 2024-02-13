<?php


require_once('Backend.php');

class SalesStatistics extends Backend
{

	private $cache_dir = 'backend/view/statistics/sales_data/';
	private $cache_url;
	private $selected_month;
	private $params;



	public function get_stats($month, $year, $save_cache = false, $house_id = false)
	{
		if(empty($month) || empty($year))
			return false;

		$result = new stdClass;

		$n_month = new DateTime($year.'-'.$month.'-01');
		$strtotime_now = strtotime('now');

		if($year.'-'.$month == date('Y-m', $strtotime_now))
			$this->params->selected_month = 'now';
		elseif($n_month->getTimestamp() >  $strtotime_now)
			$this->selected_month = 'future';
		else
			$this->selected_month = 'past';


		$this->cache_url = $this->cache_dir.$year.'-'.$month.'.json';


		$created_by = $this->request->get('created_by', 'string');
		if(!empty($created_by))
		{
			$this->params->manager = $this->managers->get_manager($created_by);
		}



		if(file_exists($this->cache_url) && empty($this->params->manager) && empty($house_id))
		{
			$result->stats = json_decode(file_get_contents($this->cache_url));

			if(!empty($result->stats->bookings_ids))
			{
				$result->bookings = $this->beds->get_bookings([
					'id' => $result->stats->bookings_ids,
					'order_by' => 'b.created DESC, b.id DESC'
				]);
				if(!empty($result->bookings))
				{
					foreach($result->bookings as $k=>$b)
					{
						$b->u_arrive = strtotime($b->arrive);
				  		$b->u_depart = strtotime($b->depart);
				  		$b->days = round(($b->u_depart - $b->u_arrive) / (24 * 60 * 60)) + 1;
						$b->days_count = $b->days;


						if(date('Y-m', $b->u_arrive) == $year.'-'.$month)
							$b->arrive_this_month = true;

						$result->bookings[$k]->client_type = $this->users->get_client_type($b->client_type_id);
					}
				}
			}
		}
		else
		{
			$result = $this->init_stats($month, $year, $house_id);

			if($this->selected_month == 'past' && !empty($result->stats) && empty($house_id) && $save_cache == true)
			{
				$j_stats = json_encode($result->stats, JSON_NUMERIC_CHECK | JSON_PARTIAL_OUTPUT_ON_ERROR);
				if(!file_exists($this->cache_url))
				{
					$f = fopen($this->cache_url, 'w');
					fwrite($f, $j_stats);
					fclose($f);
				}
			}
		}
		return $result;

	}



	public function init_stats($month, $year, $house_id = false)
	{
		$result = (object)[
			'stats' => new stdClass,
			'bookings' => new stdClass
		];

		//$stats = new stdClass;

		$booking_patrams = [
			'status' => [
				// 2, // Payment Pending
				3  // Contract / Invoice
			],
			'client_type_not_id' => 5, // 5 - House Leader
			'not_to_key' => true,
			'created_month' => $month,
			'created_year' => $year,
			'order_by' => 'b.created DESC, b.id DESC',
			'sp_group' => true,
			'sp_group_from_start' => true
		];
		if (!empty($house_id)) {
			$booking_patrams['house_id'] = $house_id;
		}


		if(!empty($this->params->manager))
		{
			$booking_patrams['created_by'] = $this->params->manager->login;
			$result->created_by = $this->params->manager->login;
		}

		
		$result->bookings = $this->beds->get_bookings($booking_patrams);

		if(!empty($result->bookings))
		{
			// Bookings counts 

			$result->stats->bookings->new = 0;
			$result->stats->bookings->ext = 0;
			$result->stats->bookings->sum = 0;

			$result->stats->bookings->outpost->new = 0;
			$result->stats->bookings->outpost->ext = 0;
			$result->stats->bookings->outpost->sum = 0;
			
			$result->stats->bookings->corporate->new = 0;
			$result->stats->bookings->corporate->ext = 0;
			$result->stats->bookings->corporate->sum = 0;

			$result->stats->bookings->other->new = 0;
			$result->stats->bookings->other->ext = 0;
			$result->stats->bookings->other->sum = 0;


			// Beds

			$result->stats->beds->new = 0;
			$result->stats->beds->ext = 0;
			$result->stats->beds->sum = 0;

			$result->stats->beds->outpost->new = 0;
			$result->stats->beds->outpost->ext = 0;
			$result->stats->beds->outpost->sum = 0;
			
			$result->stats->beds->corporate->new = 0;
			$result->stats->beds->corporate->ext = 0;
			$result->stats->beds->corporate->sum = 0;

			$result->stats->beds->other->new = 0;
			$result->stats->beds->other->ext = 0;
			$result->stats->beds->other->sum = 0;


			// Money

			$result->stats->price->new = 0;
			$result->stats->price->ext = 0;
			$result->stats->price->sum = 0;

			$result->stats->price->outpost->new = 0;
			$result->stats->price->outpost->ext = 0;
			$result->stats->price->outpost->sum = 0;
			
			$result->stats->price->corporate->new = 0;
			$result->stats->price->corporate->ext = 0;
			$result->stats->price->corporate->sum = 0;

			$result->stats->price->other->new = 0;
			$result->stats->price->other->ext = 0;
			$result->stats->price->other->sum = 0;


			// Term

			$result->stats->term->new->short = 0;
			$result->stats->term->new->mid = 0;
			$result->stats->term->new->long = 0;

			$result->stats->term->ext->short = 0;
			$result->stats->term->ext->mid = 0;
			$result->stats->term->ext->long = 0;

			$result->stats->term->sum->short = 0;
			$result->stats->term->sum->mid = 0;
			$result->stats->term->sum->long = 0;


			$result->stats->term->outpost->new->short = 0;
			$result->stats->term->outpost->new->mid = 0;
			$result->stats->term->outpost->new->long = 0;

			$result->stats->term->outpost->ext->short = 0;
			$result->stats->term->outpost->ext->mid = 0;
			$result->stats->term->outpost->ext->long = 0;

			$result->stats->term->outpost->sum->short = 0;
			$result->stats->term->outpost->sum->mid = 0;
			$result->stats->term->outpost->sum->long = 0;
			
			
			$result->stats->term->corporate->new->short = 0;
			$result->stats->term->corporate->new->mid = 0;
			$result->stats->term->corporate->new->long = 0;

			$result->stats->term->corporate->ext->short = 0;
			$result->stats->term->corporate->ext->mid = 0;
			$result->stats->term->corporate->ext->long = 0;

			$result->stats->term->corporate->sum->short = 0;
			$result->stats->term->corporate->sum->mid = 0;
			$result->stats->term->corporate->sum->long = 0;


			$result->stats->term->other->new->short = 0;
			$result->stats->term->other->new->mid = 0;
			$result->stats->term->other->new->long = 0;

			$result->stats->term->other->ext->short = 0;
			$result->stats->term->other->ext->mid = 0;
			$result->stats->term->other->ext->long = 0;

			$result->stats->term->other->sum->short = 0;
			$result->stats->term->other->sum->mid = 0;
			$result->stats->term->other->sum->long = 0;



			$apartments_bookings = [];
			$bookings_apartments_ids = [];
			$apartments_ids = [];
			$result->stats->bookings_ids = [];
			foreach($result->bookings as $k=>$b)
			{
				$result->stats->bookings_ids[] = $b->id;
				if($b->type == 2) // booking: apartment
				{
					$apartments_ids[$b->object_id] = $b->object_id;
					$bookings_apartments_ids[$b->id] = $b->object_id;

					$apartments_bookings[$b->object_id]->bookings[$b->id] = $b->id;
				}
				$result->bookings[$k]->client_type = $this->users->get_client_type($b->client_type_id);
				$result->bookings[$k]->client_group = $this->users->getClientGroupByType($b->client_type_id);
			}
			if(!empty($apartments_bookings))
			{
				$rooms_filter = [];
				$rooms_filter['apartment_id'] = array_keys($apartments_ids);
				$rooms_filter['limit'] = 10000;
				
				$rooms = $this->beds->get_rooms($rooms_filter);
				$rooms_apartments = [];
				if(!empty($rooms))
				{
					$rooms_ids = [];
					foreach($rooms as $r)
					{
						$rooms_ids[] = $r->id;
						$rooms_apartments[$r->id] = $r->apartment_id;
					}


					$query = $this->db->placehold("SELECT
							b.room_id,
							count(*) as beds_count 
						FROM __beds b
						WHERE b.room_id in(?@)
						GROUP BY b.room_id;
					", $rooms_ids);

					$this->db->query($query);

					$beds_in_rooms = $this->db->results();

					if(!empty($beds_in_rooms))
					{
						
						foreach($beds_in_rooms as $br)
						{
							if(isset($apartments_bookings[$rooms_apartments[$br->room_id]]))
								$apartments_bookings[$rooms_apartments[$br->room_id]]->beds_count += $br->beds_count;
						}
					}
				}
			}


			foreach($result->bookings as $b)
			{	
				$b->u_arrive = strtotime($b->arrive);
		  		$b->u_depart = strtotime($b->depart);
		  		$b->days = round(($b->u_depart - $b->u_arrive) / (24 * 60 * 60)) + 1;
				$b->days_count = $b->days;


				if(date('Y-m', $b->u_arrive) == $year.'-'.$month)
					$b->arrive_this_month = true;


				if(!empty($b->arrive) && !empty($b->depart) && $b->price_month > 0 && $b->total_price < 1)
				{
					$price_calculate = $this->contracts->calculate($b->arrive, $b->depart, $b->price_month);
					if(!empty($price_calculate))
					{
						$b->total_price = $price_calculate->total; 
					}
				}


				$b_count = 1;
				if($b->type == 2) // booking: apartment
				{
					if(isset($apartments_bookings[$bookings_apartments_ids[$b->id]]))
					{
						if($apartments_bookings[$bookings_apartments_ids[$b->id]]->beds_count > 1)
							$b_count = $apartments_bookings[$bookings_apartments_ids[$b->id]]->beds_count;
					}
				}
				$b->days_count *= $b_count;
				
				// Not Parking
				if ($b->client_group->id != 6) {
					
					// not rider: early move in
					if ($b->sp_type != 3) {
					
						$result->stats->bookings->sum ++;
						$result->stats->beds->sum += $b->days_count;
						$result->stats->price->sum += $b->total_price;
					
						if ($b->parent_id == 0) // new
						{
							$result->stats->bookings->new ++;
							$result->stats->beds->new += $b->days_count;
							$result->stats->price->new += $b->total_price;
						}
						elseif ($b->sp_type == 1) // extention
						{
							$result->stats->bookings->ext ++;
							$result->stats->beds->ext += $b->days_count;
							$result->stats->price->ext += $b->total_price;
						}
					}

				
					if (in_array($b->client_group->id, [
						1, // outpost
						3, // hotel
						4, // houseleader
					])) {
						if($b->parent_id == 0) // new
						{
							$result->stats->bookings->outpost->new ++;
							$result->stats->beds->outpost->new += $b->days_count;
							$result->stats->price->outpost->new += $b->total_price;			
						}
						elseif ($b->sp_type == 1) // extention
						{
							$result->stats->bookings->outpost->ext ++;
							$result->stats->beds->outpost->ext += $b->days_count;
							$result->stats->price->outpost->ext += $b->total_price;		
						}
						// not rider: early move in
						if ($b->sp_type != 3) {
							$result->stats->bookings->outpost->sum ++;
							$result->stats->beds->outpost->sum += $b->days_count;
							$result->stats->price->outpost->sum += $b->total_price;
						}
					}
					// 3rd services (Airbnb, ...)
					elseif ($b->client_group->id == 2) {
						if($b->parent_id == 0) // new
						{
							$result->stats->bookings->other->new ++;
							$result->stats->beds->other->new += $b->days_count;	
							$result->stats->price->other->new += $b->total_price;	
						}
						elseif ($b->sp_type == 1) // extention
						{
							$result->stats->bookings->other->ext ++;
							$result->stats->beds->other->ext += $b->days_count;
							$result->stats->price->other->ext += $b->total_price;
						}
						// not rider: early move in
						if ($b->sp_type != 3) {
							$result->stats->bookings->other->sum ++;
							$result->stats->beds->other->sum += $b->days_count;
							$result->stats->price->other->sum += $b->total_price;
						}
					}
					// corporate
					elseif ($b->client_group->id == 5) {
						if($b->parent_id == 0) // new
						{
							$result->stats->bookings->corporate->new ++;
							$result->stats->beds->corporate->new += $b->days_count;
							$result->stats->price->corporate->new += $b->total_price;			
						}
						elseif ($b->sp_type == 1) // extention
						{
							$result->stats->bookings->corporate->ext ++;
							$result->stats->beds->corporate->ext += $b->days_count;
							$result->stats->price->corporate->ext += $b->total_price;		
						}
						// not rider: early move in
						if ($b->sp_type != 3) {
							$result->stats->bookings->corporate->sum ++;
							$result->stats->beds->corporate->sum += $b->days_count;
							$result->stats->price->corporate->sum += $b->total_price;
						}
					}
					


					if($b->days < 93)
					{
						if (in_array($b->client_group->id, [
							1, // outpost
							3, // hotel
							4, // houseleader
						])) {
							if($b->parent_id == 0) // new
								$result->stats->term->outpost->new->short ++;
							elseif ($b->sp_type == 1) // extention
								$result->stats->term->outpost->ext->short ++;

							// not rider: early move in
							if ($b->sp_type != 3) {
								$result->stats->term->outpost->sum->short ++;
							}
						}
						// 3rd services (Airbnb, ...)
						elseif ($b->client_group->id == 2) {
							if($b->parent_id == 0) // new
								$result->stats->term->other->new->short ++;
							elseif ($b->sp_type == 1) // extention
								$result->stats->term->other->ext->short ++;

							// not rider: early move in
							if ($b->sp_type != 3) {
								$result->stats->term->other->sum->short ++;
							}
						}
						// corporate
						elseif ($b->client_group->id == 5) {
							if($b->parent_id == 0) // new
								$result->stats->term->corporate->new->short ++;
							elseif ($b->sp_type == 1) // extention
								$result->stats->term->corporate->ext->short ++;

							// not rider: early move in
							if ($b->sp_type != 3) {
								$result->stats->term->corporate->sum->short ++;
							}
						}

						if($b->parent_id == 0) // new
							$result->stats->term->new->short ++;
						elseif ($b->sp_type == 1) // extention
							$result->stats->term->ext->short ++;

						// not rider: early move in
						if ($b->sp_type != 3) {
							$result->stats->term->sum->short ++;
						}
					}
					elseif($b->days < 365)
					{
						if (in_array($b->client_group->id, [
							1, // outpost
							3, // hotel
							4, // houseleader
						])) {
							if($b->parent_id == 0) // new
								$result->stats->term->outpost->new->mid ++;
							elseif ($b->sp_type == 1) // extention
								$result->stats->term->outpost->ext->mid ++;

							// not rider: early move in
							if ($b->sp_type != 3) {
								$result->stats->term->outpost->sum->mid ++;
							}
						}
						// 3rd services (Airbnb, ...)
						elseif ($b->client_group->id == 2) {
							if($b->parent_id == 0) // new
								$result->stats->term->other->new->mid ++;
							elseif ($b->sp_type == 1) // extention
								$result->stats->term->other->ext->mid ++;

							// not rider: early move in
							if ($b->sp_type != 3) {
								$result->stats->term->other->sum->mid ++;
							}
						}
						// corporate
						elseif ($b->client_group->id == 5) {
							if($b->parent_id == 0) // new
								$result->stats->term->corporate->new->mid ++;
							elseif ($b->sp_type == 1) // extention
								$result->stats->term->corporate->ext->mid ++;

							// not rider: early move in
							if ($b->sp_type != 3) {
								$result->stats->term->corporate->sum->mid ++;
							}
						}

						if($b->parent_id == 0) // new
							$result->stats->term->new->mid ++;
						elseif ($b->sp_type == 1) // extention
							$result->stats->term->ext->mid ++;
						
						// not rider: early move in
						if ($b->sp_type != 3) {
							$result->stats->term->sum->mid ++;
						}
					}
					else
					{
						if (in_array($b->client_group->id, [
							1, // outpost
							3, // hotel
							4, // houseleader
						])) {
							if($b->parent_id == 0) // new
								$result->stats->term->outpost->new->long ++;
							elseif ($b->sp_type == 1) // extention
								$result->stats->term->outpost->ext->long ++;
							// not rider: early move in
							if ($b->sp_type != 3) {
								$result->stats->term->outpost->sum->long ++;
							}
						}
						// 3rd services (Airbnb, ...)
						elseif ($b->client_group->id == 2) {
							if($b->parent_id == 0) // new
								$result->stats->term->other->new->long ++;
							elseif ($b->sp_type == 1) // extention
								$result->stats->term->other->ext->long ++;
							
							// not rider: early move in
							if ($b->sp_type != 3) {
								$result->stats->term->other->sum->long ++;
							}
						}
						// corporate
						elseif ($b->client_group->id == 5) {
							if($b->parent_id == 0) // new
								$result->stats->term->corporate->new->long ++;
							elseif ($b->sp_type == 1) // extention
								$result->stats->term->corporate->ext->long ++;
							
							// not rider: early move in
							if ($b->sp_type != 3) {
								$result->stats->term->corporate->sum->long ++;
							}
						}

						if($b->parent_id == 0) // new
							$result->stats->term->new->long ++;
						elseif ($b->sp_type == 1) // extention
							$result->stats->term->ext->long ++;

						// not rider: early move in
						if ($b->sp_type != 3) {
							$result->stats->term->sum->long ++;
						}

					}

				}

			}
			
			
			$result->stats->av_interv->outpost->new = round($result->stats->beds->outpost->new / $result->stats->bookings->outpost->new);
			$result->stats->av_interv->outpost->ext = round($result->stats->beds->outpost->ext / $result->stats->bookings->outpost->ext);
			$result->stats->av_interv->outpost->sum = round($result->stats->beds->outpost->sum / $result->stats->bookings->outpost->sum);

			$result->stats->av_interv->other->new = round($result->stats->beds->other->new / $result->stats->bookings->other->new);
			$result->stats->av_interv->other->ext = round($result->stats->beds->other->ext / $result->stats->bookings->other->ext);
			$result->stats->av_interv->other->sum = round($result->stats->beds->other->sum / $result->stats->bookings->other->sum);
			
			$result->stats->av_interv->corporate->new = round($result->stats->beds->corporate->new / $result->stats->bookings->corporate->new);
			$result->stats->av_interv->corporate->ext = round($result->stats->beds->corporate->ext / $result->stats->bookings->corporate->ext);
			$result->stats->av_interv->corporate->sum = round($result->stats->beds->corporate->sum / $result->stats->bookings->corporate->sum);

			$result->stats->av_interv->new = round($result->stats->beds->new / $result->stats->bookings->new);
			$result->stats->av_interv->ext = round($result->stats->beds->ext / $result->stats->bookings->ext);
			$result->stats->av_interv->sum = round($result->stats->beds->sum / $result->stats->bookings->sum);


			$result->stats->av_money->outpost->new = round($result->stats->price->outpost->new / $result->stats->bookings->outpost->new);
			$result->stats->av_money->outpost->ext = round($result->stats->price->outpost->ext / $result->stats->bookings->outpost->ext);
			$result->stats->av_money->outpost->sum = round($result->stats->price->outpost->sum / $result->stats->bookings->outpost->sum);

			$result->stats->av_money->other->new = round($result->stats->price->other->new / $result->stats->bookings->other->new);
			$result->stats->av_money->other->ext = round($result->stats->price->other->ext / $result->stats->bookings->other->ext);
			$result->stats->av_money->other->sum = round($result->stats->price->other->sum / $result->stats->bookings->other->sum);
			
			$result->stats->av_money->corporate->new = round($result->stats->price->corporate->new / $result->stats->bookings->corporate->new);
			$result->stats->av_money->corporate->ext = round($result->stats->price->corporate->ext / $result->stats->bookings->corporate->ext);
			$result->stats->av_money->corporate->sum = round($result->stats->price->corporate->sum / $result->stats->bookings->corporate->sum);

			$result->stats->av_money->new = round($result->stats->price->new / $result->stats->bookings->new);
			$result->stats->av_money->ext = round($result->stats->price->ext / $result->stats->bookings->ext);
			$result->stats->av_money->sum = round($result->stats->price->sum / $result->stats->bookings->sum);

		}

		return $result;

	}
}
