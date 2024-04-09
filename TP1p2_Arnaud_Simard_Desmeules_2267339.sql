-- TP1 fichier réponse -- Modifiez le nom du fichier en suivant les instructions
-- Votre nom: Arnaud Simard Desmeules                        Votre DA: 2267339
--ASSUREZ VOUS DE LA BONNE LISIBILITÉ DE VOS REQUÊTES  /5--

-- 1.   Rédigez la requête qui affiche la description pour les trois tables. Le nom des champs et leur type. /2
desc OUTILS_OUTIL;
desc outils_usager;
desc OUTILS_EMPRUNT;
-- 2.   Rédigez la requête qui affiche la liste de tous les usagers, sous le format prénom « espace » nom de famille (indice : concaténation). /2
select  prenom as "Prenom",
        nom_famille as "Nom de famille"
        from outils_usager;
-- 3.   Rédigez la requête qui affiche le nom des villes où habitent les usagers, en ordre alphabétique, le nom des villes va apparaître seulement une seule fois. /2
select prenom as "Prenom",
        adresse as "Adresse"
        from outils_usager
        group by ville
        order by prenom;
-- 4.   Rédigez la requête qui affiche toutes les informations sur tous les outils en ordre alphabétique sur le nom de l’outil puis sur le code. /2
select * 
from outils_outil
order by NOM,CODE_OUTIL;
-- 5.   Rédigez la requête qui affiche le numéro des emprunts qui n’ont pas été retournés. /2
select num_emprunt as "Numero d'emprunt"
       from outils_emprunt
       where date_retour is not null;
-- 6.   Rédigez la requête qui affiche le numéro des emprunts faits avant 2014./3
select num_emprunt as "Numero d'emprunt",
       to_char(date_emprunt,'dd-mm-yy') as "Date d'emprunt"
       from outils_emprunt
       where extract (year from date_emprunt) < 2014;
-- 7.   Rédigez la requête qui affiche le nom et le code des outils dont la couleur début par la lettre « j » (indice : utiliser UPPER() et LIKE) /3
select nom as "Nom", code_outil as "Code de l'outil"
from outils_outil
where upper(caracteristiques) 
like 'J%';
-- 8.   Rédigez la requête qui affiche le nom et le code des outils fabriqués par Stanley. /2
select nom,code_outil
from outils_outil
where fabricant like '%Stanley%';
-- 9.   Rédigez la requête qui affiche le nom et le fabricant des outils fabriqués de 2006 à 2008 (ANNEE). /2
select nom,fabricant
from outils_outil
where annee between 2006 and 2008;
-- 10.  Rédigez la requête qui affiche le code et le nom des outils qui ne sont pas de « 20 volts ». /3
select code_outil, nom
from outils_outil
where caracteristiques not like '%20 volt%';
-- 11.  Rédigez la requête qui affiche le nombre d’outils qui n’ont pas été fabriqués par Makita. /2
select count(*) as "Nombre d’outils qui n’ont pas été fabriqués par Makita"
from outils_outil
where fabricant not like '%Makita%';
-- 12.  Rédigez la requête qui affiche les emprunts des clients de Vancouver et Regina. Il faut afficher le nom complet de l’usager, le numéro d’emprunt, la durée de l’emprunt et le prix de l’outil (indice : n’oubliez pas de traiter le NULL possible (dans les dates et le prix) et utilisez le IN). /5

-- 13.  Rédigez la requête qui affiche le nom et le code des outils empruntés qui n’ont pas encore été retournés. /4
select o.nom,
       e.code_outil
       from outils_outil o
       join outils_emprunt e
       on o.code_outil = e.code_outil
       where date_retour is null;
-- 14.  Rédigez la requête qui affiche le nom et le courriel des usagers qui n’ont jamais fait d’emprunts. (indice : IN avec sous-requête) /3
select nom_famille,courriel
from   outils_usager
where  num_usager not in (select distinct num_usager from outils_emprunt);
-- 15.  Rédigez la requête qui affiche le code et la valeur des outils qui n’ont pas été empruntés. (indice : utiliser une jointure externe – LEFT OUTER, aucun NULL dans les nombres) /4
select o.code_outil as "Code de l'outil",
Coalesce(o.prix,0) as "Valeur de l'outil"
from outils_outil o
left outer join outils_emprunt e on o.code_outil = e.code_outil
where e.code_outil is null;

