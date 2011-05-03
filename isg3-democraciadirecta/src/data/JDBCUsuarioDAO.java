package data;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import domain.Usuario;

public class JDBCUsuarioDAO implements IUsuarioDAO{
	
	@Override
	public Usuario select(String idUsuario) {
		Connection con = ConnectionManager.getInstance().checkOut();
        String sql = "SELECT * FROM usuarios WHERE (id = ? ) ";
        PreparedStatement stmt = null;
        ResultSet result = null;
        Usuario u = null;

        try {
            stmt = con.prepareStatement(sql);
            stmt.setString(1, idUsuario);

            result = stmt.executeQuery();

            result.next();
            u = new Usuario();
            u.setId(idUsuario);
            u.setNick(result.getString("nick"));
            u.setPassword(result.getString("password"));
            u.setEmail(result.getString("email"));
            u.setNombre(result.getString("nombre"));
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

        return u;
	}
	
	@Override
	public boolean valida(String nick, String passwd) {
		Connection con = ConnectionManager.getInstance().checkOut();
        String sql = "SELECT * FROM usuarios WHERE (nick = ? && password = ? ) ";
        PreparedStatement stmt = null;
        ResultSet result = null;
        boolean res = false;

        try {
            stmt = con.prepareStatement(sql);
            stmt.setString(1, nick);
            stmt.setString(2, passwd);
            result = stmt.executeQuery();
            res = result.next();
            
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

        return res;
	}
	
	@Override
	public Usuario select(String nick, String passwd) {
		Connection con = ConnectionManager.getInstance().checkOut();
        String sql = "SELECT * FROM usuarios WHERE (nick = ? && password = ? ) ";
        PreparedStatement stmt = null;
        ResultSet result = null;
        Usuario u = null;

        try {
            stmt = con.prepareStatement(sql);
            stmt.setString(1, nick);
            stmt.setString(2, passwd);

            result = stmt.executeQuery();

            result.next();
            u = new Usuario();
            u.setId(result.getString("id"));
            u.setNick(result.getString("nick"));
            u.setPassword(result.getString("password"));
            u.setEmail(result.getString("email"));
            u.setNombre(result.getString("nombre"));
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

        return u;
	}
}
