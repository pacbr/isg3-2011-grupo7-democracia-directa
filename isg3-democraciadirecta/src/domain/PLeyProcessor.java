package domain;

import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import data.IPLeyDAO;
import data.ITagDAO;
import data.IUsuarioDAO;
import data.JDBCPLeyDAO;
import data.JDBCTagDAO;
import data.JDBCUsuarioDAO;

public class PLeyProcessor implements IPLeyProcessor{
	
	private ITagDAO tagDAO = new JDBCTagDAO();
	private IPLeyDAO pleyDAO = new JDBCPLeyDAO();
	private IUsuarioDAO userDAO = new JDBCUsuarioDAO();
	
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

	@Override
	public List<PLey> getPLeyesPorUsuario(Usuario u) {
		return pleyDAO.selectPLeyesByUser(u);
	}

	@Override
	public List<PLey> getPLeyesVotadasPorUsuario(Usuario u) {
		List<PLey> lista = new ArrayList<PLey>();
		Usuario user = userDAO.select(u.getId());
		for(String id:user.getPleyesVotadas()){
			lista.add(obtenerPLeyPorId(id));
		}
		return lista;
	}

	@Override
	public boolean borrarPLey(PLey p) {
		int tamInicial;
		for(Usuario u:userDAO.selectAll()){
			tamInicial = u.getPleyesVotadas().size();
			u.getPleyesVotadas().remove(p.getId());
			if(tamInicial>(u.getPleyesVotadas().size())){
				userDAO.updatePleyesVotadas(u);
			}
		}
		return pleyDAO.deletePley(p.getId());
	}
	
	@Override
	public boolean editarPLey(PLey p) {
		return pleyDAO.updatePley(p);
	}

	@Override
	public boolean validaForm(String nombre, List<Tag> tags, String descripcion, Usuario usuario) {
		boolean valida = true;
		if (nombre == null || nombre.equals("")) {
			valida = false;
		}
		if (tags.size() == 0) {
			valida = false;
		}
		if (descripcion == null || descripcion.equals("")) {
			valida = false;
		}
		if (usuario == null) {
			valida = false;
		}
		return valida;
	}
}
