/*EQUIPOS*/

DROP TABLE EQUIPOS CASCADE CONSTRAINTS;

CREATE TABLE EQUIPOS(
    ID_EQUIPO NUMBER(2),
    NOMBRE VARCHAR2(25),
    FECHA_FUNDACION DATE,
    CONSTRAINT ID_EQUIPO_PK PRIMARY KEY (ID_EQUIPO)
);

/* JUGADORES */

DROP TABLE JUGADORES CASCADE CONSTRAINTS;

CREATE TABLE JUGADORES(
    ID_JUGADOR NUMBER(2),
    NOMBRE VARCHAR2(50),
    NACIONALIDAD VARCHAR2(50),
    FECHA_NACIMIENTO DATE,
    NICKNAME VARCHAR2(50),
    ROL VARCHAR2(50),
    SUELDO NUMBER(10),
    ID_EQUIPO NUMBER(2),
    CONSTRAINT ID_JUGADOR_PK PRIMARY KEY (ID_JUGADOR),
    CONSTRAINT ID_EQUIPO_J_FK FOREIGN KEY (ID_EQUIPO)
        REFERENCES EQUIPOS(ID_EQUIPO)
);

/*USUARIOS*/

DROP TABLE USUARIOS CASCADE CONSTRAINTS;

CREATE TABLE USUARIOS(
    ID_USUARIO NUMBER(2),
    NOMBRE VARCHAR2(50),
    CONTRASENA VARCHAR2(50),
    ROL VARCHAR2(50),
    CONSTRAINT ID_USUARIO_PK PRIMARY KEY (ID_USUARIO),
    CONSTRAINT CHK_ROL CHECK(ROL IN('ADMINISTRADOR', 'USUARIO'))
);

/*JUEGOS*/

DROP TABLE JUEGOS CASCADE CONSTRAINTS;

CREATE TABLE JUEGOS(
    ID_JUEGO NUMBER(2),
    NOMBRE VARCHAR2(50),
    EMPRESA VARCHAR2(50),
    FECHA_LANZAMIENTO DATE,
    CONSTRAINT ID_JUEGO_PK PRIMARY KEY (ID_JUEGO)
);

/*ENFRENTAMIENTOS*/

DROP TABLE ENFRENTAMIENTOS CASCADE CONSTRAINTS;

CREATE TABLE ENFRENTAMIENTOS(
    ID_ENFRENTAMIENTO NUMBER(2),
    HORA TIMESTAMP,
    ID_JORNADA NUMBER(2),
    ID_EQUIPO_LOCAL NUMBER(2),
    ID_EQUIPO_VISITANTE NUMBER(2),
    ID_GANADOR NUMBER(2),
    CONSTRAINT ID_ENFRENTAMIENTO_PK PRIMARY KEY (ID_ENFRENTAMIENTO),
    CONSTRAINT ID_EQUIPO_LOCAL_FK FOREIGN KEY (ID_EQUIPO_LOCAL)
        REFERENCES EQUIPOS(ID_EQUIPO),
    CONSTRAINT ID_EQUIPO_VISITANTE_FK FOREIGN KEY (ID_EQUIPO_VISITANTE)
        REFERENCES EQUIPOS(ID_EQUIPO),
    CONSTRAINT ID_GANADOR_FK FOREIGN KEY (ID_GANADOR)
        REFERENCES EQUIPOS(ID_EQUIPO)
);

/*JORNADAS*/

DROP TABLE JORNADAS CASCADE CONSTRAINTS;

CREATE TABLE JORNADAS(
    ID_JORNADA NUMBER(2),
    FECHA_JORNADA DATE,
    ID_COMPETICION NUMBER(2),
    CONSTRAINT ID_JORNADA_PK PRIMARY KEY (ID_JORNADA),
    CONSTRAINT ID_COMPETICION_JORNADA_FK FOREIGN KEY (ID_COMPETICION)
        REFERENCES COMPETICIONES(ID_COMPETICION)
);

/*COMPETICIONES*/

