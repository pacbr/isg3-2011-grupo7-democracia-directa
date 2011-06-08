package domain;

import java.util.List;

public interface IProcessorUserTags {
	List<Tag> obtenerTop10();
	Tag obtenerTagPorId(String idTag);
	List<Tag> obtenerTagsActualesDeUsuario(String idUsuario);
	boolean insertaUserTag(String idTag, String idUsuario);
}
