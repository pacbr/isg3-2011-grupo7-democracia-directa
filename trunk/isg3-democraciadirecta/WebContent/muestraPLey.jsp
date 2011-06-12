<%@ page language="java" import="java.util.*,domain.*"  
	contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Propuesta de ley</title>
<style type="text/css">
<!--
	#all{
		font-family:Helvetica;
		margin:auto;
		float: inherit;
		width:1100px;
	}
	#all legend{
		style="font-family:Helvetica ;
		 font-size: 18px; 
		 color: #660000;
	}
	#all table{
		padding:5px;
	}
	.desc{
		font-style: italic;
		font-weight: bold;
	}
-->
</style>
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
		pp.nuevaVisita(sessionPley);
	}else{
		sessionPley = (PLey)session.getAttribute("session.PLey");
	}
	%>
	<div id="all">
	<fieldset>
	<legend><%=sessionPley.getNombre() %></legend>
	<table summary="PLey">
		
		
		<tr valign ="middle" align="left" id="autor">
			<td><%out.println("Autor: "+sessionPley.getUsuario().getNombre()); %></td>
		</tr>
		<tr></tr>
		<tr valign ="middle" align="left" id="descripcion">
			<td> <span class="desc">Descripción:</span><p><%out.println(sessionPley.getDescripcion());%> </p></td>	
		</tr>
		<tr valign ="middle" align="left" id="descripcion">
			<td><b> <%out.println("TAGS: ");%></b><%
							for(Tag t:sessionPley.getTags()){
								out.println(t.getNombre());
							}
							%> </td>	
		</tr>
		<tr valign ="middle" align="left" id="votos">
			<td colspan="3" align="left">
		
		<%
		if (!(request.getParameter("votar") != null && request.getParameter("votar").equals("ok"))) {
			out.println("(Votos: "+sessionPley.getVotos()+")"); %>
			</td>
		</tr>
			<%
			if(!sessionPley.isActiva()){
				%>
				
				<tr valign ="middle" align="left" id="votar">
					<td colspan="3" align="left">
				<%	
				out.println("ESTA LEY ESTÁ INACTIVA. YA NO SE PUEDE VOTAR");
				%>
					</td>
				</tr>
				
				<%
			}else{
				if( !up.pleyVotada(usuario, sessionPley)){
					%>
					
					<tr valign ="middle" align="left" id="votar">
						<td colspan="3" align="left">
							<form action="FrontController?res=muestraPLey.jsp?votar=ok" method="post"><input type="submit" value="VOTAR">
					
							</form>
						</td>
					</tr>
					<%
				}else{
					%>
					<tr valign ="middle" align="left" id="novotar">
					<td colspan="3" align="left">
					<%
					out.println("YA HAS VOTADO ESTA LEY");
					%>
					</td>
					</tr>
					
					<%
				}
			}
		}else{
			
			if(up.votaPLey(sessionPley, usuario)){
				PLey pley2 = pp.obtenerPLeyPorId(sessionPley.getId());
				%>
				<tr valign ="middle" align="left" id="votar">
					<td colspan="3" align="left">
				<%
				out.println("(Votos: "+pley2.getVotos()+")"); 
				%>
				</td>
				</tr>
				<tr valign ="middle" align="left" id="votar">
					<td colspan="3" align="left">
				<%
				out.println("Tu voto se ha realizado correctamente.");
				%>
				</td>
				</tr>
				
				<%
			} else {
				%>
				<tr valign ="middle" align="left" id="votar">
					<td colspan="3" align="left">
				<%
				out.println("Sólo puedes dar un voto a esta ley");
				%>
				</td>
				</tr>
				
				<%
			}
			
		}
			
		%>
		<tr colspan="3" align="left">
			<td><a href="FrontController?res=index.jsp">Volver al inicio</a></td>
		</tr>
		
		</table>
	</fieldset>
</div>
</body>
</html>