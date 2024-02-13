<?php


require_once('Backend.php');

class Forms extends Backend
{
    /*
    *  Types:
    *  1 - House forms
    */

	public function get_forms_data($params = [])
	{
		$forms_data = false;
        $id_filter = '';
        $type_filter = '';
		$parent_id_filter = '';
        $limit = '';

        if (isset($params['id'])) {
            $id_filter = $this->db->placehold('AND fd.id in(?@)', (array)$params['id']);
        }

        if (isset($params['type'])) {
            $type_filter = $this->db->placehold('AND fd.type in(?@)', (array)$params['type']);
        }

        if (isset($params['parent_id'])) {
            $parent_id_filter = $this->db->placehold('AND fd.parent_id in(?@)', (array)$params['parent_id']);
        }

        if (!empty($params['count'])) {
            $limit = $this->db->placehold('LIMIT ?', (int)$params['count']);
        }

        $query = $this->db->placehold("SELECT
                    fd.id,
                    fd.type,
                    fd.parent_id,
                    fd.value
                FROM __forms_data fd
                WHERE 1
                    $id_filter
                    $type_filter
                    $parent_id_filter
                ORDER BY fd.id
                $limit");
		$this->db->query($query);


        $forms_data = $this->db->results();
        if ($forms_data) {
            foreach ($forms_data as $fd) {
                if (!empty($fd->value)) {
                    $fd->value = json_decode($fd->value, false);
                }
            }
        }

        if (isset($params['count']) && $params['count'] == 1) {
            $forms_data = current($forms_data);
        }

		return $forms_data;
	}


	public function add_form_data($form_data) {
		$form_data = (object)$form_data;
        $form_data->value = json_encode($form_data->value, true);

		$this->db->query("INSERT INTO __forms_data SET ?%", $form_data);
		return $this->db->insert_id();

    }



	public function update_form_data($id, $form_data)
	{
        $form_data = (object)$form_data;
        $form_data->value = json_encode($form_data->value);

		$query = $this->db->placehold("UPDATE __forms_data SET ?% WHERE id=? LIMIT 1", $form_data, intval($id));
		$this->db->query($query);
		return $id;
	}


	public function delete_form_data($id)
	{
		if(!empty($id))
		{
			$query = $this->db->placehold("DELETE FROM __forms_data WHERE id=? LIMIT 1", $id);
			$this->db->query($query);
		}
	}
}

