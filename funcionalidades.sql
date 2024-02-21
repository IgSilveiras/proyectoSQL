-- Crear Schema
CREATE SCHEMA escuela;
USE escuela;


-- Crear SPs
DELIMITER //

CREATE PROCEDURE getMateriasCursadasPorAlumno (IN id INT)
BEGIN 
    SELECT * 
    FROM view_materiascursadasporalumno
    WHERE Nombre = (SELECT nombre FROM alumnos WHERE idAlumno = id);
END //

CREATE PROCEDURE inscribirAlumno (nombre VARCHAR(50), telefono INT, mail VARCHAR(75), edad INT)
BEGIN 
    INSERT INTO alumnos (nombre, telefono, mail, edad) VALUES (nombre, telefono, mail, edad);
END //

CREATE PROCEDURE desistirAlumno (id INT)
BEGIN
    DELETE FROM alumnosengrupo where idAlumno = id;
    DELETE FROM alumnos where idAlumno = id;
END //


-- Crear Funciones
CREATE FUNCTION calcularAlumnosCursandoAsignatura(id INT)
RETURNS INT
READS SQL DATA
BEGIN
    DECLARE total_alumnos INT;
    
    SELECT SUM(num_alumnos) INTO total_alumnos
    FROM (
        SELECT COUNT(*) AS num_alumnos
        FROM alumnosEnGrupo aeg
        INNER JOIN grupos g ON aeg.idGrupo = g.idGrupo
        WHERE g.idAsignatura = id
        GROUP BY g.idGrupo
    ) AS alumnos_per_group;
    
    RETURN total_alumnos;
END //

CREATE FUNCTION calcularAlumnosACargoProfesor(id INT)
RETURNS INT
READS SQL DATA
BEGIN
    DECLARE total_alumnos INT;
    
    SELECT SUM(num_alumnos) INTO total_alumnos
    FROM (
        SELECT COUNT(*) AS num_alumnos
        FROM alumnosEnGrupo aeg
        INNER JOIN grupos g ON aeg.idGrupo = g.idGrupo
        WHERE g.idProfesor = id
        GROUP BY g.idGrupo
    ) AS alumnos_por_grupo;
    
    RETURN total_alumnos;
END //

DELIMITER ;