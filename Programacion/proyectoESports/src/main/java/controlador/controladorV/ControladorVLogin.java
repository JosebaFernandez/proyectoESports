package controlador.controladorV;

import vista.VistaLogin;

import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class ControladorVLogin {
    private ControladorV cv;
    private VistaLogin vl;

    public ControladorVLogin(ControladorV cv){
        this.cv = cv;
    }
    public void mostrarVentanaPrincipal()
    {
        // Area De login
        vl = new VistaLogin();

        vl.addBEntrarAl(new BLoginAl());
        vl.addBSalirAl(new BSalirAl());

        vl.setVisible(true);
    }

    public class BLoginAl implements ActionListener{
        @Override
        public void actionPerformed(ActionEvent e) {
            var nombreUsuario = vl.getTfUsuario().getText();
            var contrasenaUsuario = vl.getTfContrasena().getText();


        }
    }

    public class BSalirAl implements ActionListener{

        @Override
        public void actionPerformed(ActionEvent e) {
            System.exit(1);
        }
    }
}