package data;

import java.util.List;

import domain.Ley;

public interface ILeyDAO {

	List<Ley> selectByTag(String idTag);
	
}