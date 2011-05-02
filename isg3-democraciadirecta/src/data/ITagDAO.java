package data;

import java.util.List;

import domain.Tag;

public interface ITagDAO {
	
	Tag select(String idTag);
	List<Tag> selectAll();

}
