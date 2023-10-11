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
    notas INT DEFAULT 0,
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


CREATE TABLE IF NOT EXISTS Bitacora (
    id_bitacora INT AUTO_INCREMENT PRIMARY KEY,
    fecha DATETIME,
    descripcion VARCHAR(255),
    tipo VARCHAR(20)
);



-- --------------------------------------------------------
-- FUNCIONES
-- --------------------------------------------------------
DELIMITER //
CREATE FUNCTION EsLetraAZ(caracter CHAR(1))
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    DECLARE esLetra BOOLEAN;
    SET esLetra = FALSE;
    IF (ASCII(caracter) BETWEEN ASCII('A') AND ASCII('Z') AND caracter NOT LIKE 'Ñ') THEN
        SET esLetra = TRUE;
    END IF;

    RETURN esLetra;
END;
//
DELIMITER ;


DELIMITER //
CREATE FUNCTION EsCorreoValido(correo VARCHAR(100))
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    DECLARE esValido BOOLEAN;
    SET esValido = FALSE;
    SET @correo_regex = '^[A-Za-z0-9._%-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}$';
    IF correo REGEXP @correo_regex THEN
        SET esValido = TRUE;
    END IF;
    RETURN esValido;
END;
//
DELIMITER ;


DELIMITER //
CREATE FUNCTION EsSoloLetras(frase VARCHAR(255)) 
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    DECLARE i INT;
    DECLARE len INT;
    SET i = 1;
    SET len = LENGTH(frase);
    WHILE i <= len DO
        IF NOT (SUBSTRING(frase, i, 1) REGEXP '^[A-Za-zÁÉÍÓÚÜáéíóíü ]$') THEN
            RETURN FALSE; 
        END IF;
        SET i = i + 1;
    END WHILE;
    RETURN TRUE;
END;
//
DELIMITER ;


DELIMITER //
CREATE FUNCTION ValidarYReducirTelefono(telefono VARCHAR(20)) 
RETURNS VARCHAR(8)
DETERMINISTIC
BEGIN
    DECLARE telefono_validado VARCHAR(20);
    SET telefono_validado = REGEXP_REPLACE(telefono, '[^0-9]', '');
    IF LENGTH(telefono_validado) > 8 THEN
        SET telefono_validado = RIGHT(telefono_validado, 8);
    END IF;
    RETURN telefono_validado;
END;
//
DELIMITER ;


DELIMITER //
CREATE FUNCTION ValidarValoresPermitidos(valor VARCHAR(2)) 
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    DECLARE resultado BOOLEAN DEFAULT FALSE;
    IF valor IN ('1S', '2S', 'VJ', 'VD') THEN
        SET resultado = TRUE;
    END IF;
    RETURN resultado;
END;
//
DELIMITER ;


DELIMITER //
CREATE FUNCTION EsEnteroPositivo(valor INT) 
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    DECLARE es_valido BOOLEAN DEFAULT FALSE;
    IF valor >= 0 AND valor = FLOOR(valor) THEN
        SET es_valido = TRUE;
    END IF;
    RETURN es_valido;
END;
//
DELIMITER ;


DELIMITER //
CREATE FUNCTION VerificarDia(numero INT) 
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    DECLARE es_valido BOOLEAN DEFAULT FALSE;
    IF numero >= 1 AND numero <= 7 THEN
        SET es_valido = TRUE;
    END IF;
    RETURN es_valido;
END;
//
DELIMITER ;


