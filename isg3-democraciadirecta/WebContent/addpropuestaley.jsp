<%@ page language="java" import="java.util.*,domain.*" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Democracia Directa</title>
</head>
<body>
	<div>
		<form action="addpropuestaley.jsp" method="post">
			<label for="tag">Tag</label>
			<select name="tag">
				<option selected="selected" value="0">Escoge tag</option>
				<%
				IPropuestaProcessor pp = new PropuestaProcessor();
				System.out.println("pp.mostrarTags().size()");
				for (Tag t : pp.mostrarTags()) {
				%>
				<option value="<% out.println(t.getId()); %>"><% out.println(t.getNombre()); %></option>
				<%
				}
				%>
			</select>
			<input type="button" value="Enviar">
		</form>
	</div>
</body>
</html>