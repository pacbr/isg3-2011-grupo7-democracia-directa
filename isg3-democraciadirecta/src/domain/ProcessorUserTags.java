package domain;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import data.IPLeyDAO;
import data.ITagDAO;
import data.IUserTagsDAO;
import data.IUsuarioDAO;
import data.JDBCPLeyDAO;
import data.JDBCTagDAO;
import data.JDBCUserTagsDAO;
import data.JDBCUsuarioDAO;

public class ProcessorUserTags implements IProcessorUserTags{
	ITagDAO tagDAO = new JDBCTagDAO();
	IPLeyDAO pleyDAO = new JDBCPLeyDAO();
	IUsuarioDAO usuarioDAO = new JDBCUsuarioDAO();
	IUserTagsDAO userTagsDAO = new JDBCUserTagsDAO();
	
	
	@Override
	public List<Tag> obtenerTop10() {
		List<Tag> arraytags = new ArrayList<Tag>();
		List<Tag2> arraytags2 = new ArrayList<Tag2>();
		
		for(Tag t:tagDAO.selectAll()){
			arraytags2.add(new Tag2(Integer.parseInt(t.getId())));
		}
		
		for(PLey p:pleyDAO.selectAll()){
			for(Tag t:p.getTags()){
				for(Tag2 t2:arraytags2){
					if(t.getId().compareTo(t2.getId().toString())==0){
						t2.aumentaApariciones();
					}
				}
			}
				
		}
		Collections.sort(arraytags2);
		int i =1;
		for(Tag2 t2:arraytags2){
				if(i<=10)
				arraytags.add(tagDAO.select(t2.getId().toString()));
				i++;
		}
		return arraytags;
	}
	
	@Override
	public Tag obtenerTagPorNombre(String nombre) {
		Tag res = null;
		for(Tag t:tagDAO.selectAll()){
			if(t.getNombre().compareTo(nombre)==0)
				res = tagDAO.select(t.getId());
		}
		return res;
	}

	@Override
	public Tag obtenerTagPorId(String id) {
		return tagDAO.select(id);
	}
	
	@Override
	public List<Tag> obtenerTagsActualesDeUsuario(Usuario u) {
		Usuario user = usuarioDAO.select(u.getId());
		return user.getUserTags();
	}

	@Override
	public boolean insertaUserTag(Tag t, Usuario u) {
		return userTagsDAO.insertaTagAUsuario(t.getId(), u.getId());
	}

	@Override
	public boolean eliminaUserTag(Tag t, Usuario u) {
		return userTagsDAO.eliminaTagDeUsuario(t.getId(), u.getId());
	}
	
	@Override
	public List<PLey> obtenerLeyesConTagDeUsuario(Usuario u) {
		List<PLey> lp = new ArrayList<PLey>();
		for(PLey p : pleyDAO.selectAll()){
			for(Tag tagdepley : p.getTags()){
				for(Tag tagdeusuario : usuarioDAO.select(u.getId()).getUserTags()){
					if(tagdepley.getId().compareTo(tagdeusuario.getId())==0 && lp.contains(p)==false)
						lp.add(p);
				}	
			}
		}
		return lp;
	}

private class Tag2 implements Comparable<Tag2>{
		
		Integer id;
		Integer apariciones=0;
		public Tag2(Integer id){
			this.id=id;
		}
		public Integer getId() {
			return id;
		}
		
		public void aumentaApariciones(){
			this.apariciones++;
		}
		public Integer getApariciones(){
			return this.apariciones;
		}
		@Override
		public int compareTo(Tag2 o) {
			//Se ordenan de mayor a menor
			return o.getApariciones() - this.getApariciones() ;
		}
		
	}
}
