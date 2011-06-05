<%@ page language="java" import="java.util.*,domain.*" 
contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Democracia Directa</title>
</head>
<body>
	<div>
	<%
	if (session.getAttribute("dd.usuario") == null) {
	%>
		<form action="FrontController?res=index.jsp" method="post">
		<div id="arribaDcha">
			<fieldset>
				<legend
					style="font-family: Arial, sans-serif; font-size: 18px; color: #660000">Datos
					de Usuario</legend>
				<table summary="Identificación de Usuario" align="center">
					<tr>
						<td>Nombre de Usuario:</td>
						<td><input type="text" name="user" />
						</td>
					</tr>
					<tr>
						<td>Contraseña:</td>
						<td><input type="password" name="passwd" />
						</td>
					</tr>
					<tr>
						<td colspan="3" align="center"><input type="submit"
							value="ENTRAR" /></td>
					</tr>
				</table>
			</fieldset>
		</div>
		<!--cierra arribaDcha -->
	</form>
	<%
	} else {
		Usuario u = (Usuario)session.getAttribute("dd.usuario");
	%>
		<p>
			Hola <% out.println(u.getNick()); %> <a href="FrontController?res=logOut.jsp">Cerrar Sesion</a> 
			<br> 
			<a href="FrontController?res=addpropuestaley.jsp">Añadir propuesta de ley</a>
			
		</p>
		
		<p>
			<a href="FrontController?res=userTags.jsp">Modifica tus tags favoritos</a>
		</p>
		<p>
			<a href="FrontController?res=pleyesInteresantes.jsp">Propuestas de ley más interesantes en estos momentos</a>

		</p>
	<%
	}
	%>
	</div>
</body>
</html>