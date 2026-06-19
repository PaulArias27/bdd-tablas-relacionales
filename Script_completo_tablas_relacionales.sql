
CREATE TABLE libros(

	codigo VARCHAR(5) PRIMARY KEY,
	titulo VARCHAR(50) NOT NULL,
	paginas INT NOT NULL
);

CREATE TABLE autores(

	id INT PRIMARY KEY,
	nombre VARCHAR(50) NOT NULL,
	pais VARCHAR(30) NOT NULL
);
--TABLA DE ROMPIMIENTO

CREATE TABLE libro_autor(

	la_libro_codigo_fk VARCHAR(5) NOT NULL,
	la_autor_id_fk int NOT NULL,
	anio_publicacion int NOT NULL,

	PRIMARY KEY(la_libro_codigo_fk,la_autor_id_fk),

	CONSTRAINT fk_libro FOREIGN KEY(la_libro_codigo_fk) REFERENCES libros(codigo),

	CONSTRAINT fk_autor FOREIGN KEY (la_autor_id_fk) REFERENCES autores(id)
);

INSERT INTO libros(codigo, titulo, paginas)
VALUES
('L001', 'Java Basico', 250),
('L002', 'Spring Boot', 400),
('L003', 'PostgreSQL Avanzado', 320),
('L004', 'Desarrollo Web', 280);

INSERT INTO autores(id, nombre, pais)
VALUES
(1, 'Carlos Perez', 'Ecuador'),
(2, 'Ana Torres', 'Colombia'),
(3, 'Luis Ramirez', 'Peru');

INSERT INTO libro_autor(
    la_libro_codigo_fk,
    la_autor_id_fk,
    anio_publicacion
)
VALUES
('L001', 1, 2019),
('L002', 1, 2022),
('L002', 2, 2023),
('L003', 3, 2021),
('L004', 2, 2024);

--consultas

SELECT l.titulo,a.nombre,a.pais,la.anio_publicacion
FROM libro_autor la INNER JOIN libros l 
on la.la_libro_codigo_fk = l.codigo
INNER JOIN autores a
on la.la_autor_id_fk = a.id;

--2
SELECT l.titulo, la.anio_publicacion FROM libro_autor la
INNER JOIN libros l
on la.la_libro_codigo_fk = l.codigo
WHERE la.anio_publicacion > 2020;

--3
SELECT *
FROM autores
WHERE pais = 'Ecuador';

--4
SELECT  l.titulo,la.anio_publicacion
FROM libro_autor la
INNER JOIN libros l
ON la.la_libro_codigo_fk = l.codigo
ORDER BY la.anio_publicacion DESC;

--5
SELECT a.nombre,
COUNT(*) AS cantidad_libros
FROM libro_autor la
INNER JOIN autores a
ON la.la_autor_id_fk = a.id
GROUP BY a.nombre;

-- modificacion
ALTER TABLE libros
ADD COLUMN precio DOUBLE PRECISION;

UPDATE libros
SET precio = 25.50
WHERE codigo = 'L001';

UPDATE libros
SET precio = 40.00
WHERE codigo = 'L002';

UPDATE libros
SET precio = 35.75
WHERE codigo = 'L003';

SELECT titulo,precio FROM libros;