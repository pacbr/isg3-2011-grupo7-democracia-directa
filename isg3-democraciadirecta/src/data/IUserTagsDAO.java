package data;

import java.util.Set;

import domain.*;

public interface IUserTagsDAO {
	
	Set<Tag> getUserTags(String idUsuario);
	boolean insertaTagAUsuario(String idTag, String idUsuario);
	boolean eliminaTagDeUsuario(String idTag, String idUsuario);

}
