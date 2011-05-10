package data;

import domain.Propuesta;

public interface IPropuestaDAO {

	Propuesta select(String idPropuesta);
	
	Propuesta delete(Propuesta p);
	
	Propuesta edit(Propuesta p);
	
	
	
}
