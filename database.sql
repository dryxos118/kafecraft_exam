CREATE DATABASE IF NOT EXISTS kafecraft;
USE kafecraft;

CREATE TABLE IF NOT EXISTS Gato (
    id INT AUTO_INCREMENT PRIMARY KEY,
    gout INT NOT NULL CHECK (gout BETWEEN 0 AND 100),
    amertume INT NOT NULL CHECK (amertume BETWEEN 0 AND 100),
    teneur INT NOT NULL CHECK (teneur BETWEEN 0 AND 100),
    odorat INT NOT NULL CHECK (odorat BETWEEN 0 AND 100)
);

CREATE TABLE IF NOT EXISTS CafeType (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    avatar VARCHAR(255) NOT NULL,
    growTime INT NOT NULL,
    costDeeVee INT NOT NULL,
    fruitWeight FLOAT NOT NULL,
    gato_id INT NOT NULL,
    FOREIGN KEY (gato_id) REFERENCES Gato(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Player (
    id INT AUTO_INCREMENT PRIMARY KEY,
    firstName VARCHAR(255),
    lastName VARCHAR(255),
    email VARCHAR(255) UNIQUE NOT NULL,
    deeVee INT NOT NULL DEFAULT 10,
    goldSeed INT NOT NULL DEFAULT 0
);

CREATE TABLE IF NOT EXISTS Exploitation (
    id INT AUTO_INCREMENT PRIMARY KEY,
    player_id INT NOT NULL,
    FOREIGN KEY (player_id) REFERENCES Player(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Field (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    speciality ENUM('rendementX2', 'tempsDiv2', 'neutre') NOT NULL DEFAULT 'neutre'
);

CREATE TABLE IF NOT EXISTS ExploitationField (
    exploitation_id INT NOT NULL,
    field_id INT NOT NULL,
    PRIMARY KEY (exploitation_id, field_id),
    FOREIGN KEY (exploitation_id) REFERENCES Exploitation(id) ON DELETE CASCADE,
    FOREIGN KEY (field_id) REFERENCES Field(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Plant (
    id INT AUTO_INCREMENT PRIMARY KEY,
    cafeType_id INT,
    plantedAt DATETIME,
    field_id INT NOT NULL,
    FOREIGN KEY (cafeType_id) REFERENCES CafeType(id) ON DELETE SET NULL,
    FOREIGN KEY (field_id) REFERENCES Field(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Stock (
    id INT AUTO_INCREMENT PRIMARY KEY,
    cafeType VARCHAR(255) NOT NULL,
    grainWeight DOUBLE PRECISION NOT NULL,
    player_id INT NOT NULL,
    FOREIGN KEY (player_id) REFERENCES Player(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Assembly (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    totalWeight DOUBLE PRECISION NOT NULL,
    isRegister BOOLEAN NOT NULL DEFAULT FALSE,
    gato_id INT NOT NULL,
    player_id INT NOT NULL,
    FOREIGN KEY (gato_id) REFERENCES Gato(id),
    FOREIGN KEY (player_id) REFERENCES Player(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Competition (
    id INT AUTO_INCREMENT PRIMARY KEY,
    epreuve_type ENUM('tasse', 'kafetiere', 'degustation') NOT NULL,
    user_score DECIMAL(5,2) NOT NULL,
    bot_score DECIMAL(5,2) NOT NULL,
    user_won BOOLEAN NOT NULL,
    is_draw BOOLEAN NOT NULL,
    assembly_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (assembly_id) REFERENCES Assembly(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS CompetitionEpreuve (
    competition_id INT NOT NULL,
    epreuve_type ENUM('tasse', 'kafetiere', 'degustation') NOT NULL,
    user_score DECIMAL(5,2) NOT NULL,
    bot_score DECIMAL(5,2) NOT NULL,
    PRIMARY KEY (competition_id, epreuve_type),
    FOREIGN KEY (competition_id) REFERENCES Competition(id) ON DELETE CASCADE
);

INSERT INTO Gato (gout, amertume, teneur, odorat) VALUES
(15, 54, 35, 19),   -- Pour Rubisca
(87, 4, 35, 59),    -- Pour Arbrista
(35, 41, 75, 67),   -- Pour Roupetta
(3, 91, 74, 6),     -- Pour Tourista
(39, 9, 7, 87);     -- Pour Goldoria

INSERT INTO CafeType (name, avatar, growTime, costDeeVee, fruitWeight, gato_id) VALUES
('Rubisca', '🌱', 1, 2, 0.632, 1),
('Arbrista', '🌳', 4, 6, 0.274, 2),
('Roupetta', '🍒', 2, 3, 0.461, 3),
('Tourista', '🌿', 1, 1, 0.961, 4),
('Goldoria', '✨', 3, 2, 0.473, 5);