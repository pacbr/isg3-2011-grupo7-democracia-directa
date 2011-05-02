package data;

import java.sql.Connection;
import domain.Ley;

public interface ILeyDAO {

    void delete(Connection conn, Integer idLey);
    void insert(Connection conn, Integer idLey, String nombre, String descripcion);
    Ley select(Connection conn, Integer idLey);
	
}