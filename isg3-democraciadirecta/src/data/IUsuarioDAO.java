package data;

import domain.Usuario;

public interface IUsuarioDAO {

	Usuario select(String idUsuario);

	boolean valida(String nick, String passwd);

	Usuario select(String nick, String passwd);

}
