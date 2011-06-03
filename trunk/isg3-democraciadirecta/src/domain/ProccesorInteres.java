package domain;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import data.IPLeyDAO;
import data.IUsuarioDAO;
import data.JDBCPLeyDAO;
import data.JDBCUsuarioDAO;

public class ProccesorInteres implements IProccesorInteres{
	private IPLeyDAO pleyDAO = new JDBCPLeyDAO();
	private IUsuarioDAO usuarioDAO = new JDBCUsuarioDAO();
		
	@Override
	public List<Usuario> getUsers() {
		return usuarioDAO.selectAll();
	}

	@Override
	public Map<PLey, Integer> getPleysInteresantesByUser(Usuario user) {
		Integer interesUsuario = new Integer(0);
		Map<PLey,Integer> mapaPleyes = new HashMap<PLey,Integer>();
		List<PLey> pleyesActivas = pleyDAO.getPLeyesActivasByUser(user);
		List<PLey> pleyesNoActivas = pleyDAO.getPLeyesNoActivasByUser(user);
		for(PLey p:pleyesNoActivas){
			interesUsuario+=p.getVotos();
		}
		interesUsuario =(int)(interesUsuario*0.25);
		for(PLey p:pleyesActivas){
			mapaPleyes.put(p, (p.getVotos()+interesUsuario));
		}
		return mapaPleyes;
	}
	
	
	
}
