package data;

import java.sql.SQLException;
import java.util.List;
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
	public List<Tag> getUserTags(String idUsuario) {
		return usuarioDAO.selectTags(usuarioDAO.select(idUsuario));
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
            
            boolean tagRepetido=false;
            for(Tag tag:tagsDeUsuarioActuales){
            	if(idTag.equals(tag.getId()))
            		tagRepetido=true;
    			cadenaDeTags=cadenaDeTags+tag.getId()+";";
            }
            if(tagRepetido==false){
	            String tag = tagDAO.select(idTag).getId();
	            cadenaDeTags=cadenaDeTags+tag+";";
            }
            
            stmt.setString(1, cadenaDeTags);
            stmt.setString(2, idUsuario);
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
	
	public boolean eliminaTagDeUsuario(String idTag, String idUsuario) {
		PreparedStatement stmt = null;
        String sql = "UPDATE usuarios SET tagsfav = ? WHERE id = ?";

        Usuario u = usuarioDAO.select(idUsuario);
        List<Tag> tagsDeUsuarioActuales = u.getUserTags();
        String cadenaDeTags = "";
        try {
            stmt = (PreparedStatement) conn.prepareStatement(sql);
            
            for(Tag tag:tagsDeUsuarioActuales){
            	if(!idTag.equals(tag.getId()))
            		cadenaDeTags=cadenaDeTags+tag.getId()+";";
            }
            
            stmt.setString(1, cadenaDeTags);
            stmt.setString(2, idUsuario);
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
