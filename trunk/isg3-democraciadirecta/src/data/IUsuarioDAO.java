package data;

import java.util.List;

import domain.Tag;
import domain.Usuario;

public interface IUsuarioDAO {

	Usuario select(String idUsuario);
	
	List<Usuario> selectAll();
	
	boolean valida(String nick, String passwd);

	Usuario select(String nick, String passwd);
	
	boolean insertVoto(String idPLey, String idUsuario);

	boolean updatePleyesVotadas(Usuario u);
	
}