-- --------------------------------------------------------
-- PROCEDIMIENTOS 
-- --------------------------------------------------------
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
   IF NOT EsCorreoValido(nuevo_correo) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El correo no tiene un formato válido';
    END IF;
    SET nuevo_telefono = ValidarYReducirTelefono(nuevo_telefono);
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
CREATE PROCEDURE crearCarrera(IN nuevo_nombre VARCHAR(20))
BEGIN
    DECLARE nuevo_id INT;
    IF EsSoloLetras(nuevo_nombre) THEN
        SELECT id_carrera INTO nuevo_id FROM Carrera WHERE nombre = nuevo_nombre LIMIT 1;
        IF nuevo_id IS NULL THEN
            SELECT MAX(id_carrera) + 1 INTO nuevo_id FROM Carrera;
            IF nuevo_id IS NULL THEN
                SET nuevo_id = 0;
            END IF;
            INSERT INTO Carrera (id_carrera, nombre) VALUES (nuevo_id, nuevo_nombre);
        ELSE
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El nombre de la carrera ya existe.';
        END IF;
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El nombre de la carrera debe contener solo letras.';
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
   IF NOT EsCorreoValido(nuevo_correo) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El correo no tiene un formato válido';
    END IF;
    SET nuevo_telefono = ValidarYReducirTelefono(nuevo_telefono);
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
	IF NOT EsEnteroPositivo(nuevo_creditos_necesarios) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error al asignar creditos necesarios';
    END IF;
    IF NOT EsEnteroPositivo(nuevo_creditos_otorgados) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error al asignar creditos otorgados';
    END IF;
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
CREATE PROCEDURE habilitarCurso(
    IN id_curso INT,
    IN nombre_ciclo VARCHAR(2),
    IN id_docente BIGINT,
    IN cupomaximo INT,
    IN nuevo_letra CHAR(1)
)
BEGIN
    DECLARE seccion_id INT;
    DECLARE ciclo_id INT;
    IF NOT ValidarValoresPermitidos(nombre_ciclo) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Nombre de ciclo no válido';
    END IF;
	IF NOT EsLetraAZ(nuevo_letra) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Se ha ingresado un carácter diferente a una letra';
    END IF;
    SET nuevo_letra = UPPER(nuevo_letra);
    IF NOT EsEnteroPositivo(cupomaximo) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cupo máximo no es un número entero positivo';
    END IF;
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
CREATE PROCEDURE agregarHorario(
    IN nuevo_id_cursohabilitado INT,
    IN nuevo_dia INT,
    IN nuevo_horario VARCHAR(20)
)
BEGIN
	DECLARE nuevo_id_horario INT;
	IF NOT VerificarDia(nuevo_dia) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No se seleccionó un día válido';
    END IF;
    IF EXISTS (SELECT 1 FROM CursoHabilitado WHERE id_cursohabilitado = nuevo_id_cursohabilitado) THEN
        IF NOT EXISTS (SELECT 1 FROM Horario WHERE dia = nuevo_dia AND horario = nuevo_horario) THEN
            INSERT INTO Horario (
            dia, 
            horario
            ) 
            VALUES (
            nuevo_dia, 
            nuevo_horario
            );
            SET nuevo_id_horario = LAST_INSERT_ID();
        ELSE
            SELECT id_horario INTO nuevo_id_horario FROM Horario WHERE dia = nuevo_dia AND horario = nuevo_horario;
        END IF;
        INSERT INTO HorarioEnCurso(
        id_cursohabilitado, 
        id_horario
        ) 
        VALUES(
        nuevo_id_cursohabilitado, 
        nuevo_id_horario
        );
    END IF;
END;
//
DELIMITER ;


