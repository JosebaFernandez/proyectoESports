package vista;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionListener;


public class VistaStaff extends JFrame {
    private JPanel panelComboBox;
    private JComboBox cbStaff;
    private JPanel panelPrincipal;
    private JPanel panelDatos;
    private JTextArea taDatos;
    private JButton bEditar;
    private JButton bBorrar;
    private JPanel panelCrear;
    private JTextField tfNombre;
    private JButton bAceptar;
    private JButton bSalir;
    private JTextField tfPuesto;
    private JTextField tfSueldo;
    private JComboBox cbEquipos;

    public VistaStaff(){
        super("Staff");
        setContentPane(panelPrincipal);
        setSize(600,500);
        setLocationRelativeTo(null);
        panelPrincipal.setBackground(Color.black);
        panelComboBox.setOpaque(false);
        panelCrear.setOpaque(false);
        panelDatos.setOpaque(false );
        taDatos.setEnabled(false);
        taDatos.setDisabledTextColor(Color.black);
        taDatos.setSelectedTextColor(Color.black);
        taDatos.setSelectionColor(Color.white);
        cbStaff.setBackground(Color.black);
        cbStaff.setForeground(Color.white);
        bEditar.setBackground(Color.black);
        bEditar.setForeground(Color.white);
        bAceptar.setForeground(Color.white);
        bAceptar.setBackground(Color.black);
        bBorrar.setForeground(Color.white);
        bBorrar.setBackground(Color.black);
        bSalir.setForeground(Color.white);
        bSalir.setBackground(Color.black);
        tfNombre.setBackground(Color.black);
        tfNombre.setForeground(Color.white);
        tfNombre.setSelectionColor(Color.white);
        tfNombre.setSelectedTextColor(Color.black);
        tfSueldo.setBackground(Color.black);
        tfSueldo.setForeground(Color.white);
        tfSueldo.setSelectionColor(Color.white);
        tfSueldo.setSelectedTextColor(Color.black);
        tfPuesto.setBackground(Color.black);
        tfPuesto.setForeground(Color.white);
        tfPuesto.setSelectionColor(Color.white);
        tfPuesto.setSelectedTextColor(Color.black);
        cbEquipos.setBackground(Color.black);
        cbEquipos.setForeground(Color.white);
    }

    public void addBEditarAl (ActionListener al){
        bEditar.addActionListener(al);
    }
    public void addBBorrarAl (ActionListener al){
        bBorrar.addActionListener(al);
    }
    public void addBAceptarAl (ActionListener al){
        bAceptar.addActionListener(al);
    }
    public void addCbEquiposAl (ActionListener al){
        cbEquipos.addActionListener(al);
    }
    public void addCbStaffAl (ActionListener al){
        cbStaff.addActionListener(al);
    }
    public void addBSalirAl (ActionListener al){
        bSalir.addActionListener(al);
    }
    public void limpiar()
    {
        tfNombre.setText("");
        tfSueldo.setText("");
        cbEquipos.setSelectedItem(0);
        taDatos.setText("");
        tfNombre.requestFocus();
    }
    public JPanel getPanelComboBox() {
        return panelComboBox;
    }

    public void setPanelComboBox(JPanel panelComboBox) {
        this.panelComboBox = panelComboBox;
    }

    public JComboBox getCbStaff() {
        return cbStaff;
    }

    public void setCbStaff(JComboBox cbStaff) {
        this.cbStaff = cbStaff;
    }

    public JPanel getPanelPrincipal() {
        return panelPrincipal;
    }

    public void setPanelPrincipal(JPanel panelPrincipal) {
        this.panelPrincipal = panelPrincipal;
    }

    public JPanel getPanelDatos() {
        return panelDatos;
    }

    public void setPanelDatos(JPanel panelDatos) {
        this.panelDatos = panelDatos;
    }

    public JTextArea getTaDatos() {
        return taDatos;
    }

    public void setTaDatos(JTextArea taDatos) {
        this.taDatos = taDatos;
    }

    public JPanel getPanelCrear() {
        return panelCrear;
    }

    public void setPanelCrear(JPanel panelCrear) {
        this.panelCrear = panelCrear;
    }

    public JTextField getTfNombre() {
        return tfNombre;
    }

    public void setTfNombre(JTextField tfNombre) {
        this.tfNombre = tfNombre;
    }

    public JTextField getTfPuesto() {
        return tfPuesto;
    }

    public void setTfPuesto(JTextField tfPuesto) {
        this.tfPuesto = tfPuesto;
    }

    public JTextField getTfSueldo() {
        return tfSueldo;
    }

    public void setTfSueldo(JTextField tfSueldo) {
        this.tfSueldo = tfSueldo;
    }

    public JComboBox getCbEquipos() {
        return cbEquipos;
    }

    public void setCbEquipos(JComboBox cbEquipos) {
        this.cbEquipos = cbEquipos;
    }

}
