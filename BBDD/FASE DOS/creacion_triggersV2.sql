--Trigger para crear las jornadas cuando se modifque el estado de la competici�n
CREATE OR REPLACE TRIGGER cambiar_estado_competicion
AFTER UPDATE OF ESTADO ON COMPETICIONES
FOR EACH ROW
BEGIN
    IF :NEW.ESTADO = 1 AND :OLD.ESTADO = 0 THEN
        crear_jornadas_competicion(:NEW.ID_COMPETICION);
    END IF;
END;


--Trigger que impide borrar equipos de una competici�n cerrada
CREATE OR REPLACE TRIGGER competicion_cerrada_delete_eq
BEFORE DELETE ON EQUIPOS
FOR EACH ROW
DECLARE
    v_estado COMPETICIONES.ESTADO%TYPE;
BEGIN
    -- Obtener el estado de la competici�n
    verificar_competicion(:OLD.ID_EQUIPO, v_estado);

    -- Excepci�n en caso de que la competici�n est� cerrada
    IF v_estado = 1 THEN
        RAISE_APPLICATION_ERROR(-20002, 'No se puede eliminar este registro porque la competici�n est� cerrada.');
    END IF;
END;


--Trigger que impide eliminar equipos que participen en una competici�n cerrada
CREATE OR REPLACE TRIGGER competicion_cerrada_delete_ju
BEFORE DELETE ON JUGADORES
FOR EACH ROW
DECLARE
    v_estado COMPETICIONES.ESTADO%TYPE;
BEGIN
    -- Obtener el estado de la competici�n
    verificar_competicion(:OLD.ID_EQUIPO, v_estado);

    -- Excepci�n en caso de que la competici�n est� cerrada
    IF v_estado = 1 THEN
        RAISE_APPLICATION_ERROR(-20004, 'No se puede eliminar este registro porque la competici�n est� cerrada.');
    END IF;
END;


--Trigger que impide insertar equipos en una competici�n que se encuentra cerrada
CREATE OR REPLACE TRIGGER competicion_cerrada_insert_eq
BEFORE INSERT OR UPDATE ON EQUIPOS
FOR EACH ROW
DECLARE
    v_estado COMPETICIONES.ESTADO%TYPE;
BEGIN
    -- Verificar si la competici�n est� abierta o cerrada
    verificar_competicion(:NEW.ID_EQUIPO, v_estado);

    -- Excepci�n en caso de que la competici�n est� cerrada
    IF v_estado = 1 THEN
        RAISE_APPLICATION_ERROR(-20001, 'No se puede realizar esta operaci�n porque la competici�n est� cerrada.');
    END IF;
END;


--Trigger que impide insertar o modificar jugadores que se encuentran en una competici�n cerrada
CREATE OR REPLACE TRIGGER competicion_cerrada_insert_ju
BEFORE INSERT OR UPDATE ON JUGADORES
FOR EACH ROW
DECLARE
    v_estado COMPETICIONES.ESTADO%TYPE;
BEGIN
    -- Obtener el estado de la competici�n
    verificar_competicion(:NEW.ID_EQUIPO, v_estado);

    -- Excepci�n en caso de que la competici�n est� cerrada
    IF v_estado = 1 THEN
        RAISE_APPLICATION_ERROR(-20003, 'No se puede realizar esta operaci�n porque la competici�n est� cerrada.');
    END IF;
END;


--Trigger que controla que no pueda haber competiciones con el mismo nombre
CREATE OR REPLACE TRIGGER competiciones_nombre_duplicate
FOR INSERT OR UPDATE OF NOMBRE ON COMPETICIONES
COMPOUND TRIGGER

    -- Variable para almacenar los nombres de las competiciones nuevos o actualizados
    TYPE nombres_t IS TABLE OF COMPETICIONES.NOMBRE%TYPE;
    v_nombres nombres_t := nombres_t();

    BEFORE EACH ROW IS
    BEGIN

        v_nombres.EXTEND;
        v_nombres(v_nombres.LAST) := :NEW.NOMBRE;
    END BEFORE EACH ROW;

    AFTER STATEMENT IS
        v_count NUMBER := 0;

    BEGIN

        FOR i IN 1 .. v_nombres.COUNT LOOP
            SELECT COUNT(*)
            INTO v_count
            FROM COMPETICIONES
            WHERE UPPER(NOMBRE) = UPPER(v_nombres(i));

            IF v_count > 1 THEN
                RAISE_APPLICATION_ERROR(-20002, 'Ya existe una competici�n con el nombre ' || v_nombres(i) || '.');
            END IF;
        END LOOP;
    END AFTER STATEMENT;

END competiciones_nombre_duplicate;


