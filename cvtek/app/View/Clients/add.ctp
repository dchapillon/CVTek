<h1>Ajouter un nouveau client</h1>
<?php
	echo $this->Form->create('Client');
	echo $this->Form->input('nom');
	echo $this->Form->input('logo');
	echo $this->Form->end('Enregistrer');
?>