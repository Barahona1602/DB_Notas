use notasdb;
CALL crearCarrera('Ingenieria Civil');       -- 1  VALIDAR QUE LES QUEDE ESTE ID EN LA CARRERA CORRESPONDIENTE
CALL crearCarrera('Ingenieria Industrial');  -- 2  VALIDAR QUE LES QUEDE ESTE ID EN LA CARRERA CORRESPONDIENTE
CALL crearCarrera('Ingenieria Sistemas');    -- 3  VALIDAR QUE LES QUEDE ESTE ID EN LA CARRERA CORRESPONDIENTE
CALL crearCarrera('Ingenieria Electronica'); -- 4  VALIDAR QUE LES QUEDE ESTE ID EN LA CARRERA CORRESPONDIENTE
CALL crearCarrera('Ingenieria Mecanica');    -- 5  VALIDAR QUE LES QUEDE ESTE ID EN LA CARRERA CORRESPONDIENTE
CALL crearCarrera('Ingenieria Mecatronica'); -- 6  VALIDAR QUE LES QUEDE ESTE ID EN LA CARRERA CORRESPONDIENTE
CALL crearCarrera('Ingenieria Quimica');     -- 7  VALIDAR QUE LES QUEDE ESTE ID EN LA CARRERA CORRESPONDIENTE
CALL crearCarrera('Ingenieria Ambiental');   -- 8  VALIDAR QUE LES QUEDE ESTE ID EN LA CARRERA CORRESPONDIENTE
CALL crearCarrera('Ingenieria Materiales');  -- 9  VALIDAR QUE LES QUEDE ESTE ID EN LA CARRERA CORRESPONDIENTE
CALL crearCarrera('Ingenieria Textil');      -- 10 VALIDAR QUE LES QUEDE ESTE ID EN LA CARRERA CORRESPONDIENTE

-- REGISTRO DE DOCENTES
CALL registrarDocente('Docente1','Apellido1','30-10-1999','aadf@ingenieria.usac.edu.gt',12345678,'direccion',12345678910,1);
CALL registrarDocente('Docente2','Apellido2','20-11-1999','docente2@ingenieria.usac.edu.gt',12345678,'direcciondocente2',12345678911,2);
CALL registrarDocente('Docente3','Apellido3','20-12-1980','docente3@ingenieria.usac.edu.gt',12345678,'direcciondocente3',12345678912,3);
CALL registrarDocente('Docente4','Apellido4','20-11-1981','docente4@ingenieria.usac.edu.gt',12345678,'direcciondocente4',12345678913,4);
CALL registrarDocente('Docente5','Apellido5','20-09-1982','docente5@ingenieria.usac.edu.gt',12345678,'direcciondocente5',12345678914,5);

-- REGISTRO DE ESTUDIANTES
-- SISTEMAS
CALL registrarEstudiante(202000001,'Estudiante de','Sistemas Uno','30-10-1999','sistemasuno@gmail.com',12345678,'direccion estudiantes sistemas 1',337859510101,3);
CALL registrarEstudiante(202000002,'Estudiante de','Sistemas Dos','3-5-2000','sistemasdos@gmail.com',12345678,'direccion estudiantes sistemas 2',32781580101,3);
CALL registrarEstudiante(202000003,'Estudiante de','Sistemas Tres','3-5-2002','sistemastres@gmail.com',12345678,'direccion estudiantes sistemas 3',32791580101,3);
-- CIVIL
CALL registrarEstudiante(202100001,'Estudiante de','Civil Uno','3-5-1990','civiluno@gmail.com',12345678,'direccion de estudiante civil 1',3182781580101,1);
CALL registrarEstudiante(202100002,'Estudiante de','Civil Dos','03-08-1998','civildos@gmail.com',12345678,'direccion de estudiante civil 2',3181781580101,1);
-- INDUSTRIAL
CALL registrarEstudiante(202200001,'Estudiante de','Industrial Uno','30-10-1999','industrialuno@gmail.com',12345678,'direccion de estudiante industrial 1',3878168901,2);
CALL registrarEstudiante(202200002,'Estudiante de','Industrial Dos','20-10-1994','industrialdos@gmail.com',89765432,'direccion de estudiante industrial 2',29781580101,2);
-- ELECTRONICA
CALL registrarEstudiante(202300001, 'Estudiante de','Electronica Uno','20-10-2005','electronicauno@gmail.com',89765432,'direccion de estudiante electronica 1',29761580101,4);
CALL registrarEstudiante(202300002, 'Estudiante de','Electronica Dos', '01-01-2008','electronicados@gmail.com',12345678,'direccion de estudiante electronica 2',387916890101,4);
-- ESTUDIANTES RANDOM
CALL registrarEstudiante(201710160, 'ESTUDIANTE','SISTEMAS RANDOM','20-08-1994','estudiasist@gmail.com',89765432,'direccionestudisist random',29791580101,3);
CALL registrarEstudiante(201710161, 'ESTUDIANTE','CIVIL RANDOM','20-08-1995','estudiacivl@gmail.com',89765432,'direccionestudicivl random',30791580101,1);


