<%@ page language="java" import="java.util.*,domain.*,data.*" 
	contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Recomendaciones</title>
<style type="text/css">
<!--
	
	body{
		width:700px;
		font-family: Arial;
		margin:auto;
	}
	h1{
		text-align:center;
	}
	h5{
		text-align:center;

	}
	h5 a{
		color: #039;
	}
	.exito {
		color: #33ff00;
		font-size: 20px;
		text-align: center;
	}
	.error {
		color: red;
		font-size: 20px;
		text-align: center;
	}
	.one-column-emphasis{
		font-family: "Lucida Sans Unicode", "Lucida Grande", Sans-Serif;
		font-size: 12px;
		margin: 10px;
		width: 680px;
		text-align: left;
		border-collapse: collapse;
	}
	.one-column-emphasis th{
		text-align:center;
		font-size: 14px;
		font-weight: normal;
		padding: 12px 15px;
		color: #039;
	}
	.one-column-emphasis td{
		text-align:center;
		padding: 10px 15px;
		color: #669;
		border-top: 1px solid #e8edff;
	}
	.oce-first{
		background: #d0dafd;
		border-right: 10px solid transparent;
		border-left: 10px solid transparent;
	}
	.oce-top{
		background: #dddddd;
		border-right: 10px solid transparent;
		border-left: 10px solid transparent;
	}
	.one-column-emphasis tr:hover td{
		color: #339;
		background: #eff2ff;
	}
	
-->
</style>
</head>

<body>

	<%
		Usuario user = (Usuario)session.getAttribute("dd.usuario");
		String nick = user.getId();
		IProcessorRecomendaciones pr = new ProcessorRecomendaciones();
	%>
	<div>
		<h1>RECOMENDACIONES</h1>
		<h5><a href="FrontController?res=index.jsp">Volver a la página principal</a></h5>
		<p> 
		<h5>¡Recuerda marcar la casilla de <a href="FrontController?res=userTags.jsp">Temas Favoritos</a> si deseas que también usemos tus temas favoritos!
		<BR>
		Elige un porcentaje de aparición de Temas en la página y... Dale al botón ¡Recomiéndame!</h5>
		<h6>(Si eliges 90-99% saldrán leyes sobre temas muy frecuentes, si eliges 1-20% será sobre temas poco frecuentes)</h6>

		<p>
		<form action="FrontController?res=pleyesRecomendadas.jsp" method="post">
		<select name="porcentaje1">
		<option value="1"> 1		
		<option value="5"> 5
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
		<option value="5"> 5
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
		
		
		<input type="submit" value="¡Recomiéndame!">
		</form>
	</div>
	


</body>
</html>