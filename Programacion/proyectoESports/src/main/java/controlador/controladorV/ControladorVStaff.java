package controlador.controladorV;

import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class ControladorVStaff {
    private VistaStaff vs;
    private ControladorV cv;
    public ControladorVStaff(ControladorV cv) {
        this.cv = cv;
    }
    public void mostrarUsuarios() {
        vs = new VistaStaff();

        // vjd.addBAceptarAl(new BAceptarAl());
        // vjd.addBBorrarAl(new BBorrarAl());
        // vjd.addBEditarAl(new BEditarAl());
        // vjd.addCbJugadoresAl(new CbJugadoresAl());
        // vjd.addCBEquiposAl(new CbEquiposAl());
        vs.addBSalirAl(new BSalirAl());

        vs.getPanelComboBox().setVisible(true);
    }

    public class BSalirAl implements ActionListener {
        @Override
        public void actionPerformed(ActionEvent e) {
            try {
                cv.terminar();
            } catch (Exception ex) {
                throw new RuntimeException(ex);
            }
        }
    }
}