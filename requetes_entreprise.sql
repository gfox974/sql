-- Requetes que l'on va passer --

create database nom_bdd; -- permet de creer une nouvelle bdd --
show databases; -- permet de voir les bases de donnees
use nom_ ; -- utiliser / selectionner la ressource
drop nom_ ; -- detruit la ressource
truncate nom_de_la_table; -- purge le contenu de la table
desc nom_ ; -- decrire la structure d'une table

-- #############################            methodes de selection ############################################## --
-- afficher toute la table employés --
select id_employes, prenom, nom, sexe, service, date_embauche, salaire from employes;
ou select * from employes;

-- exo : lister les employer avec nom et prenom --
select prenom, nom from employes;

-- exo : quels sont les differents services occupés par les employés de l'entreprise ? --
select distinct service from employes;

-- condition where -
-- affichage de tous les employes du service informatique -
select prenom,nom from employes where service='informatique';

-- between --
-- affichage des employés ayant été recrutés entre 2010 et aujourd'hui --
select prenom, nom from employes where date_embauche between '2010-01-01' and '2019-10-22';
-- ( plus clean : ) --
select prenom, nom, date_embauche from employes where date_embauche between '2010-01-01' and now(); -- ou CURDATE(); --

-- like --
-- selectionner les employés ayant un prénom commencant par s --
select prenom from employes where prenom like 's%'; -- match debut
-- ici la meme, mais finissant par s --
select prenom from employes where prenom like '%s'; -- match fin
-- là les prenoms composés --
select prenom from employes where prenom like '%-%'; -- match milieu

-- exemple exo : --
-- ID | NOM | Code | postal --
-- 1    | Appart1   | 75015
-- 2    | Appart2   | 75001
-- 3    | Appart3   | 75017
-- 4    | Appart4   | 28000

-- On veut ceux de paris --
select * from exemple where postal like '75%';

-- operateurs --
-- = egal
-- < inferieur à
-- > superieur à
-- and, or, !=, >=, <= etc. --

-- selectionner tous ceux qui ne sont pas dans le service info --
select nom, prenom, service from employes where service != 'informatique';

-- afficher ceux qui ont un salaire > 3000€ --
select nom, prenom, service, salaire from employes where salaire >= 3000;

-- order by --
select prenom from employes order by prenom asc; -- l'order se fait par defaut ( asc: ascendant, soit ordre alphabetique )
select prenom from employes order by prenom desc; -- decroissant

-- limit --
-- ex : affichage des employés 3 par 3 --
select prenom from employes order by prenom limit 0,3;

-- affichage des employés avec leur salaire annuel (on va multiplier le mensuel * 12) --
select prenom, nom, salaire*12 from employes;
-- ici, la meme mais classée en decroissant et avec un alias pour la colonne generée --
select prenom, nom, salaire*12 as "salaire annuel" from employes order by salaire desc;

-- sum --
-- ex : affichage de la masse salariale sur 12 mois --
-- on va faire le total des salaires sur 12 mois --
select sum(salaire*12) as "masse salariale" from employes;

-- avg --
-- ex : affichage du salaire moyen --
select avg(salaire) as "salaire moyen" from employes;
-- la meme arrondi a deux decimales apres la virgule --
select round(avg(salaire),2) as "salaire moyen" from employes;

-- count --
-- ex : afficher le nombre de femmes dans l'entreprise --
select count(*) as "nombre de femmes" from employes where sexe='f';

-- min / max --
-- ex : affichage de qui ont les salaires mini / maxi
select nom, prenom, min(salaire) as "mensuel plus bas" from employes; -- > on remarque que les noms / prenoms recuperés correspondent au premier match, pas à ce qui corresponds au resultat de la fonction
select nom, prenom, max(salaire) as "mensuel plus haut" from employes;

-- si on veut cumuler le resultat des deux il faut forger la requete autrement : --
select prenom, nom, salaire from employes where salaire = (select min(salaire) from employes); -- ici, requete imbriquée, c'est le resultat de la requete imbriquée qui passe en argument --
select prenom, nom, salaire from employes order by salaire limit 0,1; -- desc ou asc, selon quelle metrique on veut

-- in --
-- affichage des employés travaillant dans le service info et compta
select prenom, nom, service from employes where service in('informatique','comptabilite');
-- in permet de match plusieurs valeurs, = une seule.

