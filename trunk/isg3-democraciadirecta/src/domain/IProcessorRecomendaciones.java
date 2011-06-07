package domain;

import java.util.List;

public interface IProcessorRecomendaciones {
	List<Tag> getFavoritos(Usuario u);
	List<Tag> getAllTags();
	Integer cuentaByTag(Tag t);
	List<PLey> getPleyByTag(List<Tag> t);

}
