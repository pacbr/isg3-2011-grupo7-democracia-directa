package domain;

import java.util.List;
import java.util.SortedMap;

public interface IProccesorInteres {
	List<Usuario> getUsers();
	SortedMap<Integer, List<PLey>> getPleysInteresantesByUser(Usuario user);
	Integer getInteresByUser(Usuario user);
	List<PLey> getPleysNoActivasByUser(Usuario user);
}
