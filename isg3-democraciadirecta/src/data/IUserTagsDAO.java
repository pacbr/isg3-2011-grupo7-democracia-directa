package data;

import java.util.List;
import domain.*;

public interface IUserTagsDAO {
	
	List<Tag> getUserTags(String idUsuario);
	boolean insertaTagAUsuario(String idTag, String idUsuario);
	boolean eliminaTagDeUsuario(String idTag, String idUsuario);

}
