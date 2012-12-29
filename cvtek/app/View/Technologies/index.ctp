<h1>Liste des technologies</h1>
<table>
    <tr>
        <th>Id</th>
        <th>Nom</th>
        <th>Descriptif</th>
        <th>Version</th>
    </tr>

    <?php foreach ($technologies as $technology): ?>
        <tr>
            <td><?php echo $technology['technology']['idtechnology']; ?></td>
            <td><?php echo $technology['technology']['nom']; ?></td>
            <td><?php echo $technology['technology']['descriptif']; ?></td>
            <td><?php echo $technology['technology']['version']; ?></td>
        </tr> 
    <?php endforeach; ?>
    <?php unset($technology); ?>
</table>