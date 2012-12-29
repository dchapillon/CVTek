<?php
/**
* 
*/
class ClientsController extends AppController
{
	public $helpers = array('Html', 'Form');	

	public function index() {
        $this->set('clients', $this->Client->find('all'));
    }
}
?>