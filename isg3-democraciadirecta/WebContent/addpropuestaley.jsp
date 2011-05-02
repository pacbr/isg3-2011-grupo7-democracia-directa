<%@ page language="java" import="java.util.*,domain.*" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Democracia Directa</title>
</head>
<body>
	<%
	IPropuestaProcessor pp = new PropuestaProcessor();
	String tag = request.getParameter("tag");
	if (tag != null && !tag.equals("0")) {
	%>
	<div>
		<% 
		Tag t = pp.mostrarTag(tag);
		out.println(t.getNombre()); 
		%>	
	</div>
	<%
	} else {
	%>
	<div>
		<form action="addpropuestaley.jsp" method="post">
			<label for="tag">Tag</label>
			<select name="tag">
				<option selected="selected" value="0">Escoge tag</option>
				<%
				for (Tag t : pp.mostrarTags()) {
				%>
				<option value="<% out.println(t.getId()); %>"><% out.println(t.getNombre()); %></option>
				<%
				}
				%>
			</select>
			<input type="submit" value="Enviar">
		</form>
	</div>
	<%
	}
	%>
</body>
</html>