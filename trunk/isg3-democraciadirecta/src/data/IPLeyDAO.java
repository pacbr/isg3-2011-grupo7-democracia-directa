package data;

import java.util.List;

import domain.PLey;
import domain.Tag;
import domain.Usuario;

public interface IPLeyDAO {

	List<PLey> getPLeyesByTags(List<Tag> tags);
	List<PLey> selectPLeyesByUser(Usuario user);
	List<PLey> selectPLeyesActivasByUser(Usuario user);
	List<PLey> selectPLeyesNoActivasByUser(Usuario user);
	boolean voto(PLey e);
	List<PLey> selectAll();
	PLey select(String idPley);
	boolean insert(PLey p);
	
	List<PLey> selectPLeyesActivas();
	boolean insertVoto(String idPLey);
	
	boolean insertMaxPositionList(String idPley, int posicionLista);
	boolean insertMinPositionList(String idPley, int posicionLista);
	boolean insertVisita(String idPley);
}