-- AREA COMUN
CALL crearCurso(0006,'Idioma Tecnico 1',0,7,0,false); 
CALL crearCurso(0007,'Idioma Tecnico 2',0,7,0,false);
CALL crearCurso(101,'MB 1',0,7,0,true); 
CALL crearCurso(103,'MB 2',0,7,0,true); 
CALL crearCurso(017,'SOCIAL HUMANISTICA 1',0,4,0,true); 
CALL crearCurso(019,'SOCIAL HUMANISTICA 2',0,4,0,true); 
CALL crearCurso(348,'QUIMICA GENERAL',0,3,0,true); 
CALL crearCurso(349,'QUIMICA GENERAL LABORATORIO',0,1,0,true);
-- INGENIERIA EN SISTEMAS
CALL crearCurso(777,'Compiladores 1',80,4,3,true); 
CALL crearCurso(770,'INTR. A la Programacion y computacion 1',0,4,3,true); 
CALL crearCurso(960,'MATE COMPUTO 1',33,5,3,true); 
CALL crearCurso(795,'lOGICA DE SISTEMAS',33,2,3,true);
CALL crearCurso(796,'LENGUAJES FORMALES Y DE PROGRAMACIÓN',0,3,3,TRUE);
-- INGENIERIA INDUSTRIAL
CALL crearCurso(123,'Curso Industrial 1',0,4,2,true); 
CALL crearCurso(124,'Curso Industrial 2',0,4,2,true);
CALL crearCurso(125,'Curso Industrial enseñar a pensar',10,2,2,false);
CALL crearCurso(126,'Curso Industrial ENSEÑAR A DIBUJAR',2,4,2,true);
CALL crearCurso(127,'Curso Industrial 3',8,4,2,true);
-- INGENIERIA CIVIL
CALL crearCurso(321,'Curso Civil 1',0,4,1,true);
CALL crearCurso(322,'Curso Civil 2',4,4,1,true);
CALL crearCurso(323,'Curso Civil 3',8,4,1,true);
CALL crearCurso(324,'Curso Civil 4',12,4,1,true);
CALL crearCurso(325,'Curso Civil 5',16,4,1,false);
CALL crearCurso(0250,'Mecanica de Fluidos',0,5,1,true);
-- INGENIERIA ELECTRONICA
CALL crearCurso(421,'Curso Electronica 1',0,4,4,true);
CALL crearCurso(422,'Curso Electronica 2',4,4,4,true);
CALL crearCurso(423,'Curso Electronica 3',8,4,4,false);
CALL crearCurso(424,'Curso Electronica 4',12,4,4,true);
CALL crearCurso(425,'Curso Electronica 5',16,4,4,true);

-- Comun
CALL habilitarCurso(0006,'1S',1,110,'A');
-- Sistemas
CALL habilitarCurso(
    770,
    '1S',
    2,
    110,
    'B'
);

CALL habilitarCurso(
    796,
    '1S',
    2,
    110,
    'A'
);


-- Civil
CALL habilitarCurso(
    321,
    '1S',
    3,
    60,
    'C'
);

-- Industrial
CALL habilitarCurso(
    123,
    '1S',
    4,
    110,
    'A'
);

