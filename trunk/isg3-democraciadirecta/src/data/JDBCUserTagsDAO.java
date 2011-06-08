package data;

import java.sql.SQLException;
import java.util.List;
import java.util.Set;

import com.mysql.jdbc.Connection;
import com.mysql.jdbc.PreparedStatement;

import domain.Tag;
import domain.Usuario;

public class JDBCUserTagsDAO implements IUserTagsDAO{
	private Connection conn;
    IUsuarioDAO usuarioDAO;
    ITagDAO tagDAO;

    public JDBCUserTagsDAO() {
        conn = (Connection) ConnectionManager.getInstance().checkOut();
        tagDAO = new JDBCTagDAO();
        usuarioDAO = new JDBCUsuarioDAO();
    }

    protected void finalize() {
        ConnectionManager.getInstance().checkIn(conn);
    }

	@Override
	public Set<Tag> getUserTags(String idUsuario) {
		
		return null;
	}
	
	@Override
	public boolean insertaTagAUsuario(String idTag, String idUsuario) {
		PreparedStatement stmt = null;
        String sql = "UPDATE usuarios SET tagsfav = ? WHERE id = ?";

        Usuario u = usuarioDAO.select(idUsuario);
        List<Tag> tagsDeUsuarioActuales = u.getUserTags();
        String cadenaDeTags = "";
        try {
            stmt = (PreparedStatement) conn.prepareStatement(sql);
            
            stmt.setInt(2, Integer.parseInt(idUsuario));
//            stmt.setString(2, u.getNick());
//            stmt.setString(3, u.getPassword());
//            stmt.setString(4, u.getEmail());
//            stmt.setString(5, u.getNombre());
            for(Tag tag:tagsDeUsuarioActuales)
    			cadenaDeTags=cadenaDeTags+tag.getId()+";";
            String tag = tagDAO.select(idTag).getId();
            cadenaDeTags=cadenaDeTags+tag+";";
            stmt.setString(1, cadenaDeTags);
//            stmt.setString(1, "1;2;3;");
            stmt.executeUpdate();

        } catch (SQLException e) {
            System.out.println("Message: " + e.getMessage());
            System.out.println("SQLState: " + e.getSQLState());
            System.out.println("ErrorCode: " + e.getErrorCode());
        } finally {
            try {
                if (stmt != null) {
                    stmt.close();
                }
            } catch (SQLException e) {
            }
        }
		return false;
    }
//		Usuario usuario = usuarioDAO.select(idUsuario);
//		List<Tag> tagsDeUsuarioActuales = usuario.getUserTags();
//		String cadenaDeTags=null;
//		
//		for(Tag tag:tagsDeUsuarioActuales)
//			cadenaDeTags=cadenaDeTags.concat(tag.getId()+";");
//		
//		PreparedStatement stmt = null;
//        String sql = "UPDATE usuarios SET tagsfav=" + cadenaDeTags + "WHERE id=" + idUsuario;
//        try {
//            stmt = (PreparedStatement) conn.prepareStatement(sql);

//            stmt.setString(1, oido);
//            stmt.setString(2, oida);
//            stmt.setString(3, oidc);
//            stmt.setString(4, o.getOrderID());
//            stmt.setLong(5, o.getTimeplaced().getTime());
//            stmt.setString(6, o.getPlacedbyCustomer());
//
//            stmt.executeUpdate();
//
//            //insert details
//            ddao.insert(conn, o.getDetails(), oido);
//
//        } catch (SQLException e) {
//            System.out.println("Message: " + e.getMessage());
//            System.out.println("SQLState: " + e.getSQLState());
//            System.out.println("ErrorCode: " + e.getErrorCode());
//        } finally {
//            try {
//                if (stmt != null) {
//                    stmt.close();
//                }
//            } catch (SQLException e) {
//            }
//        }
//		return false;
//    }

}
