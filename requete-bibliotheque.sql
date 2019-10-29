-- ############ REQUETE BIBLIOTHEQUE ###################

-- Affichage des ID des livres qui n'ont pas été rendu
-- un champ NULL se test toujours avec IS
SELECT livre_id FROM emprunt WHERE date_rendu IS NULL;

-- +----------+
-- | livre_id |
-- +----------+
-- |      105 |
-- |      100 |
-- +----------+

-- ############ REQUETE IMBRIQUEE ###################

-- Affichage des titres des livres qui n'ont pas été rendu
SELECT titre FROM livre WHERE id_livre IN
    (SELECT livre_id FROM emprunt WHERE date_rendu IS NULL);

-- requete decomposée : 
SELECT titre FROM livre WHERE id_livre IN(100,105);

-- C'est la requete entre parenthèse qui est executée en premier, elle va selectionner les ID des livres non rendu. Ensuite la 2ème requete est executée et va selectionner le titre des livres dans la table 'livre'

-- +-------------------------+
-- | titre                   |
-- +-------------------------+
-- | Une vie                 |
-- | Les trois mousquetaires |
-- +-------------------------+

-- Exo : afficher la liste des abonnés n'ayant pas rendu des livres à la bibliothèque
SELECT prenom FROM abonne WHERE id_abonne IN
    (SELECT abonne_id FROM emprunt WHERE date_rendu IS NULL);

-- +---------+
-- | prenom  |
-- +---------+
-- | Benoit  |
-- | Chloé   |
-- +---------+

-- Exo : Nous aimzerions connaitre le n° de(s) livre(s) que Chloé a emprunté à la bibliothèque ? 
SELECT livre_id FROM emprunt WHERE abonne_id =
    (SELECT id_abonne FROM abonne WHERE prenom = 'Chloe');


-- +----------+
-- | livre_id |
-- +----------+
-- |      100 |
-- |      105 |
-- +----------+

-- Exo : Afficher les prénoms des abonnés ayant emprunté un livre le 19/12/2014  
SELECT prenom FROM abonne WHERE id_abonne IN 
    (SELECT abonne_id FROM emprunt WHERE date_sortie = '2014-12-19');

-- +-----------+
-- | prenom    |
-- +-----------+
-- | Guillaume |
-- | Chloé     |
-- | Laura     |
-- +-----------+

-- Exo :combien de livres Guillaume a emprunté à la bibliothèque ? 
SELECT COUNT(livre_id) AS 'nombre de livre' FROM emprunt WHERE abonne_id = (SELECT id_abonne FROM abonne WHERE prenom = 'Guillaume');

-- +-----------------+
-- | nombre de livre |
-- +-----------------+
-- |               2 |
-- +-----------------+

-- Exo : Afficher la liste des abonnés ayant déja emprunté un livre d'ALPHONSE DAUDET ? 
SELECT prenom FROM abonne WHERE id_abonne IN
    (SELECT abonne_id FROM emprunt WHERE livre_id IN 
        (SELECT id_livre FROM livre WHERE auteur = 'Alphonse DAUDET'));

-- +--------+
-- | prenom |
-- +--------+
-- | Laura  |
-- +--------+

-- Exo : Afficher le titre des livres que Chloé a emprunté à la bibliothèque ? 
SELECT titre FROM livre WHERE id_livre IN 
    (SELECT livre_id FROM emprunt WHERE abonne_id =  
        (SELECT id_abonne FROM abonne WHERE prenom = 'Chloe'));

-- +-------------------------+
-- | titre                   |
-- +-------------------------+
-- | Une vie                 |
-- | Les trois mousquetaires |
-- +-------------------------+

-- Exo : Afficher le titre des livres que Chloé n'a pas encore emprunté à la bibliothèque ? 
SELECT titre FROM livre WHERE id_livre NOT IN 
    (SELECT livre_id FROM emprunt WHERE abonne_id =  
        (SELECT id_abonne FROM abonne WHERE prenom = 'Chloe'));

-- +-----------------+
-- | titre           |
-- +-----------------+
-- | Bel-Ami         |
-- | Le père goriot  |
-- | Le petit chose  |
-- | La reine margot |
-- +-----------------+

-- Exo : Afficher le titre des livres que Chloé n'a pas encore rendu à la bibliothèque ? 
SELECT titre FROM livre WHERE id_livre IN 
    (SELECT livre_id FROM emprunt WHERE date_rendu IS NULL AND abonne_id = (SELECT id_abonne FROM abonne WHERE prenom = 'Chloe'));

-- +-------------------------+
-- | titre                   |
-- +-------------------------+
-- | Les trois mousquetaires |
-- +-------------------------+

-- Exo : Qui a emprunté le plus de livres à la bibliothèque ? 
SELECT prenom FROM abonne WHERE id_abonne = 
    (SELECT abonne_id FROM emprunt GROUP BY abonne_id ORDER BY COUNT(abonne_id) DESC LIMIT 0,1);

-- +--------+
-- | prenom |
-- +--------+
-- | Benoit |
-- +--------+

-- ############ JOINTURE ###################

-- Nous aimerions connaitre les dates de sortie et de rendu pour l'abonné Guillaume ?

SELECT a.prenom, e.date_sortie, e.date_rendu
FROM abonne a, emprunt e 
WHERE a.id_abonne = e.abonne_id
AND a.prenom = 'Guillaume';
-- 1e ligne : ce que je souhaite afficher
-- 2e ligne : de quelle table cela provient, et de quelle table je vais avoir besoin ? 
-- 3e ligne : condition, quel est le champ en commun dans les 2 tables qui me permet d'effectuer la jointure

-- +-----------+-------------+------------+
-- | prenom    | date_sortie | date_rendu |
-- +-----------+-------------+------------+
-- | Guillaume | 2014-12-17  | 2014-12-18 |
-- | Guillaume | 2014-12-19  | 2014-12-28 |
-- +-----------+-------------+------------+

SELECT date_sortie, date_rendu FROM emprunt WHERE abonne_id = 
    (SELECT id_abonne FROM abonne WHERE prenom = 'Guillaume');

-- +-------------+------------+
-- | date_sortie | date_rendu |
-- +-------------+------------+
-- | 2014-12-17  | 2014-12-18 |
-- | 2014-12-19  | 2014-12-28 |
-- +-------------+------------+

-- Différence entre jointure & requete imbriquée : 
-- Une jointure et une requete imbriquée permettent de faire des relations entre les différentes tables afin d'avoir des colonnes associé pour former qu'un seul résultat
-- Une jointure est possible dans tout les cas
-- Une requete imbriquée est possible seulement dans le cas où le résultat est issue de la même table
-- Les requetes imbriquée ont l'avantage de s'executer plus rapidement 

-- Exo : nous aimerions connaitre les mouvements des livres (date sortie et rendu) écrit par Alphonse Daudet


-- Si vous l'avez trouvé en jointure, est il possible de trouver le resultat en requete imbiquée ? Alors, allez y !












