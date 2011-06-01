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
		private boolean validaForm(String nombre, String tag, String descripcion,
				String idUsuario){
			boolean valida = true;
			if (nombre == null || nombre.equals("")) {
				valida = false;
			}
			if (tag == null || tag.equals("0")) {
				valida = false;
			}
			if (descripcion == null || descripcion.equals("")) {
				valida = false;
			}
			if (idUsuario == null || idUsuario.equals("")) {
				valida = false;
			}
			return valida;
		}
		%>
	<%
		IPLeyProcessor pp = new PLeyProcessor();
		String nombre = request.getParameter("nombre");
		String tag = request.getParameter("tag");
		String descripcion = request.getParameter("descripcion");
		String idUsuario = request.getParameter("idUsuario");
		if (validaForm(nombre, tag, descripcion, idUsuario)) {
	%>
	<div>
		<%
			List<PLey> lista = pp.mostrarLeyes(tag); 
			for (PLey l : lista) {
		%>
				<p><% out.println(l.getNombre()); %> -&gt; <% out.println(l.getDescripcion()); %></p> 
			<%
			}
			%>
	</div>
	<%
		} else {
		%>
	<div>
		<form action="FrontController?res=addpropuestaley.jsp" method="post">
			<label for="nombre">Nombre</label> <input type="text" id="nombre"
				name="nombre"> <br> <label for="tag">Tag</label> <select
				id="tag" name="tag">
				<option selected="selected" value="0">Escoge tag</option>
				<%
					for (Tag t : pp.mostrarTags()) {
					%>
				<option value="<% out.println(t.getId()); %>">
					<% out.println(t.getNombre()); %>
				</option>
				<%
					}
					%>
			</select> <br> <label for="descripcion">Descripción</label>
			<textarea id="descripcion" name="descripcion" rows="5" cols="30"></textarea>
			<br> <input type="hidden" name="idUsuario"
				value="
				<%
				Usuario u = (Usuario)session.getAttribute("dd.usuario");
				out.println(u.getId());
				%>
				">
			<input type="submit" value="Enviar">
		</form>
	</div>
	<%
		}
	%>
</body>
</html>