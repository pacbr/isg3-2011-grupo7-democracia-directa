package data;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import domain.PLey;
import domain.Tag;
import domain.Usuario;

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
	            temp.setUsuario(usuarioDAO.select(result.getString("idUsuario")));
	            temp.setVotos(result.getInt("Votos"));
	            temp.setActiva(result.getBoolean("Activa"));
	            temp.setVisitas(result.getInt("Visitas"));
	            temp.setMaxPosicionLista(result.getInt("posicionMax"));
	            temp.setMinPosicionLista(result.getInt("posicionMin"));
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
	        	            temp.setVotos(result.getInt("Votos"));
	        	            temp.setActiva(result.getBoolean("Activa"));
	        	            temp.setVisitas(result.getInt("Visitas"));
	        	            temp.setMaxPosicionLista(result.getInt("posicionMax"));
	        	            temp.setMinPosicionLista(result.getInt("posicionMin"));
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

	public List<PLey> selectPLeyesByUser(Usuario user) {
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
	            List<Tag> tags = new ArrayList<Tag>();
	            for (String s : campos) {
	            	if (s != "") {
	            		Tag t = tagDAO.select(s);
	            		tags.add(t);
	            	}
	            }
	            String idUserActual = result.getString("idUsuario");
	            if(idUserActual.equals(user.getId())){
	            	PLey temp = new PLey();
        			temp.setId(result.getString("id"));
        			temp.setNombre(result.getString("nombre"));
        			temp.setDescripcion(result.getString("descripcion"));
        			temp.setUsuario(usuarioDAO.select(result.getString("idUsuario")));
    	            temp.setVotos(result.getInt("Votos"));
    	            temp.setActiva(result.getBoolean("Activa"));
    	            temp.setVisitas(result.getInt("Visitas"));
    	            temp.setMaxPosicionLista(result.getInt("posicionMax"));
    	            temp.setMinPosicionLista(result.getInt("posicionMin"));
        			temp.setTags(tags);
        			if (!lista.contains(temp)) {
        				lista.add(temp);
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
	
	public List<PLey> selectPLeyesActivasByUser(Usuario user) {
		Connection con = ConnectionManager.getInstance().checkOut();
		
        String sql = "SELECT * FROM pleyes WHERE (Activa = true)";
        PreparedStatement stmt = null;
        ResultSet result = null;
        List<PLey> lista = new ArrayList<PLey>();

        try {
            stmt = con.prepareStatement(sql);
            result = stmt.executeQuery();
            while (result.next()) {
            	String[] campos = result.getString("tags").split(";");
	            List<Tag> tags = new ArrayList<Tag>();
	            for (String s : campos) {
	            	if (s != "") {
	            		Tag t = tagDAO.select(s);
	            		tags.add(t);
	            	}
	            }
	            String idUserActual = result.getString("idUsuario");
	            if(idUserActual.equals(user.getId())){
	            	PLey temp = new PLey();
        			temp.setId(result.getString("id"));
        			temp.setNombre(result.getString("nombre"));
        			temp.setDescripcion(result.getString("descripcion"));
        			temp.setUsuario(usuarioDAO.select(result.getString("idUsuario")));
        			temp.setVotos(result.getInt("Votos"));
    	            temp.setActiva(result.getBoolean("Activa"));
    	            temp.setVisitas(result.getInt("Visitas"));
    	            temp.setMaxPosicionLista(result.getInt("posicionMax"));
    	            temp.setMinPosicionLista(result.getInt("posicionMin"));
        			temp.setTags(tags);
        			if (!lista.contains(temp)) {
        				lista.add(temp);
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
	
	public List<PLey> selectPLeyesNoActivasByUser(Usuario user) {
		Connection con = ConnectionManager.getInstance().checkOut();
		
        String sql = "SELECT * FROM pleyes WHERE (Activa != true)";
        PreparedStatement stmt = null;
        ResultSet result = null;
        List<PLey> lista = new ArrayList<PLey>();

        try {
            stmt = con.prepareStatement(sql);
            result = stmt.executeQuery();
            while (result.next()) {
            	String[] campos = result.getString("tags").split(";");
	            List<Tag> tags = new ArrayList<Tag>();
	            for (String s : campos) {
	            	if (s != "") {
	            		Tag t = tagDAO.select(s);
	            		tags.add(t);
	            	}
	            }
	            String idUserActual = result.getString("idUsuario");
	            if(idUserActual.equals(user.getId())){
	            	PLey temp = new PLey();
        			temp.setId(result.getString("id"));
        			temp.setNombre(result.getString("nombre"));
        			temp.setDescripcion(result.getString("descripcion"));
        			temp.setUsuario(usuarioDAO.select(result.getString("idUsuario")));
        			temp.setVotos(result.getInt("Votos"));
    	            temp.setActiva(result.getBoolean("Activa"));
    	            temp.setVisitas(result.getInt("Visitas"));
    	            temp.setMaxPosicionLista(result.getInt("posicionMax"));
    	            temp.setMinPosicionLista(result.getInt("posicionMin"));
        			temp.setTags(tags);
        			if (!lista.contains(temp)) {
        				lista.add(temp);
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
	public PLey select(String idPley) {
		Connection con = ConnectionManager.getInstance().checkOut();
		
        String sql = "SELECT * FROM pleyes WHERE (id = ?)";
        PreparedStatement stmt = null;
        ResultSet result = null;
        PLey pley = null;

        try {
            stmt = con.prepareStatement(sql);
            stmt.setString(1, idPley);
            result = stmt.executeQuery();
            
            result.next();
            pley = new PLey();
            pley.setId(idPley);
            pley.setNombre(result.getString("nombre"));
            pley.setDescripcion(result.getString("descripcion"));
            pley.setUsuario(usuarioDAO.select(result.getString("idUsuario")));
			pley.setVotos(result.getInt("Votos"));
            pley.setActiva(result.getBoolean("Activa"));
            pley.setVisitas(result.getInt("Visitas"));
            pley.setMaxPosicionLista(result.getInt("posicionMax"));
            pley.setMinPosicionLista(result.getInt("posicionMin"));
            String[] campos = result.getString("tags").split(";");
	        List<Tag> tags = new ArrayList<Tag>();
	        for (String s : campos) {
	        	if (s != "") {
	        		Tag t = tagDAO.select(s);
	        		tags.add(t);
	            }
	        }
	        pley.setTags(tags);
	        
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

        return pley;
	}

	@Override
	public boolean insert(PLey p) {
		boolean res = false;
		PreparedStatement stmt = null;
		String sql = "INSERT INTO pleyes ( id, nombre, tags, descripcion, idUsuario, Votos, Activa) VALUES (?, ?, ?, ?, ?, ?, ?) ";
		
		try {
			
			stmt = con.prepareStatement(sql);
			
			stmt.setString(1, p.getId());
			stmt.setString(2, p.getNombre());
			String tags = "";
			for (Tag t : p.getTags()) {
				tags = tags.concat(t.getId()+";");
			}
			stmt.setString(3, tags);
			stmt.setString(4, p.getDescripcion());
			stmt.setString(5, p.getUsuario().getId());
			stmt.setInt(6, 0);
			stmt.setString(7, "true");
			
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

	@Override
	public List<PLey> selectPLeyesActivas() {
		Connection con = ConnectionManager.getInstance().checkOut();
		String sql = "SELECT * FROM pleyes WHERE (Activa = true)";

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
	            temp.setUsuario(usuarioDAO.select(result.getString("idUsuario")));
	            temp.setVotos(result.getInt("Votos"));
	            temp.setActiva(result.getBoolean("Activa"));
	            temp.setVisitas(result.getInt("Visitas"));
	            temp.setMaxPosicionLista(result.getInt("posicionMax"));
	            temp.setMinPosicionLista(result.getInt("posicionMin"));
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
	public boolean insertVoto(String idPLey) {
		PreparedStatement stmt = null;
		String sql = "UPDATE pleyes SET Votos = Votos+1 WHERE id = ?";
		boolean res=false;
		try {
			stmt = (PreparedStatement) con.prepareStatement(sql);
			
			stmt.setString(1, idPLey);
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

	@Override
	public boolean insertMaxPositionList(String idPley, int posicionLista) {
		PreparedStatement stmt = null;
		String sql = "UPDATE pleyes SET posicionMax = ? WHERE id = ?";
		boolean res=false;
		try {
			stmt = (PreparedStatement) con.prepareStatement(sql);
			
			
			stmt.setInt(1,posicionLista);
			stmt.setString(2,idPley);

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

	@Override
	public boolean insertMinPositionList(String idPley, int posicionLista) {
		PreparedStatement stmt = null;
		String sql = "UPDATE pleyes SET posicionMin = ? WHERE id = ?";
		boolean res=false;
		try {
			stmt = (PreparedStatement) con.prepareStatement(sql);
			
			
			stmt.setInt(1,posicionLista);
			stmt.setString(2,idPley);

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

	@Override
	public boolean insertVisita(String idPley) {
		PreparedStatement stmt = null;
		String sql = "UPDATE pleyes SET visitas = visitas+1 WHERE id = ?";
		boolean res=false;
		try {
			stmt = (PreparedStatement) con.prepareStatement(sql);
			
			stmt.setString(1, idPley);
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

	@Override
	public boolean deletePley(String idPley) {
		boolean res = false;
		PreparedStatement stmt = null;
		String sql = "DELETE FROM pleyes WHERE id = ?";
		
		try {
			stmt = con.prepareStatement(sql);
			stmt.setString(1, idPley);
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

	@Override
	public boolean updatePley(PLey p) {
		boolean res = false;
		PreparedStatement stmt = null;
		String sql = "UPDATE pleyes SET nombre = ?, tags = ?, descripcion = ? WHERE id = ?";
		
		try {
			
			stmt = con.prepareStatement(sql);
			
			stmt.setString(1, p.getNombre());
			String tags = "";
			for (Tag t : p.getTags()) {
				tags = tags.concat(t.getId()+";");
			}
			stmt.setString(2, tags);
			stmt.setString(3, p.getDescripcion());
			stmt.setString(4, p.getId());
			
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
