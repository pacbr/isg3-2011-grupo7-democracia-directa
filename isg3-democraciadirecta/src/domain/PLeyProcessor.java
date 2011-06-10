package domain;

import java.text.DecimalFormat;
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
	public Map<PLey, String> obtenerCoincidencias(PLey p) {
		Map<PLey, String> mapa = new HashMap<PLey, String>();
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
			Double key = 0.0;
			if (p1.getTags().size() <= p.getTags().size()) {
				key = (double)coincidencias/p.getTags().size();
			} else if (p1.getTags().size() > p.getTags().size()) {
				key = (double)coincidencias/p1.getTags().size();
			}
			key = key*100;
			DecimalFormat df = new DecimalFormat();
			df.setMaximumFractionDigits(0);
			String porcentaje = df.format(key);
			mapa.put(p1, porcentaje);
		}
		return mapa;
	}
	
	@Override
	public boolean insertaPLey(PLey p) {
		return pleyDAO.insert(p);
	}
	
	@Override
	public List<Tag> obtenerTags() {
		return tagDAO.selectAll();
	}
	
	@Override
	public Tag obtenerTagPorId(String idTag) {
		return tagDAO.select(idTag);
	}
	@Override
	public PLey obtenerPLeyPorId(String id) {
		return pleyDAO.select(id);
	}
	@Override
	public List<PLey> obtenerTodasPleyes() {
		return pleyDAO.selectAll();
	}

	@Override
	public boolean nuevaVisita(PLey pley) {
		return pleyDAO.insertVisita(pley.getId());
	}
}
