<?PHP

require_once('view/View.php');

use Models\Sure;

class SureThankYouView extends View
{
    private ?Sure $sureModel = null;

    function fetch()
	{
        $userHashCode = $this->request->get('user_hash_code');
        $bookingId = (int)$this->request->get('booking_id');
        $this->sureModel = Sure::getByUserHash($userHashCode, $bookingId);

        switch (strtoupper($this->request->method())){
            case 'GET':
                return $this->get();
        }
	}

    private function get()
    {
        return $this->design->fetch('sure/sure-thankyou.tpl');
    }

    private function post()
    {
    }
}