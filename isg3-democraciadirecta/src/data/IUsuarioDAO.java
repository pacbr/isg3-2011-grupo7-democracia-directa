package data;

import java.util.List;

import domain.Tag;
import domain.Usuario;

public interface IUsuarioDAO {

	Usuario select(String idUsuario);
	
	boolean add(Usuario u);
	
	Usuario delete(Usuario u);

	boolean valida(String nick, String passwd);

	Usuario select(String nick, String passwd);
	
	List<Tag> selectTags(Usuario user);
	
	boolean addTag(Tag t);
	
	Tag deleteTag(Tag t);
	
	

}