-- 16.  Rédigez la requête qui affiche la liste des outils (nom et prix) qui sont de marque Makita et dont le prix est supérieur à la moyenne des prix de tous les outils. Remplacer les valeurs absentes par la moyenne de tous les autres outils. /4
select nom,
       prix
from outils_outil
where fabricant = 'Makita'
and prix >(select AVG(prix)from outils_outil);
-- 17.  Rédigez la requête qui affiche le nom, le prénom et l’adresse des usagers et le nom et le code des outils qu’ils ont empruntés après 2014. Triés par nom de famille. /4
select u.nom_famille as "Nom de famille",
        u.prenom as "Prenom",
        u.adresse as "Adresse",
        o.nom as "Nom",
        o.code_outil as "Code de l'outil"
from outils_usager u
join outils_emprunt e on u.num_usager
= e.num_usager
join outils_outil o on e.code_outil
= o.code_outil
where e.date_emprunt > '2014-12-31'
order by u.nom_famille;
-- 18.  Rédigez la requête qui affiche le nom et le prix des outils qui ont été empruntés plus qu’une fois. /4
select o.NOM, oi.PRIX
from outils_outil o
inner join OUTILS_EMPRUNT e
on o.CODE_OUTIL = e. CODE_OUTIL
inner join (
select CODE_OUTIL
from OUTILS_EMPRUNT
group by CODE_OUTIL
havint count(*) > 1
) s on e.CODE_OUTIL = s. CODE_OUTIL
inner join OUTILS_OUTIL oi
on o.CODE_OUTIL = oi.CODE_OUTIL;
-- 19.  Rédigez la requête qui affiche le nom, l’adresse et la ville de tous les usagers qui ont fait des emprunts en utilisant : /6
--  Une jointure
select o.NOM_FAMILLE as "Nom de Famille", 
o.ADRESSE as "Adresse", 
o.VILLE as "Ville"
from OUTILS_USAGER o
join OUTILS_EMPRUNT e on e.NUM_USAGER = o.NUM_USAGER;
--  IN
select NOM_FAMILLE as "Nom de famille", 
ADRESSE as "Adresse", 
VILLE as "Ville"
from OUTILS_USAGER
where NUM_USAGER in (select NUM_USAGER from OUTILS_EMPRUNT);
--  EXISTS
select  NOM_FAMILLE as "Nom de famille", 
        ADRESSE as "Adresse",
        VILLE as "Ville"
        from OUTILS_USAGER o
where exists (select * from OUTILS_EMPRUNT e where e.NUM_USAGER = o.NUM_USAGER);
-- 20.  Rédigez la requête qui affiche la moyenne du prix des outils par marque. /3
select avg(prix) as "Moyenne des outils",
       fabricant as "Marque"
       from outils_outil
       group by fabricant;
-- 21.  Rédigez la requête qui affiche la somme des prix des outils empruntés par ville, en ordre décroissant de valeur. /4
select sum(o.prix) as Somme_des_prix,
        u.ville
        from outils_outil o
        join outils_emprunt e on o.code_outil = e.code_outil
        join outils_usager u on e.num_usager = u.num_usager
        group by ville
        order by Somme_des_prix;
-- 22.  Rédigez la requête pour insérer un nouvel outil en donnant une valeur pour chacun des attributs. /2
insert into outils_outil(code_outil,nom,fabricant,caracteristiques,annee,prix) 
values ('PE769','Scie','Black and Decker','80 watt, verte, À essence', 2004, 500) ;
-- 23.  Rédigez la requête pour insérer un nouvel outil en indiquant seulement son nom, son code et son année. /2
insert into outils_outil(code_outil,nom,annee)
values('DE769','Scie',2003);
-- 24.  Rédigez la requête pour effacer les deux outils que vous venez d’insérer dans la table. /2
delete from outils_outil
where code_outil like '%PE769%'
or code_outil like '%DE769%';
-- 25.  Rédigez la requête pour modifier le nom de famille des usagers afin qu’ils soient tous en majuscules. /2
update  outils_usager
set nom_famille = upper(nom_famille);
