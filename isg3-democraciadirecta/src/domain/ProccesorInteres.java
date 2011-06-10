package domain;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.SortedMap;
import java.util.TreeMap;

import data.IPLeyDAO;
import data.JDBCPLeyDAO;

public class ProccesorInteres implements IProccesorInteres{
	private IPLeyDAO pleyDAO = new JDBCPLeyDAO();
		
	@Override
	public Integer getInteresUsuario(Usuario u) {
		Integer interesUsuario= new Integer(0);
		List<PLey> pleyesNoActivas = pleyDAO.selectPLeyesNoActivasByUser(u);
		for(PLey p:pleyesNoActivas){
			interesUsuario +=p.getVotos();
		}
		interesUsuario = (int)(interesUsuario*0.25);
		return interesUsuario;
	}

	@Override
	public int getMovimientoEnLista(PLey p, int actualPos) {
		int valor=2;
		if((p.getMaxPosicionLista()==0)&&(p.getMinPosicionLista()==0)){
			setNewMaxPositionOnList(p,actualPos);
			setNewMinPositionOnList(p,actualPos);
		}else{
			if(p.getVotos()>10){
				if(p.getMaxPosicionLista()<actualPos){
					if(p.getMinPosicionLista()<actualPos){
						setNewMinPositionOnList(p,actualPos);
					}
					valor = -1;
				}else{
					if(p.getMaxPosicionLista()>actualPos){
						setNewMaxPositionOnList(p, actualPos);
						valor = 1;
					}else{
						if(p.getMaxPosicionLista()<p.getMinPosicionLista()){
							/*MAX = posActual
							 ...
							 MIN*/
							valor=1;
						}else{		
							/*
							MAX = MIN = posActual
							 */
							valor = 0;
						}
					}
				}
			}
		}
		return valor;
	}
				
	@Override
	public void setNewMaxPositionOnList(PLey p, int posicionLista) {
		p.setMaxPosicionLista(posicionLista);
		pleyDAO.insertMaxPositionList(p.getId(),posicionLista);
	}
	
	@Override
	public void setNewMinPositionOnList(PLey p, int posicionLista) {
		p.setMinPosicionLista(posicionLista);
		pleyDAO.insertMinPositionList(p.getId(),posicionLista);
	}

	@Override
	public SortedMap<Integer,List<PLey>> creaMapaPLeyes() {
		SortedMap<Integer,List<PLey>> mapaPleyesOrdenadas = new TreeMap<Integer,List<PLey>>();
		Map<Usuario,Integer> mapaInteresUsuarios = new HashMap<Usuario,Integer>();
		List<PLey> pleyesActivas = pleyDAO.selectPLeyesActivas();
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
}
