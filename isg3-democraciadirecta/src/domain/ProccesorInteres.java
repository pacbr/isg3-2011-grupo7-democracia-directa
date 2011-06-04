package domain;

import java.util.ArrayList;
import java.util.List;
import java.util.SortedMap;
import java.util.TreeMap;

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
	public SortedMap<Integer,List<PLey>> getPleysInteresantesByUser(Usuario user) {
		Integer interesUsuario = new Integer(0);
		Integer interesLey = new Integer (0);
		SortedMap<Integer, List<PLey>> mapaPleyes = new TreeMap<Integer, List<PLey>>();
		List<PLey> pleyesActivas = pleyDAO.getPLeyesActivasByUser(user);
		List<PLey> pleyesNoActivas = pleyDAO.getPLeyesNoActivasByUser(user);
		for(PLey p:pleyesNoActivas){
			interesUsuario+=p.getVotos();
		}
		interesUsuario =(int)(interesUsuario*0.25);		
		for(PLey p:pleyesActivas){
			interesLey = p.getVotos()+interesUsuario;
			if(mapaPleyes.containsKey(interesLey)){
				mapaPleyes.get(interesLey).add(p);
			}else{
				List<PLey> lista = new ArrayList<PLey>();
				lista.add(p);
				mapaPleyes.put(interesLey, lista);
			}
			
		}
		return mapaPleyes;
	}

	@Override
	public Integer getInteresByUser(Usuario user) {
		Integer interesUsuario = new Integer(0);
		List<PLey> pleyesNoActivas = pleyDAO.getPLeyesNoActivasByUser(user);
		for(PLey p:pleyesNoActivas){
			interesUsuario+=p.getVotos();
		}
		interesUsuario =(int)(interesUsuario*0.25);
		return interesUsuario;
	}

	@Override
	public List<PLey> getPleysNoActivasByUser(Usuario user) {
		List<PLey> pleyesNoActivas = pleyDAO.getPLeyesNoActivasByUser(user);
		return pleyesNoActivas;
	}
	
	
	
}
