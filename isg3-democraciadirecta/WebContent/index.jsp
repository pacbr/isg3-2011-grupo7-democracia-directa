<%@page import="data.JDBCPLeyDAO"%>
<%@page import="data.IPLeyDAO"%>
<%@ page language="java" import="java.util.*,domain.*" 
contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Democracia Directa</title>
<link rel="stylesheet" type="text/css" href="style/style.css" />
<style type="text/css">
<!--
	#all{
		font-family: Arial;
	}
	#arribaderecha{
		float:right;
	}
	#leyes{
		float:left;
	}
	#votos{
		align:right;
		font:Verdana;
		color:red;

	}
	#nombreleyes{
		font:Verdana;
		color:blue;
	}
	#aviso{
		align:right;
		font:Verdana;
		font-size:20px;
	}
-->
</style>
</head>
<body>
	<div id=all>
	<div id=leyes>
	<%
	if (session.getAttribute("dd.usuario") == null) {
		IPLeyDAO pd = new JDBCPLeyDAO();
		%>
		<table>
		<%
		for(PLey p:pd.selectAll()){
			%>
			<tr>
				<td id=votos><%out.println(p.getVotos()); %></td><td id=nombreleyes><%out.println(p.getNombre());%></td>
			</tr>
			<%
		}
	%>
	</table>
	</div>
		<form action="FrontController?res=index.jsp" method="post">
		<div id="usuario">
				<table summary="Identificación de Usuario" align="right">
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
					<tr>
						<td>Debes estar logueado para poder votar</td>
					</tr>
				</table>
		</div>
		<!--cierra arribaDcha -->
	</form>
	<%
	} else {
		Usuario u = (Usuario)session.getAttribute("dd.usuario");
	%>
		
			<div align="right">
			<a href="FrontController?res=logOut.jsp">Cerrar Sesion</a>
			</div>
			
			<div>
			Hola <% out.println(u.getNick()); %> 
			</div>
			<br> 
			<a href="FrontController?res=addpropuestaley.jsp">Añadir propuesta de ley</a>
			
		
		
		<p>
			<a href="FrontController?res=userTags.jsp">Modifica tus tags favoritos</a>
		</p>

		<p>
			<a href="FrontController?res=pleyesInteresantes.jsp">Propuestas de ley más interesantes en estos momentos</a>

		</p>
		<p>
			<a href="FrontController?res=recomendaciones.jsp">¿Quieres que te sugiera algo que votar?</a>
		</p>
	<%
	}
	%>
	</div>
</body>
</html>