--Trigger que controla que un equipo tenga entrenador antes de que participe en una competici�n
CREATE OR REPLACE TRIGGER competiciones_nombre_duplicate
FOR INSERT OR UPDATE OF NOMBRE ON COMPETICIONES
COMPOUND TRIGGER

    -- Variable para almacenar los nombres de las competiciones nuevos o actualizados
    TYPE nombres_t IS TABLE OF COMPETICIONES.NOMBRE%TYPE;
    v_nombres nombres_t := nombres_t();

    BEFORE EACH ROW IS
    BEGIN

        v_nombres.EXTEND;
        v_nombres(v_nombres.LAST) := :NEW.NOMBRE;
    END BEFORE EACH ROW;

    -- AFTER STATEMENT: Realiza la verificaci�n despu�s de que todas las filas hayan sido procesadas
    AFTER STATEMENT IS
        v_count NUMBER := 0;

    BEGIN

        FOR i IN 1 .. v_nombres.COUNT LOOP
            SELECT COUNT(*)
            INTO v_count
            FROM COMPETICIONES
            WHERE UPPER(NOMBRE) = UPPER(v_nombres(i));

            IF v_count > 1 THEN
                RAISE_APPLICATION_ERROR(-20002, 'Ya existe una competici�n con el nombre ' || v_nombres(i) || '.');
            END IF;
        END LOOP;
    END AFTER STATEMENT;

END competiciones_nombre_duplicate;


--Trigger que controla que no haya m�s de 6 jugadores en un equipo
CREATE OR REPLACE TRIGGER controlar_max_jugadores
FOR INSERT OR UPDATE ON JUGADORES
COMPOUND TRIGGER
    v_cantidad_jugadores NUMBER;
    v_id_equipo NUMBER(2);

    BEFORE EACH ROW IS
    BEGIN
      v_id_equipo := :NEW.ID_EQUIPO;
    END BEFORE EACH ROW;

    AFTER STATEMENT IS
    BEGIN
        SELECT COUNT(*)
        INTO v_cantidad_jugadores
        FROM JUGADORES
        WHERE ID_EQUIPO = v_id_equipo;

        IF v_cantidad_jugadores >= 6 THEN
            RAISE_APPLICATION_ERROR(-20011, 'No se pueden agregar m�s de 6 jugadores en un equipo');
        END IF;
    END AFTER STATEMENT;

END controlar_max_jugadores;


--Trigger que controla que el n�mero de equipos de una competici�n sea par
CREATE OR REPLACE TRIGGER controlar_numero_equipos
BEFORE INSERT OR UPDATE ON COMPETICIONES
FOR EACH ROW
DECLARE
    v_num_equipos NUMBER;
BEGIN
    -- Contar el n�mero de equipos participantes en la competici�n
    SELECT COUNT(*)
    INTO v_num_equipos
    FROM PARTICIPACIONES
    WHERE ID_COMPETICION = :NEW.ID_COMPETICION;

    -- Excepci�n en caso de que el n�mero de equipos sea impar
    IF MOD(v_num_equipos, 2) <> 0 THEN
        RAISE_APPLICATION_ERROR(-20016, 'El n�mero de equipos en una competici�n debe ser par');
    END IF;
END;


--Trigger que controla que no se sobrepase el sueldo m�ximo de un equipo
CREATE OR REPLACE TRIGGER CONTROLAR_SUELDO_EQUIPO
FOR INSERT OR UPDATE ON JUGADORES
COMPOUND TRIGGER
    v_sueldo_total NUMBER;
    v_new_equipo NUMBER(2);

    BEFORE EACH ROW IS
    BEGIN
        v_new_equipo := :NEW.ID_EQUIPO;
    END BEFORE EACH ROW;

    AFTER STATEMENT IS
    BEGIN
        SELECT SUM(sueldo)
        INTO v_sueldo_total
        FROM JUGADORES
        WHERE ID_EQUIPO = v_new_equipo;

        IF v_sueldo_total > 200000 THEN
            RAISE_APPLICATION_ERROR(-20002, 'El sueldo total del equipo no puede superar los 200000');
        END IF;
    END AFTER STATEMENT;
END CONTROLAR_SUELDO_EQUIPO;


--Trigger que impide que haya equipos con el mismo nombre
CREATE OR REPLACE TRIGGER equipos_nombre_duplicadoV2
FOR INSERT OR UPDATE OF NOMBRE ON EQUIPOS
COMPOUND TRIGGER

    TYPE nombres_t IS TABLE OF EQUIPOS.NOMBRE%TYPE;
    v_nombres nombres_t := nombres_t();

    BEFORE EACH ROW IS
    BEGIN
        -- Agregar el nombre actual a la colecci�n
        v_nombres.EXTEND;
        v_nombres(v_nombres.LAST) := :NEW.NOMBRE;
    END BEFORE EACH ROW;

    AFTER STATEMENT IS
        v_count NUMBER := 0;
    BEGIN
        -- Verificar cada nombre en la colecci�n
        FOR i IN 1 .. v_nombres.COUNT LOOP
            SELECT COUNT(*)
            INTO v_count
            FROM EQUIPOS
            WHERE UPPER(NOMBRE) = UPPER(v_nombres(i));

            -- Si hay equipos con el mismo nombre (v_count > 1), se genera un error de aplicaci�n
            IF v_count > 1 THEN
                RAISE_APPLICATION_ERROR(-20002, 'Ya existe un equipo con el nombre ' || v_nombres(i) || '.');
            END IF;
        END LOOP;
    END AFTER STATEMENT;

END equipos_nombre_duplicadoV2;


--Trigger que impide que haya juegos con el mismo nombre
CREATE OR REPLACE TRIGGER juegos_nombre_duplicate
FOR INSERT OR UPDATE OF NOMBRE ON JUEGOS
COMPOUND TRIGGER
    
    TYPE nombres_t IS TABLE OF JUEGOS.NOMBRE%TYPE;
    v_nombres nombres_t := nombres_t();
    
    BEFORE EACH