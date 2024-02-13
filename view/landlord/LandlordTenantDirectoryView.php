<?PHP
//ini_set('error_reporting', E_ALL);

require_once('view/View.php');

require_once 'services/generateXls/GenerateTenantDirectory.php';

// require_once 'api/dompdf/lib/php-font-lib/src/FontLib/Autoloader.php';
// require_once 'api/dompdf/lib/php-svg-lib/src/autoload.php';

require_once 'api/dompdf/lib/html5lib/Parser.php';
require_once 'api/dompdf/src/Autoloader.php';
Dompdf\Autoloader::register();
use Dompdf\Dompdf;
use Dompdf\Options;


class LandlordTenantDirectoryView extends View{
	private $params;
    private $selected_house;

    private function generate_pdf($filename)
    {
        $html = $this->design->fetch('landlord/bx/rentroll/tenant-directory_html.tpl');
        $options = new Options();
        $options->set('defaultFont', 'Helvetica');
        $dompdf = new Dompdf($options);
        $dompdf->loadHtml($html);
        $dompdf->setPaper('A4', 'portrait');
        $dompdf->render();
        $dompdf->stream($filename);
        exit;
    }

	function fetch() {

        if (empty($this->user)) {
            header("HTTP/1.1 301 Moved Permanently");
            header('Location: '.$this->config->root_url.'/user/login');
            exit();
        }

        if ($this->user->type != 4) {
            return false;
        }

        $landlord = new stdClass;

        if (!empty($this->user->email)) {
            if (!empty($this->user->main_info)) {
                $landlord->main_info = $this->user->main_info;
            }
            if (!empty($this->user->landlords_companies)) {
            } elseif ($this->user->id == 4714 || $this->user->id == 4715) {
                $this->user->houses_ids[] = 185; // The Central Park Manhattan House for owners
            }

            $house_id = $this->request->get('house_id', 'integer');
            $f = $this->request->get('f', 'string');

            $bookings = $this->rentroll->getRR1([
                'house_id' => $house_id,
                'landlord' => $this->user,
                'view' => 'landlord'
            ]);

            $houseName = $bookings->params->selected_house->name;
            $houseAddress = $bookings->params->selected_house->blocks2['address'];
            $filename = "tenant-directory_".$houseName.'_'.$houseAddress;
            // Removing commas
            $filename = str_replace(',', '', $filename);
            // Replacing spaces with underscores
            $filename = preg_replace('/\s+/', '_', $filename);

            $this->design->assign('meta_title', 'LandlordTenantDirectoryView');
            $this->design->assign('houses', $bookings->params->houses);
            $this->design->assign('cities_houses', $bookings->params->cities_houses);
            $this->design->assign('selected_house', $bookings->params->selected_house);
            $this->design->assign('params', $bookings->params);
            $this->design->assign('bookings', $bookings);
            $this->design->assign('namePage', $namePage = 'tenant-directory');

            if($f == 'xls'){
                $generateXls = new GenerateTenantDirectory();
                $generateXls->generate_xls($bookings);
            }
            elseif($f == 'pdf'){
                $this->generate_pdf($filename);
            }

            return $this->design->fetch('landlord/tenant-directory.tpl');

        }
	}
}
