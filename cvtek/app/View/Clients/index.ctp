<h1>Liste des clients</h1>
<table>
    <tr>
        <th>Id</th>
        <th>Nom</th>
        <th>Logo</th>
    </tr>

    <?php foreach ($clients as $client): ?>
        <tr>
            <td><?php echo $client['Client']['idclient']; ?></td>
            <td>
                <?php echo $client['Client']['nom']; ?>
            </td>
            <td><img src="<?php echo $client['Client']['logo']; ?>"></td>
        </tr> 
    <?php endforeach; ?>
    <?php unset($client); ?>
</table>