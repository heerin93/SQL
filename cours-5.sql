-- on crée notre base photo
CREATE DATABASE IF NOT EXISTS photos;
-- on n'oublie pas d'utiliser notre base
USE photos;

-- création de la table lieu
CREATE TABLE lieu(
    id_lieu INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    nom VARCHAR(50),
    ville VARCHAR(50),
    pays VARCHAR(50)
)Engine=InnoDB;

-- création de la table personne
CREATE TABLE personne(
    id_personne INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    nom VARCHAR(50),
    prenom VARCHAR(50)
)Engine=InnoDB;

-- création de la table photo
CREATE TABLE photo(
    id_photo INT auto_increment NOT NULL PRIMARY KEY,
    nom VARCHAR(50),
    url VARCHAR(50),
    id_lieu INT
)Engine=InnoDB;

CREATE TABLE derouler(
    id_personne INT,
    id_photo INT
)Engine=InnoDB;

-- on précise que la clé primaire de derouler est la paire de champs id_personne et id_photo
ALTER TABLE derouler
    ADD PRIMARY KEY (id_personne, id_photo);
    
-- on va faire de id_lieu (dans la table photo) une clé étrangère qui fait référence à id_lieu(dans la table lieu)
ALTER TABLE photo
    ADD CONSTRAINT fk_lieu
    FOREIGN KEY (id_lieu) REFERENCES lieu(id_lieu);
    
-- on s'occupe des clés étrangères de la table derouler
ALTER TABLE derouler
    ADD CONSTRAINT fk_personne
    FOREIGN KEY (id_personne) REFERENCES personne(id_personne);
    
ALTER TABLE derouler
    ADD CONSTRAINT fk_photo 
    FOREIGN KEY (id_photo) REFERENCES photo(id_photo);
    
-- finalement, je veux que le champs "nom" de la table personne soit en not null
ALTER TABLE personne
    MODIFY nom VARCHAR(100) NOT NULL;


-- essayons de supprimer la table lieu
DROP TABLE lieu;
-- on ne peut pas, il faut supprimer la contrainte de clé étrangère avant
ALTER TABLE photo
    DROP FOREIGN KEY fk_lieu;

-- je veux insérer des données dans la table personne avec la première méthode
INSERT INTO personne VALUES (1, "Duck", "Riri");
INSERT INTO personne VALUES (2, "Duck", "Fifi");

-- je veux insérer des données dans la table personne avec la deuxième méthode
INSERT INTO personne (prenom) VALUES ("Loulou");

INSERT INTO personne (prenom) VALUES ("Pierre"), ("Paul"), ("Jacques");

-- j'aimerais modifier l'enregistrement numéro 3 et lui donner un "nom"
UPDATE personne
SET nom = "Duck"
WHERE prenom = "Loulou";

-- je veux supprimer l'enregistrement numéro 4
DELETE FROM personne
WHERE id_personne = 4;

DELETE FROM personne
WHERE prenom = "Paul";

