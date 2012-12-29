<h1>Edition d'un client</h1>
<?php
    echo $this->Form->create('Client');
    echo $this->Form->input('nom');
    echo $this->Form->input('logo');
    echo $this->Form->input('id', array('type' => 'hidden'));
    echo $this->Form->end('Sauvegarder');