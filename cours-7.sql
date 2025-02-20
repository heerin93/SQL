CREATE DATABASE IF NOT EXISTS jeu_arene CHARSET utf8mb4;
USE jeu_arene;

-- Création de la BDD

CREATE TABLE IF NOT EXISTS carnet_amis(
	id_carnet_amis INT PRIMARY KEY AUTO_INCREMENT UNIQUE NOT NULL,
    nom_carnet VARCHAR(50) NOT NULL
    )Engine=InnoDB;

CREATE TABLE IF NOT EXISTS joueurs(
	id_joueurs INT PRIMARY KEY AUTO_INCREMENT UNIQUE NOT NULL,
    pseudo_joueur VARCHAR(50) UNIQUE NOT NULL,
    mdp_joueur VARCHAR(150) NOT NULL,
    mail_joueur VARCHAR(100) UNIQUE NOT NULL,
    id_carnet_amis INT UNIQUE NOT NULL 
    )Engine=InnoDB;
    
CREATE TABLE IF NOT EXISTS messages(
	id_messages INT PRIMARY KEY AUTO_INCREMENT UNIQUE NOT NULL,
    date_message DATETIME NOT NULL,
    sujet VARCHAR(255) NOT NULL,
    message TEXT NOT NULL,
    id_auteur INT NOT NULL,
    id_destinataire INT NOT NULL
)Engine=InnoDB;

CREATE TABLE IF NOT EXISTS achat(
	id_achat INT PRIMARY KEY AUTO_INCREMENT UNIQUE NOT NULL,
    date_achat DATETIME NOT NULL,
    id_personnage INT NOT NULL,
    id_costume INT NOT NULL,
    id_joueur INT NOT NULL
)Engine=InnoDB;

CREATE TABLE IF NOT EXISTS costume(
	id_costume INT PRIMARY KEY AUTO_INCREMENT UNIQUE NOT NULL,
    nom_costume VARCHAR(50) UNIQUE NOT NULL
)Engine=InnoDB;

CREATE TABLE IF NOT EXISTS personnage(
	id_personnage INT PRIMARY KEY AUTO_INCREMENT UNIQUE NOT NULL,
    nom_personnage VARCHAR(50) UNIQUE NOT NULL,
    id_type_personnage INT NOT NULL,
    id_joueurs INT NOT NULL
)Engine=InnoDB;

CREATE TABLE IF NOT EXISTS combats(
	id_combat INT PRIMARY KEY AUTO_INCREMENT UNIQUE NOT NULL,
    date_combat DATETIME NOT NULL,
    id_arene INT NOT NULL,
    id_vaincu INT NOT NULL,
    id_vainqueur INT NOT NULL
)Engine=InnoDB;

CREATE TABLE IF NOT EXISTS arene(
	id_arene INT PRIMARY KEY AUTO_INCREMENT UNIQUE NOT NULL,
    nom_arene VARCHAR(50) UNIQUE NOT NULL
)Engine=InnoDB;

CREATE TABLE IF NOT EXISTS type_personnage(
	id_type_personnage INT PRIMARY KEY AUTO_INCREMENT UNIQUE NOT NULL,
    type_personnage VARCHAR(50) UNIQUE NOT NULL,
    attaque INT NOT NULL,
    point_de_vie INT NOT NULL,
    defense INT NOT NULL
)Engine=InnoDB;

CREATE TABLE IF NOT EXISTS item(
	id_item INT PRIMARY KEY AUTO_INCREMENT UNIQUE NOT NULL,
    nom_item VARCHAR(50) UNIQUE NOT NULL,
    bonus_point_de_vie INT NOT NULL,
    bonus_defense INT NOT NULL,
    bonus_attaque INT NOT NULL
)Engine=InnoDB;

CREATE TABLE IF NOT EXISTS contenir(
	id_joueurs INT NOT NULL,
    id_carnet_amis INT NOT NULL,
    PRIMARY KEY (id_joueurs, id_carnet_amis)
)Engine=InnoDB;

ALTER TABLE contenir
	ADD CONSTRAINT fk_contenir_joueurs
    FOREIGN KEY (id_joueurs)
    REFERENCES joueurs(id_joueurs);

ALTER TABLE contenir
	ADD CONSTRAINT fk_contenir_carnet_amis
    FOREIGN KEY (id_carnet_amis)
    REFERENCES carnet_amis(id_carnet_amis);

