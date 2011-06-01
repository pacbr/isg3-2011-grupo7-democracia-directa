package domain;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import data.IPLeyDAO;
import data.ITagDAO;
import data.JDBCPLeyDAO;
import data.JDBCTagDAO;

public class PLeyProcessor implements IPLeyProcessor{
	
	private ITagDAO tagDAO = new JDBCTagDAO();
	private IPLeyDAO pleyDAO = new JDBCPLeyDAO();
	
	@Override
	public Map<PLey, Double> obtenerCoincidencias(PLey p) {
		Map<PLey, Double> mapa = new HashMap<PLey, Double>();
		List<PLey> lista = pleyDAO.getPLeyesByTags(p.getTags());
		for (PLey p1 : lista) {
			Integer coincidencias = 0;
			for (Tag t : p.getTags()) {
				for (Tag t1 : p1.getTags()) {
					if (t1.equals(t)) {
						coincidencias++;
					}
				}
			}
			Double key = (double)coincidencias/p.getTags().size();
			//Penalización
			if (p1.getTags().size() > coincidencias) {
				key = key - ((double)(p1.getTags().size()-coincidencias)/100);
			}
			mapa.put(p1, key);
		}
		return mapa;
	}
	@Override
	public boolean insertaPLey(PLey p) {
		// TODO Auto-generated method stub
		return false;
	}
	@Override
	public List<Tag> obtenerTags() {
		return tagDAO.selectAll();
	}
	@Override
	public Tag obtenerTagPorId(String idTag) {
		return tagDAO.select(idTag);
	}

}
