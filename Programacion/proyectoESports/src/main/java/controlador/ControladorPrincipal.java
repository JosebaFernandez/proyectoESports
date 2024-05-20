
package controlador;

import controlador.controladorM.ControladorM;
import controlador.controladorV.ControladorV;
import modelo.Equipo;
import modelo.Jugador;
import modelo.Usuario;

import java.util.List;

public class ControladorPrincipal {
    private ControladorV cv;
    private ControladorM cm;
    private Equipo eq;
    private Jugador jd;


    public ControladorPrincipal() {
        cm = new ControladorM(this);
        cv = new ControladorV(this);
        System.out.println("Creados");


    }
    public void terminar() throws Exception
    {
        System.exit(0);
    }

    // Parte del Usuario

    public Usuario buscarUsuario(String nombre) throws Exception
    {
        return cm.buscarUsuario(nombre);
    }

    //Parte del Equipo
    public Equipo buscarEquipo(String nombre) throws Exception {
        return cm.buscarEquipo(nombre);
    }
    public void insertarEquipo(Equipo eq) throws Exception{
        cm.insertarEquipo(eq);
    }
    public void borrarEquipo() throws Exception{
        cm.borrarEquipo();
    }
    public List<Equipo> comboEquipos() {
        return cm.comboEquipos();
    }

    //Parte del Jugador

    public Jugador buscarJugador(String nickname) throws Exception{
        return cm.buscarJugador(nickname);
    }
    public void insertarJugador(Jugador jd) throws Exception{
        cm.insertarJugador(jd);
    }
    public void borrarJugador() throws Exception{
        cm.borrarJugador();
    }
    public List<Jugador> comboJugadores() {
        return cm.comboJugadores();
    }

}



