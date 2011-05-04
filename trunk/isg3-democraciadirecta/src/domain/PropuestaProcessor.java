package domain;

import java.util.List;

import data.ILeyDAO;
import data.ITagDAO;
import data.IUsuarioDAO;
import data.JDBCLeyDAO;
import data.JDBCTagDAO;
import data.JDBCUsuarioDAO;

public class PropuestaProcessor implements IPropuestaProcessor{

	private ITagDAO tagDAO = new JDBCTagDAO();
	private ILeyDAO leyDAO = new JDBCLeyDAO();
	private IUsuarioDAO usuarioDAO = new JDBCUsuarioDAO();
	
	@Override
	public boolean cancelPropuesta(String idPropuesta) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean addPropuesta(Propuesta p) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public List<Tag> mostrarTags() {
		return tagDAO.selectAll();
	}

	@Override
	public Tag mostrarTag(String idTag) {
		return tagDAO.select(idTag);
	}
	
	@Override
	public Usuario seleccionaUsuario(String idUsuario) {
		return usuarioDAO.select(idUsuario);
	}
	
	@Override
	public List<Ley> mostrarLeyes(String idTag) {
		return leyDAO.selectByTag(idTag);
	}

}
