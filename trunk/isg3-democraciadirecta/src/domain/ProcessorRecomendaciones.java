package domain;

import java.util.List;

import data.IPLeyDAO;
import data.ITagDAO;
import data.IUsuarioDAO;
import data.JDBCPLeyDAO;
import data.JDBCTagDAO;
import data.JDBCUsuarioDAO;

public class ProcessorRecomendaciones implements IProcessorRecomendaciones {
	private IPLeyDAO pleyDAO = new JDBCPLeyDAO();
	private IUsuarioDAO usuarioDAO = new JDBCUsuarioDAO();
	private ITagDAO tagDAO = new JDBCTagDAO();

	@Override
	public List<Tag> getFavoritos(Usuario u) {
		return usuarioDAO.selectTags(u);
	}

	@Override
	public List<Tag> getAllTags() {
		return tagDAO.selectAll();
	}

	@Override
	public Integer cuentaByTag(Tag t) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<PLey> getPleyByTag(List<Tag> tags) {
		return pleyDAO.getPLeyesByTags(tags);
	}
	

}
