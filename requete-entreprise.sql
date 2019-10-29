-- REQUETE ENTREPRISE

-- Par convention les requetes et commandes SQL s'écrivent toujours en majuscule

CREATE DATABASE nom_BDD; -- permet de créer une nouvelle BDD 

SHOW DATABASES; -- permet de voir toute les BDD

USE nom_de_la_BDD; -- permet d'utiliser / selectionner une BDD

DROP DATABASE nom_BDD; -- permet de supprimer une BDD

DROP TABLE nom_de_la_table; -- permet de supprimer une table

TRUNCATE nom_de_la_table; -- permet de vider une table;

-- Toutes requetes dt commandes SQL se terminent toujours par un point virgule ';' c'est le délimiteur

DESC employes; -- Observer la structure de la table (DESC pour describe, c'est la description)

-- ################ REQUETE DE SELECTION (affichage) ###############--

-- Affichage complET de la table 'employes'
SELECT id_employes, prenom, nom, sexe, service, date_embauche, salaire FROM employes;

SELECT * FROM employes; 
-- Affichage de la table employes avec le raccourci de l'étoile '*' pour dire "ALL" 
-- AFFICHE MOI [toute les colonnes] DE LA TABLE employes

-- Exo : afficher les noms et prénoms des employés travaillant dans l'entreprise
SELECT prenom, nom FROM employes;

-- Exo : Quels ont les différents service occupés par les employés travillant dans l'entreprise ? 
SELECT service FROM employes;

SELECT DISTINCT service FROM employes;

-- condition WHERE 
-- Affichage de tout les employés du service informatique
SELECT nom, prenom, service FROM employes WHERE service = 'informatique';
-- WHERE : à condition que
-- Il ne peut y avoir qu'une seule conditions WHERE par requete
-- AFFICHE MOI nom, prenom, service DE LA TABLE employes A CONDITION QUE le champs service de la BDD soit bien égal à 'informatique'

-- BETWEEN 
-- Affichage des employés ayant été recruté entre 2010 et aujourd'hui
SELECT nom, prenom, date_embauche FROM employes WHERE date_embauche BETWEEN '2010-01-01' AND '2019-10-22';

SELECT CURDATE(); -- fonction prédéfinie SQL qui affiche / retourne la date du jour

SELECT nom, prenom, date_embauche FROM employes WHERE date_embauche BETWEEN '2010-01-01' AND CURDATE(); -- il est possible d'intégrer des fonctions prédéfinies avec des requêtes SQL

-- LIKE : valeur approchante 
-- Affichage des employés ayant un prénom commencant par la lettre 's' | % : peut importe la suite....
SELECT prenom FROM employes WHERE prenom LIKE 's%';
-- Affichage des employés ayant un prénom finissant par la lettre 's' | % : peut importe le début....
SELECT prenom FROM employes WHERE prenom LIKE '%s';

-- Affichage des prénoms composés 
SELECT prenom FROM employes WHERE prenom LIKE '%-%';

-- ID   -- NOM  -- code postal
-- 1    Appart1     75015
-- 2    Appart2     75001
-- 3    Appart3     75017
-- 4    Appart4     28000

-- SELECT * FROM appartement WHERE code_postal = 75; /!\ !! erreur ! resultat vide
-- SELECT * FROM appartement WHERE code_postal LIKE '75%'; /!\ OK bonne formulation

/*
    OPERATEUR DE COMPARAISON
    =       égal à
    <       strictement inférieur
    >       strictement supérieur
    <=      inférieur ou égal à 
    >=      supérieur ou égal à
    AND     ET
    OR      OU
    !=      différent de
*/

-- Affichage de tous les employés (sauf les informaticiens)
SELECT nom, prenom, service FROM employes WHERE service != 'informatique';
-- != différent de... permet d'exclure une valeur

-- Affichage de tous les employés gagnant un salaire supérieur à 3000€
SELECT nom, prenom, service, salaire FROM employes WHERE salaire > 3000;

-- ORDER BY 
-- ASC
-- Affichage des employés par ordre alphabétique
SELECT prenom FROM employes ORDER BY prenom ASC;
SELECT prenom FROM employes ORDER BY prenom;
-- ASC : ascendant croissant, par défaut les ordenements sont fait par ordre alphabétique

-- DESC
SELECT prenom FROM employes ORDER BY prenom DESC; -- DESC descendant, decroissant 
-- ORDER BY permet d'effectuer un classement

-- LIMIT 
-- Affichage des employés 3 par 3 
SELECT prenom FROM employes ORDER BY prenom LIMIT 0,3;
SELECT prenom FROM employes ORDER BY prenom LIMIT 3,4;
SELECT prenom FROM employes ORDER BY prenom LIMIT 6,5;
-- LIMIT 0,3 : 0 => point de départ | 3 => nombre de selection souhaité 

-- Affichage des employés avec un salaire annuel 
SELECT prenom, salaire*12 FROM employes ORDER BY salaire DESC;
SELECT prenom, salaire*12 AS 'salaire_annuel' FROM employes ORDER BY salaire DESC;
-- AS : alias

-- SUM() : fonction prédéfinie SQL
-- Affichage de la "masse salariale" sur 12 mois
SELECT SUM(salaire*12) AS 'masse_salariale' FROM employes;
-- SUM : somme 

-- AVG() : fonction prédéfinie SQL 
-- Affichage du salaire moyen 
SELECT AVG(salaire) AS 'salaire_moyen' FROM employes;
-- AVG : permet de calculer une moyenne
-- ROUND() : fonction prédéfinie SQL 
SELECT ROUND(AVG(salaire),2) AS 'salaire_moyen' FROM employes;
-- ROUND : permet d'arrondir

-- COUNT() : fonction prédéfinie SQL
-- Affichage du nombre de femme dans l'entreprise 
SELECT COUNT(*) AS 'Nombre_femmes' FROM employes WHERE sexe = 'f';

-- MIN/MAX : fonction prédéfinie  SQL
-- Affichage du salaire minimum / maximum
SELECT MIN(salaire) AS 'salaire le plus bas' FROM employes;
SELECT MAX(salaire) AS 'salaire le plus eleve' FROM employes;

-- Exo : afficher les informations de l'employé qui gagne le salaire le plus bas  
SELECT prenom, nom, service, MIN(salaire) AS 'salaire le plus bas' FROM employes; -- /!\ resultat incohérent !!! l'interpréteur ne peut pas tout faire en même temps 

SELECT prenom, nom, salaire FROM employes WHERE salaire = (SELECT MIN(salaire) FROM employes); 
-- La requete entre parenthèses s'execute en premeier et va chercher le salaire minimum et ensuite la 2ème requete s'execute et on recupère les informations de l'employé, c'est une requete imbriquée sur le même table 

SELECT prenom, nom, salaire FROM employes ORDER BY salaire LIMIT 0,1;

-- IN 
-- Affichage des employés travaillant dans le service informatique et comptabilité 
SELECT prenom, service FROM employes WHERE service IN('informatique', 'comptabilite');
-- IN : permet d'inclure plusieurs valeurs 
-- = : permet d'inclure une seule valeur

-- NOT IN 
-- Affichage de tout les employé employés sauf ceux du service informatique et comptabilité 
SELECT prenom, service FROM employes WHERE service NOT IN('informatique', 'comptabilite');
-- != permet d'exclure une seule valeur
-- NOT IN : permet d'exculre plusieurs valeurs 

-- Exo : afficher les commerciaux gagnant un salaire infèrieur ou égal à 2000€
SELECT prenom, nom, salaire, service FROM employes WHERE service = 'commercial' AND salaire < 2000; 
-- AND : et... (condition complémentaire)

-- OR 
-- Affichage des commerciaux gagnat un salaikre de 1900 ou 2300€
SELECT prenom, nom, service, salaire FROM employes WHERE service = 'commercial' AND (salaire = 2300 OR salaire = 1900);
-- Sans les aprenthèses le test ne fonctionne pas, il faut respecter l'ordre des priorité des conditions

-- GROUP BY 
-- Affichage du nombre d'employé par service 
SELECT service, COUNT(*) AS 'nombre' FROM employes GROUP BY service; 
-- GROUP BY : permet d'effectuer des regourpements
-- GROUP BY va ré-associer +1 par service 
/*
    comptabilite
    informatique
    direction 1+1 
    production
    commercial 1+1+1 
*/

-- ########### REQUETE D'INSERTION ##############

INSERT INTO employes (prenom, nom, sexe, service, date_embauche, salaire) VALUES ('Grégory', 'LACROIX', 'm', 'présidence', '2019-10-22', 15000);
-- INSERT INTO nom_de_la_table (nom_des_champs) VALUES ('nouvelle valeur', '','');
-- l'ordre des champs appelé doit être le même que les valeurs définit

-- SI nous sommes sûr d'insérer dans toute les colonnes / champs de la table, il n'est pas nécessaire d'appelé les champs entre parenthèse mais d'envoyer directement les valeurs 
-- NULL permet d'envoyer une valeur par défaut pour la colonne id_employes (clé primaire) 
INSERT INTO employes VALUES (NULL, 'Emmanuel', 'Macron', 'm', 'poubelle','2019-10-22', 1);

-- INSERT INTO employes VALUES (DEFAULT, 'Emmanuel', 'Macron', 'm', 'poubelle','2019-10-22', 1);

-- INSERT INTO employes VALUES ('', 'Emmanuel', 'Macron', 'm', 'poubelle','2019-10-22', 1);

-- Il est possible de définir notre porpre ID
INSERT INTO employes VALUES (8059, 'toto', 'toto', 'm', 'poubelle','2019-10-22', 1);

-- ########### REQUETE DE MODIFICATION ##############

-- Modification du salaire et du service de l'employé ID 350
UPDATE employes SET salaire = '1200', service = 'poubelle' WHERE id_employes = 350;
-- UPDATE nom_de_la_table SET colonne = 'nouvelle valeur', colonne = 'nouvelle valeur' WHERE condition complémentaire 

INSERT INTO employes (id_employes, prenom, nom,sexe, service, date_embauche, salaire) VALUES (8065, 'toto2', 'toto2', 'm', 'poubelle','2019-10-22', 2000);

-- Si l'ID est connu dans la BDD, REPLACE secomporte comme un update
REPLACE INTO employes (id_employes, prenom, nom,sexe, service, date_embauche, salaire) VALUES (8065, 'toto2', 'toto2', 'm', 'cuisine','2019-10-22', 3000);

-- Si l'ID n'est pas connu dans la BDD, REPLACE se comporte comme un INSERT
REPLACE INTO employes (id_employes, prenom, nom,sexe, service, date_embauche, salaire) VALUES (NULL, 'toto2', 'toto2', 'm', 'cuisine','2019-10-22', 3000);

-- ########### REQUETE DE SUPPRESSION ##############

-- Suppression de l'employé ID 350
DELETE FROM employes WHERE id_employes = 350;
-- DELETE FROM nom_sde_la_table WHERE condition complémentaire

