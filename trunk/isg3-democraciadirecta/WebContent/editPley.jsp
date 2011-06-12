<%@ page language="java" import="java.util.*,domain.*"  
	contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Editar pley</title>
<link rel="stylesheet" type="text/css" href="style/style.css" />
<style type="text/css">
<!--
#advertencia{
color:red;
font-size: large;
}
#vueltaAUsuario{
text-align: center;
}

-->
</style>
</head>
<body>
	<%
	Usuario usuario = (Usuario) session.getAttribute("dd.usuario");
	IPLeyProcessor pp = new PLeyProcessor();
	PLey sessionPley = pp.obtenerPLeyPorId(request.getParameter("idPLey"));
	
	if(!(sessionPley.getUsuario().getId().equals(usuario.getId()))){
		out.println("No tienes permisos para editar esta propuesta");
	}else{
		if(request.getParameter("accion").equals("delete")){
			if(sessionPley.getVotos()>10){
				out.println("No puedes borrar la propuesta, ya tiene más de 10 votos asignados.");
			}else{
				if(request.getParameter("confirmar").equals("yes")){
					if(pp.borrarPLey(sessionPley)){
						out.println("Eliminada correctamente.");
					}else{
						out.println("Hubo un error al eliminarla.");
					}
				}else{
					%><div id="advertencia"><b>
					¿Estás seguro de querer eliminar completamente: "
					<u><%=sessionPley.getNombre()%></u>"?
					
					<br>
					<input type="button" value="Continuar" onclick="window.location='FrontController?res=editPley.jsp?idPLey=<%=sessionPley.getId()%>&accion=delete&confirmar=yes'">
					<input type="button" value="Cancelar" onclick="window.location='FrontController?res=usuario.jsp'">
					</b></div><%
					}
				}
			}
		else{
			if(request.getParameter("accion").equals("edit")){
				if(request.getParameter("confirmar").equals("yes")){
					if(pp.editarPLey(sessionPley)){
						out.println("Todavía no se ha editado, falta crear metodos");
						out.println("Editada correctamente.");
					}else{
						out.println("Todavía no se ha editado, falta crear metodos");
						out.println("Hubo un error al editarla.");
					}
				}else{
				%><div id="advertencia"><b>
				¿VAS A EDITAR LA PLEY: "
				<u><%=sessionPley.getNombre()%></u>"?
				</b></div>
				<div>
				<form action="FrontController?res=addpropuestaley.jsp" method="post">
						<label for="nombre">Nombre</label>
						<br>
						<input type="text" id="nombre" name="nombre" size=40 value="<%=sessionPley.getNombre()%>">
						<br> 
						<label for="descripcion">Descripción</label>
						<br>
						<textarea id="descripcion" name="descripcion" rows="5" cols="40"><%=sessionPley.getDescripcion()%>
						</textarea>
						<br>
						<input type="button" value="Continuar" onclick="window.location='FrontController?res=editPley.jsp?idPLey=<%=sessionPley.getId()%>&accion=edit&confirmar=yes'">
						<input type="button" value="Cancelar" onclick="window.location='FrontController?res=usuario.jsp'">
				</form>
 				</div>
				
				<%
				}
			}
		}
	}
		
	%>
	<div id="vueltaAUsuario">
	<a href="FrontController?res=usuario.jsp">Volver al perfil</a>
	</div>
</body>
</html>