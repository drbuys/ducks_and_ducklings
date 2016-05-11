CREATE TABLE mummy_ducks (
  id SERIAL4 primary key,
  name VARCHAR(255),
  address VARCHAR(255),
  duck_type VARCHAR(255)
);


CREATE TABLE ducklings (
  id SERIAL4 primary key,
  name VARCHAR(255),
  hobby VARCHAR(255),
  age INT4,
  mummy_id INT4 references mummy_ducks(id)
);
