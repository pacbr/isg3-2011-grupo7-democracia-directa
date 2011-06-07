<%@ page language="java" import="java.util.*,domain.*,data.*" 
	contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Democracia Directa - User Tags</title>
<link rel="stylesheet" type="text/css" href="style/style.css" />
<style type="text/css">
<!--
	#favoritos td{
		background-color: rgb(238, 238, 238);
	}
  	#top10 td{
		padding: 5px;
		font-size: 14px;
		background-color: #83aec0;
		background-repeat: repeat-x;
		color: #FFFFFF;
		border-right-width: 1px;
		border-bottom-width: 1px;
		border-right-style: solid;
		border-bottom-style: solid;
		border-right-color: #558FA6;
		border-bottom-color: #558FA6;
		font-family: Arial;
		text-transform: uppercase;
	}
	#all{
		width:500px;
	}
	#top10{
		float:right;
	}
	#favoritos{
		float:left;
	}
	#buscador{float:left;}
-->
</style>
</head>
<body>
	
	<%
	IProcessorUserTags proUserTags = new ProcessorUserTags();
	Usuario usuario = (Usuario)session.getAttribute("dd.usuario");
	String tagid = request.getParameter("tagid");
	
	//IUsuarioDAO user = new JDBCUsuarioDAO();
	//user.select(usuario.getId());
	%>
<div id="all">	
	Hola <%out.println(usuario.getNombre()); %>  </p>
	<div id="favoritos">
		TAGS FAVORITOS
		<br>
		<table>
			<tr>
				<th>FAVORITOS</th>
			</tr>
			<%
			for (Tag t : usuario.getUserTags()) {
			%>
			<tr>
				<td><%out.println(t.getNombre());%></td><td><a href="FrontController?res=userTags.jsp?tagid=<%=t.getId()%>"> Eliminar </a> </td>
			</tr>
			<%
			}
			%>
		</table>
	</div>
	<div id="top10">
		TOP 10
		<br>
		<table>
			<%
			for (Tag t : proUserTags.obtenerTop10()) {
			%>
			<tr>
				<td>
					<%out.println(t.getNombre());%>
				</td>
				<td>
				<%
				if(!usuario.getUserTags().contains(t)){
				%>
				<a href="FrontController?res=addUserTag.jsp?tagid=<%=t.getId()%>"><img src='img/pack-plus.gif'></a>
				<%
				}else{	
				%>
				
				</td>
				<%
				}
				%>
			</tr>
			<%
			}
			%>
		</table>
	</div>
	<div id="buscador">
	<form>
		<label>Buscar Tag </label>
		<input type="text" id="tagABuscar" name="tag">
		<input type="submit" value="Buscar">
	</form>
	</div>
</div>
</body>
</html>