DELIMITER //
CREATE PROCEDURE asignarCurso(
    IN nuevo_id_curso INT,
    IN nuevo_ciclo VARCHAR(2),
    IN nuevo_seccion CHAR(1),
    IN nuevo_id_estudiante BIGINT
)
BEGIN
    DECLARE import_creditos INT;
    DECLARE import_id_carrera_estudiante INT;
    DECLARE import_id_carrera_curso INT;
    DECLARE import_id_seccion INT;
    DECLARE import_cupomaximo INT;
    DECLARE import_asignacion INT;
    DECLARE import_cursohabilitado INT;
    DECLARE import_id_ciclo INT;
    IF NOT ValidarValoresPermitidos(nuevo_ciclo) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Nombre de ciclo no válido';
    END IF;
    SET nuevo_seccion = UPPER(nuevo_seccion);
	IF NOT EsLetraAZ(nuevo_seccion) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Se ha ingresado un caracter diferente a una letra';
    END IF;
    SELECT creditos, id_carrera INTO import_creditos, import_id_carrera_estudiante FROM Estudiante WHERE id_estudiante = nuevo_id_estudiante;
    SELECT id_carrera INTO import_id_carrera_curso FROM Curso WHERE id_curso = nuevo_id_curso;
    SELECT id_seccion INTO import_id_seccion FROM Seccion WHERE letra = nuevo_seccion;
    SELECT id_ciclo INTO import_id_ciclo FROM Ciclo WHERE nombre = nuevo_ciclo;
    SELECT cupomaximo, asignacion, id_cursohabilitado INTO import_cupomaximo, import_asignacion, import_cursohabilitado FROM CursoHabilitado WHERE id_curso = nuevo_id_curso AND id_seccion = import_id_seccion AND id_ciclo = import_id_ciclo;
    IF NOT EXISTS (SELECT 1 FROM Asignacion WHERE id_estudiante = nuevo_id_estudiante AND id_cursohabilitado = import_cursohabilitado) THEN
        IF import_id_carrera_curso = import_id_carrera_estudiante OR import_id_carrera_curso = 0 THEN
            IF (SELECT creditos_necesarios FROM Curso WHERE id_curso = nuevo_id_curso) <= import_creditos THEN
                IF EXISTS (SELECT 1 FROM CursoHabilitado WHERE id_curso = nuevo_id_curso AND id_seccion = import_id_seccion AND id_ciclo = import_id_ciclo) THEN
                    IF import_cupomaximo > import_asignacion THEN
                        INSERT INTO Asignacion (
                            asignado, 
                            id_estudiante,
                            id_cursohabilitado
                        ) 
                        VALUES (
                            1, 
                            nuevo_id_estudiante,
                            import_cursohabilitado
                        );
                        UPDATE CursoHabilitado SET asignacion = asignacion + 1 WHERE id_cursohabilitado = import_cursohabilitado;
                    ELSE
                        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Se ha alcanzado el cupo máximo';
                    END IF;
                ELSE
                    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No existe la sección seleccionada';
                END IF;
            ELSE
                SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No tienes los créditos suficientes';
            END IF;
        ELSE
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El curso no pertenece a tu carrera';
        END IF;
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Ya te has asignado previamente al curso';
    END IF;
END;
//
DELIMITER ;


DELIMITER //
CREATE PROCEDURE desasignarCurso(
    IN nuevo_id_curso INT,
    IN nuevo_ciclo VARCHAR(2),
    IN nuevo_seccion CHAR(1),
    IN nuevo_id_estudiante BIGINT
)
BEGIN
    DECLARE import_id_seccion INT;
    DECLARE import_asignacion INT;
    DECLARE import_cursohabilitado INT;
    DECLARE import_id_ciclo INT;
    IF NOT ValidarValoresPermitidos(nuevo_ciclo) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Nombre de ciclo no válido';
    END IF;
    SET nuevo_seccion = UPPER(nuevo_seccion);
	IF NOT EsLetraAZ(nuevo_seccion) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Se ha ingresado un caracter diferente a una letra';
    END IF;
    SELECT id_seccion INTO import_id_seccion FROM Seccion WHERE letra = nuevo_seccion;
    SELECT id_ciclo INTO import_id_ciclo FROM Ciclo WHERE nombre = nuevo_ciclo;
    SELECT id_cursohabilitado INTO import_cursohabilitado FROM CursoHabilitado WHERE id_curso = nuevo_id_curso AND id_seccion = import_id_seccion AND id_ciclo = import_id_ciclo;
    SELECT id_asignacion INTO import_asignacion FROM Asignacion WHERE id_estudiante = nuevo_id_estudiante AND id_cursohabilitado = import_cursohabilitado AND asignado=1;
    IF EXISTS (SELECT 1 FROM Asignacion WHERE id_estudiante = nuevo_id_estudiante AND id_cursohabilitado = import_cursohabilitado AND asignado=1) THEN
                        UPDATE Asignacion SET asignado = 0 WHERE id_asignacion = import_asignacion;
                        UPDATE CursoHabilitado SET asignacion = asignacion - 1 WHERE id_cursohabilitado = import_cursohabilitado;
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No existe la asignación seleccionada';
    END IF;
