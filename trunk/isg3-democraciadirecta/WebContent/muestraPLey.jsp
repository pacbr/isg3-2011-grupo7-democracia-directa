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
	
	Usuario usuario = (Usuario)session.getAttribute("dd.usuario");
	

	
			
			
			if (request.getParameter("votar") != null && request.getParameter("votar").equals("ok")) {
				PLey sessionPley;
				sessionPley = (PLey)session.getAttribute("session.PLey");
				IProccesorUsuario up = new ProccesorUsuario();
				
				if(up.votaPLey(sessionPley, usuario)){
					out.println("Tu voto para la propuesta de ley: '"+sessionPley.getNombre()+"' se ha realizado correctamente");
				} else {
					out.println("HA HABIDO UN ERROR AL VOTAR");
				}
				
			}else{
				IProccesorUsuario up = new ProccesorUsuario();
				PLey pley;
				pley = pp.obtenerPLeyPorId(request.getParameter("idPLey"));
				PLey sessionPley = pley;
				session.setAttribute("session.PLey", sessionPley);
				
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
					<tr valign ="middle" align="center" id="votos">
						<td colspan="3" align="center">
							<%out.println("(Votos: "+pley.getVotos()+")"); %>
						</td>
					</tr>
					<%
					if( !up.pleyVotada(usuario, pley)){
					%>
					<tr valign ="middle" align="center" id="votar">
						<td colspan="3" align="center">
							<form action="FrontController?res=muestraPLey.jsp?votar=ok" method="post"><input type="submit" value="VOTAR">
					
							</form>
						</td>
					</tr>
					<%
					}else{
						%>
						<tr valign ="middle" align="center" id="novotar">
						<td colspan="3" align="center">
						<%
						out.println("YA HAS VOTADO ESTA LEY");
						%>
						</td>
						</tr>
						<%
					}
					%>
					
					<%
			}
			%>
			
		</table>
	</fieldset>
	
</body>
</html>