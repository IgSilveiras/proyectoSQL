-- Crear Schema
CREATE SCHEMA escuela;
USE escuela;

-- Crear tablas
CREATE TABLE alumnos (
	idAlumno INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    telefono INT NOT NULL,
    mail VARCHAR(75) NOT NULL,
    edad INT NOT NULL
);

CREATE TABLE profesores (
	idProfesor INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    telefono INT NOT NULL,
    mail VARCHAR(75) NOT NULL,
    grado INT
);

CREATE TABLE asignaturas (
	idAsignatura INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL
);

CREATE TABLE grupos (
	idGrupo INT AUTO_INCREMENT PRIMARY KEY,
	idAsignatura int
);

CREATE TABLE alumnosEnGrupo (
	idGrupo INT,
    idAlumno INT,
    PRIMARY KEY (idGrupo, idAlumno)
);

CREATE TABLE profesoresPorAsignatura (
	idAsignatura INT,
    idProfesor INT,
    PRIMARY KEY (idAsignatura, idProfesor)
);


-- Crear Relaciones
ALTER TABLE grupos
ADD idProfesor INT;

ALTER TABLE grupos
ADD CONSTRAINT FK_GRUPOS_PROFESOR
FOREIGN KEY (idProfesor) REFERENCES profesores(idProfesor);

ALTER TABLE grupos
ADD CONSTRAINT FK_GRUPOS_ASIGNATURA
FOREIGN KEY (idAsignatura) REFERENCES asignaturas(idAsignatura);

ALTER TABLE alumnosEnGrupo
ADD CONSTRAINT FK_AEG_GRUPO
FOREIGN KEY (idGrupo) REFERENCES grupos(idGrupo);

ALTER TABLE alumnosEnGrupo
ADD CONSTRAINT FK_AEG_ALUMNOS
FOREIGN KEY (idAlumno) REFERENCES alumnos(idAlumno);

ALTER TABLE profesoresPorAsignatura
ADD CONSTRAINT FK_PPA_ASIGNATURA
FOREIGN KEY (idAsignatura) REFERENCES asignaturas(idAsignatura);

ALTER TABLE profesoresPorAsignatura
ADD CONSTRAINT FK_PPA_PROFESORES
FOREIGN KEY (idProfesor) REFERENCES profesores(idProfesor);


-- Crear Views
CREATE OR REPLACE VIEW profesoresEnAsignatura AS
SELECT t2.nombre as Asignatura, t3.nombre AS Profesor
FROM profesoresPorAsignatura as t1 
JOIN asignaturas as t2 ON t1.idAsignatura = t2.idAsignatura
JOIN profesores as t3 ON t1.idProfesor = t3.idProfesor;


-- Cargar Datos
INSERT INTO profesores (nombre, telefono, mail, grado) VALUES ('Pepe Frondt', '21639591', 'pfrondt0@patch.com', 2),('Lyndsie Simao', '25380838', 'lsimao1@nba.com', 6),('Shena Daniele', '59856754', 'sdaniele2@home.pl', 1),('Boyce Drable', '37113416', 'bdrable3@shoppro.jp', 6),('Delcina Scheffler', '79146534', 'dscheffler4@sciencedaily.com', 3),('Stanislaw Axby', '83790695', 'saxby5@dailymail.co.uk', 2);

INSERT INTO asignaturas (nombre) VALUES ('Calculo'), ('Algebra'), ('Geometria'), ('Fisica'), ('Programacion');

INSERT INTO profesoresporasignatura (idAsignatura, idProfesor) VALUES (1,1), (1,2), (2,3), (3,4), (4,5), (5,6);