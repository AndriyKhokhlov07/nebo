<?php
// ini_set('error_reporting', E_ALL);
chdir ('../../');

session_start();
require_once('api/Backend.php');


class CallbackGuesty extends Backend
{
	public function fetch()
	{
		$postData = file_get_contents('php://input');

		if(!empty($postData))
		{
			$data = json_decode($postData, false);

			if ($data->event == 'reservation.new' && !empty($data->reservation)) {
				$reservation = new stdClass;

				$reservation->reservation_id = $data->reservation->id;
                if ($data->reservation->integration->platform == 'airbnb2' && $data->reservation->integration->airbnb2->status == 'active') {
				 	// $reservation->airbnb_id =  $data->reservation->integration->_id;
                }
				$reservation->arrive = $data->reservation->checkInDateLocalized;
				$reservation->depart = $data->reservation->checkOutDateLocalized;

				$reservation->days = $data->reservation->nightsCount;


				$houses = $this->pages->get_pages([
					'menu_id' => 5, // houses
					'not_parent_id' => 0,
					'visible' => 1
				]);

				$houses_address = [];
				foreach ($houses as $house) {
					$house->blocks2 = unserialize($house->blocks2);

					if (!empty($house->blocks2['address'])) {
						$k = trim($house->blocks2['postal']);

                        $houses_address[$k][$house->id] = trim($house->blocks2['address']);
					}
				}

				if (!empty($data->reservation->listing->address->zipcode) && isset($houses_address[$data->reservation->listing->address->zipcode])) {

					if (count($houses_address[$data->reservation->listing->address->zipcode]) == 1) {
						$reservation->house_id = array_keys($houses_address[$data->reservation->listing->address->zipcode])[0];
					} else {
						$selected_house = new stdClass;

						foreach($houses_address[$data->reservation->listing->address->zipcode] as $house_id=>$house_address)
						{

							$sim = similar_text($data->reservation->listing->address->full, $house_address, $perc);
							if(empty($selected_house) || $selected_house->perc < $perc)
							{
								$selected_house->perc = $perc;
								$selected_house->id = $house_id;
							}
						}
						$reservation->house_id = $selected_house->id;
					}

                    $reservation->listing_house_address = $data->reservation->listing->address->full;
				}

				if(!empty($data->reservation->guest->firstName) && !is_null($data->reservation->guest->firstName)) {
                    $reservation->guest_first_name = $data->reservation->guest->firstName;
                    $reservation->guest_name = $reservation->guest_first_name;
                }


				if(!empty($data->reservation->guest->lastName) && !is_null($data->reservation->guest->lastName)) {
                    $reservation->guest_last_name = $data->reservation->guest->lastName;
                    if (!empty($reservation->guest_name)) {
                        $reservation->guest_name += ' ';
                    }
                    $reservation->guest_name += $reservation->guest_last_name;
                }






				if(!empty($data->reservation->guest->emails) && !is_null($data->reservation->guest->emails))
					$reservation->guest_email = current($data->reservation->guest->emails);
				
				if(!empty($data->reservation->guest->phones) && !is_null($data->reservation->guest->phones))
					$reservation->guest_phone = current($data->reservation->guest->phones);

                if (!empty($data->reservation->guest->airbnb->id)) {
                    $reservation->guest_airbnb_id = $data->reservation->guest->airbnb->id;
                }

                if (!empty($data->reservation->guest->airbnb2->id)) {
                    $reservation->guest_airbnb2_id = $data->reservation->guest->airbnb2->id;
                }


				$reservation->guests_count = $data->reservation->guestsCount;


				$reservation->booking_type = 1; // Bed

				if (preg_match('/(apt|\dbr)/', strtolower($data->reservation->listing->nickname))) {
					$reservation->booking_type = 2; // Apartment
				}


				$reservation->beds = $data->reservation->listing->beds;
				$reservation->listing_name = $data->reservation->listing->nickname;
				$reservation->listing_title = $data->reservation->listing->title;
				$reservation->property_type = $data->reservation->listing->propertyType;
				$reservation->room_type = $data->reservation->listing->roomType;


				$reservation->price = $data->reservation->money->subTotalPrice;

				$reservation->invoice_items = $data->reservation->money->invoiceItems;
				$reservation->payments = $data->reservation->money->payments;


                if (!empty($data->reservation->listing->picture->large)) {
                    $reservation->listing_image = $data->reservation->listing->picture->large;
                }



				if (!empty($reservation)) {
					$reservation->type = 1; // Guesty
					$reservation->status = 1; // New
                    $reservation->reservation_status = 'new';

					$this->prebookings->add_prebooking($reservation);
				}
                // file_put_contents('request/guesty/log_new.txt', file_get_contents('request/guesty/log_new.txt')."\r\n\r\n\r\n".date("m.d.Y H:i:s")." ".$_SERVER['REMOTE_ADDR']."\r\n".(!empty($postData) ? $postData : ' empty post data'));

			}
            elseif ($data->event == 'reservation.updated' && !empty($data->reservation)) {
                // file_put_contents('request/guesty/log_upd.txt', file_get_contents('request/guesty/log_upd.txt')."\r\n\r\n\r\n".date("m.d.Y H:i:s")." ".$_SERVER['REMOTE_ADDR']."\r\n".(!empty($postData) ? $postData : ' empty post data'));

                switch ($data->reservation->status) {
                    // Confirm
                    case 'confirmed':
                        $reservation = $this->confirmPrebooking($data);
                        break;

                    // Pending
                    case 'inquiry':
                    case 'reserved':
                    case 'awaiting_payment':
                        $reservation = $this->pendingPrebooking($data);
                        break;

                    // Cancel
                    case 'canceled':
                    case 'declined':
                    case 'closed':
                        $reservation = $this->updatePrebooking($data);
                        break;

                    case 'checked_in':
                    case 'checked_out':
                        $reservation = $this->updatePrebooking($data);
                        break;
                }
            }


			header("Content-type: application/json; charset=UTF-8");
			echo json_encode($reservation); exit;
		}
		else
		{
			header("Content-type: application/json; charset=UTF-8");
			echo '{"status": false}'; exit;
		}
	}


