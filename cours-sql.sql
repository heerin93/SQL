CREATE DATABASE IF NOT EXISTS librairie CHARSET utf8mb4;
USE librairie;

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

CREATE TABLE IF NOT EXISTS completer(
	id_livre INT,
    id_genre INT,
    PRIMARY KEY (id_livre, id_genre),
    CONSTRAINT fk_livre FOREIGN KEY (id_livre) REFERENCES livre(id_livre),
    CONSTRAINT fk_genre FOREIGN KEY (id_genre) REFERENCES genre(id_genre)
)Engine=InnoDB;
