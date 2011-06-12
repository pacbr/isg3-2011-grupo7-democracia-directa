package domain;

import java.util.List;
import java.util.Map;

public interface IPLeyProcessor {
	List<Tag> obtenerTags();
	Tag obtenerTagPorId(String idTag);
	Map<PLey, String> obtenerCoincidencias(PLey p);
	boolean insertaPLey(PLey p);
	PLey obtenerPLeyPorId(String id);
	public List<PLey> obtenerTodasPleyes();
	boolean nuevaVisita(PLey pley);
	List<PLey> getPLeyesPorUsuario(Usuario u);
	List<PLey> getPLeyesVotadasPorUsuario(Usuario u);
	boolean borrarPLey(PLey p);
	boolean editarPLey(PLey p);
	boolean validaForm(String nombre, List<Tag> tags, String descripcion,Usuario usuario);
}
