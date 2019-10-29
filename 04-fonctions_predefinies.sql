-- ############# Fonctions predefinies #### -----------
-- Quelques fonctions utiles :
SELECT DATABASE(); -- Indique dans quelle base de données on se situe
select version(); -- affiche la version de mysql
insert into `abonne` (prenom) values('Test');
select last_insert_id(); -- retourne l'id du dernier insert
select curdate(); -- affiche la date du jour
select curtime(); -- affiche ll'heure courante
select now(); -- affiche la date et l'heure
select date_format('2015-05-17 15:16:00', '%d\%m\%y - %h:%i:%s'); -- permet de formater le resultat
select id_emprunt, livre_id, abonne_id, date_format(date_sortie, '%d\%m\%y'), date_format(date_rendu, '%d\%m\%y') from emprunts;
select concat('a','b','c'); -- concatenation, peut etre pratique pour constituer une chaine a partir de plusieurs champs
select concat_ws(" - ", id_abonne, prenom) as 'liste' from bibliotheque.abonne; -- affiche une liste des abonnées avec leur numero dans une seule colonne de resultat
select length('Gregory'); -- affiche la longueur de la chaine de caracteres
select locate('j', "aujourd'hui"); -- affiche la position du caractere dans la chaine fournie
select replace('www.wf3.fr', 'w', 'W'); -- affiche le resultat du remplacement des w par W
select substring('Bonjour', 4); -- tronque la chaine a partir du 4eme caractere