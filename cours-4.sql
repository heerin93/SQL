-- création de la base de données
CREATE DATABASE If NOT EXISTS caisse CHARSET utf8mb4;
USE caisse;

-- création des tables
CREATE TABLE IF NOT EXISTS categorie(
    id_categorie INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nom_categorie VARCHAR(50) NOT NULL UNIQUE
)Engine=InnoDB;

CREATE TABLE IF NOT EXISTS vendeur(
    id_vendeur INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nom_vendeur VARCHAR(50) NOT NULL,
    prenom_vendeur VARCHAR(50) NOT NULL
)Engine=InnoDB;

CREATE TABLE IF NOT EXISTS ticket(
id_ticket INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
date_creation DATETIME NOT NULL,
id_vendeur INT NOT NULL
)Engine=InnoDB;

CREATE TABLE IF NOT EXISTS produit(
id_produit INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
nom_produit VARCHAR(50) NOT NULL,
`description` VARCHAR(255) NOT NULL,
tarif DECIMAL(3,2) NOT NULL,
id_categorie INT NOT NULL
)Engine=InnoDB;

-- Création de la table d'association
CREATE TABLE IF NOT EXISTS produit_ticket(
    id_ticket INT,
    id_produit INT,
    quantite INT NOT NULL,
    PRIMARY KEY(id_ticket, id_produit),
    CONSTRAINT fk_ticket FOREIGN KEY (id_ticket) REFERENCES ticket(id_ticket),
    CONSTRAINT fk_produit FOREIGN KEY (id_produit) REFERENCES produit(id_produit)
)Engine=InnoDB;

-- Les autres clés étrangères
ALTER TABLE produit 
    ADD CONSTRAINT fk_lier_categorie
    FOREIGN KEY (id_categorie) REFERENCES categorie(id_categorie)
    ON DELETE CASCADE;
-- si on supprime une catégorie, alors avec ON DELETE CASCADE on va aller supprimer tous les produits de cette catégorie également

ALTER TABLE ticket
    ADD CONSTRAINT fk_vendre_vendeur
    FOREIGN KEY (id_vendeur)
    REFERENCES vendeur(id_vendeur)
    ON DELETE CASCADE;

-- Ajouter des catégories
INSERT INTO categorie(nom_categorie)
VALUES('Électronique'),
('Vêtements'),
('Alimentation'),
('Meubles'),
('Jouets');

INSERT INTO produit(nom_produit, `description`, tarif, id_categorie)
VALUES
('Lait entier','Lait entier pasteurisé, bouteille de 1 litre.', 1.20, 3),
('Pain de mie', 'Pain de mie tranché, paquet de 500g.', 1.50, 3),
('Pâtes spaghetti','Pâtes spaghetti, paquet de 500g.', 0.90, 3),
('Jus d\'orange', 'Jus d\'orange 100% pur jus, bouteille de 1 litre.',2.00,3),
('Fromage râpé','Fromage râpé, sachet de 200g.',2.50, 3),
('Chemise en lin','Chemise légère en lin, disponible en plusieurs couleurs.',35,2),
('Pantalon chino','Pantalon chino en coton, coupe droite.',40,2),
('Commode en bois','Commode en bois avec 4 tiroirs.', 150 ,4),
('Bureau d\'ordinateur','Bureau d\'ordinateur avec étagères intégrées.',120,4),
('Puzzle 3D','Puzzle 3D de la Tour Eiffel, 500 pièces.',20,5); 

-- Ajouter des vendeurs
INSERT INTO vendeur(prenom_vendeur, nom_vendeur)
VALUES
('Jean', 'Dupont'),
('Marie','Curie'),
('Pierre', 'Martin'),
('Sophie','Durand'),
('Lucien','Bernard');

-- Ajouter 10 tickets de caisse
INSERT INTO ticket(date_creation,id_vendeur)  VALUES
('2024-10-10',1),
('2024-06-02',2),
('2023-08-21',3),
('2024-07-09',3),
('2024-01-02',3),
('2024-09-07',4),
('2023-01-05',4),
('2024-11-12',4),
('2024-11-12',5),
('2024-12-22',5);

