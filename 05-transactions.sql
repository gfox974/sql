---- ## Points de sauvetage et rollbacks ## --

-- habituellement, lorsqu'une commande permet de modifier les informations dans une table (insert, update, delete, etc) il n'est plus possible de faire marche arriere. Nouus ne sommes jamais à l'abri d'une erreur, c'est our cela qu'innodb integre une notion d'annulation.

start transaction; -- demarre un buffer pour la transaction
select * from employes;
update employes set salaire = 1000;
-- oops ! que faire ? --
rollback; --> annule tout ce qui a été fait depuis le start transaction
-- ( ou commit pour appliquer les modifs)

-- ## Transaction + point de sauvegarde
start transaction;
select * from employes;
savepoint point_1;
-- a tout moment, on pourra revenir à l'etat de point_1
update employes set salaire = 3000 where id_employes = 415;
savepoint point_2;

update employes set salaire = 2000 where id_employes = 415;
savepoint point_3;

update employes set salaire = 6000 where id_employes = 415;
savepoint point_4;

rollback to point_2; -- ici on decide d'en revenir a l'etat au moment du savepoint 2 ( donc les points d'apres n'existent pas, par contre on peut revenir au 1 par exemple )

commit; -- disons qu'on valide parce qu'on est satisfaits des modifs.