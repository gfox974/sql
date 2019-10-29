DROP SCHEMA IF EXISTS taxis;
CREATE SCHEMA taxis;
USE taxis;
CREATE TABLE `conducteur` (
  `ID_CONDUCTEUR` INT(3) NOT NULL AUTO_INCREMENT,
  `PRENOM` VARCHAR(20) NOT NULL DEFAULT '',
  `NOM` VARCHAR(20) NOT NULL DEFAULT '',
  PRIMARY KEY (`ID_CONDUCTEUR`)
)
ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `vehicule` (
  `ID_VEHICULE` INT(3) NOT NULL AUTO_INCREMENT,
  `MARQUE` VARCHAR(20) NOT NULL DEFAULT '',
  `MODELE` VARCHAR(20) NOT NULL DEFAULT '',
  `COULEUR` VARCHAR(20) NOT NULL DEFAULT '',
  `IMMATRICULATION` VARCHAR(20) NOT NULL DEFAULT '',
  PRIMARY KEY (`ID_VEHICULE`)
)
ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `association_vehicule_conducteur` (
  `ID_ASSOCIATION` INT(3) NOT NULL AUTO_INCREMENT,
  `ID_VEHICULE` INT(3) DEFAULT NULL,
  `ID_CONDUCTEUR` INT(3) DEFAULT NULL,
  PRIMARY KEY (`ID_ASSOCIATION`),
  FOREIGN KEY `ID_CONDUCTEUR` (`ID_CONDUCTEUR`) REFERENCES `conducteur` (`ID_CONDUCTEUR`) ON DELETE RESTRICT ON UPDATE RESTRICT;
  FOREIGN KEY `ID_VEHICULE` (`ID_VEHICULE`) REFERENCES `vehicule` (`ID_VEHICULE`) ON DELETE RESTRICT ON UPDATE RESTRICT;
)
ENGINE=InnoDB DEFAULT CHARSET=utf8;


INSERT INTO `conducteur` (PRENOM, NOM) VALUES
('Julien', 'Avigny'),
('Morgane', 'Alamia'),
('Philippe', 'Pandre'),
('Amelie', 'Blondelle'),
('Alex', 'Richy');
INSERT INTO `association_vehicule_conducteur` (ID_VEHICULE, ID_CONDUCTEUR) VALUES
(501, 1),
(502, 2),
(503, 3),
(504, 4),
(501, 3);
INSERT INTO `vehicule` (MARQUE, MODELE, COULEUR, IMMATRICULATION) VALUES
('Peugeot', '807', 'noir','AB-355-CA'),
('Citroen', 'C8', 'bleu','CE-122-AE'),
('Mercedes', 'Cls', 'vert','FG-953-HI'),
('Volkswagen', 'Touran', 'noir','SO-322-NV'),
('Skoda', 'Octavia', 'gris','PB-631-TK'),
('Volkswagen', 'Passat', 'gris','XN-973-MM');