END;
//
DELIMITER ;


DELIMITER //
CREATE PROCEDURE ingresarNota(
    IN nuevo_id_curso INT,
    IN nuevo_ciclo VARCHAR(2),
    IN nuevo_seccion CHAR(1),
    IN nuevo_id_estudiante BIGINT,
    IN nuevo_nota INT
)
BEGIN
    DECLARE import_id_seccion INT;
    DECLARE import_asignacion INT;
    DECLARE import_cursohabilitado INT;
    DECLARE import_id_ciclo INT;
    DECLARE import_creditos INT;
    IF NOT ValidarValoresPermitidos(nuevo_ciclo) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Nombre de ciclo no válido';
    END IF;
    SET nuevo_seccion = UPPER(nuevo_seccion);
	IF NOT EsLetraAZ(nuevo_seccion) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Se ha ingresado un caracter diferente a una letra';
    END IF;
    IF NOT EsEnteroPositivo(nuevo_nota) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El numero que se ha ingresado es incorrecto';
    END IF;
    SET nuevo_nota = ROUND(nuevo_nota,0);
    SELECT creditos_otorgados INTO import_creditos FROM Curso WHERE id_curso = nuevo_id_curso;
    SELECT id_seccion INTO import_id_seccion FROM Seccion WHERE letra = nuevo_seccion;
    SELECT id_ciclo INTO import_id_ciclo FROM Ciclo WHERE nombre = nuevo_ciclo;
    SELECT id_cursohabilitado INTO import_cursohabilitado FROM CursoHabilitado WHERE id_curso = nuevo_id_curso AND id_seccion = import_id_seccion AND id_ciclo = import_id_ciclo;
    SELECT id_asignacion INTO import_asignacion FROM Asignacion WHERE id_estudiante = nuevo_id_estudiante AND id_cursohabilitado = import_cursohabilitado AND asignado=1;
    IF EXISTS (SELECT 1 FROM Asignacion WHERE id_estudiante = nuevo_id_estudiante AND id_cursohabilitado = import_cursohabilitado AND asignado=1) THEN
		IF NOT EXISTS (SELECT 1 FROM Nota WHERE id_asignacion = import_asignacion) THEN
			INSERT INTO Nota(
			nota,
			id_asignacion
			) 
			VALUES (
			nuevo_nota,
			import_asignacion
			);
			IF nuevo_nota >= 61 THEN
				UPDATE Estudiante SET creditos = import_creditos WHERE id_estudiante = nuevo_id_estudiante;
                UPDATE CursoHabilitado SET notas = notas + 1 WHERE id_cursohabilitado = import_cursohabilitado;
			END IF;
		ELSE
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Ya se ha ingresado la nota a este estudiante';
		END IF;
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El estudiante no tiene asignado el curso F';
    END IF;
END;
//
DELIMITER ;


DELIMITER //
CREATE PROCEDURE generarActa(
    IN nuevo_id_curso INT,
    IN nuevo_ciclo VARCHAR(2),
    IN nuevo_seccion CHAR(1)
)
BEGIN
    DECLARE import_id_seccion INT;
    DECLARE import_cursohabilitado INT;
    DECLARE import_id_ciclo INT;
    DECLARE import_notas INT;
    DECLARE import_asignado INT;
    IF NOT ValidarValoresPermitidos(nuevo_ciclo) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Nombre de ciclo no válido';
    END IF;
    SET nuevo_seccion = UPPER(nuevo_seccion);
	IF NOT EsLetraAZ(nuevo_seccion) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Se ha ingresado un caracter diferente a una letra';
    END IF;
    SELECT id_seccion INTO import_id_seccion FROM Seccion WHERE letra = nuevo_seccion;
    SELECT id_ciclo INTO import_id_ciclo FROM Ciclo WHERE nombre = nuevo_ciclo;
    SELECT id_cursohabilitado, notas, asignacion INTO import_cursohabilitado, import_notas, import_asignado FROM CursoHabilitado WHERE id_curso = nuevo_id_curso AND id_seccion = import_id_seccion AND id_ciclo = import_id_ciclo;
    IF import_notas = import_asignado THEN
			INSERT INTO Acta (
            id_cursohabilitado
            )
            VALUES (
            import_cursohabilitado
            );
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No se ha ingresado las notas de todos los estudiantes';
    END IF;
