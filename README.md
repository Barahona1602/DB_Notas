# DB_Notas
Esta es una base de Datos en la cual podemos hacer manejo de la información de la Facultad de Ingeniería, teniendo el registro de los estudiantes, cursos, docentes, notas y actas.
Tenemos funciones, procedimientos almacenados y triggers
## Ejemplo
Este es un ejemplo de los datos que se pueden ingresar a la DB:
```sh
CALL crearCarrera('Civil');
CALL crearCarrera('Industrial');
CALL crearCarrera('Sistemas');
CALL crearCarrera('Mecanica');

CALL registrarDocente(200200001,'Javier','Guzmán','1990-01-31','edu@gmail.com',78693541,'123 Main St, Ciudad 0101',2997859610101);
CALL registrarDocente(200200002,'María','López','1985-07-15','maria@gmail.com',71234567,'456 Elm St, Villa 0101',2997859610102);
CALL registrarDocente(200200003,'Carlos','Pérez','1980-03-22','carlos@gmail.com',65432109,'789 Oak St, Pueblo 0101',2997859610103);
CALL registrarDocente(200200004,'Luisa','Ramírez','1988-11-10','luisa@gmail.com',89012345,'101 Pine St, Colonia 0101',2997859610104);
CALL registrarDocente(200200005,'Ana','Martínez','1995-05-05','ana@gmail.com',62345678,'222 Cedar St, Aldea 0101',2997859610105);

CALL registrarEstudiante(202300001,'Diego','Torres','2003-04-28','diego@example.com',65432109,'678 Avenida Secundaria',1234567890101,1);
CALL registrarEstudiante(202300002,'Elena','Vargas','2001-10-03','elena@gmail.com',89674321,'234 Ruta Secundaria',9876543210102,2);
CALL registrarEstudiante(202300003,'Pedro','López','2001-05-12','pedro@example.com',12345678,'789 Avenida Principal',1234567890123,1);
CALL registrarEstudiante(202300004,'Laura','Ramírez','1999-12-08','laura@gmail.com',98765432,'101 Calle Principal',9876543210987,2);
CALL registrarEstudiante(202300005,'Carlos','Martínez','2003-03-25','carlos@example.com',56473829,'234 Carretera Principal',9876543210101,3);
CALL registrarEstudiante(202300006,'Ana','González','2000-09-17','ana@gmail.com',45678901,'567 Camino Principal',2997536980101,4);
CALL registrarEstudiante(202300007,'Luis','Hernández','2004-07-31','luis@example.com',78901234,'123 Calle Secundaria',1234567890987,3);
CALL registrarEstudiante(202300008,'María','Pérez','1997-02-14','maria@gmail.com',23568974,'890 Ruta Principal',2997536980102,2);
CALL registrarEstudiante(202300009,'Juan','Rodríguez','2002-11-19','juan@example.com',78965432,'567 Ruta Secundaria',9876543210103,4);
CALL registrarEstudiante(202300010,'Sofía','Díaz','1998-06-05','sofia@gmail.com',45678912,'456 Camino Secundario',2997536980104,3);

CALL crearCurso(101, 'Mate Basica 1', 0, 6, 0, 1);
CALL crearCurso(102, 'Etica', 0, 3, 0, 1);
CALL crearCurso(103, 'Idioma Técnico', 0, 4, 0, 1);
CALL crearCurso(104, 'Física General', 0, 5, 0, 1);
CALL crearCurso(105, 'Química Aplicada', 0, 4, 0, 1);
CALL crearCurso(201, 'Mecánica de Materiales', 0, 6, 1, 1);
CALL crearCurso(202, 'Diseño Estructural', 0, 9, 1, 1);
CALL crearCurso(203, 'Hidráulica', 10, 7, 1, 1);
CALL crearCurso(204, 'Geotecnia', 8, 6, 1, 1);
CALL crearCurso(205, 'Topografía', 6, 5, 1, 1);
CALL crearCurso(301, 'Procesos de Manufactura', 0, 8, 2, 1);
CALL crearCurso(302, 'Gestión de la Calidad', 0, 7, 2, 1);
CALL crearCurso(303, 'Automatización Industrial', 10, 9, 2, 1);
CALL crearCurso(304, 'Logística y Cadena de Suministro', 8, 7, 2, 1);
CALL crearCurso(305, 'Diseño de Productos', 12, 10, 2, 1);
CALL crearCurso(401, 'Programación Avanzada', 0, 7, 3, 1);
CALL crearCurso(402, 'Bases de Datos', 0, 7, 3, 1);
CALL crearCurso(403, 'Redes de Computadoras', 10, 8, 3, 1);
CALL crearCurso(404, 'Inteligencia Artificial', 10, 9, 3, 1);
CALL crearCurso(405, 'Seguridad Informática', 8, 7, 3, 1);
CALL crearCurso(501, 'Termodinámica', 0, 7, 4, 1);
CALL crearCurso(502, 'Dinámica de Máquinas', 0, 9, 4, 1);
CALL crearCurso(503, 'Diseño de Elementos Mecánicos', 10, 8, 4, 1);
CALL crearCurso(504, 'Mecánica de Fluidos', 8, 7, 4, 1);
CALL crearCurso(505, 'Proyectos de Ingeniería Mecánica', 12, 10, 4, 1);

-- ---------------------------------------------------------------------------

-- Habilitación de Cursos de Área Común
CALL habilitarCurso(101, '1S', 200200001, 75, 'A');
CALL habilitarCurso(102, '1S', 200200002, 50, 'B');
CALL habilitarCurso(101, '2S', 200200002, 50, 'C');
CALL habilitarCurso(103, '1S', 200200003, 40, 'D');
CALL habilitarCurso(104, '2S', 200200004, 90, 'E');

-- Habilitación de Cursos de Carrera Civil
CALL habilitarCurso(201, '1S', 200200001, 70, 'A');
CALL habilitarCurso(201, 'VJ', 200200001, 70, 'B');
CALL habilitarCurso(202, '1S', 200200002, 35, 'C');
CALL habilitarCurso(202, '2S', 200200002, 35, 'D');
CALL habilitarCurso(203, '1S', 200200003, 80, 'E');
CALL habilitarCurso(203, '2S', 200200003, 80, 'F');
CALL habilitarCurso(204, '1S', 200200004, 45, 'A');
CALL habilitarCurso(204, 'VD', 200200004, 45, 'B');
CALL habilitarCurso(205, '1S', 200200005, 55, 'C');
CALL habilitarCurso(205, 'VD', 200200005, 55, 'D');

-- Habilitación de Cursos de Carrera Industrial
CALL habilitarCurso(301, '1S', 200200001, 95, 'E');
CALL habilitarCurso(301, '2S', 200200001, 95, 'F');
CALL habilitarCurso(302, '1S', 200200002, 30, 'A');
CALL habilitarCurso(302, 'VJ', 200200002, 30, 'B');
CALL habilitarCurso(303, 'VJ', 200200003, 110, 'C');
CALL habilitarCurso(303, '2S', 200200003, 110, 'D');
CALL habilitarCurso(304, '1S', 200200004, 75, 'E');
CALL habilitarCurso(304, '2S', 200200004, 75, 'F');
CALL habilitarCurso(305, '1S', 200200005, 65, 'A');
CALL habilitarCurso(305, 'VD', 200200005, 65, 'B');

-- Habilitación de Cursos de Carrera de Sistemas
CALL habilitarCurso(401, '1S', 200200001, 85, 'C');
CALL habilitarCurso(401, '2S', 200200001, 85, 'D');
CALL habilitarCurso(402, '1S', 200200002, 100, 'E');
CALL habilitarCurso(402, 'VJ', 200200002, 100, 'F');
CALL habilitarCurso(403, '1S', 200200003, 70, 'G');
CALL habilitarCurso(403, '2S', 200200003, 70, 'H');
CALL habilitarCurso(404, '1S', 200200004, 45, 'I');
CALL habilitarCurso(404, '2S', 200200004, 45, 'J');
CALL habilitarCurso(405, '1S', 200200005, 60, 'K');
CALL habilitarCurso(405, 'VD', 200200005, 60, 'L');

-- Habilitación de Cursos de Carrera Mecánica
CALL habilitarCurso(501, '1S', 200200001, 85, 'L');
CALL habilitarCurso(501, '2S', 200200001, 85, 'M');
CALL habilitarCurso(502, '1S', 200200002, 100, 'N');
CALL habilitarCurso(502, '2S', 200200002, 100, 'O');
CALL habilitarCurso(503, '1S', 200200003, 70, 'P');
CALL habilitarCurso(503, 'VJ', 200200003, 70, 'A');
CALL habilitarCurso(504, '1S', 200200004, 45, 'B');
CALL habilitarCurso(504, '2S', 200200004, 45, 'C');
CALL habilitarCurso(505, '2S', 200200005, 60, 'M');
CALL habilitarCurso(505, 'VD', 200200005, 60, 'N');

CALL agregarHorario(1, 2, '6:50-7:40');
CALL agregarHorario(2, 5, '7:50-8:40');
CALL agregarHorario(3, 3, '8:50-9:40');
CALL agregarHorario(4, 7, '9:50-10:40');
CALL agregarHorario(5, 1, '10:50-11:40');
CALL agregarHorario(6, 4, '11:50-12:40');
CALL agregarHorario(7, 6, '12:50-13:40');
CALL agregarHorario(8, 2, '13:50-14:40');
CALL agregarHorario(9, 5, '14:50-15:40');
CALL agregarHorario(10, 3, '15:50-16:40');
CALL agregarHorario(11, 1, '16:50-17:40');
CALL agregarHorario(12, 4, '17:50-18:40');
CALL agregarHorario(13, 2, '18:50-19:40');
CALL agregarHorario(14, 6, '19:50-20:40');
CALL agregarHorario(15, 1, '6:50-7:40');
CALL agregarHorario(16, 4, '7:50-8:40');
CALL agregarHorario(17, 6, '8:50-9:40');
CALL agregarHorario(18, 2, '9:50-10:40');
CALL agregarHorario(19, 5, '10:50-11:40');
CALL agregarHorario(20, 3, '11:50-12:40');
CALL agregarHorario(21, 2, '12:50-13:40');
CALL agregarHorario(22, 5, '13:50-14:40');
CALL agregarHorario(23, 3, '14:50-15:40');
CALL agregarHorario(24, 7, '15:50-16:40');
CALL agregarHorario(25, 1, '16:50-17:40');
CALL agregarHorario(26, 4, '17:50-18:40');
CALL agregarHorario(27, 6, '18:50-19:40');
CALL agregarHorario(28, 2, '19:50-20:40');
CALL agregarHorario(29, 5, '6:50-7:40');
CALL agregarHorario(30, 3, '7:50-8:40');
CALL agregarHorario(31, 1, '8:50-9:40');
CALL agregarHorario(32, 4, '9:50-10:40');
CALL agregarHorario(33, 2, '10:50-11:40');
CALL agregarHorario(34, 6, '11:50-12:40');
CALL agregarHorario(35, 1, '12:50-13:40');
CALL agregarHorario(36, 4, '13:50-14:40');
CALL agregarHorario(37, 6, '14:50-15:40');
CALL agregarHorario(38, 2, '15:50-16:40');
CALL agregarHorario(39, 5, '16:50-17:40');
CALL agregarHorario(40, 3, '17:50-18:40');
CALL agregarHorario(41, 2, '18:50-19:40');
CALL agregarHorario(42, 5, '19:50-20:40');
CALL agregarHorario(43, 3, '17:50-18:40');
CALL agregarHorario(44, 2, '18:50-19:40');
CALL agregarHorario(45, 5, '19:50-20:40');
CALL agregarHorario(1, 4, '6:50-7:40');
CALL agregarHorario(2, 7, '7:50-8:40');
CALL agregarHorario(3, 4, '8:50-9:40');
CALL agregarHorario(4, 1, '9:50-10:40');
CALL agregarHorario(5, 6, '10:50-11:40');
CALL agregarHorario(6, 5, '11:50-12:40');
CALL agregarHorario(7, 3, '12:50-13:40');
CALL agregarHorario(8, 2, '13:50-14:40');
CALL agregarHorario(9, 1, '14:50-15:40');
CALL agregarHorario(10, 5, '15:50-16:40');

-- Estudiante 202300001 (Diego) - Carrera: Civil (código 1)
CALL asignarCurso(101, '1S', 'A', 202300001);
CALL asignarCurso(102, '1S', 'B', 202300001);
CALL asignarCurso(201, '1S', 'A', 202300001);
CALL asignarCurso(202, '1S', 'C', 202300001);

-- Estudiante 202300002 (Elena) - Carrera: Industrial (código 2)
CALL asignarCurso(101, '1S', 'A', 202300002);
CALL asignarCurso(102, '1S', 'B', 202300002);
CALL asignarCurso(301, '1S', 'E', 202300002);
CALL asignarCurso(302, '1S', 'A', 202300002);

-- Estudiante 202300003 (Pedro) - Carrera: Civil (código 1)
CALL asignarCurso(101, '1S', 'A', 202300003);
CALL asignarCurso(102, '1S', 'B', 202300003);
CALL asignarCurso(201, '1S', 'A', 202300003);
CALL asignarCurso(202, '1S', 'C', 202300003);

-- Estudiante 202300004 (Laura) - Carrera: Industrial (código 2)
CALL asignarCurso(101, '1S', 'A', 202300004);
CALL asignarCurso(102, '1S', 'B', 202300004);
CALL asignarCurso(301, '1S', 'E', 202300004);
CALL asignarCurso(302, '1S', 'A', 202300004);

-- Estudiante 202300005 (Carlos) - Carrera: Sistemas (código 3)
CALL asignarCurso(101, '1S', 'A', 202300005);
CALL asignarCurso(102, '1S', 'B', 202300005);
CALL asignarCurso(401, '1S', 'C', 202300005);
CALL asignarCurso(402, '1S', 'E', 202300005);

-- Estudiante 202300006 (Ana) - Carrera: Mecánica (código 4)
CALL asignarCurso(101, '1S', 'A', 202300006);
CALL asignarCurso(102, '1S', 'B', 202300006);
CALL asignarCurso(501, '1S', 'L', 202300006);
CALL asignarCurso(502, '1S', 'N', 202300006);

-- Estudiante 202300007 (Luis) - Carrera: Sistemas (código 3)
CALL asignarCurso(101, '1S', 'A', 202300007);
CALL asignarCurso(102, '1S', 'B', 202300007);
CALL asignarCurso(401, '1S', 'C', 202300007);
CALL asignarCurso(402, '1S', 'E', 202300007);

-- Estudiante 202300008 (María) - Carrera: Industrial (código 2)
CALL asignarCurso(101, '1S', 'A', 202300008);
CALL asignarCurso(102, '1S', 'B', 202300008);
CALL asignarCurso(301, '1S', 'E', 202300008);
CALL asignarCurso(302, '1S', 'A', 202300008);

-- Estudiante 202300009 (Juan) - Carrera: Mecánica (código 4)
CALL asignarCurso(101, '1S', 'A', 202300009);
CALL asignarCurso(102, '1S', 'B', 202300009);
CALL asignarCurso(501, '1S', 'L', 202300009);
CALL asignarCurso(502, '1S', 'N', 202300009);

-- Estudiante 202300010 (Sofía) - Carrera: Sistemas (código 3)
CALL asignarCurso(101, '1S', 'A', 202300010);
CALL asignarCurso(102, '1S', 'B', 202300010);
CALL asignarCurso(401, '1S', 'C', 202300010);
CALL asignarCurso(402, '1S', 'E', 202300010);

CALL desasignarCurso(101, '1S', 'A', 202300001); -- Estudiante 202300001
CALL desasignarCurso(101, '1S', 'A', 202300002); -- Estudiante 202300002
CALL desasignarCurso(101, '1S', 'A', 202300003); -- Estudiante 202300003
CALL desasignarCurso(101, '1S', 'A', 202300004); -- Estudiante 202300004
CALL desasignarCurso(101, '1S', 'A', 202300005); -- Estudiante 202300005

-- Estudiante 202300001 (Diego) - Carrera: Civil (código 1)
CALL ingresarNota(102, '1S', 'B', 202300001, 78);
CALL ingresarNota(201, '1S', 'A', 202300001, 92);
CALL ingresarNota(202, '1S', 'C', 202300001, 85);

-- Estudiante 202300002 (Elena) - Carrera: Industrial (código 2)
CALL ingresarNota(102, '1S', 'B', 202300002, 88);
CALL ingresarNota(301, '1S', 'E', 202300002, 76);
CALL ingresarNota(302, '1S', 'A', 202300002, 95);

-- Estudiante 202300003 (Pedro) - Carrera: Civil (código 1)
CALL ingresarNota(102, '1S', 'B', 202300003, 88);
CALL ingresarNota(201, '1S', 'A', 202300003, 75);
CALL ingresarNota(202, '1S', 'C', 202300003, 91);

-- Estudiante 202300004 (Laura) - Carrera: Industrial (código 2)
CALL ingresarNota(102, '1S', 'B', 202300004, 95);
CALL ingresarNota(301, '1S', 'E', 202300004, 77);
CALL ingresarNota(302, '1S', 'A', 202300004, 89);

-- Estudiante 202300005 (Carlos) - Carrera: Sistemas (código 3)
CALL ingresarNota(102, '1S', 'B', 202300005, 78);
CALL ingresarNota(401, '1S', 'C', 202300005, 88);
CALL ingresarNota(402, '1S', 'E', 202300005, 95);

-- Estudiante 202300006 (Ana) - Carrera: Mecánica (código 4)
CALL ingresarNota(101, '1S', 'A', 202300006, 61);
CALL ingresarNota(102, '1S', 'B', 202300006, 60);
CALL ingresarNota(501, '1S', 'L', 202300006, 92);
CALL ingresarNota(502, '1S', 'N', 202300006, 79);

-- Estudiante 202300007 (Luis) - Carrera: Sistemas (código 3)
CALL ingresarNota(101, '1S', 'A', 202300007, 85);
CALL ingresarNota(102, '1S', 'B', 202300007, 90);
CALL ingresarNota(401, '1S', 'C', 202300007, 35);
CALL ingresarNota(402, '1S', 'E', 202300007, 75);

-- Estudiante 202300008 (María) - Carrera: Industrial (código 2)
CALL ingresarNota(101, '1S', 'A', 202300008, 81);
CALL ingresarNota(102, '1S', 'B', 202300008, 78);
CALL ingresarNota(301, '1S', 'E', 202300008, 38);
CALL ingresarNota(302, '1S', 'A', 202300008, 90);

-- Estudiante 202300009 (Juan) - Carrera: Mecánica (código 4)
CALL ingresarNota(101, '1S', 'A', 202300009, 76);
CALL ingresarNota(102, '1S', 'B', 202300009, 85);
CALL ingresarNota(501, '1S', 'L', 202300009, 44);
CALL ingresarNota(502, '1S', 'N', 202300009, 73);

-- Estudiante 202300010 (Sofía) - Carrera: Sistemas (código 3)
CALL ingresarNota(101, '1S', 'A', 202300010, 80);
CALL ingresarNota(102, '1S', 'B', 202300010, 82);
CALL ingresarNota(401, '1S', 'C', 202300010, 60);
CALL ingresarNota(402, '1S', 'E', 202300010, 91);


CALL generarActa(101, '1S', 'A');
CALL generarActa(102, '1S', 'B');
CALL generarActa(201, '1S', 'A');
CALL generarActa(202, '1S', 'C');
CALL generarActa(301, '1S', 'E');
CALL generarActa(302, '1S', 'A');
CALL generarActa(401, '1S', 'C');
CALL generarActa(402, '1S', 'E');
CALL generarActa(501, '1S', 'L');
CALL generarActa(502, '1S', 'N');

-- -------------------------------------------------------

CALL asignarCurso(101, '2S', 'C', 202300001); 
CALL asignarCurso(101, '2S', 'C', 202300002); 
CALL asignarCurso(101, '2S', 'C', 202300003); 
CALL asignarCurso(101, '2S', 'C', 202300004); 
CALL asignarCurso(101, '2S', 'C', 202300005); 
CALL ingresarNota(101, '2S', 'C', 202300001, 61); 
CALL ingresarNota(101, '2S', 'C', 202300002, 75); 
CALL ingresarNota(101, '2S', 'C', 202300003, 58); 
CALL ingresarNota(101, '2S', 'C', 202300004, 68); 
CALL ingresarNota(101, '2S', 'C', 202300005, 92); 
CALL generarActa(101, '2S', 'c');
CALL asignarCurso(503, '1S', 'P', 202300006);

-- -------------------------------------------------------
CALL consultarPensum(3);
CALL consultarEstudiante(202300006);
CALL consultarDocente(200200001);
CALL consultarAsignados(102, '1S', 2023, 'B');
CALL consultarAprobacion(102, '1S', 2023, 'B');
CALL consultarActas(101);
CALL consultarDesasignacion(101, '1S', 2023, 'A');
```
