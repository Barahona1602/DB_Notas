-- create database notasdb;
use notasdb;

-- CREACION DE TABLAS 
create table if not exists tmp_carrera 
(
id_carrera int primary key auto_increment,
nombre varchar(20)
);


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
    nombre VARCHAR(50)
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
-- PROCEDIMIENTOS 
DELIMITER //
CREATE PROCEDURE crearCarrera(IN nuevo_nombre VARCHAR(20))
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Carrera WHERE nombre = nuevo_nombre) THEN
        INSERT INTO tmp_carrera (nombre) VALUES (nuevo_nombre);
    END IF;
    DELETE FROM Carrera;
    INSERT INTO Carrera (id_carrera, nombre) VALUES (0, 'Área Común');
    INSERT INTO Carrera SELECT * FROM tmp_carrera;
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
CREATE PROCEDURE crearEstudiante(
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
CREATE PROCEDURE crearDocente(
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


-- LLAMADAS
CALL crearCarrera('Civil');
CALL crearCarrera('Industrial');
CALL crearCarrera('Sistemas');
CALL crearCarrera('Mecánica');
CALL crearCurso(101, 'Matemática Básica 1', 0, 7, 0,1);
CALL crearCurso(102, 'Matemática Básica 2', 0, 7, 0,1);
CALL crearEstudiante(202300002,'María','Gómez','1998-08-22','maria@example.com',25067895,'456 Calle Secundaria',9876543210987,2);
CALL crearEstudiante(202300001,'Jose','Carrillo','2002-10-16','jose@gmail.com',45897463,'Ruta a Escuintla km 12',2997536980101,1);
CALL crearDocente(200200001,'Javier','Guzmán','1990-01-31','edu@gmail.com',78693541,'Antigua Guatemala',2997859611101);


-- BORRAR TABLAS PRUEBA
/*
DROP TABLE Curso;
DROP TABLE Estudiante;
DROP TABLE Docente;
DROP TABLE Seccion;
DROP TABLE Carrera;
DROP TABLE tmp_carrera;
DROP PROCEDURE crearCarrera;
DROP PROCEDURE crearCurso;
DROP PROCEDURE crearEstudiante;
DROP PROCEDURE crearDocente;
*/



