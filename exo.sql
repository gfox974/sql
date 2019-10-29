-- 1 -- Afficher la profession de l'employé 547
SELECT service FROM employes WHERE id_employes = 547;		
-- 2 -- Afficher la date d'embauche d'Amandine.
SELECT date_embauche FROM employes WHERE prenom = 'Amandine';		
-- 3 -- Afficher le nom de famille de Guillaume
SELECT nom FROM employes WHERE prenom = 'Guillaume';
-- 4 -- Afficher le nombre de personne ayant un né id_employes commenéant par le chiffre 5.
SELECT COUNT(*) AS 'nombre' FROM employes WHERE id_employes LIKE '5%';
-- 5 -- Afficher le nombre de commerciaux.
SELECT COUNT(*) AS 'nombre_commerciaux' FROM employes WHERE service = 'commercial';
-- 6 -- Afficher le salaire moyen des informaticiens (+arrondie).
SELECT ROUND(AVG(salaire),2) AS 'salaire moyen' FROM employes WHERE service = 'informatique';
-- 7 -- Afficher les 5 premiers employés aprés avoir classer leur nom de famille par ordre alphabétique.
SELECT nom FROM employes ORDER BY nom LIMIT 0,5;
-- 8 -- Afficher le cout des commerciaux sur 1 année.
SELECT SUM(salaire*12) AS 'masse salariale' FROM employes WHERE service = 'commercial';
-- 9 -- Afficher le salaire moyen par service. (service + salaire moyen)
SELECT service, ROUND(AVG(salaire),2) AS 'salaire par service' FROM employes GROUP BY service;
-- 10 -- Afficher le nombre de recrutement sur l'année 2010 (+alias).
SELECT COUNT(*) FROM employes WHERE date_embauche LIKE '2010%';	

SELECT COUNT(*) FROM employes WHERE date_embauche BETWEEN  '2010-01-01' AND '2010-12-31';		

SELECT COUNT(*) FROM employes WHERE date_embauche >= '2010-01-01' AND date_embauche <= '2010-12-31';

-- 11 -- Afficher le salaire moyen appliqué lors des recrutements sur la période allant de 2005 a 2007
SELECT ROUND(AVG(salaire),2) AS 'salaire_moyen' FROM employes WHERE date_embauche BETWEEN '2005-01-01' AND '2007-12-31';
-- 12 -- Afficher le nombre de service différent
SELECT COUNT(DISTINCT service) AS 'nombre_service' FROM employes;
-- 13 -- Afficher tous les employés (sauf ceux du service production et secrétariat)
SELECT prenom, nom, service, salaire FROM employes WHERE service NOT IN('production', 'secretariat');
-- 14 -- Afficher conjoitement le nombre d'homme et de femme dans l'entreprise
SELECT sexe, COUNT(*) AS 'Nombre' FROM employes GROUP BY sexe; 
-- 15 -- Afficher les commerciaux ayant été recrutés avant 2005 de sexe masculin et gagnant un salaire supérieur a 2500 é
SELECT nom, prenom, service, date_embauche, salaire FROM employes WHERE service = 'commercial' AND salaire > 2500 AND sexe = 'm' AND date_embauche < '2005-01-01';
-- 16 -- Qui a été embauché en dernier
SELECT nom, prenom, date_embauche FROM employes ORDER BY date_embauche DESC LIMIT 0,1;

SELECT * FROM employes WHERE date_embauche = (SELECT MAX(date_embauche) FROM employes);
-- 17 -- Afficher les informations sur l'employé du service commercial gagnant le salaire le plus élevé
SELECT nom, prenom, MAX(salaire) FROM employes WHERE service = 'commercial';

SELECT * FROM employes WHERE service  = 'commercial' ORDER BY salaire DESC LIMIT 0,1;

SELECT * FROM employes WHERE service = 'commercial' AND salaire = (SELECT MAX(salaire) FROM employes WHERE service  = 'commercial');

-- 18 -- Afficher le prénom du comptable gagnant le meilleur salaire
SELECT prenom, salaire, service FROM employes WHERE service = 'comptabilite' ORDER BY salaire DESC LIMIT 0,1;

SELECT prenom, salaire, service FROM employes WHERE service = 'comptabilite' AND salaire = (SELECT MAX(salaire) FROM employes WHERE service = 'comptabilite');

-- 19 -- Afficher le prénom de l'informaticien ayant été recruté en premier
SELECT prenom FROM employes WHERE service = 'informatique' ORDER BY date_embauche LIMIT 0,1;

SELECT prenom FROM employes WHERE service = 'informatique' AND date_embauche = (SELECT MIN(date_embauche) FROM employes WHERE service = 'informatique');

-- 20 -- Augmenter chaque employé de 100 €
    UPDATE employes SET salaire = salaire  + 100;
-- 21 -- Supprimer les employés du service secrétariat
DELETE FROM employes WHERE service = 'secretariat';