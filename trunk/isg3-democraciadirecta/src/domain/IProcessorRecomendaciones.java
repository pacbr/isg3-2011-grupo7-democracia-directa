package domain;

import java.util.List;

public interface IProcessorRecomendaciones {

	List<PLey> recomienda(boolean b, String idUsuario, Integer i, Integer j);

}
