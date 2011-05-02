package domain;

import java.util.List;

public interface IPropuestaProcessor {
	boolean cancelPropuesta(String idPropuesta);
	boolean addPropuesta(Propuesta p);
	List<Tag> mostrarTags();
}
