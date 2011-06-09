package domain;

public interface IProccesorUsuario {
	boolean votaPLey(PLey p, Usuario u);
	boolean pleyVotada(Usuario usuario, PLey pley);
}