-- ici on va faire le contraire :
select prenom, nom, service from employes where service not in('informatique','comptabilite');

-- and --
-- exo : afficher les commerciaux gagnant un salaire inferieur ou egal a 2000€
select prenom, nom, service, salaire from employes where service ="commercial" and salaire <= 2000;

-- or --
-- affichage des commerciaux gagnant un salaire de 1900 ou 2300 euros
select prenom, nom, service, salaire from employes where service="commercial" and salaire = 1900 or salaire = 2300;

-- si on inverse les criteres, la condition where est supplantée par le or niveau prio :
select prenom, nom, service, salaire from employes where service="commercial" and salaire = 2300 or salaire = 1900;
-- il faut donc segmenter correctement les priorités :
select prenom, nom, service, salaire from employes where service="commercial" and (salaire = 2300 or salaire = 1900);

-- group by --
-- ex : affichage du nombre d'employés par services
select service, count(*) as "nombre" from employes group by service;


-- ############################# methodes de modifications ############################################## --

-- insertion :

insert into employes (prenom, nom, sexe, service, date_embauche, salaire) values ('Gregory','lacroix','m','presidence','2019-10-22', 15000);

-- Sur celle ci on sait que l'on va renseigner a peu pres tous les champs, on peut ne pas preciser quels champs on renseigne, mais il faut quand meme envoyer une valeur pour le champ id du coup
insert into employes values (NULL, 'Emmanuel','macron','m','poubelle','2019-10-22', 1); -- DEFAULT, NULL, "" font la meme chose

-- update :
-- on va changer le salaire d'emmanuel macron :
update employes set salaire = '1200', service = 'poubelle' where id_employes = 992;

-- ex :
-- on crée toto
insert into employes values (993, 'toto','le dodo','m','poubelle','2019-10-22', 2000);
-- on modifie toto :
replace into employes values (993, 'toto','le dodo','m','cuisine','2019-10-22', 2000);
-- ca fonctionne comme un update, toute la ligne liée à l'id est réaffectée, si l'id ne match pas à un id existant, replace fera un insert et generera une nouvelle ligne

--- ############ Requetes de suppressions ## --
delete from employes where id_employes='350'; -- > Bye bye jean-pierre ! ( si on ne met pas de where, on purge toute la table, gaffe.)


---- ########## Exos ######### --------
-- 1 -- Afficher la profession de l'employé 547 :
select service from employes where id_employe='547';
-- 2 -- Afficher la date d'embauche d'Amandine. :
select date_embauche from employes where prenom='Amandine';
-- 3 -- Afficher le nom de famille de Guillaume :
select nom from employes where prenom='Guillaume';
-- 4 -- Afficher le nombre de personne ayant un né id_employes commenéant par le chiffre 5. :
select count(*) as 'nombre' from employes where id_employe like '5%';
-- 5 -- Afficher le nombre de commerciaux. :
select count(*) as 'nombre_commerciaux' where service='commercial';
-- 6 -- Afficher le salaire moyen des informaticiens (+arrondie). :
select round(avg(salaire)) as 'salaire_moyen' from employes where service='informatique'; 
-- 7 -- Afficher les 5 premiers employés aprés avoir classer leur nom de famille par ordre alphabétique. :
select nom from employes order by nom limit 0,5;
-- 8 -- Afficher le coét des commerciaux sur 1 année. :
select salaire, sum(salaire*12) as 'masse salariale' from employes where service='commercial';
-- 9 -- Afficher le salaire moyen par service. (service + salaire moyen) :
select service, round(avg(salaire),2) as "moyenne salaire" from employes group by service;
-- 10 -- Afficher le nombre de recrutement sur l'année 2010 (+alias). :
select count(*) from employes where date_embauche between '2010-01-01' and '2010-12-31';
-- 11 -- Afficher le salaire moyen appliqué lors des recrutements sur la période allant de 2005 a 2007 :
select round(avg(salaire),2) as "moyenne salaire 2005/2007" from employes where date_embauche between '2005-01-01' and '2007-12-31';
-- 12 -- Afficher le nombre de service différent :
select count(distinct service) as 'nombre de services' from employes;
-- 13 -- Afficher tous les employés (sauf ceux du service production et secrétariat) :
select nom, prenom, service where service not in ('production','secretariat');
-- 14 -- Afficher conjoitement le nombre d'homme et de femme dans l'entreprise :
select sexe, count(*) as 'nombre' from employes group by sexe;
-- 15 -- Afficher les commerciaux ayant été recrutés avant 2005 de sexe masculin et gagnant un salaire supérieur a 2500 é :
select nom, prenom, service, date_embauche, salaire from employes where service = 'commercial' and salaire > 2500 and sexe ='m' and date_embauche < '2005-01-01';
-- 16 -- Qui a été embauché en dernier :
select * from employes where date_embauche = (select max(date_embauche) from employes);
-- 17 -- Afficher les informations sur l'employé du service commercial gagnant le salaire le plus élevé :
select * from employes where service ='commercial' order by salaire desc limit 0,1;
ou
select * from employes where service ='commercial' and salaire=(select max(salaire) from employes where service='commercial');
-- 18 -- Afficher le prénom du comptable gagnant le meilleur salaire :
select prenom, salaire, service from employes where service='comptabilite';
-- 19 -- Afficher le prénom de l'informaticien ayant été recruté en premier :
select prenom from employes where service='informatique' and date_embauche = (select min(date_embauche) from employes where service='informatique');
-- 20 -- Augmenter chaque employé de 100 é :
update employes set salaire = (salaire + 100);
-- 21 -- Supprimer les employés du service secrétariat :
delete from employes where service='secretariat';


