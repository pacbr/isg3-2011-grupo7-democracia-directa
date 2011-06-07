<%@ page language="java" import="java.util.*,domain.*,data.*" 
	contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Añade user tag</title>
</head>
<body>
<%
	IProcessorUserTags proUserTags = new ProcessorUserTags();
//TODOJOSE Cambiar esto	
ITagDAO tagDAO = new JDBCTagDAO();
	Usuario usuario = (Usuario)session.getAttribute("dd.usuario");
	String tagid = request.getParameter("tagid");
	
	//IUsuarioDAO user = new JDBCUsuarioDAO();
	//user.select(usuario.getId());
%>
Se va a añadir el tag <%out.println(tagDAO.select(tagid).getNombre()); %> con id: <%out.println(tagDAO.select(tagid).getId()); %>

<% proUserTags.insertaUserTag(tagDAO.select(tagid).getId(),usuario.getId());%>
</body>
</html>