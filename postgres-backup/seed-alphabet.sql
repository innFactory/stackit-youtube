-- Seed script to fill the database with the alphabet (26 letters)
CREATE TABLE "abc-entries" (
    id SERIAL PRIMARY KEY,
    abc TEXT,
    createdAT TIMESTAMPTZ DEFAULT NOW()
);

INSERT INTO "abc-entries" (abc) VALUES
    ('A'),
    ('B'),
    ('C'),
    ('D'),
    ('E'),
    ('F'),
    ('G'),
    ('H'),
    ('I'),
    ('J'),
    ('K'),
    ('L'),
    ('M'),
    ('N'),
    ('O'),
    ('P'),
    ('Q'),
    ('R'),
    ('S'),
    ('T'),
    ('U'),
    ('V'),
    ('W'),
    ('X'),
    ('Y'),
    ('Z');