CREATE TABLE IF NOT EXISTS obtenir(
	id_personnage INT NOT NULL,
    id_item INT NOT NULL,
    equipe BOOL NOT NULL,
    PRIMARY KEY (id_personnage, id_item)
)Engine=InnoDB;

ALTER TABLE obtenir
	ADD CONSTRAINT fk_obtenir_personnage
    FOREIGN KEY (id_personnage)
    REFERENCES personnage(id_personnage);

ALTER TABLE obtenir
	ADD CONSTRAINT fk_obtenir_item
    FOREIGN KEY (id_item)
    REFERENCES item(id_item);

-- Insertion de données

INSERT INTO type_personnage(type_personnage, point_de_vie, defense, attaque)
VALUES ("Barbare", 125, 5, 15),
("Guerrier", 100, 10, 10),
("Chevalier", 75, 15, 5);

INSERT INTO arene(nom_arene)
VALUES ("Colisée"),
("Muraille"),
("Armurerie");

INSERT INTO item(nom_item, bonus_point_de_vie, bonus_defense, bonus_attaque)
VALUES ("Arme de base", 0, 0, 0),
("Bouclier de la Méduse", 25, 15, 10),
("Marteau de Thor", 25, 5, 20),
("Excalibur", 20, 10, 20),
("Egide", 20, 30, 0),
("Sainte Lance", 10, 10, 30);

INSERT INTO costume(nom_costume)
VALUES ("La Faucheuse"),
("Le Lapin de Pâques"),
("La Banshee"),
("Jeanne d'Arc"),
("Phénix");

INSERT INTO carnet_amis(nom_carnet)
VALUES ("Ma Liste"),
("Mes Amis"),
("Super Friends"),
("The Crew"),
("Famille de Coeur");

INSERT INTO joueurs(pseudo_joueur, mdp_joueur, mail_joueur, id_carnet_amis)
VALUES ("Dark Schneider", "12345", "dark.s@gmail.com", 1),
("Perceval", "Kaamelott31", "alexast@fr.fr", 2),
("Guts", "berserker#666", "ceska@orange.fr", 3),
("Broly", "cacarot974", "guillaume@gmail.com", 4),
("Suskiki666", "NarutoIsTheBest", "hinatainlove@sfr.fr", 5);

INSERT INTO personnage(nom_personnage, id_joueurs, id_type_personnage)
VALUES ("Power Killer", 1, 1),
("Mordred", 2, 3),
("Griffith", 3, 3),
("Vegeta", 4, 2),
("Kakashi", 5, 2),
("Bohort", 2, 1),
("Lars", 1, 3);

INSERT INTO combats(date_combat, id_arene, id_vainqueur, id_vaincu)
VALUES ("2022-06-23", 1, 1, 2),
("2022-06-23", 2, 3, 2),
("2022-07-01", 3, 6, 5),
("2022-07-13", 1, 5, 7),
("2022-07-15", 1, 4, 1),
("2022-07-17", 1, 4, 1);

INSERT INTO obtenir(id_item, id_personnage, equipe)
VALUES (6, 1, false),
(6, 2, false),
(6, 3, false),
(6, 4, false),
(6, 5, false),
(6, 6, true),
(6, 7, true),
(1, 1, true),
(2, 1, false),
(3, 2, true),
(4, 3, true),
(5, 4, true),
(1, 5, true),
(3, 3, false),
(4, 1, false);

INSERT INTO contenir(id_carnet_amis, id_joueurs)
VALUES (3, 1),
(1, 3),
(3, 2),
(2, 3),
(1, 4),
(4, 1),
(4, 5),
(5, 4),
(5, 2),
(2, 5),
(5, 3),
(3, 5);

INSERT INTO messages(id_auteur, id_destinataire, date_message, sujet, message)
VALUES (1, 3, "2022-06-21", "Hey", "Salut bro ! Comment tu vas ?"),
(3,1, "2022-06-21", "Re:Hey","Salut poto ! ça va super. C'est l'éclate ce jeu. :D"),
 (1,3, "2022-06-22", "ReRe:Hey","Ha ha, t'as vu, je te l'avais dit. Heureusement que je t'ai bassiné avec pendant des plombes. ;)"),
 (3,1, "2022-06-22", "ReReRe:Hey","J'avoue XD Au passage, je viens de me payer la tenue de Jeanne D'Arc. Tu sais, la version Fate Apocryphe"),
 (1,2, "2022-06-23", "Salut","Coucou toi. Je savais que t'étais sur le jeu. Comment tu vas"),
 (2,3, "2022-06-23", "Dis, t'aurais pas gaffé","Hé toi, par hasard, t'aurais pas dit à ton pote que j'étais sur le jeu. Non parce que ce relou vient de m'envoyer un message.");
 
