package domain;

import java.util.List;

public interface IProcessorUserTags {
	List<Tag> obtenerTop10();
	Tag obtenerTagPorNombre(String nombre);
	List<Tag> obtenerTagsActualesDeUsuario(Usuario u);
	boolean insertaUserTag(Tag t, Usuario u);
	boolean eliminaUserTag(Tag t, Usuario u);
}
