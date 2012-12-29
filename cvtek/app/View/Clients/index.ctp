<h1>Liste des clients</h1>
<?php echo $this->Html->link(
    'Ajouter un client',
    array('controller' => 'clients', 'action' => 'add')
); ?>
<table>
    <tr>
        <th>Id</th>
        <th>Nom</th>
        <th>Logo</th>
        <th>Action</th>
    </tr>

    <?php foreach ($clients as $client): ?>
        <tr>
            <td><?php echo $client['Client']['id']; ?></td>
            <td>
                <?php echo $client['Client']['nom']; ?>
            </td>
            <td><img src="<?php echo $client['Client']['logo']; ?>"></td>
            <td>
                <?php echo $this->Html->link('Editer', array('action' => 'edit', $client['Client']['id'])); ?>
                <?php echo $this->Form->postLink(
                'Supprimer',
                array('action' => 'delete', $client['Client']['id']),
                array('confirm' => 'êtes-vous sûr ?'));
            ?>
            </td>

        </tr> 
    <?php endforeach; ?>
    <?php unset($client); ?>
</table>