-- Modification de la BDD

ALTER TABLE costume
	ADD COLUMN prix DECIMAL (5,2) NOT NULL;

UPDATE costume
	SET prix = 20.00 
    WHERE nom_costume = "La Faucheuse";

UPDATE costume
	SET prix = 35.00 
    WHERE nom_costume = "Lapin de Pâques" ;

UPDATE costume
	SET prix = 35.00 
    WHERE nom_costume = "Phénix" ;

UPDATE costume
	SET prix = 15.50 
    WHERE nom_costume = "La Banshee" ;
    
UPDATE costume
	SET prix = 29.50 
    WHERE nom_costume = "Jeanne d'Arc" ;

INSERT INTO achat(date_achat, id_joueur, id_costume, id_personnage)
VALUES ("2022-05-10",1,1,1),
 ("2022-06-01",1,2,7),
 ("2022-06-21",3,4,3),
("2022-06-21",1,3,1),
 ("2022-06-23",3,5,3),
 ("2022-07-03",5,1,5);
 
 -- Consultation des Données
 
 SELECT pseudo_joueur
 FROM joueurs;
 
 SELECT pseudo_joueur, mail_joueur
 FROM joueurs
 WHERE id_joueurs = 3;
 
 SELECT j.pseudo_joueur, p.nom_personnage
 FROM joueurs AS j
 INNER JOIN personnage AS p
 ON j.id_joueurs = p.id_joueurs
 WHERE j.id_joueurs = 1;
 
SELECT j.pseudo_joueur, p.nom_personnage, c.nom_costume
FROM joueurs AS j
INNER JOIN personnage AS p
ON j.id_joueurs = p.id_joueurs
INNER JOIN achat AS a
ON p.id_personnage = a.id_personnage
INNER JOIN costume AS c
ON a.id_costume = c.id_costume
WHERE j.id_joueurs = 1;

SELECT j.pseudo_joueur, SUM(c.prix) AS total
FROM joueurs AS j
INNER JOIN achat AS a
ON j.id_joueurs = a.id_joueur
INNER JOIN costume AS c
ON a.id_costume = c.id_costume
GROUP BY j.pseudo_joueur
ORDER BY total DESC;

SELECT j1.pseudo_joueur AS joueur , j2.pseudo_joueur AS ami
FROM joueurs AS j1
INNER JOIN contenir AS c
ON j1.id_joueurs = c.id_joueurs
INNER JOIN joueurs AS j2
ON c.id_carnet_amis = j2.id_carnet_amis
WHERE j1.id_joueurs = 3;

SELECT j.pseudo_joueur AS joueur , m.sujet, m.message, m.date_message
FROM messages AS m
INNER JOIN joueurs as j
ON m.id_auteur = j.id_joueurs
WHERE j.id_joueurs = 3;

SELECT j.pseudo_joueur AS joueur , m.sujet, m.message, m.date_message
FROM messages AS m
INNER JOIN joueurs as j
ON m.id_destinataire = j.id_joueurs
WHERE j.id_joueurs = 3;

-- 8/

-- 9/

SELECT p.nom_personnage, 
tp.point_de_vie + i.bonus_point_de_vie AS point_de_vie,
tp.attaque + i.bonus_attaque AS attaque,
tp.defense + i.bonus_defense AS defense,
i.nom_item AS item_equipe
FROM personnage AS p
INNER JOIN type_personnage AS tp
ON p.id_type_personnage = tp.id_type_personnage
LEFT JOIN obtenir AS o
ON o.id_personnage = p.id_personnage AND o.equipe = TRUE
LEFT JOIN item AS i
ON o.id_item = i.id_item 
WHERE p.id_joueurs = 1;

-- Suppression de Données

DELETE FROM obtenir
WHERE id_personnage = 1;

DELETE FROM combats
WHERE id_vainqueur = 1 OR id_vaincu = 1;

DELETE FROM personnage
WHERE id_personnage = 1;










