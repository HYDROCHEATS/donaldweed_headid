CREATE TABLE IF NOT EXISTS player_relations (
    identifier VARCHAR(60) NOT NULL,
    target_identifier VARCHAR(60) NOT NULL,
    PRIMARY KEY (identifier, target_identifier)
);