-- Electronica
CALL habilitarCurso(
    421,
    '1S',
    4,
    110,
    'A'
);

/* Agregar horarios */

-- Comun
CALL agregarHorario(
    1,
    1,
    '9:00-10:40'
);


CALL agregarHorario(
    1,
    2,
    '9:50-11:30'
);
-- Sistemas
CALL agregarHorario(
    2,
    7,
    '19:00-20:40'
);


CALL agregarHorario(
    2,
    3,
    '19:00-20:40'
);

-- Civil

CALL agregarHorario(
    3,
    4,
    '7:00-8:40'
);

CALL agregarHorario(
    3,
    5,
    '7:50-9:30'
);
-- Industrial
CALL agregarHorario(
    4,
    6,
    '15:00-16:40'
);

CALL agregarHorario(
    4,
    7,
    '15:50-17:30'
);

-- Electronica
CALL agregarHorario(
    5,
    7,
    '15:50-17:30'
);

/* Asignaciones  */

-- Sistemas
CALL asignarCurso(
    770,
    '1S',
    'B',
    202000001
);

CALL asignarCurso(
    796,
    '1S',
    'A',
    202000001
);


-- Civil
CALL asignarCurso(
    321,
    '1S',
    'C',
    202100001
);

-- Industrial
CALL asignarCurso(
    123,
    '1S',
    'A',
    202200001
);

-- Electronica
CALL asignarCurso(
    421,
    '1S',
    'A',
    202300001
);

CALL asignarCurso(
    421,
    '1S',
    'A',
    202300002
);

/* Desasignaciones */

CALL desasignarCurso(
    421,
    '1S',
    'A',
    202300002
);

/* Ingreso de notas */

-- Sistemas
CALL ingresarNota(
    770,
    '1S',
    'B',
    202000001,
    100
);

CALL ingresarNota(
    796,
    '1S',
    'A',
    202000001,
    100
);

-- Civil
CALL ingresarNota(
    321,
    '1S',
    'C',
    202100001,
    50
);
-- Industrial
CALL ingresarNota(
    123,
    '1S',
    'A',
    202200001,
    97
);

-- Electronica
CALL ingresarNota(
    421,
    '1S',
    'A',
    202300001,
    62
);

/* Generar actas */

-- Sistemas
CALL generarActa(
    770,
    '1S',
    'B'
);

CALL generarActa(
    796,
    '1S',
    'A'
);

-- Civil
CALL generarActa(
    321,
    '1S',
    'C'
);

-- Industrial
CALL generarActa(
    123,
    '1S',
    'A'
);

-- Electronica
CALL generarActa(
    421,
    '1S',
    'A'
);


/* GETTERS 
CALL consultarPensum(1);
CALL consultarPensum(2);
CALL consultarPensum(3);
CALL consultarPensum(4);

CALL consultarEstudiante(202000001);
CALL consultarEstudiante(202000002);
CALL consultarEstudiante(202000003);
CALL consultarEstudiante(202100001);
CALL consultarEstudiante(202200001);
CALL consultarEstudiante(202200002);
CALL consultarEstudiante(202300001);
CALL consultarEstudiante(202300002);
CALL consultarEstudiante(201710160);
CALL consultarEstudiante(201710161);

CALL consultarDocente(1);
CALL consultarDocente(2);
CALL consultarDocente(3);
CALL consultarDocente(4);
CALL consultarDocente(5);

-- Sistemas
CALL consultarAsignados(
    770,
    '1S',
    2023,
    'B'
);

CALL consultarAsignados(
    796,
    '1S',
    2023,
    'A'
);

-- Civil
CALL consultarAsignados(
    321,
    '1S',
    2023,
    'C'
);

-- Industrial
CALL consultarAsignados(
    123,
    '1S',
    2023,
    'A'
);

-- Electronica
CALL consultarAsignados(
    421,
    '1S',
    2023,
    'A'
);

Consultar aprobaciones 

-- Sistemas
CALL consultarAprobacion(
    421,
    '1S',
    2023,
    'A'
);


CALL consultarActas(770);

CALL consultarDesasignacion(
    421,
    '1S',
    2023,
    'A'
);
*/