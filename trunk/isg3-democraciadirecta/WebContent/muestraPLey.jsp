<%@ page language="java" import="java.util.*,domain.*"  
	contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<%
	IPLeyProcessor pp = new PLeyProcessor();
	PLey pley;
	pley = pp.obtenerPLeyPorId(request.getParameter("idPLey"));
	%>
	<table summary ="Listado de Productos" cellSpacing="1" cellPadding="6" width="770" align="center" border="0">
	<tr valign ="middle" align="center">
		<td id = "colchones" colspan="6"><b><%out.println(pley.getNombre()); %></b></td>
	</tr>
	<tr valign ="middle" align="center" id="cabecera">
	<td>&nbsp;</td><td><em>Descripción</em></td><td><em>Usuario</em></td><td><em>Votos</em></td>
	<tr align="center" id="productos">
				<td></td>	<td> <%out.println(pley.getDescripcion());%> </td>	<td> <%out.println(pley.getUsuario().getNombre()); %></td>	<td> <%out.println(pley.getVotos()); %></td>
				
	</tr>
		<tr align="center" id="productos">
				<td></td>	<td> <form action="" method="post">
				<div>
				<input type="submit" value="VOTAR"> </td>	
				
			    
	</tr>
		
	</tr>
	
	<% %>
	
</body>
</html>