package data;

import java.util.List;

import domain.*;

public interface IUserTagsDAO {
	
	List<Tag> getUserTags(Usuario u);
	

}
