package data;

import java.util.List;

import domain.PLey;
import domain.Tag;
import domain.Usuario;

public interface IPLeyDAO {

	List<PLey> getPLeyesByTags(List<Tag> tags);
	List<PLey> getPLeyesByUser(Usuario user);
	List<PLey> getPLeyesActivasByUser(Usuario user);
	List<PLey> getPLeyesNoActivasByUser(Usuario user);
	boolean voto(PLey e);
	List<PLey> selectAll();
	PLey select(String idPley);
	boolean insert(PLey p);
	
}