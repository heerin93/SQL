CREATE DATABASE IF NOT EXISTS livres CHARSET utf8mb4;
USE livres;

-- création des tables
CREATE TABLE IF NOT EXISTS livre(
    id_livre INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    titre VARCHAR(50) NOT NULL,
    `resume` TEXT NOT NULL,
    date_sortie DATE NOT NULL
)Engine=InnoDB;

CREATE TABLE IF NOT EXISTS genre(
    id_genre INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    libele VARCHAR(50) NOT NULL
)Engine=InnoDB;

-- table d'association
CREATE TABLE IF NOT EXISTS livre_genre(
    id_livre INT,
    id_genre INT,
    PRIMARY KEY(id_livre, id_genre)
)Engine=InnoDB;

ALTER TABLE livre_genre
    ADD CONSTRAINT fk_completer_livre
    FOREIGN KEY(id_livre)
    REFERENCES livre(id_livre);
  
ALTER TABLE livre_genre
    ADD CONSTRAINT fk_completer_genre
    FOREIGN KEY(id_genre)
    REFERENCES genre(id_genre);
    
INSERT INTO livre VALUES (1,"Le Mystère de la Forêt", "Un groupe d'amis découvre un secret ancien caché dans une forêt enchantée.", "2023-01-01");
INSERT INTO livre VALUES (2, "Les Secrets de l'Océan", "Une jeune biologiste marine explore les profondeurs de l'océan et découvre une civilisation perdue.", "2023-02-01");
INSERT INTO livre VALUES (3, "L'Énigme du Pharaon", "Un archéologue tente de résoudre les mystères d'une ancienne pyramide égyptienne.", "2023-03-01");
INSERT INTO livre VALUES (4, "La Quête du Chevalier", "Un chevalier part en quête pour sauver son royaume d'une menace imminente.", "2023-04-01");
INSERT INTO livre VALUES (5, "Le Voyage Interstellaire", "Un équipage spatial part à la découverte de nouvelles planètes et formes de vie.", "2023-05-01");
INSERT INTO livre VALUES (6, "Les Chroniques du Temps", "Un scientifique invente une machine à voyager dans le temps et explore différentes époques.", "2023-06-01");
INSERT INTO livre VALUES (7, "La Cité Perdue", "Une équipe d'explorateurs découvre une cité ancienne cachée dans la jungle.", "2023-07-01");
INSERT INTO livre VALUES (8, "Le Trésor des Pirates", "Un jeune garçon trouve une carte au trésor et part à l'aventure pour le trouver.", "2023-08-01");
INSERT INTO livre VALUES (9, "L'Île Mystérieuse", "Un groupe de naufragés découvre une île pleine de mystères et de dangers.", "2023-09-01");
INSERT INTO livre VALUES (10, "Les Gardiens de la Galaxie", "Une équipe de super-héros protège la galaxie contre des menaces interstellaires.", "2023-10-01");

INSERT INTO genre VALUES (1, "fanstastique");
INSERT INTO genre VALUES (2, "science-fiction");
INSERT INTO genre VALUES (3, "polar");
INSERT INTO genre VALUES (4, "drame");
INSERT INTO genre VALUES (5, "roman");

INSERT INTO livre_genre (id_livre, id_genre) VALUES (1, 2), (1, 5);
INSERT INTO livre_genre (id_livre, id_genre) VALUES (2, 1), (2, 2);
INSERT INTO livre_genre (id_livre, id_genre) VALUES (3, 3), (3, 5);
INSERT INTO livre_genre (id_livre, id_genre) VALUES (4, 1), (4, 5);
INSERT INTO livre_genre (id_livre, id_genre) VALUES (5, 2), (5, 4);
INSERT INTO livre_genre (id_livre, id_genre) VALUES (6, 2), (6, 5);
INSERT INTO livre_genre (id_livre, id_genre) VALUES (7, 2), (7, 4);
INSERT INTO livre_genre (id_livre, id_genre) VALUES (8, 2), (8, 5);
INSERT INTO livre_genre (id_livre, id_genre) VALUES (9, 3), (9, 4);
INSERT INTO livre_genre (id_livre, id_genre) VALUES (10, 2), (10, 4);

ALTER TABLE livre MODIFY titre VARCHAR(50) NOT NULL UNIQUE;

INSERT INTO livre VALUES (11, "Le Mystère de la Forêt", "Un groupe d'amis découvre un secret ancien caché dans une forêt enchantée.", "2023-01-01");

ALTER TABLE genre MODIFY libele VARCHAR(50) NOT NULL UNIQUE;

CREATE TABLE IF NOT EXISTS auteur(
    id_auteur INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nom VARCHAR(50) NOT NULL,
    prenom VARCHAR(50) NOT NULL
)Engine=InnoDB;

ALTER TABLE livre
	ADD COLUMN id_auteur INT ;

ALTER TABLE livre
    ADD CONSTRAINT fk_livre_auteur
    FOREIGN KEY(id_auteur)
    REFERENCES auteur(id_auteur);
    
INSERT INTO auteur VALUES (1,"Asimov", "Isaac");
INSERT INTO auteur VALUES (2,"Dick", "Philip");
INSERT INTO auteur VALUES (3,"Tolkien", "J.R.R");
INSERT INTO auteur VALUES (4,"Herbet", "Franck");
INSERT INTO auteur VALUES (5,"Lovecraft", "H.P");

CREATE TABLE IF NOT EXISTS livre_auteur(
    id_livre INT,
    id_auteur INT,
    PRIMARY KEY(id_livre, id_auteur)
)Engine=InnoDB;

ALTER TABLE livre_auteur
    ADD CONSTRAINT fk_completer_livre
    FOREIGN KEY(id_livre)
    REFERENCES livre(id_livre);
  
ALTER TABLE livre_auteur
    ADD CONSTRAINT fk_completer_auteur
    FOREIGN KEY(id_auteur)
    REFERENCES auteur(id_auteur);
