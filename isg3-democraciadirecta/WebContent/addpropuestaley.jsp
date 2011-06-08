<%@ page language="java" import="java.util.*,domain.*"
	contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Democracia Directa</title>
</head>
<body>
 	<%!
	private boolean validaForm(String nombre, List<Tag> tags, String descripcion,
			Usuario usuario){
		boolean valida = true;
		if (nombre == null || nombre.equals("")) {
			valida = false;
		}
		if (tags.size() == 0) {
			valida = false;
		}
		if (descripcion == null || descripcion.equals("")) {
			valida = false;
		}
		if (usuario == null) {
			valida = false;
		}
		return valida;
	}
	%>
	<%
	IPLeyProcessor pp = new PLeyProcessor();
	String nombre = request.getParameter("nombre");
	String[] idTags = request.getParameterValues("tags");
	String descripcion = request.getParameter("descripcion");
	List<Tag> tags = new ArrayList<Tag>();
	if (idTags != null) {
		for (String s : idTags) {
			tags.add(pp.obtenerTagPorId(s));
		}
	}
	Usuario usuario = (Usuario)session.getAttribute("dd.usuario");
	PLey sessionPLey = null;
	if (validaForm(nombre, tags, descripcion, usuario)) {
	%>
		<div>
	 		<%
			PLey p = new PLey();
	 		p.setId(""+System.currentTimeMillis());
	 		p.setNombre(nombre);
	 		p.setTags(tags);
	 		p.setDescripcion(descripcion);
	 		p.setUsuario(usuario);
	 		p.setVotos(0);
	 		p.setActiva(true);
	 		p.setPosicionLista(0);
	 		p.setVisitas(0);
	 		sessionPLey = p;
	 		session.setAttribute("session.PLey", sessionPLey);
			Map<PLey,String> mapa = pp.obtenerCoincidencias(p);
			if (mapa.size() == 0) {
			%>
				<p>No hay ninguna PLey con coincidencia de tags.</p>
			<%
			} else {
			%>
				<table width="50%"><tr><td width="50%">PLey</td><td width="50%">% Coincidencia Tags</td></tr>
				<%
				for (PLey l : mapa.keySet()) {
				%>
					<tr>
					<td>
						<a href="FrontController?res=muestraPLey.jsp?idPLey=<% out.println(l.getId()); %>">
						<% out.println(l.getNombre()); %>
						</a>
					</td>
					<td>
						<% out.println(mapa.get(l)+"%"); %>
					</td>
					</tr> 
			<%
				}
			}
			%>
			</table>
			<a href="FrontController?res=addpropuestaley.jsp?continuar=ok">Continuar</a> | <a href="FrontController?res=index.jsp">Cancelar</a>
		</div>
	<%
	} else if (request.getParameter("continuar") != null && request.getParameter("continuar").equals("ok")) {
		sessionPLey = (PLey)session.getAttribute("session.PLey");
		if (pp.insertaPLey(sessionPLey)) {
			out.println("PLey insertada con éxito.");
		} else {
			out.println("Error al insertar la PLey.");
		}
	} else {
	%>
		<div>
			<form action="FrontController?res=addpropuestaley.jsp" method="post">
				<label for="nombre">Nombre</label>
				<br>
				<input type="text" id="nombre" name="nombre">
				<br> 
				<label for="tags">Tags</label>
				<br>
				<select multiple name="tags" size="5">
					<%
					for (Tag t : pp.obtenerTags()) {
					%>
						<option value="<% out.println(t.getId()); %>">
						<% out.println(t.getNombre()); %>
						</option>
					<%
					}
					%>
				</select> 
				<br>
				<label for="descripcion">Descripción</label>
				<br>
				<textarea id="descripcion" name="descripcion" rows="5" cols="30"></textarea>
				<br>
				<input type="submit" value="Enviar">
			</form>
 		</div>
	<%
	}
	%>
</body>
</html>