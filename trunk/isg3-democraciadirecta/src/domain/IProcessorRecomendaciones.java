package domain;

import java.util.List;
import java.util.SortedMap;

public interface IProcessorRecomendaciones {

	public List<PLey> recomienda(boolean b, String idUsuario, Integer i, Integer j);
	public List<Tag> getTagsByPorcentaje(Integer min, Integer max);
	SortedMap<Integer,List<Tag>> mapaDeAparicionesDeTags();

}
