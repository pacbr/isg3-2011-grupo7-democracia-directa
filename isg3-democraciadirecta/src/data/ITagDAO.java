package data;

import java.sql.Connection;
import java.util.List;

import domain.Tag;

public interface ITagDAO {
	
	Tag select(Connection con, Integer idTag);
	List<Tag> selectAll();

}
