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
	IProccesorUsuario up = new ProccesorUsuario();
	Usuario usuario = (Usuario)session.getAttribute("dd.usuario");
	PLey pley;
	pley = pp.obtenerPLeyPorId(request.getParameter("idPLey"));
	PLey sessionPley = pley;
	
			
			session.setAttribute("session.PLey", sessionPley);
			if (request.getParameter("votar") != null && request.getParameter("votar").equals("ok")) {
				sessionPley = (PLey)session.getAttribute("session.PLey");
				//if (up.votaPLey(sessionPley,usuario)) {
					//out.println("VOTADA CORRECTAMENTE");
				//} else {
					//out.println("HA HABIDO UN ERROR AL VOTAR");
				//}
			}else{
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
							<form action="FrontController?res=muestraPLey.jsp?votar=ok" method="post"><input type="submit" value="VOTAR">
					
							</form>
						</td>
					</tr>
					<tr valign ="middle" align="center" id="votos">
						<td colspan="3" align="center">
							<%out.println("(Votos: "+pley.getVotos()+")"); %>
						</td>
					</tr>
					<%
			}
			%>
			
		</table>
	</fieldset>
	
</body>
</html>