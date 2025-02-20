CREATE DATABASE IF NOT EXISTS judoka CHARSET utf8mb4;
USE judoka;

CREATE TABLE IF NOT EXISTS judoka(
    id_judoka INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nom_judoka VARCHAR(50) NOT NULL,
    prenom_judoka VARCHAR(50) NOT NULL,
    age INT NOT NULL,
    sexe VARCHAR(5) NOT NULL,
    id_niveau INT
)Engine=InnoDB;

CREATE TABLE IF NOT EXISTS niveau(
    id_niveau INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    couleur_ceinture VARCHAR(50) NOT NULL
)Engine=InnoDB;

CREATE TABLE IF NOT EXISTS competition(
    id_cpt INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nom_cpt VARCHAR(50) NOT NULL,
    date_fin DATE NOT NULL,
    date_debut DATE NOT NULL
)Engine=InnoDB;

CREATE TABLE IF NOT EXISTS judoka_competition(
    id_judoka INT,
    id_cpt INT,
    PRIMARY KEY (id_judoka, id_cpt)
)Engine=InnoDB;

ALTER TABLE judoka_competition
    ADD CONSTRAINT fk_judoka_competition_judoka
    FOREIGN KEY (id_judoka)
    REFERENCES judoka(id_judoka);
    
ALTER TABLE judoka_competition
    ADD CONSTRAINT fk_judoka_competition_cpt
    FOREIGN KEY (id_cpt)
    REFERENCES competition(id_cpt);
    
INSERT INTO niveau(couleur_ceinture)
VALUES ("blanche"),
("jaune"),
("orange"),
("verte"),
("bleu"),
("marron"),
("noire");

INSERT INTO judoka(nom_judoka, prenom_judoka, age, sexe, id_niveau)
VALUES ("Lachance", "Dominique", 16, "F", 2),
("Porter", "Gilbert", 18, "H", 3),
("Lemaître", "Anne", 15, "F", 4),
("Robert", "Juliette", 12, "F", 1),
("Montiny", "Pierre", 17, "H", 5),
("Charrette", "Pascal", 21, "H", 6),
("Guay", "Emilie", 19, "F", 6),
("Maheu", "Louise", 14, "F", 4),
("Poulin", "Raymond", 26, "H", 7),
("Dupret", "Alain", 20, "H", 6);

INSERT INTO competition(nom_cpt, date_debut, date_fin)
VALUES ("Judo31", "2021-02-06", "2021-02-07"),
("Judo11", "2021-02-27", "2021-02-28"),
("Judo81", "2021-03-20", "2021-03-21"),
("Judo82", "2021-04-17", "2021-04-18");

INSERT INTO judoka_competition(id_cpt, id_judoka)
VALUES (1, 1),
(1, 3),
(1, 4),
(2, 2),
(2, 5),
(2, 6),
(2, 9),
(3, 10),
(3, 9),
(4, 1),
(4, 3),
(4, 8),
(4, 4);

UPDATE judoka
	SET id_niveau = id_niveau + 1
    WHERE id_judoka BETWEEN 1 AND 5;

INSERT INTO judoka(nom_judoka, prenom_judoka, age, sexe, id_niveau)
VALUES ("Coco", "Loco", 28, "F", 5),
("Félix", "Lee", 26, "H", 7);

DELETE FROM judoka
WHERE id_judoka IN(11,12);

SELECT j.nom_judoka, j.prenom_judoka, j.age, j.sexe, n.couleur_ceinture
FROM judoka AS j
INNER JOIN niveau AS n
ON j.id_niveau = n.id_niveau
WHERE n.couleur_ceinture = "verte";

SELECT COUNT(j.id_judoka) AS np
FROM judoka_competition AS jc
INNER JOIN judoka AS j
ON jc.id_judoka = j.id_judoka
INNER JOIN competition AS c
ON jc.id_cpt = c.id_cpt
WHERE c.nom_cpt = "Judo31";

SELECT j.nom_judoka, j.prenom_judoka, j.age, j.sexe
FROM judoka_competition AS jc
INNER JOIN judoka AS j
ON jc.id_judoka = j.id_judoka
INNER JOIN competition AS c
ON jc.id_cpt = c.id_cpt
WHERE c.nom_cpt = "Judo81";

SELECT j.nom_judoka, j.prenom_judoka, j.age, j.sexe, n.couleur_ceinture
FROM judoka AS j
INNER JOIN niveau AS n
ON j.id_niveau = n.id_niveau
WHERE n.couleur_ceinture = "marron" AND j.age > 19;

SELECT j.nom_judoka, j.prenom_judoka, j.age, j.sexe, n.couleur_ceinture
FROM judoka AS j
INNER JOIN niveau AS n
ON j.id_niveau = n.id_niveau
ORDER BY j.nom_judoka ASC; 