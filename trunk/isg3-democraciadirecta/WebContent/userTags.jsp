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
		IProcessorUserTags proUserTags = new ProcessorUserTags();
			
			
			Usuario usuario = (Usuario)session.getAttribute("dd.usuario");
			String tagid = request.getParameter("tagid");
			if(tagid==null) { 
			/* List<Tag> tagsdeusuario = usuario.getUserTags();
			tagsdeusuario.add(tagToAdd);
			sessionUsuario.setUserTags(tagsdeusuario); */
	%>
	<div>
			<table >
				<%
				for (Tag t : proUserTags.obtenerTop10()) {
				%>
				<tr>
					<td><%out.println(t.getId());out.println(t.getNombre());%></td><td><a href="FrontController?res=userTags.jsp?tagid=<%=t.getId()%>"> ADD </a> </td>
				</tr>
				<%
				}
				%>
			</table>
 		</div>
 	<%
	} else {
	%>
		<div>
			<table >
				<%
				for (Tag t : proUserTags.obtenerTop10()) {
				%>
				<tr>
				<% 
				if(tagid.equals(t.getId()) && tagid!=null) {
				%>
					<td><%out.println(t.getId());out.println(t.getNombre());%></td><td>Añadido</td>
					<%}else{ %>
					<td><%out.println(t.getId());out.println(t.getNombre());%></td><td><a href="FrontController?res=userTags.jsp?tagid=<%=t.getId()%>"> ADD </a> </td>
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