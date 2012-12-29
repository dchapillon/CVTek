<?php
/**
* 
*/
class ProfilsController extends AppController
{
	public $helpers = array('Html', 'Form');	

	public function index() {
        $this->set('profils', $this->Profil->find('all'));
    }
}
?>