<?PHP

require_once('view/View.php');

class LandlordRentRollView extends View
{
	private $params;
	private $table;


	function fetch()
	{
		if(empty($this->user))
		{
			header("HTTP/1.1 301 Moved Permanently"); 
			header('Location: '.$this->config->root_url.'/user/login');
			exit();
		}

		if($this->user->type != 4)
			return false;

		$landlord = new stdClass;

		if(!empty($this->user->email))
		{
			if(!empty($this->user->main_info))
				$landlord->main_info = $this->user->main_info;

			$houses = [];
			$selected_house_id = $this->request->get('house_id', 'integer');
			$month = $this->request->get('month', 'string');
			$this->params->show_empty_rows = $this->request->get('sr', 'integer');




			/*$landlords_companies = $this->users->get_landlords_houses([
				'user_id' => $this->user->id
			]);
			$landlords_companies = $this->request->array_to_key($landlords_companies, 'house_id');

			if(!empty($landlords_companies))
			{
				// LLC
				$houses_ids = [];
				$this->params->companies = $this->companies->get_companies([
					'id' => array_keys($landlords_companies)
				]);
				$this->params->companies = $this->request->array_to_key($this->params->companies, 'id');
				if(!empty($this->params->companies))
				{
					$company_houses_ids = $this->companies->get_company_houses([
						'company_id' => array_keys($this->params->companies)
					]);
					$company_houses_ids = $this->request->array_to_key($company_houses_ids, 'house_id');

					if(!empty($company_houses_ids))
					{
						$houses_ids = array_keys($company_houses_ids);
					}
				}

			}
			elseif($this->user->id == 4714 || $this->user->id == 4715)
			{
				$houses_ids[] = 185; // The Central Park Manhattan House for owners
			}*/

			if(!empty($this->user->landlords_companies))
			{

			}
			elseif($this->user->id == 4714 || $this->user->id == 4715)
			{
				$this->user->houses_ids[] = 185; // The Central Park Manhattan House for owners
			}
			


			if(!empty($this->user->houses_ids))
			{
				$houses = $this->pages->get_pages([
					'id' => $this->user->houses_ids,
					'menu_id' => 5,
					'visible' => 1
				]);

				if(!empty($houses))
				{
					if(!empty($selected_house_id) && isset($houses[$selected_house_id]))
						$this->selected_house = $houses[$selected_house_id];
					else
						$this->selected_house = current($houses);

					$houses[$this->selected_house->id]->selected = 1;

				}

				if(!empty($this->selected_house))
				{
					if(!empty($this->selected_house->blocks2))
						$this->selected_house->blocks2 = unserialize($this->selected_house->blocks2);

					// LLC Name
					if(isset($this->user->companies[$this->user->company_houses_ids[$this->selected_house->id]->company_id]))
						$this->selected_house->llc_name = $this->user->companies[$this->user->company_houses_ids[$this->selected_house->id]->company_id]->name;
					/*
					if(!empty($this->selected_house->blocks2['contract_side']))
					{
						if($this->selected_house->blocks2['contract_side'] == $this->user->id)
							$this->selected_house->llc_name = $this->user->name;
						else{
							$llc = $this->users->get_user( (int)$this->selected_house->blocks2['contract_side']);
							if(!empty($llc))
								$this->selected_house->llc_name = $llc->name;
						}
					}
					*/

					$beds_ids = array();
					$bookings_beds = array();
					$bookings_ataprments = array();
					$beds_rooms_ids = array();
					$rooms = array();
					$bookings_users = array();


					$this->params->grand_total = new stdClass;
					// $this->params->grand_total->price_month_income = 0;
					// $this->params->grand_total->price_rent_month = 0;
					// $this->params->grand_total->price_rent_day = 0;
					$this->params->grand_total->price_invoices = 0;
					$this->params->grand_total->price_paid_invoices = 0;

					// Apartments
					$apartments = $this->beds->get_apartments(array(
						'house_id' => $this->selected_house->id,
						'visible' => 1,
						'sort' => 'name'
					));
					$apartments = $this->request->array_to_key($apartments, 'id');

					// Rooms
					$rooms_ = $this->beds->get_rooms(array(
						'house_id' => $this->selected_house->id
						//'visible' => 1
					));
					
					$rooms_apartments_ids = array();
					if(!empty($rooms_))
					{
						foreach($rooms_ as $r)
						{
							if(substr(trim($r->name), 0, 5) == 'Room ')
								$r->name = substr(trim($r->name), 5);


							
							if(!empty($r->apartment_id) && isset($apartments[$r->apartment_id]))
							{
								$apartments[$r->apartment_id]->rooms[$r->id] = $r;

								$rooms[$r->id] = $r;
								$apartments[$r->apartment_id]->rows ++;
								$rooms_apartments_ids[$r->id] = $r->apartment_id;
							}

							
						}
					}

					// Beds
					$beds = $this->beds->get_beds(array(
						'room_id' => array_keys($rooms)
					));
					if(!empty($beds))
					{
						foreach($beds as $b)
						{
							$beds_rooms_ids[$b->id] = $b->room_id;

							$apartment_id = $rooms[$b->room_id]->apartment_id;
							if(isset($apartments[$apartment_id]->rooms[$b->room_id]->beds))
							{
								$apartments[$apartment_id]->rows ++;
							}
							if(isset($apartments[$apartment_id]->rooms[$b->room_id]))
								$apartments[$apartment_id]->rooms[$b->room_id]->rows ++;

							$b->rows = 1;
							$apartments[$apartment_id]->rooms[$b->room_id]->beds[$b->id] = $b;

							$apartments[$apartment_id]->beds_count++;

						}
					}



					
					// $tr = [];

					// $tr['apartment']->name = $apartments[$apartment_id]->name;
					// $tr['room']->name = $rooms[$b->room_id]->name;
					// $tr['bed']->name = $b->name;

					// $this->table[] = $tr;
					$strtotime_now = strtotime('now');
					$strtotime_lastmonth = strtotime('- 1 month');

					if(!empty($month))
					{
						list($this->params->month, $this->params->year) = explode('-', $month);
					}
					else
					{
						$this->params->month = date("m", $strtotime_lastmonth);
						$this->params->year = date("Y", $strtotime_lastmonth);
					}

					$this->params->now_month = new DateTime($this->params->year.'-'.$this->params->month.'-01');


					$this->params->next_month = new DateTime($this->params->year.'-'.$this->params->month.'-01'); 
					$this->params->next_month->modify('+1 month');


					
					$this->params->prev_month = new DateTime($this->params->year.'-'.$this->params->month.'-01');
					$this->params->prev_month->modify('-1 month');


					if((int)$this->params->year < 2021 && (int)$this->params->month < 12)
						unset($this->params->prev_month);


					if(strtotime(date("Y-m", $strtotime_now).'-01') < $this->params->now_month->getTimestamp())
						unset($this->params->next_month);


					$this->params->days_in_month = date("t", strtotime($this->params->year.'-'.$this->params->month.'-01'));

					//$this->params->days_beds_count = $this->params->days_in_month * count($beds);


					$this->params->now_month_last_day = $this->params->year.'-'.$this->params->month.'-'.$this->params->days_in_month;

					if(strtotime($this->params->year.'-'.$this->params->month.'-01') > strtotime(date("Y-m", $strtotime_now).'-01'))
						$this->params->hide_debt = true;
					
					// $booking_patrams['date_from'] = $this->params->year.'-'.$this->params->month.'-01';
					// $booking_patrams['date_to'] = $this->params->now_month_last_day;


					// echo date("Y-m-t", strtotime($this->params->year.'-'.$this->params->month.'-01')); exit;

					// print_r($this->table); exit;





					// Invoices / Bookings

					$orders_params = [
						'house_id' => $this->selected_house->id,
						'date_from_month' => $this->params->month,
						'date_from_year' => $this->params->year,
						'or_paid_month' => true,
						'type' => 1,
						'deposit' => 0,
						'not_status' => 3,
						'limit' => 1000,
						'sort_date_from' => true
					];
					if(!$this->params->hide_debt)
						$orders_params['debt'] = true;

					$invoices = $this->orders->get_orders($orders_params);


					if(!empty($invoices))
					{

						$bookings_invoices_ids = [];
						$contracts_invoices_ids = [];
						foreach($invoices as $i)
						{
							if(!empty($i->booking_id))
								$bookings_invoices_ids[$i->booking_id][$i->id] = $i->id;

							if(!empty($i->contract_id))
								$contracts_invoices_ids[$i->contract_id][$i->id] = $i->id;
						}


						// Contracts
						if(!empty($contracts_invoices_ids))
						{
							$contracts = $this->contracts->get_contracts([
								'id' => array_keys($contracts_invoices_ids),
								'limit' => count($contracts_invoices_ids)
							]);

							if(!empty($contracts))
							{
								foreach($contracts as $c)
								{
									if(isset($contracts_invoices_ids[$c->id]))
									{
										foreach($contracts_invoices_ids[$c->id] as $invoice_id)
										{
											if(isset($invoices[$invoice_id]))
											{
												$invoices[$invoice_id]->contract = $c;
											}
										}
									}
								}
							}
						}



						// Bookings

						// Main rent roll invoices
						$beds_invoices = [];
						$apartments_invoices = [];


						// Other period invoices
						$other_period_invoices = [];
						$this->params->other_period_total->price = 0;
						$this->params->other_period_total->price_paid = 0;

						// debt invoices
						$debt_invoices = [];
						$this->params->debt_invoices->price = 0;



						if(!empty($bookings_invoices_ids))
						{
							//$bookings_count = count($bookings_invoices_ids);
							$bookings_ = $this->beds->get_bookings([
								'id' => array_keys($bookings_invoices_ids),
								'select_users' => true,
								//'limit' => ($bookings_count==1?2:$bookings_count)
								'sp_group' => true,
								'sp_group_from_start' => true
							]);

							$bookings = [];
							foreach($bookings_ as $k=>$b)
							{

								if($b->type == 1) // Booking type: Bed
								{
									$room_id = $beds_rooms_ids[$b->object_id];
									if(!empty($room_id))
									{
										$apartment_id = $rooms_apartments_ids[$room_id];
										if(!empty($apartment_id) && $b->apartment_id != $apartment_id)
											$b->apartment_id = $apartment_id;
									}
									if(isset($apartments[$b->apartment_id]))
									{
										$bookings[$k] = $b;
									}
									
								}
								elseif($b->type == 2) // Booking type: Apartment
								{
									if(isset($apartments[$b->object_id]))
									{
										$bookings[$k] = $b;
									}	
								}
							}

							//$this->design->assign('bookings', $bookings);

							foreach($bookings as $b)
							{
								if(isset($bookings_invoices_ids[$b->id]))
								{
									foreach($bookings_invoices_ids[$b->id] as $invoice_id)
									{
										if(isset($invoices[$invoice_id]))
										{
											$invoice = $invoices[$invoice_id];

											// days count
											$u_arrive = strtotime($b->arrive);
								            $u_depart = strtotime($b->depart);
								            $b_interval = $u_depart - $u_arrive;
											$b->days_count = round($b_interval / (24 * 60 * 60) + 1);



											if($b->client_type_id == 2 && $b->price_day > 0) // airbnb
											{
												$b->total_price = round($b->price_day * $b->days_count);
											}
											elseif(!empty($b->arrive) && !empty($b->depart) && $b->price_month > 0 && $b->total_price < 1)
											{
												$price_calculate = $this->contracts->calculate($b->arrive, $b->depart, $b->price_month);
												if(!empty($price_calculate))
												{
													$b->total_price = $price_calculate->total; 
												}
											}


											// new or not
											if($b->parent_id == 0) // not extension
											{
												// if(date("m-Y", $u_arrive) >= ($this->params->month.'-'.$this->params->year))
												// {
												// 	$b->new = true;
												// }


												if($invoice->date_from == $b->arrive)
												{
													$invoice->new = true;
												}
											}


											// paid month
											if($invoice->paid == 1 && substr(trim($invoice->payment_date), 0, 4) != '0000')
											{
												if(strtotime($this->params->now_month_last_day.' 23:59:59') < strtotime($invoice->payment_date))
													$invoice->paid_m = 'future';
												elseif($this->params->now_month->getTimestamp() > strtotime($invoice->payment_date))
													$invoice->paid_m = 'past';
												else
													$invoice->paid_m = 'this_month';
											}


											if(date('Y-m', strtotime($invoice->date_from.' 00:00:00')) == ($this->params->year.'-'.$this->params->month))
											{
												$invoice->month = 'this';
											}
											

											// 
											// $u_date_from = strtotime($invoice->date_from);


											/*
											// days in this month
											$bm_from = $u_arrive;
											if($u_arrive < $this->params->now_month->getTimestamp())
												$bm_from = $this->params->now_month->getTimestamp();

											$bm_to = $u_depart;
											if($u_depart > strtotime($this->params->now_month_last_day))
												$bm_to = strtotime($this->params->now_month_last_day);

											$b->days_in_month = round(($bm_to - $bm_from) / (24 * 60 * 60));

											if($b->days_in_month < 0)
												$b->days_in_month = 0;
											else
												$b->days_in_month ++;

											// commitment this month income
											$b->price_month_income = $b->days_in_month * $b->price_day;

											*/


											$invoice->booking = $b;


											if($b->type == 1) // booking: bed
											{
												$room_id = $beds_rooms_ids[$b->object_id];
												$apartment_id = $rooms[$room_id]->apartment_id;

												$b->room_id = $room_id;
												$b->apartment_id = $apartment_id;

												if(!empty($b->sp_bookings))
												{
													foreach($b->sp_bookings as $k=>$sp_booking)
													{
														$sp_booking->u_arrive -= 10;
														$sp_booking->arrive = date('Y-m-d', $b->sp_bookings[$k]->u_arrive);
														$sp_room_id = $beds_rooms_ids[$sp_booking->object_id];
														$sp_booking->room_id = $sp_room_id;
														$sp_booking->apartment_id = $rooms[$sp_room_id]->apartment_id;


														if($sp_booking->u_arrive <= $this->params->now_month->getTimestamp() && $sp_booking->u_depart >= strtotime($this->params->now_month_last_day.' 23:59:59'))
														{
															$b->object_id = $sp_booking->object_id;
															$b->room_id = $sp_booking->room_id;
															$b->apartment_id = $sp_booking->apartment_id;
														}

													}
												}
											}
											elseif($b->type == 2) // booking: bed
											{
												$apartment_id = $b->object_id;
											}


											if(!empty($apartment_id) && isset($apartments[$apartment_id]))
											{


												// Other period invoices
												// debt
												if($invoice->month != 'this')
												{
													
													
													if($b->type == 1) // booking: bed
													{
														$invoice->booking->room_id = $room_id;
														$invoice->booking->apartment_id = $apartment_id;
													}

													$opi_key = $invoice_id;
													if(!is_null($invoice->date_from))
														$opi_key = (strtotime($invoice->date_from)).$invoice_id;


													// debt
													if($invoice->paid == 0)
													{
														$debt_invoices[$opi_key] = $invoice;
														$this->params->debt_invoices->price += $invoice->total_price;
													}

													// Other period invoices
													else
													{
														$invoice->show_price = 0;
														$other_period_invoices[$opi_key] = $invoice;

														if($this->params->now_month->getTimestamp() < strtotime($invoice->date_from))
														{
															$invoice->show_price = 1;
															$this->params->other_period_total->price += $invoice->total_price;
														}
														$this->params->other_period_total->price_paid += $invoice->total_price;
													}



													
													
												}

												elseif($invoice->paid_m != 'past')
												{
													$adr_count = 1;
													if($invoice->type != 'houseleader')
														$this->params->grand_total->adr_sum += $b->price_day;


													if($b->type == 1) // booking: bed
													{

														$beds_invoices[$b->object_id][$invoice_id] = $invoice;

														// $room_id = $beds_rooms_ids[$b->object_id];
														// $apartment_id = $rooms[$room_id]->apartment_id;


														if(count($beds_invoices[$b->object_id]) > 1)
														{
															if(isset($apartments[$apartment_id]))
																$apartments[$apartment_id]->rows ++;

															if(isset($apartments[$apartment_id]->rooms[$room_id]) && isset($apartments[$apartment_id]->rooms[$room_id]->beds[$b->object_id]))
															{
																$apartments[$apartment_id]->rooms[$room_id]->rows ++;
															}

															if(isset($apartments[$apartment_id]->rooms[$room_id]->beds[$b->object_id]))
																$apartments[$apartment_id]->rooms[$room_id]->beds[$b->object_id]->rows = count($beds_invoices[$b->object_id]);

														}

														// $apartments[$apartment_id]->total_price_month_income += $b->price_month_income;
														// $apartments[$apartment_id]->total_rent_month_price += $b->price_month;

														// $apartments[$apartment_id]->total_rent_day_price += $b->price_day;
														if($invoice->month == 'this')
															$apartments[$apartment_id]->total_invices_price += $invoice->total_price;
														if($invoice->paid == 1 && (!isset($invoice->paid_m) || $invoice->paid_m == 'this_month'))
														{
															// $invoice->id .= '*'.$invoice->paid.'-'.$invoice->paid_m; 
															$apartments[$apartment_id]->total_invices_paid_price += $invoice->total_price;
														}
														
														// if(isset($bed_tr[$b->object_id]))
														// {
														// 	if(isset($this->table[$bed_tr[$b->object_id]]))
														// 	{
														// 		$this->table[$bed_tr[$b->object_id]]->invoices[$invoice_id] = $invoice;
														// 	}
														// }


													}
													elseif($b->type == 2) // booking: apartment
													{

														// $apartments[$b->object_id]->total_price_month_income += $b->price_month_income;
														// $apartments[$b->object_id]->total_rent_month_price += $b->price_month;
														// $apartments[$b->object_id]->total_rent_day_price += $b->price_day;

														if($invoice->month == 'this')
															$apartments[$b->object_id]->total_invices_price += $invoice->total_price;

														if($invoice->paid == 1)
														{
															if(!isset($invoice->paid_m) || $invoice->paid_m == 'this_month')
															{
																
																$apartments[$b->object_id]->total_invices_paid_price += $invoice->total_price;
															}
														}
														
														$adr_count = $adr_count * $apartments[$b->object_id]->beds_count;

														$apartments_invoices[$b->object_id][$invoice_id] = $invoice;
													}

													if($invoice->type != 'houseleader')
														$this->params->grand_total->adr_count += $adr_count;

													// $this->params->grand_total->price_month_income += $b->price_month_income;
													// $this->params->grand_total->price_rent_month += $b->price_month;
													// $this->params->grand_total->price_rent_day += $b->price_day;
													if($invoice->month == 'this')
														$this->params->grand_total->price_invoices += $invoice->total_price;

													if($invoice->paid == 1 && (!isset($invoice->paid_m) || $invoice->paid_m == 'this_month'))
													{
														$this->params->grand_total->price_paid_invoices += $invoice->total_price;
														$this->params->grand_total->paid_invoices_amount ++;
													}
												}

											}
										}
									}
								}
							}

							if(!empty($this->params->grand_total->adr_count))
							{
								$this->params->grand_total->adr_adv = round($this->params->grand_total->adr_sum / $this->params->grand_total->adr_count, 2);
							}

							$this->params->cost = $this->costs->get_costs([
						        'date_from' => $this->params->now_month->format('Y-m-d'),
						        'date_to' => $this->params->now_month->format('Y-m-d'),
						        'house_id' => $this->selected_house->id,
						        'type' => 9, // Expenses
						        'count' => 1
						    ]);

						    $this->params->net_operating_income = (round($this->params->grand_total->price_paid_invoices) + round($this->params->other_period_total->price_paid)) - $this->params->cost->price;



							// print_r($apartments); exit;

							/*foreach($this->table as $k=>$tr)
							{
								if(!isset($tr->invoices))
								{
									$this->table[$k]->invoices = [1];
								}
								else
								{
									if(count($this->table[$k]->invoices) > 1)
									{
										$this->table[$k]->apartment->rows += count($this->table[$k]->invoices) - 1;
										$this->table[$k]->room->rows += count($this->table[$k]->invoices) - 1;
										$this->table[$k]->bed->rows += count($this->table[$k]->invoices) - 1;
									}
								}
							}*/



						}


					}


					$this->table = [];
					$this->table_other_period = [];
					$this->table_debt = [];

					$apartment_tr = [];
					$room_tr = [];
					$bed_tr = [];
					$n = 1;

					// Main Rant Roll table
					foreach($apartments as $apartment_id=>$a)
					{
						// $apartment_name = $a->name;

						// $a->bookings_total_price = 0;


						if($apartments_invoices[$a->id])
						{
							$a->invoices = $apartments_invoices[$a->id];
							$a->rows += count($apartments_invoices[$a->id]);
						}

						if(isset($a->rooms))
						{
							$beds_count = 0;
							foreach($a->rooms as $r)
							{
								if(isset($r->beds))
								{
									foreach($r->beds as $b)
									{

										$beds_count ++;
										

										$tr = new stdClass;

										$tr->type = 'data';


										if($beds_invoices[$b->id])
										{
											$tr->invoices = $beds_invoices[$b->id];

											$apartments[$a->id]->rooms[$r->id]->beds_invoices_count += count($beds_invoices[$b->id]);
										}
										else
										{
											$tr->invoices = [1];

											if($this->params->show_empty_rows==0)
												$tr->empty = true;
										}
										

										$tr->apartment->id = $a->id;
										$tr->apartment->name = $a->name;


										if(!$tr->empty && !isset($apartment_tr[$a->id]))
											$apartment_tr[$a->id] = $n+1;

										if(!$tr->empty && !isset($room_tr[$a->id]))
											$room_tr[$r->id] = $n+1;
										// $tr->apartment->name = $a->name.' ('.$this->table[$n]->apartment->id.'-'.$a->id.')';

										if(isset($a->invoices))
											$tr->apartment->invoices = $a->invoices;

										if(
											$n > 0 && $this->table[$n]->type == 'data' && $this->table[$n]->apartment->id == $a->id
											// && $this->table[$n]->empty != true
										)
										{

											unset($tr->apartment->name);
											unset($tr->apartment->invoices);
										}




										// if($a->rows > 1)
											$tr->apartment->rows = $a->rows;

										$tr->room->id = $r->id;
										$tr->room->name = $r->name;
										//$tr->room->rows = 

										// if($r->rows > 1)
										 	$tr->room->rows = $r->rows;

										if($n > 0 && $this->table[$n]->type == 'data' && $this->table[$n]->room->id == $r->id 
											&& ($this->table[$n]->empty != true))
										{
											unset($tr->room->name);
										}


										if($tr->empty)
										{

											//$row_n_apartment = $this->RR('apartment', $n+1, $a->id);

											


											//if($this->table[$n]->apartment->id != $a->id)
											
											// $tr->apartment->rows --;


											// $tr->bed->name .= '||'.$row_n_apartment;

											// echo $row_n_apartment;
											// echo '
											// ';
											// echo $this->table[$row_n_apartment]->apartment->name;
											// $this->table[$row_n_apartment]->apartment->r +=1;


											$row_n_apartment = $apartment_tr[$a->id];

											if(isset($apartments[$apartment_id]))
												$apartments[$apartment_id]->rows --;

											if(isset($this->table[$row_n_apartment]->apartment))
											{
												$this->table[$row_n_apartment]->apartment->rows --;
											}


											$row_n_room = $room_tr[$r->id];
											if(isset($apartments[$a->id]->rooms[$r->id]))
												$apartments[$a->id]->rooms[$r->id]->rows --;

											if(isset($this->table[$row_n_room]->room))
											{
												$this->table[$row_n_room]->room->rows --;
											}


											
											//$a->rows --;
											//$a->room->rows --;
										}
										
										// if($this->table[$n]->type == 'data' && $this->table[$n]->room->id == $r->id && $this->table[$n]->empty == true)
										// {
										// 	$this->table[$n]->apartment->rows --;
										// 	$this->table[$n]->rows --;
										// }



										$tr->bed->id = $b->id;
										$tr->bed->name = $b->name;
										$tr->bed->rows = $b->rows;




										$bed_tr[$b->id] = $n;


										if(!$tr->empty)
										{
											$n++;
											$this->table[$n] = $tr;
											
										}
									}
								}
							}


							/*if($this->table[$n]->type == 'total' || $n==1)
							{
								$tr = new stdClass;
								$tr->type = 'data';
								$tr->apartment->name = $a->name;
								$tr->room->name = ' ';
								$tr->bed->name = ' ';
								$tr->invoices = [
									1 => (object)[
										'booking' => (object)[
											'users' => [
												1 => (object)[
													'name' => 'Empty'
												]
											]
										]
									]
								];
								$n++;
								$this->table[$n] = $tr;
							}*/

							if(($this->table[$n]->type == 'total' || $n==1) && isset($a->invoices))
							{
								$tr = new stdClass;
								$tr->apartment->id = $a->id;
								$tr->apartment->name = $a->name;
								$tr->apartment->invoices = $a->invoices;
								$tr->apartment->rows = count($a->invoices);
								$n++;
								$this->table[$n] = $tr;
							}

							
							if(($this->table[$n]->type != 'total' && $n>1) || isset($a->invoices))
							{
								

								$tr_total = new stdClass;
								$tr_total->booking = new stdClass;
								// $tr_total->booking->price_month_income = $a->total_price_month_income;
								// $tr_total->booking->price_month = $a->total_rent_month_price;
								// $tr_total->booking->price_day = $a->total_rent_day_price;
								$tr_total->total_price = $a->total_invices_price;
								$tr_total->month = 'this';
								$tr_total->paid = 1;
								$tr_total->paid_m = 'this_month';

								if($a->total_invices_paid_price > 0)
								{
									
									$tr_total->total_paid_price = $a->total_invices_paid_price;
								}
								

								$tr = new stdClass;
								$tr->type = 'total';
								$tr->class = 'tr_total';
								$tr->apartment->name = 'Total';
								$tr->room->name = count($a->rooms);
								$tr->bed->name = $beds_count;
								$tr->invoices = [
									1 => $tr_total
								];

								// $tr->price_month = $a->total_rent_month_price;
								$n++;
								$this->table[$n] = $tr;

							}

							
							
						}



					}




					// Occupancy

					$this->params->days_beds_count = 0;

					$booking_patrams = [
						'house_id' => $this->selected_house->id,
						// 'is_due' => true,
						'status' => 3, // 2 - Payment Pending, 3 - Contract / Invoice
						'order_by' => 'b.depart',
						'date_from2' => $this->params->year.'-'.$this->params->month.'-01',
						'date_to2' => $this->params->now_month_last_day
					];
					$bookings_ = $this->beds->get_bookings($booking_patrams);
					if(!empty($bookings_))
					{
						$bookings = [];
						foreach($bookings_ as $k=>$b)
						{

							if($b->type == 1) // Booking type: Bed
							{
								$room_id = $beds_rooms_ids[$b->object_id];
								if(!empty($room_id))
								{
									$apartment_id = $rooms_apartments_ids[$room_id];
									if(!empty($apartment_id) && $b->apartment_id != $apartment_id)
										$b->apartment_id = $apartment_id;
								}
								if(isset($apartments[$b->apartment_id]))
								{
									$bookings[$k] = $b;
								}
								
							}
							elseif($b->type == 2) // Booking type: Apartment
							{
								if(isset($apartments[$b->object_id]))
								{
									$bookings[$k] = $b;
								}	
							}
						}

						
						//$this->params->occupancy_bdays = 0;
						foreach($bookings as $b)
						{
							$u_arrive = strtotime($b->arrive);
				            $u_depart = strtotime($b->depart);

							$bm_from = $u_arrive;
							if($u_arrive < $this->params->now_month->getTimestamp())
								$bm_from = $this->params->now_month->getTimestamp();

							$bm_to = $u_depart;
							if($u_depart > strtotime($this->params->now_month_last_day))
								$bm_to = strtotime($this->params->now_month_last_day);


							$b->month_days = round(($bm_to - $bm_from) / (24 * 60 * 60)) + 1;
							//$b->month_bdays = (int)$b->month_days;


							// if($b->type == 2) // Booking: Apartment
							// {
							// 	$b->month_bdays *= (int)$apartments[$b->object_id]->beds_count;
							// }
							// $this->params->occupancy_bdays += $b->month_bdays;
						}


						// $this->params->days_beds_count = $this->params->days_in_month * count($beds);


						// Beds-deys count
						/*
						$this->params->u_from = $this->params->now_month->getTimestamp();
						$this->params->u_to = strtotime($this->params->now_month_last_day);

						$u_from = $this->params->now_month->getTimestamp();
						$u_to = strtotime($this->params->now_month_last_day);

						if(!empty($apartments))
						{
							foreach($apartments as $a)
							{
								$a_d_count = null;

								$a_days = $this->beds->calculate_bedsdays($a->date_added, $a->date_shutdown, $a->visible, $u_from, $u_to);

								if(!empty($a_days))
								{
									if($a_days->d_count !== 0 && !empty($a->rooms))
									{
										foreach($a->rooms as $r)
										{
											$r_days = $this->beds->calculate_bedsdays($r->date_added, $r->date_shutdown, $r->visible, $a_days->from, $a_days->to);

											if($r_days->d_count !== 0 && !empty($r->beds))
											{
												foreach($r->beds as $b)
												{
													$b_days = $this->beds->calculate_bedsdays($b->date_added, $b->date_shutdown, $b->visible, $r_days->from, $r_days->to);

													if($b_days->d_count !== 0)
														$this->params->days_beds_count += $b_days->d_count;
												}
											}
										}
									}
								}
							}
						}

						$this->params->occupancy = ceil($this->params->occupancy_bdays / $this->params->days_beds_count * 100);

						if($this->params->occupancy > 100)
							$this->params->occupancy = 100;

						*/

						// Occupancy
						$occupancy = $this->occupancy->init_occupancy([
							'house_id' => $this->selected_house->id,
							'month' => $this->params->month,
							'year'  => $this->params->year,
							'landlord_view' => 1
						]);
						$this->design->assign("occupancy", $occupancy);

					}





					$this->design->assign('table', $this->table);

					$this->design->assign('apartments', $apartments);

					ksort($other_period_invoices);
					$this->design->assign('other_period_invoices', $other_period_invoices);


					ksort($debt_invoices);
					$this->design->assign('debt_invoices', $debt_invoices);

					// print_r($apartments); exit;

				}
			}
		}


		$meta_title = 'Rent Roll';
		if(!empty($this->selected_house))
			$meta_title .= ' | '.$this->selected_house->name;
		$this->design->assign('meta_title', $meta_title);

		//print_r($this->selected_house); exit;

		$this->design->assign('houses', $houses);
		$this->design->assign('selected_house', $this->selected_house);
		$this->design->assign('landlord', $landlord);
		$this->design->assign('params', $this->params);

		return $this->design->fetch('landlord/rentroll.tpl');
	}
}
