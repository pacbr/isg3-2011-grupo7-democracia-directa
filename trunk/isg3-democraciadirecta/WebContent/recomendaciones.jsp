<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Recomendaciones</title>
	<script type="text/javascript">
	 	function populatedropdown(topX){
	 		var topX=document.getElementById(topX) 
	 		for (var i=0; i<100; i++) 
	 			topX.options[i]=new Option(i, i+1) 
	 	} 
 	</script>
</head>

<body>

	<%
	%>
	<div>
		<label for="sugerencias">RECOMENDACIONES</label>
		<br> 
		<br>
		<label for="">Favoritos + Top X</label>
		<br>
		<form action="" name="someform">
			<select id="topX">
			</select> 
		</form>
		
		<script type="text/javascript">
			window.onload=function(){
				populatedropdown("topX")
			}
		</script> 
		<br>
		<input type="submit" value="¡Recomiéndame!">
	</div>

</body>
</html>