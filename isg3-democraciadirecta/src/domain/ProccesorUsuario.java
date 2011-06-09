package domain;

import data.IPLeyDAO;
import data.IUsuarioDAO;
import data.JDBCPLeyDAO;
import data.JDBCUsuarioDAO;

public class ProccesorUsuario implements IProccesorUsuario{
IUsuarioDAO usuarioDAO = new JDBCUsuarioDAO();
IPLeyDAO pleyDAO = new JDBCPLeyDAO();
	
	@Override
	public boolean votaPLey(PLey p, Usuario u){
		boolean res = false;
		res = usuarioDAO.insertVoto(p.getId(), u.getId());
		res = res && pleyDAO.insertVoto(p.getId());
		return res;
	}

	@Override
	public boolean pleyVotada(Usuario usuario, PLey pley) {
		// TODO PACO
		return false;
	}
}
