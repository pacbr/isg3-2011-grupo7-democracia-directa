<%@ page language="java" import="java.util.*,domain.*"  
	contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Pley</title>
</head>
<body>
	<%
	IPLeyProcessor pp = new PLeyProcessor();
	PLey pley;
	pley = pp.obtenerPLeyPorId(request.getParameter("idPLey"));
	%>
	<fieldset>
		<legend
			style="font-family: Arial, sans-serif; font-size: 18px; color: #660000"><%=pley.getNombre() %></legend>
		<table summary="PLey" align="center">
			
			<%out.println("Autor: "+pley.getUsuario().getNick()); %>
			
			<tr valign ="middle" align="center" id="descripcion">
				<td>&nbsp;</td><td><em>Descripción</em>
			</tr>
			<tr valign ="middle" align="center" id="descripcion">
				<td></td>	<td> <%out.println(pley.getDescripcion());%> </td>	
			</tr>
			<tr valign ="middle" align="center" id="votar">
				<td colspan="3" align="center">
					<form action="" method="post"><input type="submit" value="VOTAR">
					</form>
				</td>
			</tr>
			<tr valign ="middle" align="center" id="votos">
				<td colspan="3" align="center">
					<%out.println("(Votos: "+pley.getVotos()+")"); %>
				</td>
			</tr>
			
		</table>
	</fieldset>
	
</body>
</html>