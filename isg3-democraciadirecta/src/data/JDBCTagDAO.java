package data;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedList;
import java.util.List;

import domain.Tag;

public class JDBCTagDAO implements ITagDAO{

	@Override
	public Tag select(String idTag) {
		Connection con = ConnectionManager.getInstance().checkOut();
        String sql = "SELECT * FROM tags WHERE (id = ?)";
        PreparedStatement stmt = null;
        ResultSet result = null;
        Tag t = null;

        try {
            stmt = con.prepareStatement(sql);
            stmt.setString(1, idTag.trim());

            result = stmt.executeQuery();

            if(result.next()) {
	            t = new Tag();
	            t.setId(result.getString("id"));
	            t.setNombre(result.getString("nombre"));
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

        return t;
	}

	@Override
	public List<Tag> selectAll() {
		Connection con = ConnectionManager.getInstance().checkOut();
        String sql = "SELECT * FROM tags";
        PreparedStatement stmt = null;
        ResultSet result = null;
        List<Tag> lista = new LinkedList<Tag>();

        try {
            stmt = con.prepareStatement(sql);
            result = stmt.executeQuery();
            while (result.next()) {
            	Tag temp = new Tag();
            	temp.setId(result.getString("id"));
	            temp.setNombre(result.getString("nombre"));
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
