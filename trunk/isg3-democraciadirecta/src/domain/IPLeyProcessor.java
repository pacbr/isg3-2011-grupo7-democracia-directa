package domain;

import java.util.List;
import java.util.Map;

public interface IPLeyProcessor {
	List<Tag> obtenerTags();
	Tag obtenerTagPorId(String idTag);
	Map<PLey, String> obtenerCoincidencias(PLey p);
	boolean insertaPLey(PLey p);
	PLey obtenerPLeyPorId(String id);
	
}