    public function confirmPrebooking ($data) {
        return $this->updatePrebooking($data);
    }

    public function pendingPrebooking ($data) {
        return $this->updatePrebooking($data);
    }

    public function updatePrebooking ($data) {
        if (empty($data->reservation->id)) {
            return false;
        }

        $prebooking = $this->prebookings->get_prebookings([
            'reservation_id' => $data->reservation->id,
            'count' => 1,
            'null_to_empty' => true
        ]);

        if (!empty($prebooking) && $data->reservation->status != $prebooking->reservation_status) {
            $prebooking_data = new stdClass;
            $prebooking_data->reservation_status = $data->reservation->status;
            if ($prebooking_new_status = $this->prebookings->getPrebookingStatusByReservationStatus($data->reservation->status)) {

                 // If not New or new status is Canceled
                 if (!in_array($prebooking->status->id, [1]) || $prebooking_new_status->id == 9) {
                     $prebooking_data->status = $prebooking_new_status->id;
                 }
                 // Was cancelled
                 elseif ($prebooking->status->id == 9 && $prebooking->status->id != $prebooking_new_status->id) {
                     $prebooking_data->status = 1; // New
                 }
            }
            if (!empty($data->reservation->confirmationCode)) {
                $prebooking_data->airbnb_id = $data->reservation->confirmationCode;
            }


            $log_value = '';
            if (isset($prebooking_data->status) && $prebooking->status->id != $prebooking_new_status->id) {
                $log_value .= 'Status: ' . $prebooking->status->name . ' &rarr; ' . $prebooking_new_status->name;
            }

            if ($prebooking->reservation_status != $data->reservation->status) {
                $log_value .= (empty($log_value) ? '' : '<br>');
                $log_value .= 'Reservation status: ' . $prebooking->reservation_status . ' &rarr; ' . $data->reservation->status;
            }

            if (!empty($data->reservation->confirmationCode) && $data->reservation->confirmationCode != $prebooking->airbnb_id) {
                $log_value .= (empty($log_value) ? '' : '<br>');
                $log_value .= 'Airbnb ID: ' . (empty($prebooking->airbnb_id) ? 'None' : $prebooking->airbnb_id) . ' &rarr; ' . $data->reservation->confirmationCode;
            }

            if ($prebooking->arrive != $data->reservation->checkInDateLocalized) {
                $prebooking_data->arrive = $data->reservation->checkInDateLocalized;

                $log_value .= (empty($log_value) ? '' : '<br>');
                $log_value .= 'Arrive: ' . $prebooking->arrive . ' &rarr; ' . $prebooking_data->arrive;
            }

            if ($prebooking->depart != $data->reservation->checkOutDateLocalized) {
                $prebooking_data->depart = $data->reservation->checkOutDateLocalized;

                $log_value .= (empty($log_value) ? '' : '<br>');
                $log_value .= 'Depart: ' . $prebooking->depart . ' &rarr; ' . $prebooking_data->depart;
            }

            $reservation_price = (float) $data->reservation->money->subTotalPrice;
            // Fee
            // $reservation_price += (float) $data->reservation->money->hostServiceFee;

            if (((float) $prebooking->price !== $reservation_price) && $prebooking_new_status->id != 9 && $reservation_price > 0) {
                $prebooking_data->price = $reservation_price;

                $log_value .= (empty($log_value) ? '' : '<br>');
                $log_value .= 'Price: ' . $prebooking->price . ' &rarr; ' . $prebooking_data->price;
            }


            $this->prebookings->update_prebookings($prebooking->id, $prebooking_data);

            // Add log (Change status)
            $this->logs->add_log([
                'parent_id' => $prebooking->id,
                'type' => 23, // Prebookings
                'subtype' => 3, // Change status
                'sender_type' => 4, // Callback
                'sender' => 'Guesty',
                'value' => $log_value
            ]);

            // Update Booking
            if (!empty($prebooking_data) && !empty($prebooking->booking_id)) {
                $booking = $this->beds->get_bookings([
                    'id' => $prebooking->booking_id,
                    'sp_group' => true,
                    'select_users' => true
                ]);
                $booking = (!empty($booking)) ? current($booking) : false;
                if ($booking && $booking->status != 0) {
                    // Pending
                    if ($prebooking_data->status == 3 && $booking->status != 2) {
                        $new_booking_status = 2;
                    }
                    // Confirm
                    elseif ($prebooking_data->status == 4 && $booking->status != 3) {
                        $new_booking_status = 3;
                    }
                    // Cancel
                    elseif ($prebooking_data->status == 9) {
                        $new_booking_status = 0;
                    }

                    if (isset($new_booking_status) || isset($prebooking_data->airbnb_id)) {

                        // Cancel
                        if (isset($new_booking_status) && $new_booking_status === 0) {
                            $this->beds->cancel_booking([
                                'id' => $booking->id,
                                'sender_type' => 4, // Callback
                                'sender' => 'Guesty'
                            ]);
                        } else {
                            $log_value = '';
                            $booking_data = new stdClass;

                            if (isset($new_booking_status) && $booking->status != $new_booking_status) {
                                $booking_data->status = $new_booking_status;
                                $log_value .= 'Status: ' . $this->beds->get_booking_status($booking->status) . ' &rarr; ' . $this->beds->get_booking_status($new_booking_status);
                            }

                            if (!empty($data->reservation->confirmationCode) && $data->reservation->confirmationCode != $booking->airbnb_reservation_id) {
                                $booking_data->airbnb_reservation_id = $data->reservation->confirmationCode;

                                $log_value .= (empty($log_value) ? '' : '<br>');
                                $log_value .= 'Reservation Airbnb ID: ' . (empty($booking->airbnb_reservation_id) ? 'None' : $booking->airbnb_reservation_id) . ' &rarr; ' . $booking_data->airbnb_reservation_id;
                            }
                            /*
                            if (isset($prebooking_data->arrive) && $prebooking_data->arrive != $booking->arrive) {

                                if (!empty($booking->sp_bookings)) {
                                    foreach ($booking->sp_bookings as $sp_booking) {
                                        if ($booking->arrive == $sp_booking->arrive) {
                                            $this->beds->update_booking($sp_booking->id, [
                                                'arrive' => $prebooking_data->arrive
                                            ]);
                                        }
                                    }
                                } else {
                                    $booking_data->arrive = $prebooking_data->arrive;
                                }

                                $log_value .= (empty($log_value) ? '' : '<br>');
                                $log_value .= 'Arrive: ' . $booking->arrive . ' &rarr; ' . $booking_data->arrive;
                            }

                            if (isset($prebooking_data->depart) && $prebooking_data->depart != $booking->depart) {

                                if (!empty($booking->sp_bookings)) {
                                    foreach ($booking->sp_bookings as $sp_booking) {
                                        if ($booking->depart == $sp_booking->depart) {
                                            $this->beds->update_booking($sp_booking->id, [
                                                'depart' => $prebooking_data->depart
                                            ]);
                                        }
                                    }
                                } else {
                                    $booking_data->depart = $prebooking_data->depart;
                                }

                                $log_value .= (empty($log_value) ? '' : '<br>');
                                $log_value .= 'Depart: ' . $booking->depart . ' &rarr; ' . $booking_data->depart;
                            }


                            if (isset($prebooking_data->price) && (float) $prebooking_data->price !== (float) $booking->total_price) {
                                $booking_data->total_price = $prebooking_data->price;

                                $log_value .= (empty($log_value) ? '' : '<br>');
                                $log_value .= 'Total price: ' . $booking->total_price . ' &rarr; ' . $booking_data->total_price;
                            }
                            */

                            if (!empty($booking_data)) {
                                $this->beds->update_booking($booking->id, $booking_data);

                                if (!empty($booking->users)) {
                                    foreach ($booking->users as $user) {
                                        $this->beds->update_user_active_booking($user->id);
                                    }
                                }
                            }

                            if (!empty($log_value)) {
                                $this->logs->add_log([
                                    'parent_id' => $booking->id,
                                    'type' => 1, // Booking
                                    'subtype' => 2, // Change status
                                    'sender_type' => 4, // Callback
                                    'sender' => 'Guesty',
                                    'value' => $log_value
                                ]);
                            }
                        }

                    }
                }
            }
        }

        return $data;
    }
}




$callback_guesty = new CallbackGuesty();
$callback_guesty->fetch();

