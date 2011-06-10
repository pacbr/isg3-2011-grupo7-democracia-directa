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
		font-family:Helvetica;
		margin:auto;
		float: inherit;
		width:1100px;
	}
	#all h1{
		text-align:center;
	}
	#arribaderecha{
		float:right;
	}
	.leyes{
		float:left;
		padding: 10px;
		width: 650px;
	}
	.leyes td{
		padding:5px;
	}
	.leyes thead{
		font-weight: bold;
	}
	.votos{
		font-weight:bold;
		text-align:right;
		text-size:20px;
		border-right-color: black;
		border-right-style: solid;
		border-right-width: 2px;
	}
	.nombreleyes a{
		color:#dd7777;
	}
	.nombreleyes a{
		color:#dd7777;
	}
	#aviso{
		align:right;
		font-size:20px;
	}
	#cierra{
		font-weight:bold;
		padding:10px;
		font-size:15px;
		text-align:right;
	}
	#cierra a{
		padding-left:15px;
		font-size:10px;
		text-align:right;
	}
	#menuderecha{
		border:medium;
		border-color:black;
		float:right;
		text-align: right;
	}
	#options {
		 margin: auto;
	}
	#options a{
		color:#669;
	}
	#options td{
		text-align:center;
		padding: 7px;
		color: #669;
		border: 1px solid #e8edff;
		background: #eff2ff;
	}
	#floatderecha{
		float:right;
	}
	#usuario td{
		padding:3px;
	}
	.tagsdeleyes{
		font-size: 10px;
	}
-->
</style>
</head>
<body>
	<div id=all>
		<h1>DEMOCRACIA DIRECTA</h1>
		
		<%if (session.getAttribute("dd.usuario") == null) {
			IPLeyDAO pd = new JDBCPLeyDAO();
		%>
		<div class=leyes>
			<table>
				<thead>
					<td>Votos</td><td>Leyes</td>
				</thead>
				<tbody>
					<%for(PLey p:pd.selectAll()){%>
					<tr>
						<td class="votos"><%out.println(p.getVotos()); %></td><td class="nombreleyes"><%out.println(p.getNombre());%>  <span class="tagsdeleyes"> &nbsp;&nbsp;&nbsp;[<%for(Tag t : p.getTags()){out.println(t.getNombre());}%>]</span></td>
					</tr>
					<%}%>
				</tbody>
			</table>
		</div>
	<div id="floatderecha">
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
						<td colspan="2" align="center"><input type="submit"
							value="ENTRAR" /></td>
					</tr>
					<tr>
						<td colspan="2" align="center">Debes hacer login para poder votar</td>
					</tr>
				</table>
		</div>
		<!--cierra arribaDcha -->
		</form>
	</div>
	<%
	} else {
		Usuario u = (Usuario)session.getAttribute("dd.usuario");
	%>
		<div class=leyes>
		<%IProcessorUserTags proUserTags = new ProcessorUserTags();%>
			<table>
				<thead>
					<td>Votos</td><td>Leyes</td>
				</thead>
				<tbody>
					<%for(PLey p:proUserTags.obtenerLeyesConTagDeUsuario(u)){%>
					<tr>
						<td class="votos"><%out.println(p.getVotos()); %></td><td class="nombreleyes"><a href="FrontController?res=muestraPLey.jsp?idPLey=<%=p.getId()%>"><%out.println(p.getNombre());%> </a> <span class="tagsdeleyes"> &nbsp;&nbsp;&nbsp;[<%for(Tag t : p.getTags()){out.println(t.getNombre());}%>]</span></td>
					</tr>
					<%}%>
				</tbody>
			</table>
		</div>
		<div id="menuderecha">
			<div id="cierra">
				Usuario: <% out.println(u.getNombre()); %> <a href="FrontController?res=logOut.jsp">Cerrar Sesion</a>
			</div>
		
			<div id="options">
				<table>
					<tbody>
						<tr>
							<td><a href="FrontController?res=addpropuestaley.jsp">Añade propuesta de ley</a></td>
						</tr>
						<tr>
							<td><a href="FrontController?res=userTags.jsp">Tags favoritos</a></td>
						</tr>
						<tr>
							<td><a href="FrontController?res=pleyesInteresantes.jsp">Propuestas más interesantes</a></td>					
						</tr>
						<tr>
							<td><a href="FrontController?res=recomendaciones.jsp">¿Te sugiero algo que votar?</a></td>					
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	<%}%>
	</div>
</body>
</html>