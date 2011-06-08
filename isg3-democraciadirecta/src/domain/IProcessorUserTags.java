package domain;

import java.util.List;

public interface IProcessorUserTags {
	List<Tag> obtenerTop10();
	Tag obtenerTagPorId(String idTag);
	List<Tag> obtenerTagsActualesDeUsuario(Usuario u);
	boolean insertaUserTag(Tag t, Usuario u);
	boolean eliminaUserTag(Tag t, Usuario u);
}
