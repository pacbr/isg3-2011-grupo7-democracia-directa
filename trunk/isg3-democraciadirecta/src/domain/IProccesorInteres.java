package domain;

import java.util.List;
import java.util.SortedMap;

public interface IProccesorInteres {
	Integer getInteresUsuario(Usuario u);
	int getMovimientoEnLista(PLey p, int actualPos);
	void setNewMaxPositionOnList(PLey p, int posicionLista);
	void setNewMinPositionOnList(PLey p, int posicionLista);
	SortedMap<Integer,List<PLey>> creaMapaPLeyes();	
}
