DROP TABLE tickets;
DROP TABLE customers;
DROP TABLE films;

CREATE TABLE customers (
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(255)
);

CREATE TABLE films (
  id SERIAL4 PRIMARY KEY,
  category VARCHAR(255),
  name VARCHAR(255)
);

CREATE TABLE tickets (
id SERIAL4 PRIMARY KEY,
user_id INT4 REFERENCES users(id) ON DELETE CASCADE,
  location_id INT4 REFERENCES locations(id),
  review TEXT
);
