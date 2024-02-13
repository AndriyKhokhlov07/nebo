<?PHP

require_once('view/View.php');


require_once 'api/phpexcel/Classes/PHPExcel.php';
require_once('api/phpexcel/Classes/PHPExcel/Writer/Excel2007.php');


require_once 'api/dompdf/lib/html5lib/Parser.php';
// require_once 'api/dompdf/lib/php-font-lib/src/FontLib/Autoloader.php';
// require_once 'api/dompdf/lib/php-svg-lib/src/autoload.php';
require_once 'api/dompdf/src/Autoloader.php';
Dompdf\Autoloader::register();
use Dompdf\Dompdf;
use Dompdf\Options;



class LandlordRentRoll33View extends View
{
	private $params;
	private $table;
	private $ll = ['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'];


	private function sheet_month_info($sheet, $month_info, $booking, $col_val_start, $n_row)
	{
		// $ll = ['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'];

		$n_col = array_search($col_val_start, $this->ll);

		if(!empty($month_info))
		{
			// Days
			$sheet->setCellValue($col_val_start.$n_row, $month_info->days);

			// Rent Gross
			$n_col++;
			$sheet->setCellValueExplicit($this->ll[$n_col].$n_row, number_format($booking->month1->price, 2, ',', ''), PHPExcel_Cell_DataType::TYPE_STRING);

			// Thereof utilites
			// $n_col++;
			// if(!empty($month_info->utility_price))
			// 	$sheet->setCellValueExplicit($this->ll[$n_col].$n_row, number_format($month_info->utility_price, 2, ',', ''), PHPExcel_Cell_DataType::TYPE_STRING);

			// Thereof fees
			$n_col++;

			// Tenant
			$n_col++;
			$sheet->setCellValue($this->ll[$n_col].$n_row, ($booking->client_type_id==5?'[House Leader] ':'').$booking->users_names);

			// Lease from
			$n_col++;
			$sheet->setCellValue($this->ll[$n_col].$n_row, date('m/d/Y', $booking->u_arrive));

			// Lease till
			$n_col++;
			$sheet->setCellValue($this->ll[$n_col].$n_row, date('m/d/Y', $booking->u_depart));
		}
	}

	private function sheet_feature_booking($sheet, $n_row, $booking, $prev_booking)
	{
		if(empty($booking) || $booking->id == $prev_booking->id)
			return false;

		$sheet->setCellValue('L'.$n_row, $booking->days_count);
		$sheet->setCellValue('M'.$n_row, number_format($booking->leased_rent, 2, ',', ''), PHPExcel_Cell_DataType::TYPE_STRING);
		$sheet->setCellValue('N'.$n_row, number_format($booking->total_price_result, 2, ',', ''), PHPExcel_Cell_DataType::TYPE_STRING);


		$sheet->setCellValue('O'.$n_row, ($booking->client_type_id==5?'[House Leader] ':'').$booking->users_names);

		$sheet->setCellValue('P'.$n_row, date('m/d/Y', $booking->u_arrive));
		$sheet->setCellValue('Q'.$n_row, date('m/d/Y', $booking->u_depart));
	}


