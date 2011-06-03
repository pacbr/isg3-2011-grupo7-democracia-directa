package domain;

import java.util.List;

public interface IProccesorUserTags {
	List<Tag> obtenerTop10();
	Tag obtenerTagPorId(String idTag);
	List<Tag> obtenerTagsActualesDeUsuario();
	boolean insertaUserTag(Tag t);
}
