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
	private IPLeyDAO pleyDAO = new JDBCPLeyDAO();
	private IUsuarioDAO usuarioDAO = new JDBCUsuarioDAO();
	private ITagDAO tagDAO = new JDBCTagDAO();	
	
	@Override
	public List<PLey> recomienda(boolean b, String idUsuario, Integer i, Integer j) 
	{
		Usuario usuario = usuarioDAO.select(idUsuario);		
		List<PLey> res = new ArrayList<PLey>();
		Integer min, max;
		if((max=i)<=(min=j))
		{
			min=i;
			max=j;
		}
		//Llamo al metodo getTagsByPorcentaje para que me devuelva la List<Tag> que se encuentra en ese %
		List<Tag> resTags = getTagsByPorcentaje(min, max);
		
		//Si el usuario lo ha pedido, obtengo la lista de Tags favoritos del Usuario 
		if(b)
		{
			List<Tag> listafavoritos = usuario.getUserTags();
			List<PLey> listpleysfavoritas = pleyDAO.getPLeyesByTags(listafavoritos);
			for(PLey e : listpleysfavoritas)
			{
				if(!res.contains(e)){
					res.add(e);
				}
			}
		}
		//Obtengo la List<PLey> de los Tags elegidos por porcentaje y devuelvo el resultado del método
		List<PLey> listpleyfiltradas = pleyDAO.getPLeyesByTags(resTags);
		for(PLey e : listpleyfiltradas)
		{
			if(!res.contains(e)){
				res.add(e);
			}
		}
		return res; 
	}
	public List<Tag> getTagsByPorcentaje(Integer min, Integer max)
	{
		//Quiero un mapa para almacenar <Integer numeroApariciones, List<TAGs> conEseNumeroDeApariciones>
		SortedMap<Integer,List<Tag>> mapaNumeroApariciones = new TreeMap<Integer, List<Tag>>(); 
		mapaNumeroApariciones.putAll(mapaDeAparicionesDeTags());
		//En base al numero de diferentes apariciones deseo calcular el porcentaje de TAGs que se encuentran dentro
		Integer principioMapa = 0;
		Integer finMapa = mapaNumeroApariciones.size();
		Integer porcentajeMinimo = (min*finMapa)/100;
		Integer porcentajeMaximo = (max*finMapa)/100;
		if (porcentajeMaximo<1)
		{ 
			porcentajeMaximo=1;
		}
		if (porcentajeMinimo==porcentajeMaximo)
		{
			porcentajeMinimo=porcentajeMaximo-1;
		}					
		//Creo un mapa auxiliar y elimino los TAGs que no se encuentran dentro del porcentaje de TAGs deseado
		SortedMap<Integer,List<Tag>> mapaRes = new TreeMap<Integer, List<Tag>>(); 
		mapaRes.putAll(mapaNumeroApariciones);
		while(principioMapa<porcentajeMinimo)
		{
			mapaRes.remove(mapaRes.firstKey());
			principioMapa++;
		}
		while(finMapa>porcentajeMaximo)
		{
			mapaRes.remove(mapaRes.lastKey());
			finMapa--;
		}													
		List<Tag> resTags = new ArrayList<Tag>();					//Genero una List<Tag> auxiliar en la que introducire ya si todos los Tags para poder utilizar el metodo getPLeyesByTags que recibe una List<Tag> y asi obtener la lista de Pleyes que mostrare al usuario
		Collection<List<Tag>> mapaValuesTags = mapaRes.values();	//Obtengo de dentro del mapa cada List<Tag> que corresponde a cada Key y almaceno dichos Tags en la Lista que pasare al metodo getPLeyesByTags
		for(List<Tag> e : mapaValuesTags)
		{
			for(Tag e2 : e)
			{
				if(!resTags.contains(e2))
				{
					resTags.add(e2);
				}
			}
		}
		return resTags;
	}
	public SortedMap<Integer,List<Tag>> mapaDeAparicionesDeTags(){
		SortedMap<Integer,List<Tag>> mapaNumeroApariciones = new TreeMap<Integer, List<Tag>>(); 
		
		List<Tag> listAllTags = tagDAO.selectAll();			
		for(Tag t : listAllTags)
		{ 
			List<Tag> listOneOfAllTags = new ArrayList<Tag>();
			listOneOfAllTags.add(t); 
			
			List<PLey> listNumeroApariciones = pleyDAO.getPLeyesByTags(listOneOfAllTags);
			//Integer numeroApariciones = listNumeroApariciones.size() del TAG
			Integer numeroApariciones = listNumeroApariciones.size();
			//Lo almaceno en el Map
			if(mapaNumeroApariciones.containsKey(numeroApariciones))
			{
				mapaNumeroApariciones.get(numeroApariciones).add(t);
			}
			else
			{
				List<Tag> listClave = new ArrayList<Tag>();
				listClave.add(t);
				mapaNumeroApariciones.put(numeroApariciones, listClave);
			}
	
		}
		return mapaNumeroApariciones;
	}
}