DROP TABLE COMPETICIONES CASCADE CONSTRAINTS;

CREATE TABLE COMPETICIONES(
    ID_COMPETICION NUMBER(2),
    NOMBRE VARCHAR2(50),
    FECHA_INICIO DATE,
    FECHA_FIN DATE,
    ESTADO NUMBER(1) CONSTRAINT estado_check CHECK (ESTADO IN (0, 1)),
    ID_JUEGO NUMBER(2),
    CONSTRAINT ID_COMPETICION_PK PRIMARY KEY (ID_COMPETICION),
    CONSTRAINT ID_JUEGO_COM_FK FOREIGN KEY (ID_JUEGO)
        REFERENCES JUEGOS(ID_JUEGO)
);

/* RELACION ENTRE EQUIPOS Y COMPETICIONES */

DROP TABLE PARTICIPACIONES CASCADE CONSTRAINTS;

CREATE TABLE PARTICIPACIONES(
    ID_EQUIPO NUMBER(2),
    ID_COMPETICION NUMBER(2),
    PUNTUACION VARCHAR2(10),
    CONSTRAINT ID_EQUIPO_PART_PK PRIMARY KEY (ID_EQUIPO, ID_COMPETICION),
    CONSTRAINT ID_EQUIPO_PART_FK FOREIGN KEY (ID_EQUIPO)
        REFERENCES EQUIPOS(ID_EQUIPO),
    CONSTRAINT ID_COMPETICION_PART_FK FOREIGN KEY (ID_COMPETICION)
        REFERENCES COMPETICIONES(ID_COMPETICION)
);

/*STAFF*/

DROP TABLE STAFF CASCADE CONSTRAINTS;

CREATE TABLE STAFF(
    ID_STAFF NUMBER(2),
    PUESTO VARCHAR2(50),
    NOMBRE VARCHAR2(50),
    SUELDO NUMBER(10),
    ID_EQUIPO NUMBER(2),
    CONSTRAINT ID_STAFF_PK PRIMARY KEY (ID_STAFF),
    CONSTRAINT CHK_PUESTO CHECK(PUESTO IN('ENTRENADOR', 'ASISTENTE')),
    CONSTRAINT ID_EQUIPO_STF_FK FOREIGN KEY (ID_EQUIPO)
        REFERENCES EQUIPOS(ID_EQUIPO)
);

/*PATROCINADORES*/

DROP TABLE PATROCINADORES CASCADE CONSTRAINTS;

CREATE TABLE PATROCINADORES(
    ID_PATROCINADOR NUMBER(2),
    NOMBRE VARCHAR2(50),
    CONSTRAINT ID_PATROCINADOR_PK PRIMARY KEY (ID_PATROCINADOR)
);

/*RELACION ENTRE PATROCINADORES Y EQUIPOS*/

DROP TABLE PATROCINIOS CASCADE CONSTRAINTS;

CREATE TABLE PATROCINIOS(
    ID_PATROCINADOR NUMBER(2),
    ID_EQUIPO NUMBER(2),
    CONSTRAINT ID_PATROCINADOR_FK FOREIGN KEY (ID_PATROCINADOR)
        REFERENCES PATROCINADORES(ID_PATROCINADOR),
    CONSTRAINT ID_EQUIPO_FK FOREIGN KEY (ID_EQUIPO)
        REFERENCES EQUIPOS(ID_EQUIPO)
);

/*VISTAS*/

CREATE OR REPLACE VIEW Jugadores_Sin_Equipo AS
SELECT nombre, nickname, rol, sueldo
FROM jugadores
WHERE id_equipo=NULL;


select * from jugadores_sin_equipo;

CREATE OR REPLACE VIEW Staff_Sin_Equipo AS
SELECT nombre, puesto
FROM staff
WHERE id_equipo=NULL;

select * from staff_sin_equipo;

CREATE OR REPLACE VIEW Todos_Los_Equipos AS
SELECT nombre
FROM equipos;

select * from todos_los_equipos;
