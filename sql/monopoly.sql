--
-- This SQL script builds a monopoly database, deleting any pre-existing version.
--
-- @author kvlinden
-- @version Summer, 2015
--

-- Drop previous versions of the tables if they they exist, in reverse order of foreign keys.
DROP TABLE IF EXISTS PropertyOwnership;
DROP TABLE IF EXISTS Property;
DROP TABLE IF EXISTS PlayerGame;
DROP TABLE IF EXISTS Game;
DROP TABLE IF EXISTS Player;

-- Create the schema.
CREATE TABLE Game (
	ID integer PRIMARY KEY,
	time timestamp
	);

CREATE TABLE Player (
	ID integer PRIMARY KEY, 
	emailAddress varchar(50) NOT NULL,
	name varchar(50)
	);

CREATE TABLE PlayerGame (
	gameID integer REFERENCES Game(ID),
	playerID integer REFERENCES Player(ID),
	score integer,
	cash integer,
	currentPosition integer
	);

CREATE TABLE Property (
	ID integer PRIMARY KEY,
	name varchar(50) NOT NULL,
	boardPosition integer,
	propertyGroup varchar(20),
	purchasePrice integer
	);

CREATE TABLE PropertyOwnership (
	gameID integer REFERENCES Game(ID),
	playerID integer REFERENCES Player(ID),
	propertyID integer REFERENCES Property(ID),
	houses integer DEFAULT 0,
	hotels integer DEFAULT 0,
	PRIMARY KEY (gameID, propertyID)
	);

-- Allow users to select data from the tables.
GRANT SELECT ON Game TO PUBLIC;
GRANT SELECT ON Player TO PUBLIC;
GRANT SELECT ON PlayerGame TO PUBLIC;
GRANT SELECT ON Property TO PUBLIC;
GRANT SELECT ON PropertyOwnership TO PUBLIC;

-- Add sample records.
INSERT INTO Game VALUES (1, '2006-06-27 08:00:00');
INSERT INTO Game VALUES (2, '2006-06-28 13:20:00');
INSERT INTO Game VALUES (3, '2006-06-29 18:41:00');

INSERT INTO Player(ID, emailAddress) VALUES (1, 'me@calvin.edu');
INSERT INTO Player VALUES (2, 'king@gmail.edu', 'The King');
INSERT INTO Player VALUES (3, 'dog@gmail.edu', 'Dogbreath');

INSERT INTO PlayerGame VALUES (1, 1, 0.00, 150, 5);
INSERT INTO PlayerGame VALUES (1, 2, 0.00, 200, 12);
INSERT INTO PlayerGame VALUES (1, 3, 2350.00, 3500, 28);
INSERT INTO PlayerGame VALUES (2, 1, 1000.00, 1200, 15);
INSERT INTO PlayerGame VALUES (2, 2, 0.00, 50, 10);
INSERT INTO PlayerGame VALUES (2, 3, 500.00, 800, 22);
INSERT INTO PlayerGame VALUES (3, 2, 0.00, 100, 7);
INSERT INTO PlayerGame VALUES (3, 3, 5500.00, 6000, 39);

-- Insert sample properties
INSERT INTO Property VALUES (1, 'Boardwalk', 39, 'Dark Blue', 400);
INSERT INTO Property VALUES (2, 'Park Place', 37, 'Dark Blue', 350);
INSERT INTO Property VALUES (3, 'Pennsylvania Avenue', 34, 'Green', 320);
INSERT INTO Property VALUES (4, 'Pacific Avenue', 31, 'Green', 300);
INSERT INTO Property VALUES (5, 'Marvin Gardens', 29, 'Yellow', 280);
INSERT INTO Property VALUES (6, 'Baltic Avenue', 3, 'Purple', 60);
INSERT INTO Property VALUES (7, 'Mediterranean Avenue', 1, 'Purple', 60);

-- Insert sample property ownership (for game 1)
INSERT INTO PropertyOwnership VALUES (1, 3, 1, 0, 1);  -- Player 3 owns Boardwalk with 1 hotel
INSERT INTO PropertyOwnership VALUES (1, 3, 2, 4, 0);  -- Player 3 owns Park Place with 4 houses
INSERT INTO PropertyOwnership VALUES (1, 2, 3, 2, 0);  -- Player 2 owns Pennsylvania Ave with 2 houses
INSERT INTO PropertyOwnership VALUES (1, 1, 6, 0, 0);  -- Player 1 owns Baltic Avenue
INSERT INTO PropertyOwnership VALUES (1, 1, 7, 0, 0);  -- Player 1 owns Mediterranean Avenue