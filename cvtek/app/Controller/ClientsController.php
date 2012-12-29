<?php
class ClientsController extends AppController
{
	public $helpers = array('Html', 'Form');	
	public $components = array('Session');

	public function index() {
        $this->set('clients', $this->Client->find('all'));
    }

    public function add() {
        if ($this->request->is('post')) {
            $this->Client->create();
           if ($this->Client->save($this->request->data)) {
                $this->Session->setFlash('Nouveau client ajouté.');
                $this->redirect(array('action' => 'index'));
            } else {
                $this->Session->setFlash('Impossible d\'ajouter ce client.');
            }
        }
    }

    public function edit($id = null) {
	    if (!$id) {
	        throw new NotFoundException(__('Impossible d\'éditer ce client'));
	    }

	    $client = $this->Client->findById($id);
	    if (!$client) {
	        throw new NotFoundException(__('Client introuvable'));
	    }

	    if ($this->request->is('post') || $this->request->is('put')) {
	        $this->Client->id = $id;
	       
	        if ($this->Client->save($this->request->data)) {
	            $this->Session->setFlash('Le client a été mise à jour');
	            $this->redirect(array('action' => 'index'));
	        } else {
	            $this->Session->setFlash('Impossible de mettre à jour ce client');
	        }
	    }

	    if (!$this->request->data) {
	        $this->request->data = $client;
	    }
	}

	public function delete($id) {
	    if ($this->request->is('get')) {
	        throw new MethodNotAllowedException();
	    }

	    if ($this->Client->delete($id)) {
	        $this->Session->setFlash('Le client avec l\': ' . $id . ' a été supprimé.');
	        $this->redirect(array('action' => 'index'));
	    }
	}

}
?>