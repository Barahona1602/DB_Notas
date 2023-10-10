-- create database notasdb;
use notasdb;


-- --------------------------------------------------------
-- CREACION DE TABLAS 
-- --------------------------------------------------------
create table if not exists Carrera 
(
id_carrera int primary key,
nombre varchar(20)
);
INSERT IGNORE INTO Carrera (id_carrera, nombre) VALUES (0, 'Área Común');


CREATE TABLE IF NOT EXISTS Curso
(
id_curso int primary key,
nombre varchar(20),
creditos_necesarios int,
creditos_otorgados int,
id_carrera int,
obligatorio bit,
FOREIGN KEY (id_carrera) REFERENCES Carrera(id_carrera)
);


CREATE TABLE IF NOT EXISTS Estudiante
(
    id_estudiante bigint PRIMARY KEY,
    nombre VARCHAR(50),
    apellido VARCHAR(50),
    fecha_nacimiento DATE,
    correo VARCHAR(100),
    telefono int(8),
    direccion VARCHAR(100),
    dpi bigint(13),
    creditos INT DEFAULT 0,
    id_carrera INT,
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_carrera) REFERENCES Carrera(id_carrera)
);


CREATE TABLE IF NOT EXISTS Seccion
(
    id_seccion INT PRIMARY KEY AUTO_INCREMENT,
    letra CHAR(1)
);

CREATE TABLE IF NOT EXISTS Ciclo
(
    id_ciclo INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(2)
);

CREATE TABLE IF NOT EXISTS Docente
(
    id_docente bigint PRIMARY KEY,
    nombre VARCHAR(50),
    apellido VARCHAR(50),
    fecha_nacimiento DATE,
    correo VARCHAR(100),
    telefono int(8),
    direccion VARCHAR(100),
    dpi bigint(13),
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE IF NOT EXISTS CursoHabilitado
(
	id_cursohabilitado INT PRIMARY KEY AUTO_INCREMENT,
    cupomaximo INT,
    id_seccion INT,
    id_docente BIGINT,
    id_ciclo INT,
    id_curso INT,
    asignacion INT DEFAULT 0,
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_seccion) REFERENCES Seccion(id_seccion),
    FOREIGN KEY (id_docente) REFERENCES Docente(id_docente),
    FOREIGN KEY (id_ciclo) REFERENCES Ciclo(id_ciclo),
    FOREIGN KEY (id_curso) REFERENCES Curso(id_curso)
);

CREATE TABLE IF NOT EXISTS Horario
(
id_horario INT PRIMARY KEY AUTO_INCREMENT,
dia INT,
horario VARCHAR(20)
);


CREATE TABLE IF NOT EXISTS HorarioEnCurso
(
	id_cursohabilitado int, 
	id_horario int,
	FOREIGN KEY (id_cursohabilitado) REFERENCES CursoHabilitado(id_cursohabilitado),
    FOREIGN KEY (id_horario) REFERENCES Horario(id_horario)
);


CREATE TABLE IF NOT EXISTS Asignacion(
id_asignacion INT PRIMARY KEY AUTO_INCREMENT,
asignado BIT,
id_estudiante BIGINT,
id_cursohabilitado INT,
FOREIGN KEY (id_estudiante) REFERENCES Estudiante(id_estudiante),
FOREIGN KEY (id_cursohabilitado) REFERENCES CursoHabilitado(id_cursohabilitado)
);


CREATE TABLE IF NOT EXISTS Nota(
id_nota INT PRIMARY KEY AUTO_INCREMENT,
nota INT,
id_asignacion INT,
FOREIGN KEY (id_asignacion) REFERENCES Asignacion(id_asignacion)
);


CREATE TABLE IF NOT EXISTS Acta(
	id_acta INT PRIMARY KEY AUTO_INCREMENT,
	fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id_cursohabilitado INT,
    FOREIGN KEY (id_cursohabilitado) REFERENCES CursoHabilitado(id_cursohabilitado)
);


-- --------------------------------------------------------
-- PROCEDIMIENTOS 
-- --------------------------------------------------------
DELIMITER //
CREATE PROCEDURE crearCarrera(IN nuevo_nombre VARCHAR(20))
BEGIN
    DECLARE nuevo_id INT;
    SELECT id_carrera INTO nuevo_id FROM Carrera WHERE nombre = nuevo_nombre LIMIT 1;
    IF nuevo_id IS NULL THEN
        SELECT MAX(id_carrera) + 1 INTO nuevo_id FROM Carrera;
        IF nuevo_id IS NULL THEN
            SET nuevo_id = 0;
        END IF;
        INSERT INTO Carrera (id_carrera, nombre) VALUES (nuevo_id, nuevo_nombre);
    END IF;
END;
//
DELIMITER ;


DELIMITER //
CREATE PROCEDURE habilitarCurso(
    IN id_curso INT,
    IN nombre_ciclo VARCHAR(2),
    IN id_docente bigint,
    IN cupomaximo INT,
    IN nuevo_letra CHAR(1)
)
BEGIN
    DECLARE seccion_id INT;
    DECLARE ciclo_id INT;
    SELECT id_seccion INTO seccion_id FROM Seccion WHERE letra = nuevo_letra;
    IF seccion_id IS NULL THEN
        INSERT INTO Seccion (letra) VALUES (nuevo_letra);
        SET seccion_id = LAST_INSERT_ID();
    END IF;
    SELECT id_ciclo INTO ciclo_id FROM Ciclo WHERE nombre = nombre_ciclo;
    IF ciclo_id IS NULL THEN
        INSERT INTO Ciclo (nombre) VALUES (nombre_ciclo);
        SET ciclo_id = LAST_INSERT_ID();
    END IF;
    INSERT INTO cursohabilitado (
    cupomaximo, 
    id_seccion, 
    id_docente,
    id_curso,
    id_ciclo
    ) 
    VALUES (
    cupomaximo, 
    seccion_id, 
    id_docente, 
    id_curso,
    ciclo_id
    );
