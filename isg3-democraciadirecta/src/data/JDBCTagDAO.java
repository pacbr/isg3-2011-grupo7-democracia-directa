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
	public Tag select(Connection con, Integer idTag) {
        String sql = "SELECT * FROM tag WHERE (id = ? ) ";
        PreparedStatement stmt = null;
        ResultSet result = null;
        Tag t = null;

        try {
            stmt = con.prepareStatement(sql);
            stmt.setInt(1, idTag);

            result = stmt.executeQuery();

            result.next();
            t = new Tag();
            t.setNombre(result.getString("nombre"));
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
        String sql = "SELECT * FROM tag";
        PreparedStatement stmt = null;
        ResultSet result = null;
        List<Tag> lista = new LinkedList<Tag>();

        try {
            stmt = con.prepareStatement(sql);
            result = stmt.executeQuery();
            while (result.next()) {
            	Tag temp = new Tag();
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
