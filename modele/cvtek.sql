SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

DROP SCHEMA IF EXISTS `cvtek` ;
CREATE SCHEMA IF NOT EXISTS `cvtek` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `cvtek` ;

-- -----------------------------------------------------
-- Table `cvtek`.`profils`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cvtek`.`profils` ;

CREATE  TABLE IF NOT EXISTS `cvtek`.`profils` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `intitule` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cvtek`.`collaborateurs`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cvtek`.`collaborateurs` ;

CREATE  TABLE IF NOT EXISTS `cvtek`.`collaborateurs` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `nom` VARCHAR(20) NOT NULL ,
  `prenom` VARCHAR(30) NOT NULL ,
  `fonction` VARCHAR(45) NOT NULL ,
  `identifiant` VARCHAR(45) NOT NULL COMMENT 'identifiant de connexion à l\'application si pas connecté à un ldap\n' ,
  `motdepasse` VARCHAR(45) NOT NULL COMMENT 'mot de passe de connexion si pas connecté à un ldap\n' ,
  `profil_idprofil` INT NOT NULL ,
  PRIMARY KEY (`id`, `profil_idprofil`) ,
  CONSTRAINT `fk_collaborateur_profil1`
    FOREIGN KEY (`profil_idprofil` )
    REFERENCES `cvtek`.`profils` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_collaborateur_profil1_idx` ON `cvtek`.`collaborateurs` (`profil_idprofil` ASC) ;


-- -----------------------------------------------------
-- Table `cvtek`.`clients`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cvtek`.`clients` ;

CREATE  TABLE IF NOT EXISTS `cvtek`.`clients` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `nom` VARCHAR(45) NOT NULL ,
  `logo` VARCHAR(150) NULL COMMENT 'logo du client (url d\'accès à l\'image)\n' ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cvtek`.`missions`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cvtek`.`missions` ;

CREATE  TABLE IF NOT EXISTS `cvtek`.`missions` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `datedeb` DATETIME NOT NULL COMMENT 'Date de début de a mission\n' ,
  `datefin` DATETIME NULL COMMENT 'date de fin, null si la mission n\'est pas finie' ,
  `intitule` VARCHAR(45) NOT NULL COMMENT 'intitulé de la mission\n' ,
  `description` VARCHAR(1500) NOT NULL COMMENT 'descriptif détaillé de la mission' ,
  `resume` VARCHAR(200) NULL COMMENT 'Description courte de la mission' ,
  `client_idclient` INT NOT NULL ,
  `collaborateur_idcollab` INT NOT NULL ,
  PRIMARY KEY (`id`, `client_idclient`, `collaborateur_idcollab`) ,
  CONSTRAINT `fk_mission_client`
    FOREIGN KEY (`client_idclient` )
    REFERENCES `cvtek`.`clients` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_mission_collaborateur1`
    FOREIGN KEY (`collaborateur_idcollab` )
    REFERENCES `cvtek`.`collaborateurs` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_mission_client_idx` ON `cvtek`.`missions` (`client_idclient` ASC) ;

CREATE INDEX `fk_mission_collaborateur1_idx` ON `cvtek`.`missions` (`collaborateur_idcollab` ASC) ;


-- -----------------------------------------------------
-- Table `cvtek`.`technologies`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cvtek`.`technologies` ;

CREATE  TABLE IF NOT EXISTS `cvtek`.`technologies` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `nom` VARCHAR(45) NOT NULL COMMENT 'Nom de la techno employée (java, spring…)' ,
  `descriptif` VARCHAR(200) NULL COMMENT 'Descriptif éventuel (ex : Talend est un ETL)\n' ,
  `version` VARCHAR(10) NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cvtek`.`missions_has_technologies`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cvtek`.`missions_has_technologies` ;

CREATE  TABLE IF NOT EXISTS `cvtek`.`missions_has_technologies` (
  `mission_id` INT NOT NULL ,
  `mission_client_id` INT NOT NULL ,
  `mission_collaborateur_id` INT NOT NULL ,
  `technologie_id` INT NOT NULL ,
  PRIMARY KEY (`mission_id`, `mission_client_id`, `mission_collaborateur_id`, `technologie_id`) ,
  CONSTRAINT `fk_mission_has_technologie_mission1`
    FOREIGN KEY (`mission_id` , `mission_client_id` , `mission_collaborateur_id` )
    REFERENCES `cvtek`.`missions` (`id` , `client_idclient` , `collaborateur_idcollab` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_mission_has_technologie_technologie1`
    FOREIGN KEY (`technologie_id` )
    REFERENCES `cvtek`.`technologies` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_mission_has_technologie_technologie1_idx` ON `cvtek`.`missions_has_technologies` (`technologie_id` ASC) ;

CREATE INDEX `fk_mission_has_technologie_mission1_idx` ON `cvtek`.`missions_has_technologies` (`mission_id` ASC, `mission_client_id` ASC, `mission_collaborateur_id` ASC) ;


-- -----------------------------------------------------
-- Table `cvtek`.`diplomes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cvtek`.`diplomes` ;

CREATE  TABLE IF NOT EXISTS `cvtek`.`diplomes` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `intitule` VARCHAR(45) NOT NULL COMMENT 'intitulé du diplome\n' ,
  `descriptif` VARCHAR(200) NULL COMMENT 'descriptif si nécessaire' ,
  `date` DATETIME NOT NULL COMMENT 'Date d\'obtention du diplôme' ,
  `collaborateur_idcollab` INT NOT NULL ,
  PRIMARY KEY (`id`, `collaborateur_idcollab`) ,
  CONSTRAINT `fk_experience_collaborateur1`
    FOREIGN KEY (`collaborateur_idcollab` )
    REFERENCES `cvtek`.`collaborateurs` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_experience_collaborateur1_idx` ON `cvtek`.`diplomes` (`collaborateur_idcollab` ASC) ;


-- -----------------------------------------------------
-- Table `cvtek`.`formations`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cvtek`.`formations` ;

CREATE  TABLE IF NOT EXISTS `cvtek`.`formations` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `intitule` VARCHAR(45) NOT NULL COMMENT 'Nom de la formation' ,
  `date` DATETIME NOT NULL COMMENT 'Date à laquelle la formation a été suivie' ,
  `descriptif` VARCHAR(200) NULL ,
  `institut_formation` VARCHAR(45) NOT NULL COMMENT 'nom de l\'organisme de formation' ,
  `collaborateur_idcollab` INT NOT NULL ,
  PRIMARY KEY (`id`, `collaborateur_idcollab`) ,
  CONSTRAINT `fk_formation_collaborateur1`
    FOREIGN KEY (`collaborateur_idcollab` )
    REFERENCES `cvtek`.`collaborateurs` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_formation_collaborateur1_idx` ON `cvtek`.`formations` (`collaborateur_idcollab` ASC) ;

USE `cvtek` ;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