-- Assigner 3 produits à chaque ticket
INSERT INTO produit_ticket(id_ticket, id_produit, quantite) VALUES
(1,1,5),(1,2,3),(1,5,8),
(2,1,2),(2,9,3),(2,6,12),
(3,5,3),(3,7,10),(3,6,14),
(4,2,1),(4,9,2),(4,10,8),
(5,1,1),(5,2,2),(5,3,3),
(6,2,2),(6,3,3),(6,4,7),
(7,1,1),(7,2,2),(7,3,3),
(8,1,1),(8,2,2),(8,3,3),
(9,5,5),(9,6,7),(9,4,3),
(10,1,1),(10,2,5),(10,10,5);

UPDATE vendeur
	SET nom_vendeur = "Albert"
	WHERE id_vendeur = 2;

UPDATE produit
	SET tarif = tarif + 1
    WHERE tarif < 2;

UPDATE ticket
	SET id_vendeur = 5
    WHERE id_vendeur = 2;

UPDATE categorie
	SET nom_categorie = "nouveau"
    WHERE nom_categorie < "C";

UPDATE produit_ticket 
	SET quantite = quantité +3produit
    WHERE id_ticket BETWEEN 6 AND 8;

UPDATE produit
SET tarif = tarif - (tarif/10) 
WHERE id_categorie = 4;

-- 3 Ajouter 2 jours à tous les tickets dont la date est supérieure au 1 janvier 2024
UPDATE ticket 
SET date_creation = DATE_ADD(date_creation, INTERVAL 2 DAY)
WHERE date_creation > '2024-01-01';

DELETE FROM categorie
WHERE nom_categorie = "Électronique";

DELETE FROM produit_ticket
WHERE id_produit = 10;

DELETE FROM produit
WHERE id_produit = 10;

DELETE FROM categorie
WHERE id_categorie = 5;

DELETE FROM produit_ticket
WHERE id_ticket = 1;

DELETE FROM ticket
WHERE id_ticket = 1;

DELETE FROM vendeur
WHERE id_vendeur = 1;

DELETE FROM produit_ticket
WHERE id_ticket = 7;

DELETE FROM produit_ticket
WHERE id_ticket = 3;

DELETE FROM ticket
WHERE date_creation < "2024-01-01";

DELETE FROM produit_ticket
WHERE id_produit = 6;

DELETE FROM produit
WHERE id_produit = 6;

SELECT nom_categorie
FROM categorie;

SELECT nom_vendeur, prenom_vendeur
FROM vendeur
ORDER BY nom_vendeur;

SELECT date_creation FROM ticket
WHERE MONTH(date_creation)= 12;

SELECT id_ticket, date_creation
FROM ticket
WHERE YEAR(date_creation)= 2024;

UPDATE categorie
	SET nom_categorie = "Alimentation"
    WHERE nom_categorie = "nouveau";

SELECT id_produit, nom_produit, tarif
FROM produit
WHERE id_categorie = (
	SELECT id_categorie 
    FROM categorie
    WHERE nom_categorie = "Alimentation"
);

SELECT nom_produit, tarif, "Alimentation" AS nom_categorie
FROM produit
WHERE id_categorie = 3;

SELECT id_produit, nom_produit, tarif
FROM produit
WHERE nom_produit < "J" AND tarif > 1.50;

SELECT id_produit, nom_produit, tarif
FROM produit
ORDER BY tarif DESC 
LIMIT 5;

SELECT *
FROM produit
INNER JOIN categorie
ON produit.id_categorie = categorie.id_categorie;

SELECT *
FROM categorie
LEFT JOIN produit 
ON produit.id_categorie = categorie.id_categorie;

SELECT *
FROM categorie
LEFT JOIN produit
ON produit.id_categorie = categorie.id_categorie
WHERE produit.id_categorie IS NULL;

SELECT *
FROM produit 
LEFT JOIN categorie
ON produit.id_categorie = categorie.id_categorie
UNION 
SELECT *
FROM produit
RIGHT JOIN categorie
ON produit.id_categorie = categorie.id_categorie;

SELECT p.nom_produit, p.tarif, pt.quantite
FROM produit_ticket AS pt
INNER JOIN produit AS p
ON pt.id_produit = p.id_produit
WHERE pt.id_ticket = 2;

SELECT p.nom_produit, p.tarif, c.nom_categorie
FROM produit AS p
INNER JOIN categorie AS c
ON p.id_categorie = c.id_categorie
INNER JOIN produit_ticket AS pt
ON p.id_produit = pt.id_produit
INNER JOIN ticket as t
ON pt.id_ticket = t.id_ticket
WHERE YEAR (t.date_creation) = 2024
GROUP BY p.id_produit;