END;
//
DELIMITER ;


-- --------------------------------------------------------
-- PROCESAMIENTO DE DATOS
-- --------------------------------------------------------
DELIMITER //
CREATE PROCEDURE consultaPensum(IN codigo_carrera INT)
BEGIN
    IF NOT EsEnteroPositivo(codigo_carrera) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No se ha ingresado el código de la carrera correctamente';
    END IF;

    SELECT 
        id_curso AS IdCurso, 
        nombre AS Nombre, 
        CASE 
            WHEN obligatorio = 1 THEN 'Si' 
            WHEN obligatorio = 0 THEN 'No' 
        END AS Obligatorio, 
        creditos_necesarios AS CreditosNecesarios
    FROM Curso
    WHERE id_carrera = 0 OR id_carrera = codigo_carrera;
END;
//
DELIMITER ;



DELIMITER //
CREATE PROCEDURE consultaEstudiante(IN codigo_estudiante INT)
BEGIN
	IF NOT EsEnteroPositivo(codigo_estudiante) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No se ha ingresado el codigo de la persona correctamente';
    END IF;
    SELECT id_estudiante AS Carnet, concat(nombre," ", apellido) AS Nombre, fecha_nacimiento AS FechaNacimiento, correo AS Correo, telefono AS Telefono, direccion AS Direccion, dpi AS DPI, id_carrera AS IdCarrera, creditos AS Creditos
    FROM estudiante
    WHERE id_estudiante = codigo_estudiante;
END;
//
DELIMITER ;


DELIMITER //
CREATE PROCEDURE consultaDocente(IN codigo_docente INT)
BEGIN
	IF NOT EsEnteroPositivo(codigo_docente) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No se ha ingresado el codigo de la persona correctamente';
    END IF;
    SELECT id_docente AS SIIF, concat(nombre," ", apellido) AS Nombre, fecha_nacimiento AS FechaNacimiento, correo AS Correo, telefono AS Telefono, direccion AS Direccion, dpi AS DPI
    FROM docente
    WHERE id_docente = codigo_docente;
END;
//
DELIMITER ;


DELIMITER //
CREATE PROCEDURE consultarAsignados(
    IN codigo_curso INT,
    IN ciclo_nombre VARCHAR(2),
    IN ciclo_anio INT,
    IN seccion_letra CHAR(1)
)
BEGIN
	IF NOT ValidarValoresPermitidos(ciclo_nombre) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Nombre de ciclo no válido';
    END IF;
    SET seccion_letra = UPPER(seccion_letra);
	IF NOT EsLetraAZ(seccion_letra) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Se ha ingresado un caracter diferente a una letra';
    END IF;
    IF NOT EsEnteroPositivo(ciclo_anio) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No se ha ingresado el año correctamente';
    END IF;
    IF NOT EsEnteroPositivo(codigo_curso) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No se ha ingresado el codigo del curso correctamente';
    END IF;
    SELECT 
        e.id_estudiante AS Carnet,
        CONCAT(e.nombre, ' ', e.apellido) AS Nombre,
        e.creditos AS Creditos
    FROM Estudiante e
    INNER JOIN Asignacion a ON e.id_estudiante = a.id_estudiante
    INNER JOIN CursoHabilitado ch ON a.id_cursohabilitado = ch.id_cursohabilitado
    INNER JOIN Seccion s ON ch.id_seccion = s.id_seccion
    INNER JOIN Ciclo ci ON ch.id_ciclo = ci.id_ciclo
    INNER JOIN Curso c ON ch.id_curso = c.id_curso
    WHERE c.id_curso = codigo_curso
    AND ci.nombre = ciclo_nombre
    AND YEAR(ch.fecha) = ciclo_anio
    AND s.letra = seccion_letra
    AND a.asignado = 1;
