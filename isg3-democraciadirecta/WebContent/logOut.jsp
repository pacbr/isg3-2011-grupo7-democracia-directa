<%@ page language="java" import="java.util.*,domain.*"  
	contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Log out</title>
<meta http-equiv="Refresh" content="2;url=index.jsp">
</head>
<body>
	<%
	session.invalidate(); %>
	<p><b>Deslogueado correctamente.</b></p>
		Redireccionando a la página de inicio...
	<% //response.sendRedirect("http://localhost:8080/democraciadirecta/"); %>
	
</body>
</html>