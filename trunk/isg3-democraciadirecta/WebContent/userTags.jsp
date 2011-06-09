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
		font-family: Arial;
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
	String busca = request.getParameter("busca");
	String accion = request.getParameter("accion");
	ITagDAO tagDAO = new JDBCTagDAO();
	
	if(accion!=null){
		if(accion.compareTo("add")==0){
			proUserTags.insertaUserTag(tagDAO.select(tagid),usuario);
			response.sendRedirect("FrontController?res=userTags.jsp");
		}else if(accion.compareTo("delete")==0){
			proUserTags.eliminaUserTag(tagDAO.select(tagid),usuario);
			response.sendRedirect("FrontController?res=userTags.jsp");
	}
	}
	//IUsuarioDAO user = new JDBCUsuarioDAO();
	//user.select(usuario.getId());
	%>
<div id="all">	
	Hola <%out.println(usuario.getNombre()); %>  </p>
	<div id="favoritos">
		TAGS FAVORITOS
		<br>
		<table>
			<%for (Tag t : proUserTags.obtenerTagsActualesDeUsuario(usuario)) {%>
			<tr>
				<td><%out.println(t.getNombre());%></td><td><a href="FrontController?res=userTags.jsp?tagid=<%=t.getId()%>&accion=delete"> Eliminar </a> </td>
			</tr>
			<%}%>
		</table>
	</div>
	<div id="top10">
		TOP 10
		<br>
		<table>
			<%for (Tag t : proUserTags.obtenerTop10()) {%>
			<tr>
				<td>
					<%out.println(t.getNombre());%>
				</td>
				<td>
				<%if(!proUserTags.obtenerTagsActualesDeUsuario(usuario).contains(t)){%>
				<a href="FrontController?res=userTags.jsp?tagid=<%=t.getId()%>&accion=add"><img src='img/pack-plus.gif'></a>
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
	<form action="FrontController?res=userTags.jsp" method=post>
		<label>Buscar Tag </label>
		<input type="text" id="tagABuscar" name="busca">
		<input type="submit" value="busca">
	</form>
	<%if(busca!=null){
		if(proUserTags.obtenerTagPorNombre(busca)!=null){%>
		<div>
			Tag: <%=busca %><a href="FrontController?res=userTags.jsp?tagid=<%=proUserTags.obtenerTagPorNombre(busca).getId()%>&accion=add"><img src='img/pack-plus.gif'></a>
		</div>
		<%}else{%>
		<div>
			Nombre de tag no encontrado.
		</div>
		<% }%>
	<% }%>
	</div>
</div>
</body>
</html>