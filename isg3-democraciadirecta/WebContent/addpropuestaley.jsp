<%@ page language="java" import="java.util.*,domain.*"
	contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Democracia Directa</title>
<style type="text/css">
<!--
	
	body{
		width:700px;
		font-family: Arial;
		margin:auto;
	}
	h1{
		text-align:center;
	}
	h5{
		text-align:center;

	}
	h5 a{
		color: #039;
	}
	.exito {
		color: #33ff00;
		font-size: 20px;
		text-align: center;
	}
	.error {
		color: red;
		font-size: 20px;
		text-align: center;
	}
	.one-column-emphasis{
		font-family: "Lucida Sans Unicode", "Lucida Grande", Sans-Serif;
		font-size: 12px;
		margin: 10px;
		width: 680px;
		text-align: left;
		border-collapse: collapse;
	}
	.one-column-emphasis th{
		text-align:center;
		font-size: 14px;
		font-weight: normal;
		padding: 12px 15px;
		color: #039;
	}
	.one-column-emphasis td{
		text-align:center;
		padding: 10px 15px;
		color: #669;
		border-top: 1px solid #e8edff;
	}
	.oce-first{
		background: #d0dafd;
		border-right: 10px solid transparent;
		border-left: 10px solid transparent;
	}
	.oce-top{
		background: #dddddd;
		border-right: 10px solid transparent;
		border-left: 10px solid transparent;
	}
	.one-column-emphasis tr:hover td{
		color: #339;
		background: #eff2ff;
	}
	
-->
</style>
</head>
<body>
	<div>
		<h1>AÑADIR PROPUESTA DE LEY</h1>
		<h5><a href="FrontController?res=index.jsp">Volver a la página principal</a></h5>
	</div>
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
	 		p.setMaxPosicionLista(0);
	 		p.setMinPosicionLista(0);
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
				<table class="one-column-emphasis">
				<tr>
				<td width="50%">PLey</td>
				<td width="50%">% Coincidencia Tags</td>
				</tr>
				<%
				for (PLey l : mapa.keySet()) {
				%>
					<tr>
					<td width="80%" class="oce-first">
						<a href="FrontController?res=muestraPLey.jsp?idPLey=<% out.println(l.getId()); %>">
						<% out.println(l.getNombre()); %>
						</a>
					</td>
					<td width="20%">
						<% out.println(mapa.get(l)+"%"); %>
					</td>
					</tr> 
			<%
				}
			}
			%>
			</table>
			<p align="center">
			<input type="button" value="Continuar" onclick="window.location='FrontController?res=addpropuestaley.jsp?continuar=ok'">
			 | 
			<input type="button" value="Cancelar" onclick="window.location='FrontController?res=index.jsp'">
			</p>
		</div>
	<%
	} else if (request.getParameter("continuar") != null && request.getParameter("continuar").equals("ok")) {
		sessionPLey = (PLey)session.getAttribute("session.PLey");
		if (pp.insertaPLey(sessionPLey)) {
			out.println("<p class='exito'>PLey insertada con éxito.</p>");
		} else {
			out.println("<p class='error'>Error al insertar la PLey.</p>");
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