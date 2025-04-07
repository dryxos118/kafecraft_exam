CREATE TABLE Gato (
    id SERIAL PRIMARY KEY,
    gout INT CHECK (gout BETWEEN 0 AND 100),
    amertume INT CHECK (amertume BETWEEN 0 AND 100),
    teneur INT CHECK (teneur BETWEEN 0 AND 100),
    odorat INT CHECK (odorat BETWEEN 0 AND 100)
);

CREATE TABLE CafeType (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    avatar VARCHAR(10),
    growTime INTERVAL NOT NULL,
    costDeeVee INT NOT NULL,
    fruitWeight FLOAT NOT NULL,
    gato_id INT REFERENCES Gato(id) ON DELETE CASCADE
);

CREATE TABLE Plant (
    id SERIAL PRIMARY KEY,
    cafe_type_id INT REFERENCES CafeType(id) ON DELETE CASCADE,
    plantedAt TIMESTAMP NOT NULL
);

CREATE TYPE FieldSpeciality AS ENUM ('rendementX2', 'tempsDivise2', 'neutre');

CREATE TABLE Field (
    id SERIAL PRIMARY KEY,
    speciality FieldSpeciality NOT NULL,
    max_plants INT DEFAULT 4
);

CREATE TABLE PlantInField (
    field_id INT REFERENCES Field(id) ON DELETE CASCADE,
    plant_id INT REFERENCES Plant(id) ON DELETE CASCADE,
    PRIMARY KEY (field_id, plant_id)
);

CREATE TABLE Exploitation (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    speciality VARCHAR(50) NOT NULL
);

CREATE TABLE FieldInExploitation (
    exploitation_id INT REFERENCES Exploitation(id) ON DELETE CASCADE,
    field_id INT REFERENCES Field(id) ON DELETE CASCADE,
    PRIMARY KEY (exploitation_id, field_id)
);

CREATE TABLE Player (
    id SERIAL PRIMARY KEY,
    firstName VARCHAR(50) NOT NULL,
    lastName VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    deeVee INT DEFAULT 10,
    exploitation_id INT REFERENCES Exploitation(id) ON DELETE SET NULL
);

INSERT INTO Gato (gout, amertume, teneur, odorat) VALUES (15, 54, 35, 19); -- Rubisca
INSERT INTO Gato (gout, amertume, teneur, odorat) VALUES (87, 4, 35, 59);  -- Arbrista
INSERT INTO Gato (gout, amertume, teneur, odorat) VALUES (35, 41, 75, 67); -- Roupetta
INSERT INTO Gato (gout, amertume, teneur, odorat) VALUES (3, 91, 74, 6);   -- Tourista
INSERT INTO Gato (gout, amertume, teneur, odorat) VALUES (39, 9, 7, 87);   -- Goldoria

INSERT INTO CafeType (name, avatar, growTime, costDeeVee, fruitWeight, gato_id) 
VALUES 
('Rubisca', '🌱', '1 minute', 2, 0.632, 1),
('Arbrista', '🌳', '4 minutes', 6, 0.274, 2),
('Roupetta', '🍒', '2 minutes', 3, 0.461, 3),
('Tourista', '🌿', '1 minute', 1, 0.961, 4),
('Goldoria', '✨', '3 minutes', 2, 0.473, 5);
