package domain;

import java.util.List;

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
		if (!usuarioDAO.select(u.getId()).getPleyesVotadas().contains(p.getId())){
			res = usuarioDAO.insertVoto(p.getId(), u.getId()) && pleyDAO.insertVoto(p.getId());
			u.getPleyesVotadas().add(p.getId());
			p.setVotos(p.getVotos()+1);
		}
		return res;
	}

	@Override
	public boolean pleyVotada(Usuario usuario, PLey pley) {
		List<String> lista = usuarioDAO.select(usuario.getId()).getPleyesVotadas();
		return lista.contains(pley.getId());
	}

}
