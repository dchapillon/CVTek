<h1>Liste des profils</h1>
<table>
    <tr>
        <th>Id</th>
        <th>Intitulé</th>
    </tr>

    <?php foreach ($profils as $profil): ?>
        <tr>
            <td><?php echo $profil['profil']['id']; ?></td>
            <td>
                <?php echo $profil['profil']['intitule']; ?>
            </td>
        </tr> 
    <?php endforeach; ?>
    <?php unset($profil); ?>
</table>