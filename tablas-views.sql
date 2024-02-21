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
CREATE OR REPLACE VIEW view_profesoresEnAsignatura AS
SELECT t2.nombre as Asignatura, t3.nombre AS Profesor
FROM profesoresPorAsignatura as t1 
JOIN asignaturas as t2 ON t1.idAsignatura = t2.idAsignatura
JOIN profesores as t3 ON t1.idProfesor = t3.idProfesor;

CREATE OR REPLACE VIEW view_profesoresEncargados AS
SELECT g.idGrupo AS Grupo, asig.nombre AS Asignatura, p.nombre AS ProfesorEncargado
FROM grupos g
LEFT JOIN asignaturas asig ON g.idAsignatura = asig.idAsignatura
LEFT JOIN profesores p ON g.idProfesor = p.idProfesor;

CREATE OR REPLACE VIEW view_materiasCursadasPorAlumno AS
SELECT a.nombre AS Nombre, asig.nombre AS Asignatura, g.idGrupo AS Grupo, p.nombre AS ProfesorEncargado
FROM alumnos a
INNER JOIN alumnosEnGrupo aeg ON a.idAlumno = aeg.idAlumno
INNER JOIN grupos g ON aeg.idGrupo = g.idGrupo
INNER JOIN asignaturas asig ON g.idAsignatura = asig.idAsignatura
LEFT JOIN profesores p ON g.idProfesor = p.idProfesor;


-- Cargar Datos
INSERT INTO profesores (nombre, telefono, mail, grado)
VALUES
('Pepe Frondt', '21639591', 'pfrondt0@patch.com', 2),
('Lyndsie Simao', '25380838', 'lsimao1@nba.com', 6),
('Shena Daniele', '59856754', 'sdaniele2@home.pl', 1),
('Boyce Drable', '37113416', 'bdrable3@shoppro.jp', 6),
('Delcina Scheffler', '79146534', 'dscheffler4@sciencedaily.com', 3),
('Stanislaw Axby', '83790695', 'saxby5@dailymail.co.uk', 2),
('Devy Woolhouse', '12513624', 'dwoolhouse0@wikia.com', 1),
('Dar Pittle', '62325686', 'dpittle1@sbwire.com', 6),
('Bernetta Lonsdale', '80846532', 'blonsdale2@mashable.com', 4),
('Manuel Jollie', '60615726', 'mjollie3@discuz.net', 3);

INSERT INTO asignaturas (nombre) VALUES ('Calculo'), ('Algebra'), ('Geometria'), ('Fisica'), ('Programacion');

INSERT INTO profesoresporasignatura (idAsignatura, idProfesor) VALUES (1,1), (1,2), (1,3), (2,4), (2,5), (3,6), (4,7), (5,8), (5,9);

INSERT INTO grupos (idAsignatura, idProfesor) VALUES (1,1), (1,2), (2,4), (3,6), (4,7), (5,9);

