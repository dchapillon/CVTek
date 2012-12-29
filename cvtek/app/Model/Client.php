<?php
class Client extends AppModel
{
	public $validate = array(
        'nom' => array(
            'rule' => 'notEmpty'
        )
    );
}

?>