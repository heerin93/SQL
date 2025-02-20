-- création de la base de données
CREATE DATABASE If NOT EXISTS produit CHARSET utf8mb4;
USE produit;

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
    
INSERT INTO categorie VALUES (1,"Boissons");
INSERT INTO categorie VALUES (2,"Animalerie");
INSERT INTO categorie VALUES (3,"Epicerie");
INSERT INTO categorie VALUES (4,"Boulangerie");
INSERT INTO categorie VALUES (5,"Boucherie");

INSERT INTO produit VALUES (1, "Lipton Ice Tea Pêche", "Le Lipton Ice Tea Pêche est une boisson rafraîchissante à base de thé infusé et aromatisé à la pêche.", 2, 1);
INSERT INTO produit VALUES (2, "Catsan Hygiene Plus", "La Catsan Hygiene Plus est une litière minérale composée de granulés de sable de quartz et de chaux.", 7, 2);
INSERT INTO produit VALUES (3, "Nutella", "Le Nutella est une pâte à tartiner aux noisettes et au cacao, connue pour sa texture onctueuse et son goût sucré et gourmand.", 5, 3);
INSERT INTO produit VALUES (4, "Pain au chocolat", "Le pain au chocolat est une viennoiserie à base de pâte feuilletée beurrée, similaire au croissant, mais avec deux barres de chocolat fondantes à l'intérieur.", 1, 4);
INSERT INTO produit VALUES (5, "Entrecôte de bœuf ", "L’entrecôte de bœuf est une pièce de viande tendre et savoureuse, découpée dans le train de côtes.", 9, 5);
INSERT INTO produit VALUES (6, "Orangina", "L’Orangina est une boisson gazeuse à base de jus d'orange et de pulpe, reconnaissable à sa bouteille ronde et texturée.", 2, 1);
INSERT INTO produit VALUES (7, "Royal Canin Sterilised 37", "Les Royal Canin Sterilised 37 sont des croquettes spécialement formulées pour les chats adultes stérilisés. ", 9, 2);
INSERT INTO produit VALUES (8, "Barilla Spaghetti n°5", "Les Barilla Spaghetti n°5 sont des pâtes de blé dur classiques, idéales pour préparer des plats italiens authentiques.", 3, 3);
INSERT INTO produit VALUES (9, "Baguette Tradition", "La Baguette Tradition est un pain artisanal fabriqué avec de la farine, de l'eau, du sel et de la levure ou du levain, sans additif. ", 1, 4);
INSERT INTO produit VALUES (10, "Côtes d’agneau", "Les côtes d’agneau sont des morceaux tendres et savoureux, découpés dans le carré d’agneau.", 9, 5);

INSERT INTO vendeur VALUES (1,"Martin", "Lucas");
INSERT INTO vendeur VALUES (2,"Emma", "Dupont");
INSERT INTO vendeur VALUES (3,"Lefevre", "Nathan");
INSERT INTO vendeur VALUES (4,"Moreau", "Sofia");
INSERT INTO vendeur VALUES (5,"Bernard", "Léo");

INSERT INTO ticket VALUES (1,"1975-03-04", 1);
INSERT INTO ticket VALUES (2,"2002-09-19", 1);
INSERT INTO ticket VALUES (3,"1991-01-07", 2);
INSERT INTO ticket VALUES (4,"2015-06-25", 2);
INSERT INTO ticket VALUES (5,"1983-10-14", 3);
INSERT INTO ticket VALUES (6,"2027-12-30", 3);
INSERT INTO ticket VALUES (7,"1956-08-09", 4);
INSERT INTO ticket VALUES (8,"2044-05-22", 4);
INSERT INTO ticket VALUES (9,"2011-11-05", 5);
INSERT INTO ticket VALUES (10,"1999-02-17", 5);

INSERT INTO produit_ticket VALUES (1, 2, 3), (1, 1, 2), (1, 3, 1);
INSERT INTO produit_ticket VALUES (2, 2, 3), (3, 1, 2), (4, 3, 1);
INSERT INTO produit_ticket VALUES (3, 3, 3), (4, 2, 2), (5, 6, 1);
INSERT INTO produit_ticket VALUES (2, 3, 4), (4, 4, 4), (5, 3, 4);
INSERT INTO produit_ticket VALUES (5, 5, 5), (3, 5, 5), (1, 5, 5);
INSERT INTO produit_ticket VALUES (5, 1, 6), (5, 4, 6), (5, 8, 6);
INSERT INTO produit_ticket VALUES (4, 5, 7), (4, 1, 7), (4, 9, 7);
INSERT INTO produit_ticket VALUES (2, 5, 8), (1, 4, 8), (1, 8, 8);
INSERT INTO produit_ticket VALUES (4, 8, 9), (4, 6, 9), (4, 7, 9);
INSERT INTO produit_ticket VALUES (1, 9, 10), (1, 6, 10), (1, 7, 10);