INSERT INTO alumnos (nombre, telefono, mail, edad) 
VALUES
('Caz Paraman', '13557044', 'cparaman0@last.fm', 20),
('Wheeler Worsnup', '10111648', 'wworsnup1@businessweek.com', 22),
('Leonora Rains', '41583235', 'lrains2@last.fm', 24),
('Glenden Collier', '19848447', 'gcollier3@ucoz.ru', 21),
('Tamiko Dymoke', '48589719', 'tdymoke4@ameblo.jp', 23),
('Dino Tabord', '65254242', 'dtabord5@usnews.com', 26),
('Cherise Speers', '18571036', 'cspeers6@wunderground.com', 18),
('Eadmund Webling', '33532541', 'ewebling7@pagesperso-orange.fr', 25),
('Nell Sambeck', '21797903', 'nsambeck8@nbcnews.com', 28),
('Marrissa Lindholm', '52173812', 'mlindholm9@zimbio.com', 26),
('Cointon Eccersley', '53238267', 'ceccersleya@abc.net.au', 26),
('Marsh Hugli', '97835503', 'mhuglib@jalbum.net', 24),
('Charity Portlock', '47435946', 'cportlockc@hexun.com', 35),
('Bennie McKelvie', '91056937', 'bmckelvied@opera.com', 30),
('Lilith Echlin', '37530871', 'lechline@howstuffworks.com', 28),
('Jaimie Pettifer', '81830437', 'jpettiferf@ca.gov', 22),
('Husein Paddy', '94774390', 'hpaddyg@cafepress.com', 28),
('Drusi Prestner', '95278536', 'dprestnerh@livejournal.com', 22),
('Jemima Pitcaithly', '61998548', 'jpitcaithlyi@ifeng.com', 23),
('Maure Ivanshintsev', '55715939', 'mivanshintsevj@nymag.com', 20),
('Harrie Trainer', '86097801', 'htrainerk@yahoo.co.jp', 26),
('Vasilis Matuschek', '95048871', 'vmatuschekl@ted.com', 34),
('Beverlie Skyram', '40014193', 'bskyramm@imageshack.us', 29),
('Rudolfo Fewings', '90251236', 'rfewingsn@geocities.com', 33),
('Morena Warton', '26859091', 'mwartono@gnu.org', 23),
('Gibb Boggers', '46172864', 'gboggersp@arizona.edu', 18),
('Tiebout Kettridge', '78524533', 'tkettridgeq@soup.io', 30),
('Griz Verdon', '54540618', 'gverdonr@goo.ne.jp', 31),
('Clovis Trematick', '17125426', 'ctrematicks@storify.com', 24),
('Bailey Bartell', '75634667', 'bbartellt@theguardian.com', 20),
('Lorens Edgeon', '73934166', 'ledgeonu@deviantart.com', 24),
('Rayner Weller', '86595580', 'rwellerv@europa.eu', 33),
('Reinold Ghelardoni', '43494347', 'rghelardoniw@technorati.com', 32),
('Cord Whitlock', '41065065', 'cwhitlockx@naver.com', 27),
('Bartolomeo Dulson', '46521477', 'bdulsony@multiply.com', 34),
('Aryn Seale', '69748840', 'asealez@businessweek.com', 30),
('Aileen Phelit', '16625720', 'aphelit10@youtu.be', 26),
('Trey Zimmermeister', '71389994', 'tzimmermeister11@cmu.edu', 21),
('Sollie Jozaitis', '68725100', 'sjozaitis12@nba.com', 33),
('Constancy Baigent', '74762582', 'cbaigent13@mit.edu', 29),
('Alphonso Cyster', '66295979', 'acyster14@wikipedia.org', 22),
('Blanche Burree', '61790843', 'bburree15@qq.com', 34),
('Tabbie Reynish', '27166847', 'treynish16@unesco.org', 35),
('Valera Kerton', '40491781', 'vkerton17@vimeo.com', 35),
('Lorena Kalewe', '79125961', 'lkalewe18@about.me', 18),
('Scarface Crosswaite', '70541397', 'scrosswaite19@gov.uk', 27),
('Marya Peegrem', '34288918', 'mpeegrem1a@qq.com', 30),
('Manuel Klambt', '25767303', 'mklambt1b@ucla.edu', 31),
('Filippa Poor', '89515671', 'fpoor1c@indiatimes.com', 35),
('Karlene Lanyon', '70131509', 'klanyon1d@de.vu', 33),
('Deane Seamon', '49275970', 'dseamon1e@diigo.com', 19),
('Inness Butchers', '37152838', 'ibutchers1f@reddit.com', 22),
('Roxine Hackwell', '10169483', 'rhackwell1g@dell.com', 30),
('Winslow Newham', '87681732', 'wnewham1h@tmall.com', 22),
('Ara Goacher', '50170880', 'agoacher1i@eventbrite.com', 26),
('Josefa McRamsey', '47663865', 'jmcramsey1j@intel.com', 19),
('Doloritas Abade', '75949248', 'dabade1k@multiply.com', 25);

INSERT INTO alumnosEnGrupo 
VALUES 
(1, 12), (1, 44), (1, 50), (1, 17), (1, 57), (1, 31), (1, 2), (1, 3), (1, 36), (1, 24), (1, 43), (1, 27), (1, 25), (1, 26), (1, 18), (1, 40), (1, 52), (1, 49), (1, 46), (1, 42), (1, 51), (1, 8), (1, 34), (1, 23), (1, 22),
(2, 45), (2, 48), (2, 39), (2, 53), (2, 35), (2, 38), (2, 20), (2, 47), (2, 54), (2, 4), (2, 41), (2, 13), (2, 32), (2, 1), (2, 37), (2, 55), (2, 56), (2, 9), (2, 5), (2, 6), (2, 7), (2, 30), (2, 21), (2, 16), (2, 15), (2, 19),
(3, 38), (3, 57), (3, 39), (3, 34), (3, 35), (3, 17), (3, 10), (3, 54), (3, 52), (3, 36), (3, 33), (3, 53), (3, 51), (3, 3), (3, 8), (3, 46), (3, 9), (3, 28), (3, 31), (3, 19), (3, 22), (3, 44), (3, 14), (3, 37),
(4, 2), (4, 5), (4, 11), (4, 23), (4, 30), (4, 12), (4, 41), (4, 31), (4, 48), (4, 37), (4, 55), (4, 54), (4, 49), (4, 18), (4, 28), (4, 32), (4, 51), (4, 50), (4, 33), (4, 20), (4, 15), (4, 42),
(5, 5), (5, 22), (5, 8), (5, 4), (5, 25), (5, 46), (5, 47), (5, 57), (5, 34), (5, 37), (5, 56), (5, 55), (5, 54), (5, 53), (5, 6), (5, 41), (5, 43), (5, 51),
(6, 3), (6, 18), (6, 23), (6, 4), (6, 17), (6, 1), (6, 21), (6, 24), (6, 25), (6, 48), (6, 56), (6, 9), (6, 47), (6, 6), (6, 13), (6, 55), (6, 31), (6, 52), (6, 38), (6, 33), (6, 37);