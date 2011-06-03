package domain;

import java.util.List;

import data.ITagDAO;
import data.JDBCTagDAO;

public class ProccesorUserTags implements IProccesorUserTags{
	ITagDAO tagDAO = new JDBCTagDAO();
	@Override
	public List<Tag> obtenerTop10() {
		//TODOJOSE seleccionar 10 primeras comparando con pleyes
		return tagDAO.selectAll();
	}

	@Override
	public Tag obtenerTagPorId(String idTag) {
		return tagDAO.select(idTag);
	}

	@Override
	public List<Tag> obtenerTagsActualesDeUsuario() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean insertaUserTag(Tag t) {
		// TODO Auto-generated method stub
		return false;
	}

}
