package data;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import domain.Tag;
import domain.Usuario;

public class JDBCUsuarioDAO implements IUsuarioDAO{
	
	@Override
	public Usuario select(String idUsuario) {
		Connection con = ConnectionManager.getInstance().checkOut();
        String sql = "SELECT * FROM usuarios WHERE (id = ? ) ";
        PreparedStatement stmt = null;
        ResultSet result = null;
        Usuario u = null;
        ITagDAO tagDAO = new JDBCTagDAO();
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
            String[] campos = result.getString("tagsfav").split(";");
            List<Tag> tags = new ArrayList<Tag>();
            for (String s : campos) {
            	if (s != "") {
            		Tag t = tagDAO.select(s);
            		tags.add(t);
            	}
            }
            u.setUserTags(tags);
            
            String[] camposVotadas = result.getString("leyesvotadas").split(";");
            List<String> votos = new ArrayList<String>();
            for (String s : camposVotadas) {
            	if (s != "") {
            		
            		votos.add(s);
            	}
            }
            u.setPleyesVotadas(votos);
            
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
	
	public List<Usuario> selectAll() {
		Connection con = ConnectionManager.getInstance().checkOut();
		ITagDAO tagDAO = new JDBCTagDAO();
		String sql = "SELECT * FROM usuarios";
        PreparedStatement stmt = null;
        ResultSet result = null;
        List<Usuario> lista = new ArrayList<Usuario>();

        try {
            stmt = con.prepareStatement(sql);
            result = stmt.executeQuery();
            while (result.next()) {
            	Usuario temp = new Usuario();
            	temp.setId(result.getString("id"));
	            temp.setNick(result.getString("nick"));
	            temp.setPassword(result.getString("password"));
	            temp.setEmail(result.getString("email"));
	            temp.setNombre(result.getString("nombre"));
	            String[] campos = result.getString("tagsfav").split(";");
	            List<Tag> tags = new ArrayList<Tag>();
	            for (String s : campos) {
	            	if (s != "") {
	            		Tag t = tagDAO.select(s);
	            		tags.add(t);
	            	}
	            }
	            temp.setUserTags(tags);
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
        ITagDAO tagDAO = new JDBCTagDAO();
        
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
            String[] campos = result.getString("tagsfav").split(";");
            List<Tag> tags = new ArrayList<Tag>();
            for (String s : campos) {
            	if (s != "") {
            		Tag t = tagDAO.select(s);
            		tags.add(t);
            	}
            }
            u.setUserTags(tags);
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
	public boolean add(Usuario u) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public Usuario delete(Usuario u) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Tag> selectTags(Usuario user) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean addTag(Tag t) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public Tag deleteTag(Tag t) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean insertVoto(String idPLey, String idUsuario) {
		boolean res = false;
		Connection con = ConnectionManager.getInstance().checkOut();
        PreparedStatement stmt = null;
        String sql = "UPDATE usuarios SET leyesvotadas = ? WHERE id = ?";
        IPLeyDAO pleyDAO = new JDBCPLeyDAO();
        Usuario u = select(idUsuario);
        List<String> votosRealizados = u.getPleyesVotadas();
        String cadenaDeVotos = "";
        try {
            stmt = (PreparedStatement) con.prepareStatement(sql);
            
            boolean votoRepetido=false;
            for(String s:votosRealizados){
            	if(idPLey.equals(s))
            		votoRepetido=true;
    			cadenaDeVotos=cadenaDeVotos+s+";";
            }
            if(votoRepetido==false){
            	String voto = pleyDAO.select(idPLey).getId();
	            cadenaDeVotos=cadenaDeVotos+voto+";";
            }
            
            stmt.setString(1, cadenaDeVotos);
            stmt.setString(2, idUsuario);
            int resultado = stmt.executeUpdate();
			if (resultado != 0){
				res = true;
			}

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
		return res;
	}
	
}
