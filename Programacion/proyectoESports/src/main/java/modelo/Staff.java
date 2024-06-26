package modelo;

import jakarta.persistence.*;

@Entity
@Table(name = "STAFF", schema = "EQDAW02", catalog = "")
public class Staff {
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "seq_gen")
    @SequenceGenerator(name = "seq_gen", sequenceName = "staff_seq", allocationSize = 1)
    @Id
    @Column(name = "ID_STAFF", nullable = false, precision = 0)
    private int idStaff;
    @Basic
    @Column(name = "PUESTO", nullable = true, length = 50)
    private String puesto;
    @Basic
    @Column(name = "NOMBRE", nullable = true, length = 50)
    private String nombre;
    @Basic
    @Column(name = "SUELDO", nullable = true, precision = 0)
    private Integer sueldo;

    @ManyToOne
    @JoinColumn(name = "ID_EQUIPO", referencedColumnName = "ID_EQUIPO")
    private Equipo equiposByIdEquipo;

    public int getIdStaff() {
        return idStaff;
    }

    public void setIdStaff(byte idStaff) {
        this.idStaff = idStaff;
    }

    public String getPuesto() {
        return puesto;
    }

    public void setPuesto(String puesto) {
        this.puesto = puesto;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public Integer getSueldo() {
        return sueldo;
    }

    public void setSueldo(Integer sueldo) {
        this.sueldo = sueldo;
    }


    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Staff staff = (Staff) o;

        if (idStaff != staff.idStaff) return false;
        if (puesto != null ? !puesto.equals(staff.puesto) : staff.puesto != null) return false;
        if (nombre != null ? !nombre.equals(staff.nombre) : staff.nombre != null) return false;
        if (sueldo != null ? !sueldo.equals(staff.sueldo) : staff.sueldo != null) return false;


        return true;
    }

    @Override
    public int hashCode() {
        int result = (int) idStaff;
        result = 31 * result + (puesto != null ? puesto.hashCode() : 0);
        result = 31 * result + (nombre != null ? nombre.hashCode() : 0);
        result = 31 * result + (sueldo != null ? sueldo.hashCode() : 0);

        return result;
    }

    public Equipo getEquiposByIdEquipo() {
        return equiposByIdEquipo;
    }

    public void setEquiposByIdEquipo(Equipo equiposByIdEquipo) {
        this.equiposByIdEquipo = equiposByIdEquipo;
    }
}
