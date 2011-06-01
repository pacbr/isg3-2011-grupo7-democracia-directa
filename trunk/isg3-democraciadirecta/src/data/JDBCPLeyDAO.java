package data;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedList;
import java.util.List;

import domain.PLey;
import domain.Tag;

public class JDBCPLeyDAO implements IPLeyDAO{
	
	@Override
	public List<PLey> getPLeyesByTags(List<Tag> tags) {
		Connection con = ConnectionManager.getInstance().checkOut();
        String sql = "SELECT * FROM pleyes WHERE (tag = ?)";
        PreparedStatement stmt = null;
        ResultSet result = null;
        List<PLey> lista = new LinkedList<PLey>();

        try {
            stmt = con.prepareStatement(sql);
            stmt.setString(1, "");
            result = stmt.executeQuery();
            while (result.next()) {
            	PLey temp = new PLey();
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

	@Override
	public boolean voto(PLey e) {
		// TODO Auto-generated method stub
		return false;
	}
	
}
