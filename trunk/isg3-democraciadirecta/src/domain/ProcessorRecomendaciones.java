package domain;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Iterator;
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
	public List<PLey> recomienda(boolean b, String idUsuario, Integer i, Integer j) 
	{
		System.out.println("i: "+i);
		System.out.println("j: "+j);
		System.out.println("idUsuario: "+idUsuario);
		System.out.println("boolean : "+b);
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
		
		/*
		 * De Aqui para Arriba funciona todo
		 */
//		System.out.println("minimo: "+min);
//		System.out.println("maximo: "+max);
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
			//A�ado la List<Pley> que he obtenido a una lista auxiliar que utilizo para saber 
			// el numero de veces que una Pley tiene asignado el Tag en cuestion
			for(PLey e : listaPleyesTagTodos)
			{
				listaPleysDeUnTagDeTodos.add(e);
			}
			//Dado el numero de apariciones del Tag en diferentes Pleyes lo almaceno en su correspondiente
			// posicion en el Map si existe, o creo la Key y luego lo almaceno
			Integer clave = listaPleysDeUnTagDeTodos.size()+1;
			if(mapaAux.containsKey(clave))
			{
				mapaAux.get(clave).add(t);
			}
			else
			{
				List<Tag> listClave = new ArrayList<Tag>();
				listClave.add(t);
				mapaAux.put(clave, listClave);
			}
		}
		//Calculo el numero de diferentes repeticiones posibles y los limites superior e inferior
		// por los cuales se filtraran los TAGs segun el porcentaje que haya elegido el Usuario
		Integer tamMapa = mapaAux.size()+1;
//		System.out.println("tama�oMapa Original "+tamMapa);
		Integer porcentajeMinimo = (min*tamMapa)/100;
		Integer porcentajeMaximo = (max*tamMapa)/100;
		//Evito que el porcentaje maximo sea 0
		if (porcentajeMaximo<1){
			porcentajeMaximo=1;
		}
		//Evito que el porcentaje minimo sea igual al porcentaje maximo
		if (porcentajeMinimo==porcentajeMaximo){
			porcentajeMinimo=porcentajeMaximo-1;
		}
		System.out.println("pMinimo: "+porcentajeMinimo);
		System.out.println("pMaximo: "+porcentajeMaximo);
		//Creo un mapa auxiliar y elimino los TAGs que no se encuentran dentro del 
		// porcentaje de TAGs deseado
		SortedMap<Integer,List<Tag>> mapaRes = new TreeMap<Integer, List<Tag>>(); 
		mapaRes.putAll(mapaAux);
		System.out.println("tama�o mapa a devolver antes: "+mapaRes.size());
		Integer principioMapa = 0;
		Integer finMapa = tamMapa;
		while(principioMapa<porcentajeMinimo){
			System.out.println("Eliminando: "+principioMapa);
			System.out.println("FirstKey: "+mapaRes.firstKey());
			mapaRes.remove(mapaRes.firstKey());
			principioMapa++;
			
		}
		System.out.println("tama�o mapa a devolver: "+mapaRes.size());
		
		while(finMapa>porcentajeMaximo){
			System.out.println("Eliminando: "+finMapa);
			System.out.println("FirstKey: "+mapaRes.lastKey());
			mapaRes.remove(mapaRes.lastKey());
			finMapa--;
		}
		System.out.println("tama�o mapa a devolver despues: "+mapaRes.size());
		//Genero una List<Tag> auxiliar en la que introducire ya si todos los Tags
		// para poder utilizar el metodo getPLeyesByTags que recibe una List<Tag>
		// y asi obtener la lista de Pleyes que mostrare al usuario
		List<Tag> resTags = new ArrayList<Tag>();
		
		//Obtengo de dentro del mapa cada List<Tag> que corresponde a cada Key y 
		// y almaceno dichos Tags en la Lista que pasare al metodo getPLeyesByTags
		Collection<List<Tag>> mapaValuesTags = mapaAux.values();
		for(List<Tag> e : mapaValuesTags)
		{
			for(Tag e2 : e)
			{
				resTags.add(e2);
			}
		}
		
		//Obtengo la lista de Tags favoritos del Usuario si el usuario quiere
		if(b)
		{
			//Obtengo la lista de Tags favoritos del Usuario 
			List<Tag> listafavoritos = u.getUserTags();
			
			//Obtengo la List<Pleys> de los Tags favoritos del Usuario y la almaceno
			// en la variable que devuelve el metodo
			List<PLey> lfavoritospley = pleyDAO.getPLeyesByTags(listafavoritos);
			for(PLey e : lfavoritospley)
			{
				if(!res.contains(e)){
					res.add(e);
				}
			}
		}
		
		
		//Obtengo la List<Pleys> de los Tags elegidos por porcentaje por el Usuario
		// y la almaceno en la variable que devuelve el metodo
		List<PLey> lfiltradospley = pleyDAO.getPLeyesByTags(resTags);
		for(PLey e : lfiltradospley)
		{
			if(!res.contains(e)){
				res.add(e);
			}
		}
		return res; 
	}

}