----- Partie base biblio --
-- base crée, tables créees --

-- remplissage :
INSERT INTO abonne (id_abonne, prenom) VALUES
(DEFAULT, 'Guillaume'),
(DEFAULT, 'Benoit'),
(DEFAULT, 'Chloe'),
(DEFAULT, 'Laura');

INSERT INTO livres (livre_id, auteur, titre) VALUES
(100, 'Jules Vernes','20000 lieues sous les mers'),
(101, 'Jules Vernes','Voyage au centre de la terre'),
(103, 'Jules Vernes','De la terre a la lune'),
(104, 'Isaac Asimov','Fondations'),
(105, 'Alexandre Dumas','Les trois mousquetaires');

INSERT INTO emprunts (id_emprunt, livre_id, abonne_id, date_sortie, date_rendu) VALUES
(DEFAULT, 100,1,'2014-12-17','2014-12-18'),
(DEFAULT, 101,2,'2014-12-18','2014-12-20'),
(DEFAULT, 100,3,'2014-12-19','2014-12-22'),
(DEFAULT, 103,4,'2014-12-19','2014-12-22'),
(DEFAULT, 104,1,'2014-12-19','2014-12-28'),
(DEFAULT, 105,2,'2015-03-20','2015-03-26'),
(DEFAULT, 105,3,'2015-06-13',NULL),
(DEFAULT, 100,2,'2015-06-15',NULL);

-- ## Exo biblio ## --
-- affichage des livres qui n'ont pas été rendus (105 et 100 là)
select livre_id from emprunts where date_rendu is null; -- l'etat null se teste toujours avec is

-- affichage des titres des livres qui n'ont pas été rendus -- ( requete crosstable )
select titre from livres where livre_id in
    (select livre_id from emprunts where date_rendu is null);

-- affichage des abonnées n'ayant pas rendu leurs livres à la bibliotheque
select prenom from abonne where id_abonne in
    (select abonne_id from emprunts where date_rendu is null);

-- nous aimerions connaitre le numero des livres que chloe a emprunté a la bibliotheque
select livre_id from emprunts where abonne_id in
    (select id_abonne from abonne where prenom ='chloe');

-- afficher le liste des abonnées ayant deja emprunté un livre d'asimov --
select prenom from abonne where id_abonne in
    (select abonne_id from emprunts where livre_id in 
        (select livre_id from livres where auteur ='Isaac Asimov')
    );

-- afficher les titres ds livres que chloe a emprunté --
select titre from livres where livre_id in
    (select livre_id from emprunts where abonne_id=
        (select id_abonne from abonne where prenom = 'Chloe')
    );

-- afficher les titres ds livres que chloe n'a pas emprunté --
select titre from livres where livre_id not in
    (select livre_id from emprunts where abonne_id=
        (select id_abonne from abonne where prenom = 'Chloe')
    );

-- afficher les titres ds livres que chloe n'a pas encore rendu --
select titre from livres where livre_id in
    (select livre_id from emprunts where date_rendu is null and abonne_id =
        (select id_abonne from abonne where prenom = 'Chloe')
    );

