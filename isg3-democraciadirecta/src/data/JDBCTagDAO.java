package data;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import domain.Tag;

public class JDBCTagDAO implements ITagDAO{

	@Override
	public Tag select(Connection con, Integer idTag) {
        String sql = "SELECT * FROM Tag WHERE (idTag = ? ) ";
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

}
