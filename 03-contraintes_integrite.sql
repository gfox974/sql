-- base contraintes --
-- tables : 
-- article : id_article pk ai int3 | titre varchar20 | couleur varchar20 | prix int3 | fournisseur_id fk
-- fournisseur : id_fournisseur pk ai int3 | nom varchar20 | ville varchar20

--- scriptouille --
-- ## Structuration ## --
-- crea du schema --
DROP SCHEMA IF EXISTS contraintes;
CREATE SCHEMA contraintes;
USE contraintes;
------- crea des tables --
CREATE TABLE `article` (
  `ID_ARTICLE` INT(3) NOT NULL AUTO_INCREMENT,
  `TITRE` VARCHAR(20) NOT NULL DEFAULT '',
  `COULEUR` VARCHAR(20) NOT NULL DEFAULT '',
  `PRIX` INT(3) NOT NULL DEFAULT '0',
  `STOCK` INT(3) NOT NULL DEFAULT '0',
  `FOURNISSEUR_ID` INT(3) DEFAULT '0',
  PRIMARY KEY (`ID_ARTICLE`),
  KEY `FOURNISSEUR_ID` (`FOURNISSEUR_ID`)
)
ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `fournisseur` (
  `FOURNISSEUR_ID` INT(3) NOT NULL AUTO_INCREMENT,
  `NOM` VARCHAR(20) NOT NULL DEFAULT '',
  `VILLE` VARCHAR(20) NOT NULL DEFAULT '',
  PRIMARY KEY (`FOURNISSEUR_ID`),
  KEY `FOURNISSEUR_ID` (`FOURNISSEUR_ID`)
)
ENGINE=InnoDB DEFAULT CHARSET=utf8;
--- jonction des deux tables ---
ALTER TABLE `article` ADD FOREIGN KEY (`FOURNISSEUR_ID`) REFERENCES `fournisseur` (`FOURNISSEUR_ID`) ON DELETE RESTRICT ON UPDATE RESTRICT; -- attention aux restrict et mode cascade 
---- Remplissage des tables --
INSERT INTO `fournisseur` (NOM, VILLE) VALUES
('Auchan', 'Paris'),
('Carrefour', 'Marseille');

INSERT INTO `article` (TITRE, COULEUR, PRIX, STOCK, FOURNISSEUR_ID) VALUES
('T-shirt', 'bleu', 10, 20, 1),
('Chemise', 'noir', 50, 600, 1),
('Chausettes', 'blanc', 30, 500, 1),
('Chaussures', 'noir', 35, 250, 2),
('Parapluie', 'orange', 35, 120, 2);


----
ALTER TABLE "article" DROP FOREIGN KEY "article_ibfk_1"; ALTER TABLE "article" ADD CONSTRAINT "article_ibfk_1" FOREIGN KEY ("fournisseur_id") REFERENCES "fournisseur"("id_fournisseur") ON DELETE SET NULL ON UPDATE RESTRICT; -- Permet de modifer le ON DELETE ET LE ON UPDATE.
ALTER TABLE "article" CHANGE "fournisseur_id" "fournisseur_id" INT(3) NULL; -- Permet d'accepter la valeur NULL.
DELETE FROM fournisseur WHERE id_fournisseur=2;
----

-- Contraintes d'integrité --
-- Les contraintes d'integrité permettent de gerer la bdd et avant tout de ne pas pouvoir entrer de donnees fantomes dans celle ci

-- 4 contraintes d'integrité :
-- CASCADE : repercution
-- SET NULL : inscrit NULL
-- NO ACTION : effectue puis restaure
-- RESTRICT : restrictif, interdit

-- CASCADE = Si nous modifions ou supprimons un element de la bdd, tout ce qui lui est associé sera egalement supprimé ou modifié
-- SET NULL = Si nous modifions ou supprimons un element de la bdd, la valeur initiale sera remplacée par la valeur NULL
-- NO ACTION / RESTRICT = Pas de difference entre les deux, nous ne pourrons ni modifier ni supprimer tant qu'il y aura une relation entre les tables, par exemple si un produit est associe a un fournisseur existant, on ne pourra pas modifier ou supprimer le fournisseur tant que le produit lui est associé
