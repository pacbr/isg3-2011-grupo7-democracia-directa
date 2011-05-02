package domain;

import java.util.List;

import data.ITagDAO;
import data.JDBCTagDAO;

public class PropuestaProcessor implements IPropuestaProcessor{

	private ITagDAO tagDAO = new JDBCTagDAO();
	
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

}