END;
//
DELIMITER ;


-- --------------------------------------------------------
-- Triggers
-- --------------------------------------------------------
DELIMITER //
CREATE TRIGGER Carrera_Insert_Bitacora
AFTER INSERT ON Carrera FOR EACH ROW
BEGIN
    INSERT INTO Bitacora (fecha, descripcion, tipo)
    VALUES (NOW(), CONCAT('Se ha agregado un nuevo registro en la tabla Carrera'), 'INSERT');
END;
//
DELIMITER ;

DELIMITER //
CREATE TRIGGER Estudiante_Insert_Bitacora
AFTER INSERT ON Estudiante FOR EACH ROW
BEGIN
    INSERT INTO Bitacora (fecha, descripcion, tipo)
    VALUES (NOW(), CONCAT('Se ha agregado un nuevo registro en la tabla Estudiante'), 'INSERT');
END;
//
DELIMITER ;


DELIMITER //
CREATE TRIGGER Docente_Insert_Bitacora
AFTER INSERT ON Docente FOR EACH ROW
BEGIN
    INSERT INTO Bitacora (fecha, descripcion, tipo)
    VALUES (NOW(), CONCAT('Se ha agregado un nuevo registro en la tabla Docente'), 'INSERT');
END;
//
DELIMITER ;


DELIMITER //
CREATE TRIGGER Curso_Insert_Bitacora
AFTER INSERT ON Curso FOR EACH ROW
BEGIN
    INSERT INTO Bitacora (fecha, descripcion, tipo)
    VALUES (NOW(), CONCAT('Se ha agregado un nuevo registro en la tabla Curso'), 'INSERT');
END;
//
DELIMITER ;


DELIMITER //
CREATE TRIGGER Ciclo_Insert_Bitacora
AFTER INSERT ON Ciclo FOR EACH ROW
BEGIN
    INSERT INTO Bitacora (fecha, descripcion, tipo)
    VALUES (NOW(), CONCAT('Se ha agregado un nuevo registro en la tabla Ciclo'), 'INSERT');
END;
//
DELIMITER ;


DELIMITER //
CREATE TRIGGER Seccion_Insert_Bitacora
AFTER INSERT ON Seccion FOR EACH ROW
BEGIN
    INSERT INTO Bitacora (fecha, descripcion, tipo)
    VALUES (NOW(), CONCAT('Se ha agregado un nuevo registro en la tabla Seccion'), 'INSERT');
END;
//
DELIMITER ;


DELIMITER //
CREATE TRIGGER CursoHabilitado_Insert_Bitacora
AFTER INSERT ON CursoHabilitado FOR EACH ROW
BEGIN
    INSERT INTO Bitacora (fecha, descripcion, tipo)
    VALUES (NOW(), CONCAT('Se ha agregado un nuevo registro en la tabla CursoHabilitado'), 'INSERT');
END;
//
DELIMITER ;


DELIMITER //
CREATE TRIGGER Horario_Insert_Bitacora
AFTER INSERT ON Horario FOR EACH ROW
BEGIN
    INSERT INTO Bitacora (fecha, descripcion, tipo)
    VALUES (NOW(), CONCAT('Se ha agregado un nuevo registro en la tabla Horario'), 'INSERT');
END;
//
DELIMITER ;


DELIMITER //
CREATE TRIGGER HorarioEnCurso_Insert_Bitacora
AFTER INSERT ON HorarioEnCurso FOR EACH ROW
BEGIN
    INSERT INTO Bitacora (fecha, descripcion, tipo)
    VALUES (NOW(), CONCAT('Se ha agregado un nuevo registro en la tabla HorarioEnCurso'), 'INSERT');
