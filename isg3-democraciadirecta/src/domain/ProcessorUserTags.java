package domain;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeSet;

import data.IPLeyDAO;
import data.ITagDAO;
import data.JDBCPLeyDAO;
import data.JDBCTagDAO;

public class ProcessorUserTags implements IProcessorUserTags{
	ITagDAO tagDAO = new JDBCTagDAO();
	IPLeyDAO pleyDAO = new JDBCPLeyDAO();
	
	@Override
	public List<Tag> obtenerTop10() {
//		Map<Tag,Integer> mapTagVotos = new HashMap<Tag, Integer>();
//		for(PLey p:pleyDAO.selectAll()){
//			for(Tag t:p.getTags()){
//			//TODO Separar los tags de una pley
//				if(!mapTagVotos.containsKey(t)){
//					mapTagVotos.put(t, 1);
//				}else{
//					mapTagVotos.put(t, mapTagVotos.get(t)+1);
//				}
//			}
//		}
//		LinkedHashMap<Tag, Integer> mapResultado = new LinkedHashMap<Tag, Integer>();
//		List<Tag> misMapKeys = new ArrayList<Tag>(mapTagVotos.keySet());
//		List<Integer> misMapValues = new ArrayList<Integer>(mapTagVotos.values());
//		TreeSet<Integer> conjuntoOrdenado = new TreeSet<Integer>(misMapValues);
//		Integer[] arrayOrdenado = (Integer[]) conjuntoOrdenado.toArray();
//		int size = arrayOrdenado.length;
//		for (int i=0; i<size; i++) {
//			mapResultado.put(misMapKeys.get(misMapValues.indexOf(arrayOrdenado[i])),arrayOrdenado[i]);
//		}
//		//TODOJOSE seleccionar 10 primeras comparando con pleyes
//		List<Tag> lista = new ArrayList<Tag>();
//		for(Tag t:mapResultado.keySet()){
//			lista.add(t);
//			System.out.println(t.getId());
//		}
//		return lista;
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
