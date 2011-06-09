<%@ page language="java" import="java.util.*,domain.*,data.*" 
	contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Recomendaciones</title>
</head>

<body>

	<%
		Usuario user = (Usuario)session.getAttribute("dd.usuario");
		String nick = user.getId();
		IProcessorRecomendaciones pr = new ProcessorRecomendaciones();
	%>
	<div>
		<label for="sugerencias">RECOMENDACIONES</label>
		<p> 
		<label for="">
		Te vamos a mostrar una serie de leyes, las leyes que te mostremos dependerán de los temas sobre los que tratan.
		<BR>
		Puedes hacer que tus <a href="FrontController?res=userTags.jsp">Temas Favoritos</a> también aparezcan entre estas leyes,
		si asi lo deseas, marca la Casilla de <I><B>Temas Favoritos</B></I>.<BR>
		Existen temas más frecuentes y temas menos frecuentes, elegirás los temas de las leyes dependiendo de su 
		<BR> 
		frecuencia de uso, cuanto más frecuentes sean, mayor porcentaje tendrán. 
		<BR>
		(90-99% Temas Muy Frecuentes, 1-20% Temas Poco Frecuentes)
		<BR>
		¿Sobre qué temas quieres votar?
		<BR>
		
		</label>
		<p>
		<form action="FrontController?res=pleyesRecomendadas.jsp" method="post">
		<select name="porcentaje1">
		<option value="1"> 99
		<option value="10"> 90
		<option value="20"> 80
		<option value="30"> 70
		<option value="40"> 60
		<option value="50"> 50
		<option value="60"> 40
		<option value="70"> 30
		<option value="80"> 20
		<option value="90"> 10
		<option value="99"> 1	
		
		</select>
		
		<select name="porcentaje2">
		<option value="2"> 98
		<option value="5"> 95
		<option value="15"> 85
		<option value="25"> 75
		<option value="35"> 65
		<option value="45"> 55
		<option value="55"> 45
		<option value="65"> 35
		<option value="75"> 25
		<option value="85"> 15
		<option value="95"> 5
		<option value="100"> 0
		</select>
		
		<input type="checkbox" name="favoritos" id="favoritos" value="1">  Temas Favoritos
		<br>
		<input name="userID" type="hidden" value=<% out.println(nick); %>>
		
		
		<input type="submit" value="¡Recomiéndame!">
		</form>
	</div>
	


</body>
</html>