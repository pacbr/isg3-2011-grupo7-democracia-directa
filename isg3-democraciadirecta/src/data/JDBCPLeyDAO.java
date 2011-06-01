package data;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import domain.PLey;
import domain.Tag;

public class JDBCPLeyDAO implements IPLeyDAO{
	
	private Connection con;
	IUsuarioDAO usuarioDAO;
	ITagDAO tagDAO;
	
	public JDBCPLeyDAO() {
		con = ConnectionManager.getInstance().checkOut();
		usuarioDAO = new JDBCUsuarioDAO();
		tagDAO = new JDBCTagDAO();
	}
	
    protected void finalize() {
        ConnectionManager.getInstance().checkIn(con);
    }
	
	@Override
	public List<PLey> selectAll() {
        String sql = "SELECT * FROM pleyes";
        PreparedStatement stmt = null;
        ResultSet result = null;
        List<PLey> lista = new ArrayList<PLey>();

        try {
            stmt = con.prepareStatement(sql);
            result = stmt.executeQuery();
            while (result.next()) {
            	PLey temp = new PLey();
            	temp.setId(result.getString("id"));
	            temp.setNombre(result.getString("nombre"));
	            temp.setDescripcion(result.getString("descripcion"));
	            temp.setUsuario(usuarioDAO.select(result.getString("usuario")));
	            String[] campos = result.getString("tags").split(";");
	            List<Tag> tags = new ArrayList<Tag>();
	            for (String s : campos) {
	            	if (s != "") {
	            		Tag t = tagDAO.select(s);
	            		tags.add(t);
	            	}
	            }
	            temp.setTags(tags);
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
	public List<PLey> getPLeyesByTags(List<Tag> tags) {
		Connection con = ConnectionManager.getInstance().checkOut();
		
        String sql = "SELECT * FROM pleyes";
        PreparedStatement stmt = null;
        ResultSet result = null;
        List<PLey> lista = new ArrayList<PLey>();

        try {
            stmt = con.prepareStatement(sql);
            result = stmt.executeQuery();
            while (result.next()) {
	            String[] campos = result.getString("tags").split(";");
	            List<Tag> tags1 = new ArrayList<Tag>();
	            for (String s : campos) {
	            	if (s != "") {
	            		Tag t = tagDAO.select(s);
	            		tags1.add(t);
	            	}
	            }
	            for (Tag t : tags) {
	            	for (Tag t1 : tags1) {
	            		if (t1.equals(t)) {
	            			PLey temp = new PLey();
	            			temp.setId(result.getString("id"));
	            			temp.setNombre(result.getString("nombre"));
	            			temp.setDescripcion(result.getString("descripcion"));
	            			temp.setUsuario(usuarioDAO.select(result.getString("idUsuario")));
	            			temp.setTags(tags1);
	            			if (!lista.contains(temp)) {
	            				lista.add(temp);
	            			}
	            			break;
	            		}
	            	}
	            }
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
