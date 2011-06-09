package domain;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.SortedMap;
import java.util.TreeMap;

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
	public List<PLey> recomienda(String s, Integer i, Integer j) {
		//ESTO ESTA BIEN
		Usuario u = usuarioDAO.select(s);		
		List<PLey> res = new ArrayList<PLey>();
		Integer min, max;
		if((max=i)<=(min=j)){
			min=i;
			max=j;
		}	
		List<Tag> listafavoritos = u.getUserTags();
		//ESTO ESTA BIEN
		
		List<Tag> listaTodos = tagDAO.selectAll();
		SortedMap<Integer,Tag> mapaAux = new TreeMap<Integer, Tag>();
		for(Tag t : listaTodos){
			List<Tag> listaUnTagDeTodos = new ArrayList<Tag>();
			listaUnTagDeTodos.add(t);
			List<PLey> listaPleysDeUnTagDeTodos = new ArrayList<PLey>();
			
			//El addAllFalla1
			//listaPleysDeUnTagDeTodos.addAll(pleyDAO.getPLeyesByTags(listaUnTagDeTodos)); 
			List<PLey> listaPleyesTagTodos = pleyDAO.getPLeyesByTags(listaUnTagDeTodos);
			for(PLey e : listaPleyesTagTodos){
				listaPleysDeUnTagDeTodos.add(e);
			}
			//El addAllFalla1
			
			mapaAux.put((listaPleysDeUnTagDeTodos.size()+1), t);	
		}
		Integer tamMapa = mapaAux.size()+1;
		Integer porcentajeMinimo = (min*tamMapa)/100;
		Integer porcentajeMaximo = (max*tamMapa)/100;
		SortedMap<Integer,Tag> mapaRes = new TreeMap<Integer, Tag>();
		mapaRes.putAll(mapaAux.subMap(porcentajeMinimo, porcentajeMaximo));
		List<Tag> resTags = new ArrayList<Tag>();
		
		//El addAllFalla2
		//resTags.addAll(mapaRes.values()); 
		Collection<Tag> mapaValuesTags =  mapaRes.values();
		for(Tag e : mapaValuesTags){
			resTags.add(e);
		}
		//El addAllFalla2

		
		//El addAllFalla3
		//res.addAll(pleyDAO.getPLeyesByTags(resTags));
		List<PLey> lfiltradospley = pleyDAO.getPLeyesByTags(resTags);
		for(PLey e : lfiltradospley){
			res.add(e);
		}
		//El addAllFalla3
		
		
		//ESTO ESTA BIEN
//		List<PLey> lfavoritospley = pleyDAO.getPLeyesByTags(listafavoritos);
//		for(PLey e : lfavoritospley){
//			res.add(e);
//		}
		return res;
		//ESTO ESTA BIEN
	}

}
