package domain;

import java.util.List;

public interface IProcessorUserTags {
	List<Tag> obtenerTop10();
	Tag obtenerTagPorNombre(String nombre);
	Tag obtenerTagPorId(String id);
	List<PLey> obtenerLeyesConTagDeUsuario(Usuario u);
	List<Tag> obtenerTagsActualesDeUsuario(Usuario u);
	boolean insertaUserTag(Tag t, Usuario u);
	boolean eliminaUserTag(Tag t, Usuario u);
}