	private function generate_xls($apartments)
	{
		if(empty($apartments))
			return false;

		// Создаем объект класса PHPExcel
		$xls = new PHPExcel();
		// Устанавливаем индекс активного листа
		$xls->setActiveSheetIndex(0);
		// Получаем активный лист
		$sheet = $xls->getActiveSheet();

		$sheet->getStyle("A1:Q5")->applyFromArray([
			'fill' => [
				'type' => PHPExcel_Style_Fill::FILL_SOLID,
				'color' => [
					'rgb' => 'FFFFFF'
				]
			],
			'borders' => [
				'outline' => [
					'style' => PHPExcel_Style_Border::BORDER_NONE,
					'color' => [
						'rgb' => 'FFFFFF'
					]
				]
			]
		]);


		// Подписываем лист
		$sheet->setTitle('Rent Roll');


		// head
		$sheet->setCellValue("A1", 'Rent Roll');
		$sheet->mergeCells('A1:Q1');

		$sheet->setCellValue("A2", 'Prepared On: '.date('m/d/Y'));
		$sheet->mergeCells('A2:Q2');

		//$sheet->mergeCells('A3:R3');

		$sheet->setCellValue("A3", 'Properties: '.$this->selected_house->blocks2['address']);
		$sheet->mergeCells('A3:Q3');

		// $sheet->setCellValue("A5", 'Units: Active');
		// $sheet->mergeCells('A5:R5');

		$sheet->setCellValue("A4", 'As of: '.date('m/d/Y', strtotime($this->params->selected_date)));
		$sheet->mergeCells('A4:Q4');

		$sheet->mergeCells('A5:Q5');

		// $sheet->mergeCells('A7:R7');

		// $sheet->setCellValue("A7", 'Include Non-Revenue Units: No');
		// $sheet->mergeCells('A7:R7');

		//$sheet->mergeCells('A8:R8');

		


		// table head

		$sheet->mergeCells('A6:C6');

		$sheet->setCellValue("D6", 'Monthly Rent');
		$sheet->mergeCells('D6:E6');

		$sheet->setCellValue("F6", 'Current Month');
		$sheet->mergeCells('F6:K6');

		$sheet->setCellValue("M6", 'Next Lease');
		$sheet->mergeCells('L6:Q6');


		$n_col = 0;
		$n_row = 7;

		$sheet->setCellValue($this->ll[$n_col].$n_row, 'Unit');

		$n_col++;
		$sheet->setCellValue($this->ll[$n_col].$n_row, 'BRs');

		$n_col++;
		$sheet->setCellValue($this->ll[$n_col].$n_row, 'Status');

		$n_col++;
		$sheet->setCellValue($this->ll[$n_col].$n_row, "Market Rent");

		$n_col++;
		$sheet->setCellValue($this->ll[$n_col].$n_row, "Leased Rent");

		$n_col++;
		$sheet->setCellValue($this->ll[$n_col].$n_row, 'Days');

		$n_col++;
		$sheet->setCellValue($this->ll[$n_col].$n_row, "Rent prorated"); // "Rent\r\n prorated"

		// $n_col++;
		// $sheet->setCellValue($this->ll[$n_col].$n_row, "Thereof utilites");

		$n_col++;
		$sheet->setCellValue($this->ll[$n_col].$n_row, "Thereof fees");

		$n_col++;
		$sheet->setCellValue($this->ll[$n_col].$n_row, 'Tenant');

		$n_col++;
		$sheet->setCellValue($this->ll[$n_col].$n_row, 'Lease from');

		$n_col++;
		$sheet->setCellValue($this->ll[$n_col].$n_row, 'Lease till');



		$n_col++;
		$sheet->setCellValue($this->ll[$n_col].$n_row, 'Days');

		$n_col++;
		$sheet->setCellValue($this->ll[$n_col].$n_row, "Monthly Rent");

		$n_col++;
		$sheet->setCellValue($this->ll[$n_col].$n_row, "Total contracted");

		$n_col++;
		$sheet->setCellValue($this->ll[$n_col].$n_row, 'Tenant');

		$n_col++;
		$sheet->setCellValue($this->ll[$n_col].$n_row, 'Lease from');

		$n_col++;
		$sheet->setCellValue($this->ll[$n_col].$n_row, 'Lease till');




		$sheet->getStyle("A6:Q7")->getFont()->setBold(true);

		
		$sheet->getStyle('A7:Q7')->getAlignment()->setWrapText(true);
		$sheet->getStyle('A7:Q7')->getAlignment()->setVertical(PHPExcel_Style_Alignment::VERTICAL_CENTER);

		$sheet->getStyle("A6:Q7")->applyFromArray([
			'fill' => [
				'type' => PHPExcel_Style_Fill::FILL_SOLID,
				'color' => [
					'rgb' => 'DBDBE6'
				]
			],
			// 'font' => [
			// 	'bold' => true
			// ]
		]);



		// Table body
		$n_row = 7;
		foreach($apartments as $a)
		{
			if(empty($a->a_bookings) && empty($a->b_bookings))
			{
				if(empty($a->isset_feature_b_bookings) && empty($a->feature_a_booking))
				{
					$bed_n = 0;

					foreach($a->beds as $bed)
					{
						$n_row++;
						$bed_n++;

						$sheet->setCellValue('A'.$n_row, $a->name.'-'.$bed_n);
						$sheet->setCellValue('B'.$n_row, '1');
						$sheet->setCellValue('C'.$n_row, 'Vacant-Unrented');
					}

					// Apartment total
					$n_row++;
					$sheet->setCellValue('B'.$n_row, $a->beds_count);
					$sheet->setCellValue('D'.$n_row, number_format($a->price, 2, ',', ''), PHPExcel_Cell_DataType::TYPE_STRING);

					$sheet->getStyle('A'.$n_row.':R'.$n_row)->applyFromArray([
						'borders' => [
							'top' => [
								'style' => PHPExcel_Style_Border::BORDER_THIN,
								'color' => ['rgb' => '000000']
							],
							'bottom' => [
								'style' => PHPExcel_Style_Border::BORDER_THIN,
								'color' => ['rgb' => '000000']
							]
						],
						'fill' => [
							'type' => PHPExcel_Style_Fill::FILL_SOLID,
							'color' => [
								'rgb' => 'DBDBE6'
							]
						],
						'font' => [
							'bold' => true
						]
					]);
				}
				else
				{
					$bed_n = 0;
					foreach($a->beds as $bed)
					{
						$bed_n++;

						if(!empty($a->feature_a_booking))
						{
							$n_row++;

							$sheet->setCellValue('A'.$n_row, $a->name.'-'.$bed_n);
							$sheet->setCellValue('B'.$n_row, '1');
							$sheet->setCellValue('C'.$n_row, 'Vacant-Unrented');

							$this->sheet_feature_booking($sheet, $n_row, $a->feature_a_booking, 0);
						}

						if(!empty($bed->feature_b_booking) || empty($a->feature_a_booking))
						{
							$n_row++;

							$sheet->setCellValue('A'.$n_row, $a->name.'-'.$bed_n);
							$sheet->setCellValue('B'.$n_row, '1');
							$sheet->setCellValue('C'.$n_row, 'Vacant-Unrented');

							$this->sheet_feature_booking($sheet, $n_row, $bed->feature_b_booking, 0);
						}
					}

					// Apartment total
					$n_row++;
					$sheet->setCellValue('B'.$n_row, $a->beds_count);
					$sheet->setCellValue('D'.$n_row, number_format($a->price, 2, ',', ''), PHPExcel_Cell_DataType::TYPE_STRING);

					$sheet->getStyle('A'.$n_row.':R'.$n_row)->applyFromArray([
						'borders' => [
							'top' => [
								'style' => PHPExcel_Style_Border::BORDER_THIN,
								'color' => ['rgb' => '000000']
							],
							'bottom' => [
								'style' => PHPExcel_Style_Border::BORDER_THIN,
								'color' => ['rgb' => '000000']
							]
						],
						'fill' => [
							'type' => PHPExcel_Style_Fill::FILL_SOLID,
							'color' => [
								'rgb' => 'DBDBE6'
							]
						],
						'font' => [
							'bold' => true
						]
					]);
				}
			}

			else
			{
				$bed_n = 0;
				$prev_f_booking = 0;
				foreach($a->beds as $bed)
				{
                    $bed_n++;
                    $prev_f_booking = 0;

                    if(!empty($a->a_bookings))
                    {
                    	foreach($a->a_bookings as $b)
                    	{
                    		$n_row++;

                    		$sheet->setCellValue('A'.$n_row, $a->name.'-'.$bed_n);
                    		if(!empty($this->params->leased_rent[$a->id][$bed->id]) && !empty($this->params->leased_rent[$a->id][$bed->id]->booking_id==$b->id))
                    		{
                    			$sheet->setCellValue('B'.$n_row, '1');
                    		}
							$sheet->setCellValue('C'.$n_row, $b->rr_status);

							if(!empty($this->params->leased_rent[$a->id][$bed->id]) && !empty($this->params->leased_rent[$a->id][$bed->id]->booking_id==$b->id))
                    		{
                    			$sheet->setCellValue('E'.$n_row, number_format($this->params->leased_rent[$a->id][$bed->id]->price, 2, ',', ''), PHPExcel_Cell_DataType::TYPE_STRING);
                    		}

                    		$this->sheet_month_info($sheet, $b->month1, $b, 'F', $n_row);

                            if(!empty($bed->feature_b_booking) && !empty($a->feature_a_booking) && $bed->feature_b_booking->u_arrive<$a->feature_a_booking->u_arrive && empty($a->b_bookings[$bed->id]->bookings))
                            {
                            	$feature_booking = $bed->feature_b_booking;
                            	$this->sheet_feature_booking($sheet, $n_row, $feature_booking, $prev_f_booking);
                            	$prev_f_booking = $feature_booking;
                            }
                            else
                            {
                            	if(!empty($this->params->leased_rent[$a->id][$bed->id]) && !empty($this->params->leased_rent[$a->id][$bed->id]->booking_id==$b->id))
                            	{
                            		$feature_booking = $a->feature_a_booking;
                            	}
                            	else
                            	{
                            		$feature_booking = 0;
                            	}
                            	$this->sheet_feature_booking($sheet, $n_row, $feature_booking, $prev_f_booking);
                            }
                    	}
                    }

                    if(!empty($a->b_bookings) && !empty($a->b_bookings[$bed->id]->bookings))
                    {
                    	foreach($a->b_bookings[$bed->id]->bookings as $b)
                    	{
                    		if(!empty($b->month1))
                    		{
                    			$n_row++;

                    			$sheet->setCellValue('A'.$n_row, $a->name.'-'.$bed_n);

                                if(!empty($this->params->leased_rent[$a->id][$bed->id]) && !empty($this->params->leased_rent[$a->id][$bed->id]->booking_id==$b->id))
	                    		{
	                    			$sheet->setCellValue('B'.$n_row, '1');
	                    		}
	                    		$sheet->setCellValue('C'.$n_row, $b->rr_status);

                                if(!empty($this->params->leased_rent[$a->id][$bed->id]) && !empty($this->params->leased_rent[$a->id][$bed->id]->booking_id==$b->id))
	                    		{
	                    			$sheet->setCellValue('E'.$n_row, number_format($this->params->leased_rent[$a->id][$bed->id]->price, 2, ',', ''), PHPExcel_Cell_DataType::TYPE_STRING);
	                    		}

	                    		$this->sheet_month_info($sheet, $b->month1, $b, 'F', $n_row);


	                    		if(!empty($a->feature_a_booking) && (empty($bed->feature_b_booking) || (!empty($bed->feature_b_booking) && $a->feature_a_booking->u_arrive < $bed->feature_b_booking->u_arrive)))
	                    		{
	                    			if(!empty($this->params->leased_rent[$a->id][$bed->id]) && $this->params->leased_rent[$a->id][$bed->id]->booking_id==$b->id)
	                    			{
	                    				$feature_booking = $a->feature_a_booking;
	                    			}
	                    			else
	                    			{
	                    				$feature_booking = 0;
	                    			}
	                    		}
	                    		else
	                    		{
	                    			$feature_booking = $bed->feature_b_booking;
	                    		}
	                    		$this->sheet_feature_booking($sheet, $n_row, $feature_booking, $prev_f_booking);
	                    		$prev_f_booking = $feature_booking;
                    		}
                    	}
                    }

                    if(empty($a->a_bookings) && empty($a->b_bookings[$bed->id]->bookings))
                    {
                    	$n_row++;

                    	$sheet->setCellValue('A'.$n_row, $a->name.'-'.$bed_n);
                    	$sheet->setCellValue('B'.$n_row, '1');
                    	$sheet->setCellValue('C'.$n_row, 'Vacant-Unrented');

                    	if(!empty($bed->feature_b_booking) && (empty($a->feature_a_booking) || (!empty($a->feature_a_booking) && $bed->feature_b_booking->u_arrive < $a->feature_a_booking->u_arrive)))
                    	{
                    		$feature_booking = $bed->feature_b_booking;
                    	}
                    	else
                    	{
                    		$feature_booking = $a->feature_a_booking;
                    	}
                    	$this->sheet_feature_booking($sheet, $n_row, $feature_booking, $prev_f_booking);
                    	$prev_f_booking = $feature_booking;

                    }
				}

				// Apartment total
				$n_row++;
				$sheet->setCellValue('B'.$n_row, $a->beds_count);
				$sheet->setCellValue('D'.$n_row, number_format($a->price, 2, ',', ''), PHPExcel_Cell_DataType::TYPE_STRING);
				if(!empty($a->leased_rent))
					$sheet->setCellValue('E'.$n_row, number_format($a->leased_rent, 2, ',', ''), PHPExcel_Cell_DataType::TYPE_STRING);
				if(!empty($a->total_rent_gross))
					$sheet->setCellValue('G'.$n_row, number_format($a->total_rent_gross, 2, ',', ''), PHPExcel_Cell_DataType::TYPE_STRING);
				// if(!empty($a->total_utility_price))
				// 	$sheet->setCellValue('H'.$n_row, number_format($a->total_utility_price, 2, ',', ''), PHPExcel_Cell_DataType::TYPE_STRING);

				$sheet->getStyle('A'.$n_row.':Q'.$n_row)->applyFromArray([
					'borders' => [
						'top' => [
							'style' => PHPExcel_Style_Border::BORDER_THIN,
							'color' => ['rgb' => '000000']
						],
						'bottom' => [
							'style' => PHPExcel_Style_Border::BORDER_THIN,
							'color' => ['rgb' => '000000']
						]
					],
					'fill' => [
						'type' => PHPExcel_Style_Fill::FILL_SOLID,
						'color' => [
							'rgb' => 'DBDBE6'
						]
					],
					'font' => [
						'bold' => true
					]
				]);
			}
		}


		// Result
		$n_row++;
		$n_row++;
		$sheet->setCellValue('A'.$n_row, 'Total');
		$sheet->setCellValue('B'.$n_row, "Units: ".count($apartments)." \r\n BRs: ".$this->params->total_beds);
		$sheet->getStyle('B'.$n_row)->getAlignment()->setWrapText(true);
		$sheet->getStyle('A'.$n_row.':R'.$n_row)->getAlignment()->setVertical(PHPExcel_Style_Alignment::VERTICAL_CENTER);

		$sheet->setCellValue('D'.$n_row, number_format($this->params->total_market_rent, 2, ',', ''), PHPExcel_Cell_DataType::TYPE_STRING);
		$sheet->setCellValue('E'.$n_row, number_format($this->params->total_leased_rent, 2, ',', ''), PHPExcel_Cell_DataType::TYPE_STRING);


		if(!empty($this->params->total_rent_gross[1]))
			$sheet->setCellValue('G'.$n_row, number_format($this->params->total_rent_gross[1], 2, ',', ''), PHPExcel_Cell_DataType::TYPE_STRING);
		// if(!empty($this->params->total_utility_price[1]))
		// 	$sheet->setCellValue('H'.$n_row, number_format($this->params->total_utility_price[1], 2, ',', ''), PHPExcel_Cell_DataType::TYPE_STRING);

		$sheet->getStyle('A'.$n_row.':Q'.$n_row)->applyFromArray([
			'fill' => [
				'type' => PHPExcel_Style_Fill::FILL_SOLID,
				'color' => [
					'rgb' => 'DBDBE6'
				]
			],
			'font' => [
				'bold' => true
			]
		]);



		// align center
		$sheet->getStyle('A6:Q'.$n_row)->getAlignment()->setHorizontal(PHPExcel_Style_Alignment::HORIZONTAL_CENTER);

		$sheet->getColumnDimension('A')->setWidth(10);
		$sheet->getColumnDimension('B')->setWidth(8);
		$sheet->getColumnDimension('C')->setWidth(15);

		$sheet->getColumnDimension('D')->setWidth(15);
		$sheet->getColumnDimension('E')->setWidth(15);

		$sheet->getColumnDimension('G')->setWidth(15);
		$sheet->getColumnDimension('H')->setWidth(15);
		// $sheet->getColumnDimension('I')->setWidth(15);

		$sheet->getColumnDimension('M')->setWidth(15);
		$sheet->getColumnDimension('N')->setWidth(15);

		// Tenants
		$sheet->getColumnDimension('I')->setWidth(25);
		$sheet->getColumnDimension('O')->setWidth(25);
		//$sheet->getColumnDimension('W')->setWidth(25);

		// align left
		$sheet->getStyle('I8:I'.$n_row)->getAlignment()->setHorizontal(PHPExcel_Style_Alignment::HORIZONTAL_LEFT);
		$sheet->getStyle('O8:O'.$n_row)->getAlignment()->setHorizontal(PHPExcel_Style_Alignment::HORIZONTAL_LEFT);

		// Dates
		$sheet->getColumnDimension('J')->setWidth(13);
		$sheet->getColumnDimension('K')->setWidth(13);
		$sheet->getColumnDimension('P')->setWidth(13);
		$sheet->getColumnDimension('Q')->setWidth(13);

		// borders
		$sheet->getStyle('A6:Q'.$n_row)->applyFromArray([
			'borders' => [
				'outline' => [
					'style' => PHPExcel_Style_Border::BORDER_THIN
				],
			]
		]);

		$sheet->getStyle('D6:D'.$n_row)->applyFromArray([
			'borders' => [
				'left' => [
					'style' => PHPExcel_Style_Border::BORDER_THIN,
					'color' => ['rgb' => '000000']
				]
			]
		]);
		$sheet->getStyle('F6:F'.$n_row)->applyFromArray([
			'borders' => [
				'left' => [
					'style' => PHPExcel_Style_Border::BORDER_THIN,
					'color' => ['rgb' => '000000']
				]
			]
		]);
		$sheet->getStyle('L6:L'.$n_row)->applyFromArray([
			'borders' => [
				'left' => [
					'style' => PHPExcel_Style_Border::BORDER_THIN,
					'color' => ['rgb' => '000000']
				]
			]
		]);
		$sheet->getStyle('A6:Q6')->applyFromArray([
			'borders' => [
				'bottom' => [
					'style' => PHPExcel_Style_Border::BORDER_THIN,
					'color' => ['rgb' => '000000']
				]
			]
		]);
		$sheet->getStyle('A7:Q7')->applyFromArray([
			'borders' => [
				'bottom' => [
					'style' => PHPExcel_Style_Border::BORDER_THIN,
					'color' => ['rgb' => '000000']
				]
			]
		]);
		$sheet->getStyle('A'.$n_row.':Q'.$n_row)->applyFromArray([
			'borders' => [
				'top' => [
					'style' => PHPExcel_Style_Border::BORDER_THIN,
					'color' => ['rgb' => '000000']
				]
			]
		]);





		$n_row += 2;

		$table2_n_row_start = $n_row;
		$sheet->setCellValue('A'.$n_row, 'Total Bedrooms Leased');
		$sheet->mergeCells('A'.$n_row.':C'.$n_row);
		$sheet->setCellValue('D'.$n_row, $this->params->beds_leased);

		$n_row++;
		$sheet->setCellValue('A'.$n_row, 'Current % Leased');
		$sheet->mergeCells('A'.$n_row.':C'.$n_row);
		$sheet->setCellValue('D'.$n_row, $this->params->current_leased.'%');

		$n_row++;
		$sheet->setCellValue('A'.$n_row, 'Current Occupied Bedrooms');
		$sheet->mergeCells('A'.$n_row.':C'.$n_row);
		$sheet->setCellValue('D'.$n_row, $this->params->current_beds);

		$n_row++;
		$sheet->setCellValue('A'.$n_row, 'Current Occupancy');
		$sheet->mergeCells('A'.$n_row.':C'.$n_row);
		$sheet->setCellValue('D'.$n_row, $this->params->current_occupancy.'%');

		$n_row++;
		$sheet->setCellValue('A'.$n_row, 'Vacant-Rented Bedrooms');
		$sheet->mergeCells('A'.$n_row.':C'.$n_row);
		$sheet->setCellValue('D'.$n_row, $this->params->rented_beds);

		$n_row++;
		$sheet->setCellValue('A'.$n_row, 'Vacant-Rented Occupancy');
		$sheet->mergeCells('A'.$n_row.':C'.$n_row);
		$sheet->setCellValue('D'.$n_row, $this->params->rented_occupancy.'%');


		$sheet->getStyle('D'.$table2_n_row_start.':D'.$n_row)->getAlignment()->setHorizontal(PHPExcel_Style_Alignment::HORIZONTAL_CENTER);


		$sheet->getStyle('A'.$table2_n_row_start.':D'.$n_row)->applyFromArray([
			'fill' => [
				'type' => PHPExcel_Style_Fill::FILL_SOLID,
				'color' => [
					'rgb' => 'F3F1EF'
				]
			],
			'font' => [
				'bold' => true
			]
		]);

		header("Expires: Mon, 1 Apr 1974 05:00:00 GMT");
		header("Last-Modified: " . gmdate("D,d M YH:i:s") . " GMT");
		header("Cache-Control: no-cache, must-revalidate");
		header("Pragma: no-cache");
		header("Content-type: application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
		header("Content-Disposition: attachment; filename=rentroll.xlsx");

		$objWriter = new PHPExcel_Writer_Excel2007($xls);
		$objWriter->save('php://output');
		exit;
	}


	private function moth_calc($params = [])
	{
		if(empty($params['month_date']) || empty($params['booking']))
			return false;

		$b = $params['booking'];
		$d = $params['month_date'];


		$u_arrive = $b->u_arrive;
		$u_depart = $b->u_depart;


		$u_first_day = $d->getTimestamp();
		$u_last_day = strtotime($d->format('Y-m-t'));


		if(($u_arrive <= $u_first_day && $u_depart >= $u_first_day) || ($u_arrive <= $u_last_day && $u_depart >= $u_first_day))
		{
			$result = new stdClass;

			$bm_from = $u_arrive;
			if($u_arrive < $u_first_day)
				$bm_from = $u_first_day;

			$bm_to = $u_depart;
			if($u_depart > $u_last_day)
				$bm_to = $u_last_day;

			$result->from = $bm_from;
			$result->to = $bm_to;
			$result->days = round(($bm_to - $bm_from) / (24 * 60 * 60)) + 1;

			$result->price_day = $b->total_price / (round(($u_depart - $u_arrive) / (24 * 60 * 60)) + 1);

			$kpr =  $result->days / $d->format('t');
			$result->pr = $kpr;
			$result->price = round($b->price_month * $kpr);

			if($kpr < 0.5)
				$result->price = round($result->price_day * $result->days);

			//print_r($this->selected_house->id); exit;

			if(in_array(334, (array)$this->selected_house->id))
	 		{
	 			if($b->house_id == 334)
	 			{
	 				if($b->type == 1) // 1 - booking bed
		 				$utility_tax = 75;
		 			elseif($b->type == 2) // 2 - booking apartment
	            		$utility_tax = 300;

	            	$result->utility_price = round($utility_tax * $kpr);
	            	// $result->price -= $result->utility_price;
	 			}
	 			
	 		}
	 		else
	 		{
	 			$utility_tax = 75;
	 			$result->utility_price = round($utility_tax * $kpr);
	 		}



	 		// if($b->client_type_id != 2) // not airbnb
	 		// 	$result->price -= $result->utility_price;

	 		if($result->price < 0)
	 			$result->price = 0;

	 		if($result->price == 0)
	 			$result->utility_price = 0;


	 		if($result->price > 0 && $result->utility_price > 0)
	 			$result->price += $result->utility_price;




			return $result;
		}
		return false;
	}


	private function generate_pdf()
	{

		// $options = new Options();
		// $options->set('defaultFont', 'Helvetica');

		// // instantiate and use the dompdf class
		// $dompdf = new Dompdf($options);



		


		// $dompdf->loadHtml($html);



		$html = $this->design->fetch('landlord/bx/rentroll/html.tpl');

		//echo $html; exit;

		$options = new Options();
		$options->set('defaultFont', 'Helvetica');
		// instantiate and use the dompdf class
		$dompdf = new Dompdf($options);


		$dompdf->loadHtml($html);
		// (Optional) Setup the paper size and orientation ("landscape" or "portrait")
		$dompdf->setPaper('A4', 'portrait');
		// Render the HTML as PDF
		$dompdf->render();
		// Output the generated PDF to Browser
		$dompdf->stream('rentroll.pdf');

		exit;
	}


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

		if(empty($this->user->permissions['rentroll']) && !empty($this->user->permissions))
		{
			header("HTTP/1.1 301 Moved Permanently"); 
			header('Location: '.$this->config->root_url.'/landlord/'.current($this->user->permissions));
			exit();
		}

		$landlord = new stdClass;

		if(!empty($this->user->email))
		{
			if(!empty($this->user->main_info))
				$landlord->main_info = $this->user->main_info;

			$houses = [];
			$selected_house_id = $this->request->get('house_id', 'integer');
			$this->selected_house->id = $selected_house_id;


			if($this->selected_house->id == 349) // The Mason on Chestnut - Philadelphia
			{
				header("HTTP/1.1 301 Moved Permanently"); 
				header('Location: '.$this->config->root_url.'/landlord/rentroll2/'.$this->selected_house->id);
				exit();	
			}


			$month = $this->request->get('month', 'string');
			$date = $this->request->get('date', 'string');
			$this->params->show_empty_rows = $this->request->get('sr', 'integer');
			$f = $this->request->get('f', 'string');


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


				// The Williamsburg House
				if(in_array($this->selected_house->id, [334, 337]))
				{
					$this->selected_house->id = [
						334,  // The Williamsburg House
						337   // The Williamsburg House (165 N 5th Street)
					];
				}

				// The Greenpoint House
				elseif(in_array($this->selected_house->id, [311, 316, 317]))
				{
					$this->selected_house->id = [
						311,  // The Greenpoint House
						316,  // The Greenpoint House (111)
						317   // The Greenpoint House (115)
					];
				}

				



				if(!empty($this->selected_house))
				{

					// $this->selected_house->id 


					if(!empty($this->selected_house->blocks2))
					{
						$this->selected_house->blocks2 = unserialize($this->selected_house->blocks2);
					}

					// LLC Name
					// if(isset($this->user->companies[$this->user->company_houses_ids[$this->selected_house->id]->company_id]))
					// 	$this->selected_house->llc_name = $this->user->companies[$this->user->company_houses_ids[$this->selected_house->id]->company_id]->name;
					
					$this->selected_house_addr = [];
					if(is_array($this->selected_house->id))
					{
						foreach($this->selected_house->id as $h_id)
						{
							if(isset($houses[$h_id]) && !empty($houses[$h_id]->blocks2))
							{
								if($this->selected_house->blocks2 == $houses[$h_id]->blocks2)
									$house_blocks2 = $houses[$h_id]->blocks2;
								else
									$house_blocks2 = unserialize($houses[$h_id]->blocks2);

								if(!empty($house_blocks2['address']))
									$this->selected_house_addr[$h_id] = $house_blocks2['address'];
							}	
						}
						if(!empty($this->selected_house_addr))
							$this->selected_house->blocks2['address'] = implode(' / ', $this->selected_house_addr);
					}

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
					$apartments = $this->beds->get_apartments([
						'house_id' => $this->selected_house->id,
						'visible' => 1,
						'sort' => 'name'
					]);
					$apartments = $this->request->array_to_key($apartments, 'id');
					if(!empty($apartments))
					{
						foreach($apartments as $a_id=>$a)
						{
							if(!empty($a->property_price))
								$apartments[$a_id]->price = $a->property_price;
						}
					}

					// Rooms
					$rooms_ = $this->beds->get_rooms([
						'house_id' => $this->selected_house->id,
						'visible' => 1
					]);
					
					$rooms_apartments_ids = [];
					if(!empty($rooms_))
					{
						foreach($rooms_ as $r)
						{
							// if(substr(trim($r->name), 0, 5) == 'Room ')
							// 	$r->name = substr(trim($r->name), 5);


							
							if(!empty($r->apartment_id) && isset($apartments[$r->apartment_id]))
							{
								$apartments[$r->apartment_id]->rooms[$r->id] = $r;

								$rooms[$r->id] = $r;
								$apartments[$r->apartment_id]->rows ++;
								$rooms_apartments_ids[$r->id] = $r->apartment_id;

								if(empty($apartments[$r->apartment_id]->price) && !empty($r->price1))
								{
									if(!isset($apartments[$r->apartment_id]->price_by_rooms))
										$apartments[$r->apartment_id]->price_by_rooms = 0;

									$apartments[$r->apartment_id]->price_by_rooms += $r->price1;
								}
							}

							
						}
					}

					// Beds
					$beds = $this->beds->get_beds(array(
						'room_id' => array_keys($rooms),
						'visible' => 1
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

							$apartments[$apartment_id]->beds[$b->id] = $b;

							$apartments[$apartment_id]->beds_count++;


							$this->params->total_beds++;

						}
					}


					// Считаем стоимость для комнат
					// Если в комнанах не указана стоимость, а в апартаментах указано
					foreach($apartments as $apartment_id=>$a)
					{
						if(substr(trim($a->name), 0, 5) == 'Unit ')
							$a->name = substr(trim($a->name), 5);
						elseif(substr(trim($a->name), 0, 4) == 'Apt ')
							$a->name = substr(trim($a->name), 4);
						
						if($a->house_id == 311) // The Greenpoint House
							$a->name = '107/'.$a->name;
						elseif($a->house_id == 316) // The Greenpoint House (111)
							$a->name = '111/'.$a->name;
						elseif($a->house_id == 317) // The Greenpoint House (115)
							$a->name = '115/'.$a->name;


						if(!empty($a->price))
						{
							$a->bed_price_by_apartment = round($a->price / $a->beds_count);
							if(!empty($a->rooms))
							{
								foreach($a->rooms as $room_id=>$r)
								{
									if($r->price1 == 0)
									{
										$apartments[$apartment_id]->rooms[$b->room_id]->price1 = $a->bed_price_by_apartment;
									}
								}
							}	
						}
						elseif($a->price_by_rooms)
						{
							$apartments[$apartment_id]->price = $a->price_by_rooms;
						}
					}


					
					// $tr = [];

					// $tr['apartment']->name = $apartments[$apartment_id]->name;
					// $tr['room']->name = $rooms[$b->room_id]->name;
					// $tr['bed']->name = $b->name;

					// $this->table[] = $tr;
					$strtotime_now = strtotime('now');


					if(!empty($date))
						$strtotime_now = strtotime($date);


					if(!in_array((int)$this->user->id, [3164, 2883]) && $strtotime_now < strtotime('2021-07-01'))
						$strtotime_now = strtotime('now');					



					$this->params->selected_date = date('Y-m-d', $strtotime_now);


					$strtotime_lastmonth = strtotime('- 1 month');

					if(!empty($month))
					{
						list($this->params->month, $this->params->year) = explode('-', $month);
					}
					else
					{
						$this->params->month = date("m", $strtotime_now);
						$this->params->year = date("Y", $strtotime_now);
					}

					$this->params->now_month = new DateTime($this->params->year.'-'.$this->params->month.'-01');


					$this->params->next_month = new DateTime($this->params->year.'-'.$this->params->month.'-01'); 
					$this->params->next_month->modify('+1 month');

					$this->params->next_2month = new DateTime($this->params->year.'-'.$this->params->month.'-01');
					$this->params->next_2month->modify('+2 month');


					
					$this->params->prev_month = new DateTime($this->params->year.'-'.$this->params->month.'-01');
					$this->params->prev_month->modify('-1 month');


					if((int)$this->params->year < 2021 && (int)$this->params->month < 12)
						unset($this->params->prev_month);


					// if(strtotime(date("Y-m", $strtotime_now).'-01') < $this->params->now_month->getTimestamp())
					// 	unset($this->params->next_month);


					$this->params->days_in_month = date("t", strtotime($this->params->year.'-'.$this->params->month.'-01'));

					//$this->params->days_beds_count = $this->params->days_in_month * count($beds);


					$this->params->now_month_last_day = $this->params->year.'-'.$this->params->month.'-'.$this->params->days_in_month;

					if(strtotime($this->params->year.'-'.$this->params->month.'-01') > strtotime(date("Y-m", $strtotime_now).'-01'))
						$this->params->hide_debt = true;
					
					// $booking_patrams['date_from'] = $this->params->year.'-'.$this->params->month.'-01';
					// $booking_patrams['date_to'] = $this->params->now_month_last_day;


					// Bookings

					$bookings = $this->beds->get_bookings([
						'house_id' => $this->selected_house->id,
						'date_from2' => $this->params->now_month->format('Y-m-d'),
						'date_to2' => $this->params->next_2month->format('Y-m-t'),
						'status' => 3, // Contract / Invoice
						'select_users' => true,
						// 'sp_group' => true,
						// 'sp_group_from_start' => true,
						'order_by' => 'b.arrive, b.depart'
					]);


					if(!empty($bookings))
					{
						$contracts = $this->contracts->get_contracts([
							'reserv_id' => array_keys($bookings),
							'status' => [
								1, // active
								2  // finished
							]
						]);
						if(!empty($contracts))
						{
							foreach($contracts as $c)
							{
								if(isset($bookings[$c->reserv_id]))
								{
									$bookings[$c->reserv_id]->contract = $c;
								}
							}
						}


						$apartments_current = [];
						$beds_current = [];
						$leased_rent = [];

						// $apartments_statuses = [];
						// $beds_statuses = [];

						$apartments_rented = [];
						$beds_rented = [];


						$bookings_other_period = [];

						foreach($bookings as $b)
						{
							$b->u_arrive = strtotime($b->arrive);
				            $b->u_depart = strtotime($b->depart);

				            $b_interval = $b->u_depart - $b->u_arrive;
							$b->days_count = round($b_interval / (24 * 60 * 60) + 1);

							if($strtotime_now >= $b->u_arrive && $strtotime_now <= $b->u_depart)
							{
								$b->rr_status_code = 1;
								$b->rr_status = 'Current';
							}
							elseif($b->u_arrive > $strtotime_now)
							{
								$b->rr_status_code = 2;
								$b->rr_status = 'Vacant-Rented';
							}
							elseif($b->u_depart < $strtotime_now)
							{
								$b->rr_status_code = 3;
								$b->rr_status = 'Alumni';
							}



							if(!empty($b->users))
							{
								$b->users_names = [];
								foreach($b->users as $u)
									$b->users_names[$u->id] = $u->name;
								$b->users_names = implode(', ', $b->users_names);
							}





							/*
							// Цены с контракта
							if(isset($b->contract))
							{
								if($b->contract->price_month > 0)
									$b->price_month = $b->contract->price_month;
								if($b->contract->total_price > 0)
									$b->total_price = $b->contract->total_price;
							}
							*/

							if($b->client_type_id == 2 && $b->price_day > 0) // airbnb
							{
								$b->total_price = round($b->price_day * $b->days_count);
								$b->leased_rent = round($b->price_day * 30);
							}
							else 
							{
								if($b->price_day > 0)
								{
									$b_total_price = round($b->price_day * $b->days_count);
									$c_total_price = $b->total_price / $b_total_price;

									if($c_total_price > 1.05 || $c_total_price < 0.95)
										$b->total_price = $b_total_price;
								}

								$b->leased_rent = $b->price_month;
								//$b->leased_rent_full = $b->price_month;
							}

							if($b->total_price == 0 && $b->price_month > 0)
							{
								$bcalc = $this->contracts->calculate($b->arrive, $b->depart, $b->price_month);
								$b->total_price = $bcalc->total;
							}



							if($b->type == 1) // booking bed
							{
								$room_id = $beds_rooms_ids[$b->object_id];
								if(isset($rooms[$room_id]) && !empty($rooms[$room_id]->apartment_id) && $rooms[$room_id]->apartment_id != $b->apartment_id)
								{
									$b->apartment_id = $rooms[$room_id]->apartment_id;
								}
							}
							elseif($b->type == 2) // booking apartment
							{
								$b->leased_rent = round($b->leased_rent / $apartments[$b->object_id]->beds_count, 2);
							}

							if($b->leased_rent > 0 && $b->house_id != 337)
								$b->leased_rent += 75;


							$b->month1 = $this->moth_calc([
								'month_date' => $this->params->now_month,
								'booking' => $b
							]);

							$b->month2 = $this->moth_calc([
								'month_date' => $this->params->next_month,
								'booking' => $b
							]);

							$b->month3 = $this->moth_calc([
								'month_date' => $this->params->next_2month,
								'booking' => $b
							]);


							if(!empty($b->month1))
							{
								$this->params->total_rent_gross[1] += $b->month1->price;
								if($b->month1->utility_price > 0)
									$this->params->total_utility_price[1] += $b->month1->utility_price;
							}

							if(!empty($b->month2))
							{
								$this->params->total_rent_gross[2] += $b->month2->price;
								if($b->month2->utility_price > 0)
									$this->params->total_utility_price[2] += $b->month2->utility_price;
							}

							if(!empty($b->month3))
							{
								$this->params->total_rent_gross[3] += $b->month3->price;
								if($b->month3->utility_price > 0)
									$this->params->total_utility_price[3] += $b->month3->utility_price;
							}



							





							if($b->type == 1) // 1 - booking bed
							{
								$apartments[$b->apartment_id]->b_bookings[$b->object_id]->bookings[$b->id] = $b;

								// $beds_statuses[$b->apartment_id][$b->object_id][$b->rr_status_code][$b->id] = $b->id;
							}
							elseif($b->type == 2) // 2 - booking apartment
							{
								$apartments[$b->object_id]->a_bookings[$b->id] = $b;

								// $apartments_statuses[$b->apartment_id][$b->rr_status_code][$b->id] = $b->id;
							}



							// Current count
							if($strtotime_now >= $b->u_arrive && $strtotime_now <= $b->u_depart)
							{
								if($b->type == 1) // 1 - booking bed
									$beds_current[$b->apartment_id][$b->object_id] = 1;
								elseif($b->type == 2) // 2 - booking apartment
									$apartments_current[$b->object_id] = count($apartments[$b->object_id]->beds);
							}

							// Rented count
							elseif($b->u_arrive > $strtotime_now || $b->u_depart < $strtotime_now)
							{
								if($b->type == 1) // 1 - booking bed
									$beds_rented[$b->apartment_id][$b->object_id] = 1;
								elseif($b->type == 2) // 2 - booking apartment
									$apartments_rented[$b->object_id] = count($apartments[$b->object_id]->beds);	
							}



							if(!empty($b->month1))
							{

								if($b->type == 1) // booking bed
								{
									// if(!isset($leased_rent[$b->apartment_id][$b->object_id]))
									// 	$leased_rent[$b->apartment_id][$b->object_id] = new stdClass;

									if(empty($leased_rent[$b->apartment_id][$b->object_id]) || $leased_rent[$b->apartment_id][$b->object_id]->status > $b->rr_status_code || ($leased_rent[$b->apartment_id][$b->object_id]->status == $b->rr_status_code && $leased_rent[$b->apartment_id][$b->object_id]->booking_u_arrive < $b->u_arrive))
									{
										$leased_rent[$b->apartment_id][$b->object_id]->status = $b->rr_status_code;
										$leased_rent[$b->apartment_id][$b->object_id]->booking_id = $b->id;
										$leased_rent[$b->apartment_id][$b->object_id]->booking_type = $b->type;
										$leased_rent[$b->apartment_id][$b->object_id]->booking_u_arrive = $b->u_arrive;
										$leased_rent[$b->apartment_id][$b->object_id]->price = $b->leased_rent;
									}
									
									else
									{
										$leased_rent[$b->apartment_id][$b->object_id]->error = 1;
									}
								}
								elseif($b->type == 2) // booking apartment
								{
									foreach($apartments[$b->object_id]->beds as $bed)
									{
										// if(!isset($leased_rent[$b->object_id][$bed->id]))
										// 	$leased_rent[$b->object_id][$bed->id] = new stdClass;

										if(empty($leased_rent[$b->object_id][$bed->id]) || $leased_rent[$b->object_id][$bed->id]->status > $b->rr_status_code || ($leased_rent[$b->object_id][$bed->id]->status == $b->rr_status_code && $leased_rent[$b->object_id][$bed->id]->booking_u_arrive < $b->u_arrive))
										{
											$leased_rent[$b->object_id][$bed->id]->status = $b->rr_status_code;
											$leased_rent[$b->object_id][$bed->id]->booking_id = $b->id;
											$leased_rent[$b->object_id][$bed->id]->booking_type = $b->type;
											$leased_rent[$b->object_id][$bed->id]->booking_u_arrive = $b->u_arrive;
											$leased_rent[$b->object_id][$bed->id]->price = $b->leased_rent;
										}
									}
								}
								


								


								if($b->type == 1) // 1 - booking bed
								{
									$apartment_id = $b->apartment_id;

									$apartments[$apartment_id]->month1_b_total_rent_gross += $b->month1->price;
									$apartments[$apartment_id]->month1_b_total_utility_price += $b->month1->utility_price;		
								}
								elseif($b->type == 2) // 2 - booking apartment
								{
									$apartment_id = $b->object_id;

									$apartments[$apartment_id]->month1_total_rent_gross += $b->month1->price;
									$apartments[$apartment_id]->month1_total_utility_price += $b->month1->utility_price;
								}


								$apartments[$apartment_id]->total_rent_gross += $b->month1->price;
								$apartments[$apartment_id]->total_utility_price += $b->month1->utility_price;

								if($b->type == 2) // 2 - booking apartment
								{
									$apartments[$b->object_id]->a_bookings[$b->id]->month1->price = round($b->month1->price / $apartments[$apartment_id]->beds_count, 2);
									$apartments[$b->object_id]->a_bookings[$b->id]->month1->utility_price = round($b->month1->utility_price / $apartments[$apartment_id]->beds_count, 2);
								}

								
							}


							// if(!empty($b->month2))
							// {
							// 	$bb = $b;
							// 	$bb->month_info = $b->month2;
							// 	$bookings_other_period[$b->month2->from.'-'.$b->id] = $bb;
							// }

							// if(!empty($b->month3))
							// {
							// 	$bb = $b;
							// 	$bb->month_info = $b->month3;
							// 	$bookings_other_period[$b->month3->from.'-'.$b->id] = $bb;
							// }




						}

						if(!empty($leased_rent))
						{
							foreach($leased_rent as $a_id=>$lss)
							{
								foreach($lss as $ls)
								{
									$apartments[$a_id]->leased_rent += $ls->price;
									$this->params->total_leased_rent += $ls->price;
								}
							}

						}

						$this->params->leased_rent = $leased_rent;
					}

					// print_r($this->params);
					// exit;


					$apartments_beds_leased = 0;
					$bed_leased_arr = [];

					
					foreach($apartments as $a_id=>$a)
					{
						if(isset($a->a_bookings))
						{
							$apartments_beds_leased += count($a->beds);

							foreach($a->a_bookings as $b_id=>$b)
							{
								// if($b->rr_status == 'Vacant-Rented' && empty($b->month1) && count($apartments[$a_id]->a_bookings) > 1)
								// if($b->rr_status == 'Vacant-Rented' && count($apartments[$a_id]->a_bookings) > 1)
								// {
								// 	unset($apartments[$a_id]->a_bookings[$b_id]);
								// }

								// Vacant-Rented
								if($b->rr_status_code == 2) 
								{
									if(!empty($b->month1))
									{
										//  $b->rr_status = 'Current';
									}
									else
									{
										unset($apartments[$a_id]->a_bookings[$b_id]);
									}
								}
							}
							foreach($a->a_bookings as $b_id=>$b)
							{
								// 3 - Alumni
								if($b->rr_status_code == 3 && count($apartments[$a_id]->a_bookings) > 1) 
								{
									// unset($apartments[$a_id]->a_bookings[$b_id]);
								}


								// if($b->rr_status_code == 3)
								// {
								// 	if(isset($apartments_statuses[$b->apartment_id][1]) || isset($apartments_statuses[$b->apartment_id][2]))
								// 		$apartments[$a_id]->a_bookings[$b_id]->leased_rent = 0;
								// }

								// if(isset($apartments_statuses[$b->apartment_id][1][$b->id]))
							}
						}
						if(isset($a->b_bookings) && !isset($a->a_bookings))
						{
							foreach($a->b_bookings as $object_id=>$b_objects)
							{
								$bed_leased_arr[$object_id] = 1;
							}
						}



						if(isset($a->b_bookings))
						{
							foreach($a->b_bookings as $object_id=>$b_objects)
							{
								if(!empty($b_objects->bookings))
								{
									foreach($b_objects->bookings as $b_id=>$b)
									{
										//if($b->rr_status == 'Vacant-Rented' && empty($b->month1) && count($apartments[$a_id]->b_bookings[$object_id]->bookings) > 1)
										// if($b->rr_status == 'Vacant-Rented' && count($apartments[$a_id]->b_bookings[$object_id]->bookings) > 1)
										// {
										// 	unset($apartments[$a_id]->b_bookings[$object_id]->bookings[$b_id]);
										// }
										if($b->rr_status_code == 2) // Vacant-Rented
										{

											if(!empty($b->month1))
											{
												// $b->rr_status = 'Current';
												// 
											}
											else
											{
												unset($apartments[$a_id]->b_bookings[$object_id]->bookings[$b_id]);
											}
										}



										if($b->rr_status_code == 1)
										{
											$apartments[$a_id]->b_current_count ++;
											$apartments[$a_id]->b_current_sum += $a->rooms[$a->beds[$object_id]->room_id]->price1;
										}
									}


									/*foreach($b_objects->bookings as $b_id=>$b)
									{
										if($b->rr_status == 'Alumni' && count($apartments[$a_id]->b_bookings[$object_id]->bookings) > 1)
										{
											unset($apartments[$a_id]->b_bookings[$object_id]->bookings[$b_id]);
										}
									}*/


									// Current
									// Vacant-Rented
									// Alumni
									foreach($b_objects->bookings as $b_id=>$b)
									{
										// $apartments[$a_id]->b_total 

										// Current
										if($b->rr_status_code == 1) 
										{
											$apartments[$a_id]->b_total[$object_id]->status = 1;
											$apartments[$a_id]->b_total[$object_id]->price = $a->rooms[$a->beds[$object_id]->room_id]->price1;
										}

										// Vacant-Rented
										elseif($b->rr_status == 2 && $apartments[$a_id]->b_total[$object_id]->status > 1) 
										{
											$apartments[$a_id]->b_total[$object_id]->status = 2;
											$apartments[$a_id]->b_total[$object_id]->price = $a->rooms[$a->beds[$object_id]->room_id]->price1;
										}

										// Alumni
										elseif($b->rr_status == 3 && $apartments[$a_id]->b_total[$object_id]->status > 2) 
										{
											$apartments[$a_id]->b_total[$object_id]->status = 2;
											$apartments[$a_id]->b_total[$object_id]->price = $a->rooms[$a->beds[$object_id]->room_id]->price1;
										}
									}

									/*if(count($b_objects->bookings) == 1)
									{

									}*/


								}								

							}


							foreach($a->beds as $bed)
							{
								// $a->rooms[$bed->room_id]->price1
								if(!empty($a->b_total[$bed->id]))
								{
									$a->b_total_price += $a->b_total[$bed->id]->price;
								}
								elseif($a->rooms[$bed->room_id]->price1)
								{
									$a->b_total_price += $a->rooms[$bed->room_id]->price1;
								}
							}
						}

						// print_r($apartments); exit;




						// if(isset($a->b_bookings) && !isset($a->a_bookings))
						// {
						// 	foreach($a->rooms as $r)
						// 	{
						// 		$this->params->total_market_rent += $r->price1 * count($r->beds);
						// 	}
						// }
						// else
						// {
							$this->params->total_market_rent += $a->price;
						// }
					}


					// Leased
					$this->params->beds_leased = $apartments_beds_leased + count($bed_leased_arr);

					// Current Leased
					$this->params->current_leased = round($this->params->beds_leased / $this->params->total_beds * 100, 1);


					// Current Beds
					$this->params->current_beds = 0;
					if(!empty($beds_current))
					{
						foreach($beds_current as $apartment_id=>$bds)
						{
							if(!isset($apartments_current[$apartment_id]))
							{
								foreach($bds as $b)
									$this->params->current_beds ++;
							}
						}
					}
					if(!empty($apartments_current))
					{
						foreach($apartments_current as $ac)
							$this->params->current_beds += $ac;
					}

					// Current Occupancy
					$this->params->current_occupancy = round($this->params->current_beds / $this->params->total_beds * 100, 1);



					// Rented Beds
					$this->params->rented_beds = 0;
					if(!empty($beds_rented))
					{
						foreach($beds_rented as $apartment_id=>$bds)
						{
							if(!isset($apartments_rented[$apartment_id]))
							{
								foreach($bds as $b)
									$this->params->rented_beds ++;
							}
						}
					}
					if(!empty($apartments_rented))
					{
						foreach($apartments_rented as $ac)
							$this->params->rented_beds += $ac;
					}

					// Rented Occupancy
					$this->params->rented_occupancy = round($this->params->rented_beds / $this->params->total_beds * 100, 1);







					// Invoices / Bookings
					/*$orders_params = [
						'house_id' => $this->selected_house->id,
						// 'date_from_month' => $this->params->month,
						// 'date_from_year' => $this->params->year,
						// 'or_paid_month' => true,
						'date_from_months_years' => [
							[
								'month' => $this->params->month,
								'year' => $this->params->year
							],
							[
								'month' => $this->params->next_month->format('m'),
								'year' => $this->params->next_month->format('Y')
							]
						],
						'type' => 1,
						'deposit' => 0,
						'not_status' => 3,
						'limit' => 1000,
						'sort_date_from' => true
					];


					$invoices = $this->orders->get_orders($orders_params);


					print_r($invoices); //exit;*/



					$bookings_params = [
						'house_id' => $this->selected_house->id,
						'status' => 3,
						//'client_type_not_id' => 5, // 5 - houseleader
						//'date_from' => date('Y-m-d', $strtotime_now), now
						'date_from' => $this->params->next_month->format('Y-m-d'),
						// 'sp_group' => true,
						// 'sp_group_from_start' => true,
						'select_users' => true,
						
						'order_by' => 'b.arrive',
						'limit' => 1000,
						'page' => 1
					];

					$feature_bookings = $this->beds->get_bookings($bookings_params);

					$feature_apartments_bookings = [];
					$feature_beds_bookings = [];

					if(!empty($feature_bookings))
					{
						foreach($feature_bookings as $b)
						{
							$b->u_arrive = strtotime($b->arrive);
				            $b->u_depart = strtotime($b->depart);

				            $b_interval = $b->u_depart - $b->u_arrive;
							$b->days_count = round($b_interval / (24 * 60 * 60) + 1);


							$u_first_day =  $this->params->now_month->getTimestamp();
							$u_last_day = strtotime($this->params->now_month->format('Y-m-t'));

							if(($b->u_arrive <= $u_last_day && $b->u_depart >= $u_first_day))
							{
								$bm_from = $b->u_arrive;
								$bm_to = $b->u_depart;
								if($b->u_depart > $u_last_day)
									$bm_to = $u_last_day;

								$b->days_in_month = round(($bm_to - $bm_from) / (24 * 60 * 60)) + 1;
							}



							if(!empty($b->users))
							{
								$b->users_names = [];
								foreach($b->users as $u)
									$b->users_names[$u->id] = $u->name;
								$b->users_names = implode(', ', $b->users_names);
							}

							if($b->client_type_id == 2 && $b->price_day > 0) // airbnb
							{
								$b->total_price = round($b->price_day * $b->days_count);
								$b->price_month = round($b->price_day * 30);
							}
							elseif(!empty($b->arrive) && !empty($b->depart) && $b->price_month > 0 && $b->total_price < 1)
							{
								$price_calculate = $this->contracts->calculate($b->arrive, $b->depart, $b->price_month);
								if(!empty($price_calculate))
								{
									$b->total_price = $price_calculate->total; 

									if($b->price_day > 0)
									{
										$b_total_price = round($b->price_day * $b->days_count);
										$c_total_price = $b->total_price / $b_total_price;

										if($c_total_price > 1.05 || $c_total_price < 0.95)
											$b->total_price = $b_total_price;
									}
								}
							}

							$b->leased_rent = $b->price_month;
							$b->total_price_result = $b->total_price;

							if($b->type == 2) // apartments
							{
								$b->leased_rent = round($b->leased_rent / $apartments[$b->object_id]->beds_count, 2);
								$b->total_price_result = round($b->total_price_result / $apartments[$b->object_id]->beds_count, 2);

								$feature_apartments_bookings[$b->object_id][$b->u_arrive.$b->id.$b->u_depart] = $b;
							}
							elseif($b->type == 1) // beds
							{
								$room_id = $beds_rooms_ids[$b->object_id];
								if(isset($rooms[$room_id]) && !empty($rooms[$room_id]->apartment_id) && $rooms[$room_id]->apartment_id != $b->apartment_id)
								{
									$b->apartment_id = $rooms[$room_id]->apartment_id;
								}

								$apartments[$b->apartment_id]->isset_feature_b_bookings = true;

								$feature_beds_bookings[$b->object_id][$b->u_arrive.$b->id.$b->u_depart] = $b;
							}
						}

						ksort($feature_apartments_bookings);
						ksort($feature_beds_bookings);
					}


					foreach($apartments as $a_id=>$a)
					{
						//if(isset($feature_apartments_bookings[$a->id]) && !isset($a->a_bookings[$feature_apartments_bookings[$a->id]->id]))
						if(isset($feature_apartments_bookings[$a->id]))
						{
							$a->feature_a_booking = current($feature_apartments_bookings[$a->id]);
						}

						
						foreach($a->beds as $b_id=>$b)
						{
							if(isset($feature_beds_bookings[$b->id]))
							{

								$b->feature_b_booking = current($feature_beds_bookings[$b->id]);

								if(empty($a->a_bookings) && empty($a->b_bookings) && isset($a->feature_a_booking) && $b->feature_b_booking->u_arrive > $a->feature_a_booking->u_arrive)
								{
									// unset($b->feature_b_booking);
								}

								/*
								if(isset($a->b_bookings[$b->id]->bookings[$b->feature_b_booking->id]))
								{
									if(!empty($a->b_bookings[$b->id]->bookings[$b->feature_b_booking->id]->month1))
									{
										unset($b->feature_b_booking);
										//print_r($a->b_bookings[$b->id]->bookings[$b->feature_b_booking->id]); 
									}
									// 
								}
								*/
							}
						}
						
					}


					if($this->request->get('print_r', 'integer'))
					{
						print_r($apartments); exit;
					}



					$this->design->assign('apartments', $apartments);



					/*
					$bookings_params = [
						'house_id' => $this->selected_house->id,
						'status' => 3,
						'client_type_not_id' => 5, // 5 - houseleader
						'date_from' => $this->params->next_month->format('Y-m-d'),
						'sp_group' => true,
						'select_users' => true,
						'sp_group_from_start' => true,
						'order_by' => 'b.arrive',
						'limit' => 500,
						'page' => 1
					];

					$notifications_bookings = $this->beds->get_bookings($bookings_params);

					if($notifications_bookings)
					{
						foreach($notifications_bookings as $k=>$b)
						{

							$u_arrive = strtotime($b->arrive);
				            $u_depart = strtotime($b->depart);
				            $b_interval = $u_depart - $u_arrive;
							$b->days_count = round($b_interval / (24 * 60 * 60)) + 1;


							if(!empty($b->arrive) && !empty($b->depart) && $b->price_month > 0 && $b->total_price < 1)
							{
								$price_calculate = $this->contracts->calculate($b->arrive, $b->depart, $b->price_month);
								if(!empty($price_calculate))
								{
									$notifications_bookings[$k]->total_price = $price_calculate->total;
								}
							}
						}
					}
					$this->design->assign('notifications_bookings', $notifications_bookings);
					*/



					



					




				if(isset($houses[337]))
					unset($houses[337]);

				if(isset($houses[316]))
					unset($houses[316]);

				if(isset($houses[317]))
					unset($houses[317]);





				}
			}
		}


		$meta_title = 'Rent Roll';
		if(!empty($this->selected_house))
			$meta_title .= ' | '.$this->selected_house->name;
		$this->design->assign('meta_title', $meta_title);

		$this->design->assign('houses', $houses);

		if(is_array($this->selected_house->id))
			$this->selected_house->id = current($this->selected_house->id);


		$this->design->assign('selected_house', $this->selected_house);
		$this->design->assign('landlord', $landlord);
		$this->design->assign('params', $this->params);

		if($f == 'xls')
			$this->generate_xls($apartments);
		elseif($f == 'pdf')
			$this->generate_pdf();

		return $this->design->fetch('landlord/rentroll_33.tpl');
	}


	
}