-- Qui a emprunté le plus de livres a la bibliotheque ? --
select prenom from abonne where id_abonne =
    (select abonne_id from emprunts group by abonne_id order by count(abonne_id) desc limit 0,1);

--- ########## JOINTURES ########## --------
-- Nous aimerions connaitre les dates de sortie et de rendu pour l'abonné Guillaume ? --
select a.prenom, e.date_sortie, e.date_rendu -- requete principale 
from abonne a, emprunts e -- sources aliases
where a.id_abonne = e.abonne_id -- on fait la jointure ici, les valeurs correspondent --
and a.prenom = 'Guillaume'; -- pattern --
-- ici on definis des prefixes a partir de sources, table a - table b, ce n'est pas une jointure en dur mais ca permet d'avoir des resultats multiples à partir de differentes tables
 -- équivaut à :
 select date_sortie, date_rendu from emprunts where abonne_id =
    (select id_abonne from abonne where prenom ='Guillaume');
    -- sauf qu'on ne peut pas recuperer le prenom --



-- exo : --
-- nous aimerions connaitre les mouvements des livres sortie / rendus des ecrits d'alexandre dumas
select e.date_sortie, e.date_rendu, l.auteur
from emprunts e, livres l
where l.livre_id = e.livre_id 
and l.auteur = 'Alexandre Dumas';
-- ( L'exemple precedent est une jointure explicite) --
-- ( la meme en jointure implicite :)
select e.date_sortie, e.date_rendu, l.auteur, l.titre
from livres l
inner join emprunts e
on l.livre_id = e.livre_id 
and l.auteur = 'Alexandre Dumas';

-- si vous l'avez trouvé en jointure, est il possible de trouver le resultat en requete imbriquee ?
select date_sortie, date_rendu from emprunts where livre_id in
    (select livre_id from livres where auteur="Alexandre Dumas");

-- Qui a emprunté le livre Fondations en 2014 ?
-- jointure explicite :
select a.prenom, l.titre, e.date_sortie
from abonne a, emprunts e, livres l
where a.id_abonne = e.abonne_id
and e.livre_id = l.livre_id
and l.titre ='Fondations'
and e.date_sortie like '2014%';

-- jointure implicite :
select abonne.prenom, livres.titre, emprunts.date_sortie
from abonne
inner join emprunts
on abonne.id_abonne = emprunts.abonne_id
inner join livres
on livres.livre_id = emprunts.livre_id
and livres.titre = 'Fondations'
and emprunts.date_sortie like '2014%';

-- requetes imbriquées (là, on ne peut recuperer que les prenoms du coup):
select prenom from abonne where id_abonne in
    (select abonne_id from emprunts where date_sortie like '2014%' and livre_id = (select livre_id from livres where titre = 'Fondations')
);

-- Nous aimerions connaitre le nombre de livres empruntés par chaque abonnés --
-- explicite --
select a.prenom, count(e.livre_id) as 'Nb de livres empruntés / abo'
from abonne a, emprunts e
where a.id_abonne = e.abonne_id
group by e.abonne_id;

-- implicite --
select abonne.prenom, count(emprunts.livre_id) as 'Nb de livres empruntés  / abo'
from abonne
inner join emprunts
on abonne.id_abonne = emprunts.abonne_id
group by emprunts.abonne_id;

-- simple --
select count(livre_id) as 'Nb de livres empruntés  / abo' from emprunts group by abonne_id;


-- afficher les noms et prenoms et nombre de livres non rendus des abonnés --
select a.prenom, count(e.livre_id) as 'Nb de livres non rendus'
from abonne a, emprunts e
where a.id_abonne = e.abonne_id
and e.date_rendu is null group by e.abonne_id;

-- qui a emprunté quoi et quand ? --
select a.prenom, e.date_sortie, l.titre
from abonne a, emprunts e, livres l
where a.id_abonne = e.abonne_id
and e.livre_id = l.livre_id;

-- afficher les prenoms des abonnés avec le numero des livres qu'ils ont empruntés --

-- jointure externe --
select abonne.prenom, emprunts.livre_id
from abonne
left join emprunts
on abonne.id_abonne = emprunts.abonne_id;

-- la clause left join permet de rappatrier toutes les données dans la table etant considerée a gauche, sans avoir de correspondance exigée dans l'autrre table (emprunts)