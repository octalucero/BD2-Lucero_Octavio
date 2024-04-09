CREATE DATABASE imdb;

CREATE TABLE if not	exists pelicula (
  pelicula_id INT PRIMARY KEY AUTO_INCREMENT,
  titulo VARCHAR(255) NOT NULL,
  descripcion varchar(255),
  anio_estreno YEAR
);

CREATE TABLE if not exists actor (
  actor_id INT PRIMARY KEY AUTO_INCREMENT,
  nombre VARCHAR(100) NOT NULL,
  apellido VARCHAR(100) NOT NULL
);

CREATE TABLE if not exists pelicula_actor (
  actor_id INT NOT NULL,
  pelicula_id INT NOT NULL,
  PRIMARY KEY (actor_id, pelicula_id),
  FOREIGN KEY (actor_id) REFERENCES actor(actor_id),
  FOREIGN KEY (pelicula_id) REFERENCES pelicula(pelicula_id)
);

ALTER TABLE pelicula ADD COLUMN ultima_actualizacion DATETIME DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE actor ADD COLUMN ultima_actualizacion DATETIME DEFAULT CURRENT_TIMESTAMP;

ALTER TABLE pelicula_actor ADD FOREIGN KEY (actor_id) REFERENCES actor (actor_id);
ALTER TABLE pelicula_actor ADD FOREIGN KEY (pelicula_id) REFERENCES pelicula (pelicula_id);


INSERT INTO actor (nombre, apellido) VALUES 
('Tom', 'Cruise'), 
('Cillian', 'Murphy'), 
('Leonardo', 'DiCaprio');

INSERT INTO pelicula (titulo, descripcion, anio_estreno) VALUES 
('Top Gun', 'Tras más de 30 años de servicio ', 2022), 
('Oppenheimer', 'Durante la Segunda Guerra Mundial,', 2023), 
('Inception', 'Dom Cobb es un ladrón', 2010);

INSERT INTO pelicula_actor (actor_id, pelicula_id) VALUES 
(1, 1), 
(2, 1), 
(3, 2);
