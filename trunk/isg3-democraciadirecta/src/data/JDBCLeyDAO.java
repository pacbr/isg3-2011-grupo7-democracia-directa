package data;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedList;
import java.util.List;

import domain.Ley;

public class JDBCLeyDAO implements ILeyDAO{
	
	@Override
	public List<Ley> selectByTag(String idTag){
		Connection con = ConnectionManager.getInstance().checkOut();
        String sql = "SELECT * FROM leyes WHERE (idtag = ?)";
        PreparedStatement stmt = null;
        ResultSet result = null;
        List<Ley> lista = new LinkedList<Ley>();

        try {
            stmt = con.prepareStatement(sql);
            stmt.setString(1, idTag);
            result = stmt.executeQuery();
            while (result.next()) {
            	Ley temp = new Ley();
            	temp.setId(result.getString("id"));
	            temp.setNombre(result.getString("nombre"));
	            temp.setIdTag(result.getString("idTag"));
	            temp.setDescripcion(result.getString("descripcion"));
	            lista.add(temp);
            }
        } catch (SQLException e) {
            System.out.println("Message: " + e.getMessage());
            System.out.println("SQLState: " + e.getSQLState());
            System.out.println("ErrorCode: " + e.getErrorCode());
        } finally {
            try {
                if (result != null) {
                    result.close();
                }
                if (stmt != null) {
                    stmt.close();
                }
            } catch (SQLException e) {
            }
        }

        return lista;
	}
	
}
