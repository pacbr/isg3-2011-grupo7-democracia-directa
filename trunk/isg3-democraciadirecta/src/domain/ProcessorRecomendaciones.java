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

public class ProcessorRecomendaciones implements IProcessorRecomendaciones 
{
	//Atributos
	private IPLeyDAO pleyDAO = new JDBCPLeyDAO();
	private IUsuarioDAO usuarioDAO = new JDBCUsuarioDAO();
	private ITagDAO tagDAO = new JDBCTagDAO();
	
	@Override
	public List<PLey> recomienda(String idUsuario, Integer i, Integer j) 
	{
		//A partir de la idUsuario obtengo el nick del Usuario
		Usuario u = usuarioDAO.select(idUsuario);		
		//Creo la lista de Pleyes que devuelve el metodo
		List<PLey> res = new ArrayList<PLey>();
		//Diferencio entre el porcentaje maximo y el minimo que ha pedido el Usuario
		Integer min, max;
		if((max=i)<=(min=j))
		{
			min=i;
			max=j;
		}
		//Obtengo la lista de Tags favoritos del Usuario 
		List<Tag> listafavoritos = u.getUserTags();
		
		/*
		 * De Aqui para Arriba funciona
		 */
		
		//Obtengo la lista de todos los Tags que existen
		List<Tag> listaTodos = tagDAO.selectAll();
		//Creo el Mapa en el que almacenare un numero de repeticiones dado
		// y los tags que se han repetido ese numero de veces
		SortedMap<Integer,List<Tag>> mapaAux = new TreeMap<Integer, List<Tag>>(); 
		
		//Uso el for para filtrar 
		for(Tag t : listaTodos)
		{
			//Genero la lista de Pleyes que devolvere en las que aparecen los TAGs que se 
			// encuentren en el porcentaje deseado por el Usuario  
			List<PLey> listaPleysDeUnTagDeTodos = new ArrayList<PLey>();
			
			//Genero una List<Tag> auxiliar en la que introduzco unicamente un Tag
			// para poder utilizar el metodo getPLeyesByTags que recibe una List<Tag>
			List<Tag> listaUnTagDeTodos = new ArrayList<Tag>();
			listaUnTagDeTodos.add(t); 
			List<PLey> listaPleyesTagTodos = pleyDAO.getPLeyesByTags(listaUnTagDeTodos);
			//Añado la List<Pley> que he obtenido a una lista auxiliar que utilizo para saber 
			// el numero de veces que una Pley tiene asignado el Tag en cuestion
			for(PLey e : listaPleyesTagTodos)
			{
				listaPleysDeUnTagDeTodos.add(e);
			}
			//Dado el numero de apariciones del Tag en diferentes Pleyes lo almaceno en su correspondiente
			// posicion en el Map si existe, o creo la Key y luego lo almaceno
			if(mapaAux.containsKey(listaPleysDeUnTagDeTodos.size()+1))
			{
				mapaAux.get(listaPleysDeUnTagDeTodos.size()+1).add(t);
			}
			else
			{
				List<Tag> auxMultiSet = new ArrayList<Tag>();
				auxMultiSet.add(t);
				mapaAux.put(listaPleysDeUnTagDeTodos.size()+1, auxMultiSet);
			}
		}
		//Calculo el numero de diferentes repeticiones posibles y los limites superior e inferior
		// por los cuales se filtraran los TAGs segun el porcentaje que haya elegido el Usuario
		Integer tamMapa = mapaAux.size()+1;
		Integer porcentajeMinimo = (min*tamMapa)/100;
		Integer porcentajeMaximo = (max*tamMapa)/100;
		SortedMap<Integer,List<Tag>> mapaRes = new TreeMap<Integer, List<Tag>>();
		//Creo un Submap con los Tags que se encuentren en el porcentaje que el Usuario pidio 
		mapaRes.putAll(mapaAux.subMap(porcentajeMinimo, porcentajeMaximo));
		
		//Genero una List<Tag> auxiliar en la que introducire ya si todos los Tags
		// para poder utilizar el metodo getPLeyesByTags que recibe una List<Tag>
		// y asi obtener la lista de Pleyes que mostrare al usuario
		List<Tag> resTags = new ArrayList<Tag>();
		
		//Obtengo de dentro del mapa cada List<Tag> que corresponde a cada Key y 
		// y almaceno dichos Tags en la Lista que pasare al metodo getPLeyesByTags
		Collection<List<Tag>> mapaValuesTags = mapaRes.values();
		for(List<Tag> e : mapaValuesTags)
		{
			for(Tag e2 : e)
			{
				resTags.add(e2);
			}
		}
		
		//Obtengo la List<Pleys> de los Tags elegidos por porcentaje por el Usuario
		// y la almaceno en la variable que devuelve el metodo
		List<PLey> lfiltradospley = pleyDAO.getPLeyesByTags(resTags);
		for(PLey e : lfiltradospley)
		{
			res.add(e);
		}
		
		//Obtengo la List<Pleys> de los Tags favoritos del Usuario y la almaceno
		// en la variable que devuelve el metodo
		List<PLey> lfavoritospley = pleyDAO.getPLeyesByTags(listafavoritos);
		for(PLey e : lfavoritospley)
		{
			res.add(e);
		}

		return res; 
	}

}
