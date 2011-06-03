package domain;

import java.util.List;
import java.util.Map;

public interface IProccesorInteres {
	List<Usuario> getUsers();
	Map<PLey,Integer> getPleysInteresantesByUser(Usuario user);
}
