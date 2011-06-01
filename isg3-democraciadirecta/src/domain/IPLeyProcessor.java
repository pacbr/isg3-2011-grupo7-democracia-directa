package domain;

import java.util.Map;

public interface IPLeyProcessor {
	Map<PLey, Integer> obtenerCoincidencias(PLey p);
	boolean insertaPLey(PLey p);
}