END;
//
DELIMITER ;


DELIMITER //
CREATE PROCEDURE crearCurso(
IN nuevo_id_curso int,
IN nuevo_nombre VARCHAR(20),
IN nuevo_creditos_necesarios int,
IN nuevo_creditos_otorgados int,
IN nuevo_id_carrera int,
IN nuevo_obligatorio bit
)
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Curso WHERE id_curso = nuevo_id_curso) THEN
        INSERT INTO Curso(
        id_curso,
        nombre,
		creditos_necesarios,
		creditos_otorgados,
        id_carrera,
		obligatorio
        ) 
        VALUES (
        nuevo_id_curso,
		nuevo_nombre,
		nuevo_creditos_necesarios,
		nuevo_creditos_otorgados,
		nuevo_id_carrera,
		nuevo_obligatorio 
		);
    END IF;
END;
//
DELIMITER ;


DELIMITER //
CREATE PROCEDURE registrarEstudiante(
    IN nuevo_carnet bigint,
    IN nuevo_nombre VARCHAR(50),
    IN nuevo_apellido VARCHAR(50),
    IN nueva_fecha_nacimiento DATE,
    IN nuevo_correo VARCHAR(100),
    IN nuevo_telefono int(8),
    IN nueva_direccion VARCHAR(100),
    IN nuevo_dpi bigint(13),
    IN nuevo_id_carrera INT
)
BEGIN
   
    IF NOT EXISTS (SELECT 1 FROM Estudiante WHERE id_estudiante = nuevo_carnet) THEN
        INSERT INTO Estudiante (
            id_estudiante,
            nombre,
            apellido,
            fecha_nacimiento,
            correo,
            telefono,
            direccion,
            dpi,
            id_carrera
        ) VALUES (
            nuevo_carnet,
            nuevo_nombre,
            nuevo_apellido,
            nueva_fecha_nacimiento,
            nuevo_correo,
            nuevo_telefono,
            nueva_direccion,
            nuevo_dpi,
            nuevo_id_carrera
        );
    END IF;
END;
//
DELIMITER ;


DELIMITER //
CREATE PROCEDURE registrarDocente(
    IN nuevo_carnet bigint,
    IN nuevo_nombre VARCHAR(50),
    IN nuevo_apellido VARCHAR(50),
    IN nueva_fecha_nacimiento DATE,
    IN nuevo_correo VARCHAR(100),
    IN nuevo_telefono int(8),
    IN nueva_direccion VARCHAR(100),
    IN nuevo_dpi bigint(13)
)
BEGIN
   
    IF NOT EXISTS (SELECT 1 FROM Docente WHERE id_docente = nuevo_carnet) THEN
        INSERT INTO Docente (
            id_docente,
            nombre,
            apellido,
            fecha_nacimiento,
            correo,
            telefono,
            direccion,
            dpi
        ) VALUES (
            nuevo_carnet,
            nuevo_nombre,
            nuevo_apellido,
            nueva_fecha_nacimiento,
            nuevo_correo,
            nuevo_telefono,
            nueva_direccion,
            nuevo_dpi
        );
    END IF;
END;
//
DELIMITER ;


-- --------------------------------------------------------
-- LLAMADAS
-- --------------------------------------------------------
CALL crearCarrera('Civil');
CALL crearCarrera('Mecanica Industrial');
CALL crearCarrera('Industrial');
CALL crearCarrera('Sistemas');
CALL crearCarrera('Mecánica');
CALL crearCurso(101, 'Matemática Básica 1', 0, 7, 0,1);
CALL crearCurso(102, 'Matemática Básica 2', 0, 7, 0,1);
CALL registrarEstudiante(202300002,'María','Gómez','1998-08-22','maria@example.com',25067895,'456 Calle Secundaria',9876543210987,2);
CALL registrarEstudiante(202300001,'Jose','Carrillo','2002-10-16','jose@gmail.com',45897463,'Ruta a Escuintla km 12',2997536980101,1);
CALL registrarDocente(200200001,'Javier','Guzmán','1990-01-31','edu@gmail.com',78693541,'Antigua Guatemala',2997859611101);
CALL habilitarCurso(101, '1S', 200200001, 25, 'A');
CALL habilitarCurso(102, '1S', 200200001, 25, 'B');
CALL crearCarrera('Electrica');


-- --------------------------------------------------------
-- BORRAR TABLAS PRUEBA
-- --------------------------------------------------------
/*
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE CursoHabilitado;
DROP TABLE HorarioEnCurso;
DROP TABLE Horario;
DROP TABLE Acta;
DROP TABLE Nota;
DROP TABLE Asignacion;
DROP TABLE Estudiante;
DROP TABLE Docente;
DROP TABLE Curso;
DROP TABLE Seccion;
DROP TABLE Carrera;
DROP TABLE Ciclo;
SET FOREIGN_KEY_CHECKS = 1;
DROP PROCEDURE crearCarrera;
DROP PROCEDURE crearCurso;
DROP PROCEDURE registrarEstudiante;
DROP PROCEDURE registrarDocente;
DROP PROCEDURE habilitarCurso;
*/