END;
//
DELIMITER ;


DELIMITER //
CREATE TRIGGER Asignacion_Insert_Bitacora
AFTER INSERT ON Asignacion FOR EACH ROW
BEGIN
    INSERT INTO Bitacora (fecha, descripcion, tipo)
    VALUES (NOW(), CONCAT('Se ha agregado un nuevo registro en la tabla Asignacion'), 'INSERT');
END;
//
DELIMITER ;


DELIMITER //
CREATE TRIGGER Nota_Insert_Bitacora
AFTER INSERT ON Nota FOR EACH ROW
BEGIN
    INSERT INTO Bitacora (fecha, descripcion, tipo)
    VALUES (NOW(), CONCAT('Se ha agregado un nuevo registro en la tabla Nota'), 'INSERT');
END;
//
DELIMITER ;


DELIMITER //
CREATE TRIGGER Acta_Insert_Bitacora
AFTER INSERT ON Acta FOR EACH ROW
BEGIN
    INSERT INTO Bitacora (fecha, descripcion, tipo)
    VALUES (NOW(), CONCAT('Se ha agregado un nuevo registro en la tabla Acta'), 'INSERT');
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
CALL crearCarrera('Mecanica');
CALL crearCurso(101, 'Matemática Básica 3', 0, 7, 0,1);
CALL crearCurso(102, 'Matemática Básica 2', 0, 7, 0,1);
CALL registrarEstudiante(202300002,'María','Gómez','1998-08-22','maria@example.com',25067895,'456 Calle Secundaria',9876543210987,2);
CALL registrarEstudiante(202300001,'Jose','Carrillo','2002-10-16','jose@gmail.com',45897463,'Ruta a Escuintla km 12',2997536980101,1);
CALL registrarDocente(200200001,'Javier','Guzmán','1990-01-31','edu@gmail.com',78693541,'Antigua Guatemala',2997859611101);
CALL habilitarCurso(101, '1S', 200200001, 25, 'A');
CALL habilitarCurso(102, '1S', 200200001, 25, 'B');
CALL crearCarrera('Electrica');
CALL agregarHorario(1, 2, '9:00-10:40');
CALL agregarHorario(2, 1, '9:00-10:40');
CALL agregarHorario(2, 2, '9:00-10:40');
CALL asignarCurso(102, '1S','B',202300002);
CALL asignarCurso(102, '1S','B',202300001);
CALL asignarCurso(101, '1S','a',202300001);
CALL desasignarCurso(101, '1S','a',202300001);
CALL ingresarNota(102, '1S','B',202300002, 65);
CALL ingresarNota(102, '1S','B',202300001, 65);
CALL generarActa(102, '1S','B');
CALL consultaPensum(4);
CALL consultaEstudiante(202300001);
CALL consultaDocente(200200001);
CALL consultarAsignados(102, '1S', 2023, 'B');

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
DROP TABLE Bitacora;
SET FOREIGN_KEY_CHECKS = 1;
DROP PROCEDURE crearCarrera;
DROP PROCEDURE crearCurso;
DROP PROCEDURE registrarEstudiante;
DROP PROCEDURE registrarDocente;
DROP PROCEDURE habilitarCurso;
DROP PROCEDURE agregarHorario;
DROP PROCEDURE asignarCurso;
DROP PROCEDURE desasignarCurso;
DROP PROCEDURE ingresarNota;
DROP PROCEDURE generarActa;
DROP PROCEDURE consultarAsignados;
DROP PROCEDURE consultaPensum;
DROP PROCEDURE consultaDocente;
DROP PROCEDURE consultaEstudiante;
DROP FUNCTION EsCorreoValido;
DROP FUNCTION EsLetraAZ;
DROP FUNCTION EsSoloLetras;
DROP FUNCTION EsEnteroPositivo;
DROP FUNCTION ValidarValoresPermitidos;
DROP FUNCTION ValidarYReducirTelefono;
DROP FUNCTION VerificarDia;
*/


