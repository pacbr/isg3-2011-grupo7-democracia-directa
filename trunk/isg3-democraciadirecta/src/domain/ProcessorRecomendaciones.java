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
//		System.out.println("idUsuario: "+idUsuario);
//		System.out.println("boolean : "+b);
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
//		System.out.println("Cuantos tags hay? "+listaTodos.size());
		//Creo el Mapa en el que almacenare un numero de repeticiones dado
		// y los tags que se han repetido ese numero de veces
		SortedMap<Integer,List<Tag>> mapaAux = new TreeMap<Integer, List<Tag>>(); 
		Integer contador = 0;
		//Uso el for para filtrar 
		for(Tag t : listaTodos)
		{
//			System.out.println("contador: "+contador);
//			contador++;
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
			Integer clave = listaPleysDeUnTagDeTodos.size()+1;
			System.out.println("El Tag: "+t.getNombre() +" ha aparecido en "+clave+" leyes");
			if(mapaAux.containsKey(clave))
			{
				mapaAux.get(clave).add(t);
			}
			else
			{
				List<Tag> listClave = new ArrayList<Tag>();
				listClave.add(t);
				mapaAux.put(clave, listClave);
//				System.out.println("Como la clave: "+clave+" no esta en el mapa, la agrego");
			}
//			System.out.println("tamaño mapaAux: "+mapaAux.size());

		}
		//Calculo el numero de diferentes repeticiones posibles y los limites superior e inferior
		// por los cuales se filtraran los TAGs segun el porcentaje que haya elegido el Usuario
		Integer tamMapa = mapaAux.size();
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
		System.out.println("tamaño mapa de Int,List<Tag> devolver antes: "+mapaRes.size()+1);
		Integer principioMapa = 0;
		Integer finMapa = tamMapa;
		while(principioMapa<porcentajeMinimo){
			System.out.println("FirstKey: "+mapaRes.firstKey());
			mapaRes.remove(mapaRes.firstKey());
			principioMapa++;
			
		}
		System.out.println("tamaño mapa a devolver: "+mapaRes.size()+1);
		
		while(finMapa>porcentajeMaximo){
			System.out.println("LastKey: "+mapaRes.lastKey());
			mapaRes.remove(mapaRes.lastKey());
			finMapa--;
		}
		System.out.println("tamaño mapa a devolver despues: "+mapaRes.size()+1);
		//Genero una List<Tag> auxiliar en la que introducire ya si todos los Tags
		// para poder utilizar el metodo getPLeyesByTags que recibe una List<Tag>
		// y asi obtener la lista de Pleyes que mostrare al usuario
		List<Tag> resTags = new ArrayList<Tag>();
		
		//Obtengo de dentro del mapa cada List<Tag> que corresponde a cada Key y 
		// y almaceno dichos Tags en la Lista que pasare al metodo getPLeyesByTags
		Collection<List<Tag>> mapaValuesTags = mapaRes.values();
		System.out.println("tamaño mapaValuesTags "+mapaValuesTags.size()+1);
		System.out.println("tamaño mapaAux "+mapaAux.size()+1);
		for(List<Tag> e : mapaValuesTags)
		{
			for(Tag e2 : e)
			{
				if(!resTags.contains(e2)){
					resTags.add(e2);
				}
				
			}
		}
		
		//Obtengo la lista de Tags favoritos del Usuario si el usuario quiere
		if(b)
		{
			//Obtengo la lista de Tags favoritos del Usuario 
			List<Tag> listafavoritos = u.getUserTags();
			
			//Obtengo la List<Pleys> de los Tags favoritos del Usuario y la almaceno
			// en la variable que devuelve el metodo
			List<PLey> listpleysfavoritas = pleyDAO.getPLeyesByTags(listafavoritos);
			System.out.println("Tamaño listpleysfavoritas " +listpleysfavoritas.size()+1);
			for(PLey e : listpleysfavoritas)
			{
				if(!res.contains(e)){
					res.add(e);
				}
			}
		}
		
		
		//Obtengo la List<Pleys> de los Tags elegidos por porcentaje por el Usuario
		// y la almaceno en la variable que devuelve el metodo
		List<PLey> listpleyfiltradas = pleyDAO.getPLeyesByTags(resTags);
		System.out.println("Tamaño listpleyfiltradas " +listpleyfiltradas.size()+1);
		System.out.println("Tamaño de resTags " +resTags.size()+1);
		for(PLey e : listpleyfiltradas)
		{
			if(!res.contains(e)){
				res.add(e);
			}
		}
		System.out.println("Tamaño de RES " +res.size()+1);
		return res; 
	}

}