-- Afficher la liste des produits vendu par le vendeur : 4 (nom_produit, tarif, nom_vendeur, prenom_vendeur),

SELECT p.nom_produit, p.tarif, v.nom_vendeur, v.prenom_vendeur
FROM produit AS p
INNER JOIN produit_ticket AS pt
ON p.id_produit = pt.id_produit
INNER JOIN ticket as t
ON pt.id_ticket = t.id_ticket
INNER join vendeur AS v
ON t.id_vendeur = v.id_vendeur
WHERE v.id_vendeur = 4;

-- Afficher la liste des produits de type 'Alimentation' (nom_produit, tarif, nom_categorie),

SELECT p.nom_produit, p.tarif, c.nom_categorie
FROM produit AS p
INNER JOIN categorie AS c
ON p.id_categorie = c.id_categorie
WHERE c.nom_categorie = "Alimentation"; 

-- Afficher la liste des produits dont le tarif est supérieur à 2 € (id_produit, nom_produit, tarif, nom_categorie)

SELECT p.id_produit, p.nom_produit, p.tarif, c.nom_categorie
FROM produit AS p
INNER JOIN categorie AS c
ON p.id_categorie = c.id_categorie
WHERE p.tarif > 2.00; 

-- Afficher la liste des vendeurs qui ne sont pas liés à un ticket (nom_vendeur, prenom_vendeur).

SELECT v.nom_vendeur, v.prenom_vendeur
FROM vendeur AS v
LEFT JOIN ticket AS t
ON t.id_vendeur = v.id_vendeur
WHERE t.id_ticket IS NULL;

-- Afficher les tickets de 2023 (id_ticket, date_creation, nom_vendeur, prenom_vendeur),

SELECT t.id_ticket, t.date_creation, v.nom_vendeur, v.prenom_vendeur
FROM vendeur AS v
INNER JOIN ticket AS t
ON v.id_vendeur = t.id_vendeur
WHERE YEAR(t.date_creation) = 2023;

-- Afficher la liste des produits de type Alimentation vendu (nom_produit, tarif, nom_categorie).

SELECT p.nom_produit, p.tarif, c.nom_categorie
FROM produit AS p
INNER JOIN produit_ticket AS pt
ON p.id_produit = pt.id_produit
INNER JOIN ticket as t
ON pt.id_ticket = t.id_ticket
INNER JOIN categorie AS c
ON p.id_categorie = c.id_categorie
WHERE c.nom_categorie = "Alimentation"
GROUP BY p.id_produit;

INSERT INTO produit (nom_produit, `description`, tarif, id_categorie) VALUES ("jambon", "cochon", 3, 3);

-- Obtenir la liste des produits qui ont été vendu au moins une fois

SELECT DISTINCT p.id_produit, p.nom_produit
FROM produit AS p
INNER JOIN produit_ticket AS pt
ON p.id_produit = pt.id_produit
INNER JOIN ticket AS t
ON pt.id_ticket = t.id_ticket;

-- Obtenir les vendeurs classés par nom de famille de A à Z

SELECT nom_vendeur, prenom_vendeur
FROM vendeur 
ORDER BY nom_vendeur ASC;

-- Obtenir le vendeur qui a réalisé la vente la plus récente

SELECT v.nom_vendeur, v.prenom_vendeur, t.date_creation
FROM ticket AS t
INNER JOIN vendeur AS v
ON t.id_vendeur = v.id_vendeur
ORDER BY t.date_creation DESC
LIMIT 1;

-- Calculer le nombre de vendeurs

SELECT COUNT(v.id_vendeur) AS nv
FROM vendeur AS v;

-- Calculer la quantite moyenne de produit vendu

SELECT AVG(pt.quantite) 
FROM produit_ticket AS pt;

-- Obtenir les tickets dont le total est supérieur à 10

SELECT SUM(pt.quantite * p.tarif) AS total
FROM produit AS p
INNER JOIN produit_ticket AS pt
ON p.id_produit = pt.id_produit
INNER JOIN ticket AS t
ON pt.id_ticket = t.id_ticket
GROUP BY t.id_ticket
HAVING total > 10;

-- Ajouter 1 produit, en remplissant la clé étrangère id_categorie en utilisant une sous-requête visant à l'obtenir à partir du nom d'une catégorie
INSERT INTO produit(nom_produit, `description`, tarif, id_categorie) 
VALUES ("chocolat", "au lait", 2, 
(SELECT id_categorie
FROM categorie
WHERE nom_categorie = "Alimentation"));




