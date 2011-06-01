package data;

import java.util.List;

import domain.PLey;
import domain.Tag;

public interface IPLeyDAO {

	List<PLey> getPLeyesByTags(List<Tag> tags);
	boolean voto(PLey e);
	List<PLey> selectAll();
	
}