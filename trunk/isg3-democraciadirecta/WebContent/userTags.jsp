<%@ page language="java" import="java.util.*,domain.*,data.*" 
	contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Democracia Directa - User Tags</title>
<link rel="stylesheet" type="text/css" href="style/style.css" />
<style type="text/css">
<!--
	
	#all{
		width:700px;
		font-family: Arial;
		margin:auto;
	}
	#all h1{
		text-align:center;
	}
	#all h5{
		text-align:center;

	}
	#all h5 a{
		color: #039;
	}
	#top10{
		float:right;
	}
	#favoritos{
		float:left;
		font-size:14px;
		font-family:Helvetica;
	}
	#buscador{
		margin:auto;
		width:600px;
		margin-top:0px;
		padding:20px;
		text-align:center;
	}
	#found{
		padding:20px;
		font-family:Helvetica;
	}
	.one-column-emphasis{
		font-family: "Lucida Sans Unicode", "Lucida Grande", Sans-Serif;
		font-size: 12px;
		margin: 10px;
		width: 300px;
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
	
	<%
	IProcessorUserTags proUserTags = new ProcessorUserTags();
	Usuario usuario = (Usuario)session.getAttribute("dd.usuario");
	String tagid = request.getParameter("tagid");
	String busca = request.getParameter("busca");
	String accion = request.getParameter("accion");
	
	
	if(accion!=null){
		if(accion.compareTo("add")==0){
			proUserTags.insertaUserTag(proUserTags.obtenerTagPorId(tagid),usuario);
			//response.sendRedirect("FrontController?res=userTags.jsp");
		}else if(accion.compareTo("delete")==0){
			proUserTags.eliminaUserTag(proUserTags.obtenerTagPorId(tagid),usuario);
			//response.sendRedirect("FrontController?res=userTags.jsp");
		}
	}
	
	%>
<div id="all">	
	<h1>Tags de <%out.println(usuario.getNombre()); %></h1>
	<h5><a href="FrontController?res=index.jsp">Volver a la página principal</a></h5>
	<div id="buscador">
	<form action="FrontController?res=userTags.jsp" method=post>
		<label>Buscar Tag </label>
		<input type="text" id="tagABuscar" name="busca">
		<input type="submit" value="Buscar">
	</form>
	<%if(busca!=null){
		if(proUserTags.obtenerTagPorNombre(busca)!=null){%>
		<div id="found">
			<%=busca %> <a href="FrontController?res=userTags.jsp?tagid=<%=proUserTags.obtenerTagPorNombre(busca).getId()%>&accion=add"><img src='img/iconadd.gif'></a>
		</div>
		<%}else{%>
		<div>
			Nombre de tag no encontrado.
		</div>
		<% }%>
	<% }%>
</div>
	
	<div id="favoritos">
		<table class="one-column-emphasis">
			<thead>  
	            <tr>  
	                <th scope="col" id="headertabla">Tags Favoritos</th>  
	            </tr>  
	        </thead>  
	        <tfoot>  
            <tr>  
                  <td></td><td></td> 
            </tr>  
        	</tfoot>  
			<%for (Tag t : proUserTags.obtenerTagsActualesDeUsuario(usuario)) {%>
			<tr>
				<td class=oce-first><%out.println(t.getNombre());%></td><td><a href="FrontController?res=userTags.jsp?tagid=<%=t.getId()%>&accion=delete"><img src='img/iconrem.gif'></a></td>
			</tr>
			<%}%>
		</table>
	</div>
	
	<div id="top10">
		<table class="one-column-emphasis">
			<thead>  
	            <tr>  
	                <th scope="col" id="headertabla">Top 10</th>  
	            </tr>  
	        </thead>  
	        <tfoot>  
            <tr>  
                  <td></td><td></td> 
            </tr>  
        	</tfoot>  
			<%for (Tag t : proUserTags.obtenerTop10()) {%>
			<tr>
				<td class="oce-top">
					<%out.println(t.getNombre());%>
				</td>
				<td>
				<%if(!proUserTags.obtenerTagsActualesDeUsuario(usuario).contains(t)){%>
					<a href="FrontController?res=userTags.jsp?tagid=<%=t.getId()%>&accion=add"><img src='img/iconadd.gif'></a>
				<%}else{%>
				</td>
				<%}%>
			</tr>
			<%}%>
		</table>
	</div>
	
	
</div>


</body>
</html>