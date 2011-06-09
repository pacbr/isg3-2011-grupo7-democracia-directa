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
		Te vamos a mostrar una serie de leyes, las leyes que te mostremos depender�n de los temas sobre los que tratan.
		<BR>
		Puedes hacer que tus <a href="FrontController?res=userTags.jsp">Temas Favoritos</a> tambi�n aparezcan entre estas leyes,
		si asi lo deseas, marca la Casilla de <I><B>Temas Favoritos</B></I>.<BR>
		Existen temas m�s frecuentes y temas menos frecuentes, elegir�s los temas de las leyes dependiendo de su 
		<BR> 
		frecuencia de uso, cuanto m�s frecuentes sean, mayor porcentaje tendr�n. 
		<BR>
		(90-99% Temas Muy Frecuentes, 1-20% Temas Poco Frecuentes)
		<BR>
		�Sobre qu� temas quieres votar?
		<BR>
		
		</label>
		<p>
		<form action="FrontController?res=pleyesRecomendadas.jsp" method="post">
		<select name="porcentaje1">
		<option value="1"> 1
		<option value="10"> 10
		<option value="15"> 15
		<option value="20"> 20
		<option value="25"> 25
		<option value="30"> 30
		<option value="35"> 35
		<option value="40"> 40
		<option value="45"> 45
		<option value="50"> 50
		<option value="55"> 55
		<option value="60"> 60
		<option value="65"> 65
		<option value="70"> 70
		<option value="75"> 75
		<option value="80"> 80
		<option value="85"> 85
		<option value="90"> 90
		<option value="95"> 95
		<option value="99"> 99
		</select>
		
		<select name="porcentaje2">
		<option value="1"> 1
		<option value="10"> 10
		<option value="15"> 15
		<option value="20"> 20
		<option value="25"> 25
		<option value="30"> 30
		<option value="35"> 35
		<option value="40"> 40
		<option value="45"> 45
		<option value="50"> 50
		<option value="55"> 55
		<option value="60"> 60
		<option value="65"> 65
		<option value="70"> 70
		<option value="75"> 75
		<option value="80"> 80
		<option value="85"> 85
		<option value="90"> 90
		<option value="95"> 95
		<option value="99"> 99
		</select>
		
		<input type="checkbox" name="favoritos" id="favoritos" value="1">  Temas Favoritos
		<br>
		<input name="userID" type="hidden" value=<% out.println(nick); %>>
		
		
		<input type="submit" value="�Recomi�ndame!">
		</form>
	</div>
	


</body>
</html>