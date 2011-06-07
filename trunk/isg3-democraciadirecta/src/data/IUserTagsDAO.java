package data;

import java.util.Set;

import domain.*;

public interface IUserTagsDAO {
	
	Set<Tag> getUserTags(String idUsuario);
	boolean insertaTagAUsuario(Tag t, String idUsuario);

}
