package domain;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
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
		List<PLey> pleyesActivas = pleyDAO.selectPLeyesActivasByUser(user);
		List<PLey> pleyesNoActivas = pleyDAO.selectPLeyesNoActivasByUser(user);
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
		List<PLey> pleyesNoActivas = pleyDAO.selectPLeyesNoActivasByUser(user);
		for(PLey p:pleyesNoActivas){
			interesUsuario+=p.getVotos();
		}
		interesUsuario =(int)(interesUsuario*0.25);
		return interesUsuario;
	}

	@Override
	public List<PLey> getPleysNoActivasByUser(Usuario user) {
		List<PLey> pleyesNoActivas = pleyDAO.selectPLeyesNoActivasByUser(user);
		return pleyesNoActivas;
	}

	@Override
	public List<PLey> getPLeysActivas() {
		return pleyDAO.selectPLeyesActivas();
	}

	@Override
	public Integer getInteresUsuario(Usuario u) {
		Integer interesUsuario=0;
		List<PLey> pleyesNoActivas = pleyDAO.selectPLeyesNoActivasByUser(u);
		for(PLey p:pleyesNoActivas){
			interesUsuario +=p.getVotos();
		}
		interesUsuario = (int)(interesUsuario*0.25);
		return interesUsuario;
	}

	@Override
	public int getLastPositionOnList(PLey p, int actualPos) {
		int valor=2;
		if(p.getPosicionLista()<actualPos && p.getPosicionLista()>0){
			valor=-1;
		}else{
			if(p.getPosicionLista()>actualPos){
				valor=1;
			}else{
				if(p.getPosicionLista()==actualPos){
					valor=0;
				}
			}
		}
		return valor;
	}
		
	@Override
	public void setNewPositionOnList(PLey p, int posicionLista) {
		p.setPosicionLista(posicionLista);
		pleyDAO.insertPositionList(p.getId(),posicionLista);
	}

	@Override
	public SortedMap<Integer,List<PLey>> creaMapaPLeyes(List<PLey> pleyesActivas) {
		
		SortedMap<Integer,List<PLey>> mapaPleyesOrdenadas = new TreeMap<Integer,List<PLey>>();
		Map<Usuario,Integer> mapaInteresUsuarios = new HashMap<Usuario,Integer>();
		Integer interesUsuario;
		
		for(PLey p:pleyesActivas){
			if(!mapaInteresUsuarios.containsKey(p.getUsuario())){
				mapaInteresUsuarios.put(p.getUsuario(),getInteresUsuario(p.getUsuario()));
			}
			interesUsuario=mapaInteresUsuarios.get(p.getUsuario())+p.getVotos();
			if(!mapaPleyesOrdenadas.containsKey(interesUsuario)){
				List<PLey> listaInteres = new ArrayList<PLey>();
				listaInteres.add(p);
				mapaPleyesOrdenadas.put(interesUsuario,listaInteres);
			}else{
				mapaPleyesOrdenadas.get(interesUsuario).add(p);
			}
		}
		return mapaPleyesOrdenadas;
	}
	
	public boolean prueba (PLey p){
		return pleyDAO.insert(p);
	}
	
	
}
