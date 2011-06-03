<%@ page language="java" import="java.util.*,domain.*,data.*" 
	contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Democracia Directa - User Tags</title>
</head>
<body>
	<%
	
	IProccesorUserTags proUserTags = new ProccesorUserTags();
	
	Usuario usuario = (Usuario)session.getAttribute("dd.usuario");
	if (usuario.getNombre()=="practica") { 
		// extraigo del parámetro indicándome el tag a añadir
		String tagid = request.getParameter("tagid");
		Usuario sessionUsuario = null;
		Tag tagToAdd = proUserTags.obtenerTagPorId(tagid);
		if(tagid!=null)
		{
			sessionUsuario = (Usuario)session.getAttribute("dd.usuario");
			List<Tag> tagsdeusuario = sessionUsuario.getUserTags();
			tagsdeusuario.add(tagToAdd);
			sessionUsuario.setUserTags(tagsdeusuario);
		}
		else
		{
			System.out.println("TAG NO VALIDO");
		}
		%>
		</div>
	<%
	} else {
		String tagid = request.getParameter("tagid");
	%>
		<div>
			<table >
				<%
				for (Tag t : proUserTags.obtenerTop10()) {
				%>
				<tr>
					<td>
					<%
					out.println(t.getId());
					out.println(t.getNombre());
					%>
					</td>
					
					<% 
					if(tagid.equals(t.getId())) {
					%>
					<td>Añadido</td>
					<%}else{ %>
					<td> <a href="FrontController?res=userTags.jsp?tagid=<%=t.getId()%>"> ADD </a> </td>
					<%} %>
				</tr>
				<%
				}
				%>
			</table>
 		</div>
	<%
	}
	%>
	
</body>
</html>