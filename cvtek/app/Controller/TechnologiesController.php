<?php
/**
* 
*/
class TechnologiesController extends AppController
{
	public $helpers = array('Html', 'Form');	

	public function index() {
        $this->set('technologies', $this->Technology->find('all'));
    }
}
?>