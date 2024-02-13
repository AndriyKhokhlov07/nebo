<?php
//ini_set('error_reporting', E_ALL);
ini_set('error_reporting', 0);

// session_start();

chdir('..');
require_once('api/Backend.php');



class Init extends Backend
{
	function fetch()
	{

		$this->beds->update_user_active_booking();


		// strtotime(date('Y-m-d 00:00:00'));


		//echo date('Y-m-d');

		/*$u_date = strtotime(date('Y-m-d 00:00:00'));

		$bookings = $this->beds->get_beds_journal();

		if(!empty($bookings))
		{
			$users_bookings = array();

			foreach($bookings as $b)
			{
				if(!empty($b->user_id))
				{
					$users_bookings[$b->user_id][$b->id] = $b;
				}
			}
			unset($bookings);

			//print_r($users_bookings);

			$n = 0;
			foreach($users_bookings as $user_id=>$ub)
			{
				if(count($ub) == 1)
				{
					$n++;
					$active_booking = current($ub);
					$u_id = $this->users->update_user($user_id, array('active_booking_id'=>$active_booking->id));
					echo $n.'. User #'.$user_id.' => add active booking #'.$active_booking->id.'<br>';
				}
				else{
					$active_booking = false;

					$booking_now = false;
					$booking_future = false;
					$booking_past = false;  

					


					foreach($ub as $b)
					{
						$u_arrive = strtotime($b->arrive);
						$u_depart = strtotime($b->depart);

						if(!empty($b->due))
							$u_due = strtotime($b->due);
						else
							$u_due = false;

						if(empty($u_due) || $u_due > $u_date)
							$b->is_due = true;
						else
							$b->is_due = false;



						// now
						if($u_date >= $u_arrive && $u_date <= $u_depart)
						{
							if( 
								empty($booking_now) || 
								($booking_now->is_due == false && $b->is_due == true && $booking_now->status == $b->status) ||
								($booking_now->is_due == $b->is_due && $booking_now->status < $b->status)
							)
								$booking_now = $b;
						}

						elseif($u_date > $u_depart)
						{
							// if( empty($booking_past) || ($booking_past->is_due == false && $b->is_due == true) )
							// 	$booking_past = $b;
							if( 
								empty($booking_past) || 
								($booking_past->is_due == false && $b->is_due == true && $booking_past->status == $b->status) ||
								($booking_past->is_due == $b->is_due && $booking_past->status < $b->status)
							)
								$booking_past = $b;
						}

						elseif($u_date < $u_arrive)
						{
							//if( empty($booking_future) || ($booking_future->is_due == false && $b->is_due == true) )
							if( 
								empty($booking_future) || 
								($booking_future->is_due == false && $b->is_due == true && $booking_future->status == $b->status) ||
								($booking_future->is_due == $b->is_due && $booking_future->status < $b->status)
							)
								$booking_future = $b;
						}


					}

					// Statuses:
					// 0 - Canceled
					// 1 - New
					// 2 - Payment Pending
					// 3 - Contract / Invoice
					if(
						!empty($booking_now) && 
						( 
							($booking_now->is_due == true && $booking_now->status > 0) || 
							empty($booking_future) ||
							(!empty($booking_future) && ($booking_future->is_due == false || $booking_now->status > $booking_now->status))
						)
					)
					{
						$active_booking = $booking_now;
					}

					elseif(!empty($booking_past))
						$active_booking = $booking_past;
					else
					{
						$active_booking = current($ub);
					}


					if(!empty($active_booking))
					{
						$n++;
						$u_id = $this->users->update_user($user_id, array('active_booking_id'=>$active_booking->id));
						echo $n.'. User #'.$user_id.' => add active booking #'.$active_booking->id.'<br>';
					}
					else
					{
						$n++;
						echo $n.'. User #'.$user_id.' => [no active booking] <br>';

					}




				}
			}
		}*/



	}
}


$init = new Init();
$init->fetch();
