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
	IProccesorUsuario up = new ProccesorUsuario();
	PLey sessionPley;
	
	if (!(request.getParameter("votar") != null && request.getParameter("votar").equals("ok"))) {
		sessionPley = pp.obtenerPLeyPorId(request.getParameter("idPLey"));
		session.setAttribute("session.PLey", sessionPley);
	}else{
		sessionPley = (PLey)session.getAttribute("session.PLey");
	}
	%>
	
	<fieldset>
	<legend
		style="font-family: Arial, sans-serif; font-size: 18px; color: #660000"><%=sessionPley.getNombre() %></legend>
	<table summary="PLey" align="center">
		
		<%out.println("Autor: "+sessionPley.getUsuario().getNick()); %>
		
		<tr valign ="middle" align="center" id="descripcion">
			<td>&nbsp;</td><td><em>Descripción</em>
		</tr>
		<tr valign ="middle" align="center" id="descripcion">
			<td></td>	<td> <%out.println(sessionPley.getDescripcion());%> </td>	
		</tr>
		<tr valign ="middle" align="center" id="votos">
			<td colspan="3" align="center">
		
		<%
		if (!(request.getParameter("votar") != null && request.getParameter("votar").equals("ok"))) {
			out.println("(Votos: "+sessionPley.getVotos()+")"); %>
			</td>
		</tr>
			<%
			if( !up.pleyVotada(usuario, sessionPley)){
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
		}else{
			
			if(up.votaPLey(sessionPley, usuario)){
				PLey pley2 = pp.obtenerPLeyPorId(sessionPley.getId());
				%>
				<tr valign ="middle" align="center" id="votar">
					<td colspan="3" align="center">
				<%
				out.println("(Votos: "+pley2.getVotos()+")"); 
				%>
				</td>
				</tr>
				<tr valign ="middle" align="center" id="votar">
					<td colspan="3" align="center">
				<%
				out.println("Tu voto se ha realizado correctamente.");
				%>
				</td>
				</tr>
				<%
			} else {
				%>
				<tr valign ="middle" align="center" id="votar">
					<td colspan="3" align="center">
				<%
				out.println("Ya has votado esta ley");
				%>
				</td>
				</tr>
				<%
			}
			
		}
			
		%>
		
		</table>
	</fieldset>
	
</body>
</html>