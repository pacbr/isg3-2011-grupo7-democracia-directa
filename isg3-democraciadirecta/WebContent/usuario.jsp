<%@ page language="java" import="java.util.*,domain.*"  
	contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Propuestas de Leyes actuales mas interesantes</title>
<link rel="stylesheet" type="text/css" href="style/style.css" />
<style type="text/css">
<!--
	#contenedor{
text-align: left;
width: 1000px;
margin: auto;}

#lateralIzd{
width: 400px;  /*Este será el ancho que tendrá tu columna*/
background-color: ;  /*Aquí pon el color del fondo que quieras para este lateral*/
float:left; /*Aqui determinas de lado quieres quede esta "columna" */
}

#principal{
margin-left:450px; /*Este margen hace que no se encime el contenido en tu menúlateral, es importante que pongas un pocos pixeles más que el ancho  de tu columna lateral*/
background-color: #FFFFFF;
border:#000000 1px solid; /*ponemos un dorde para que se vea bonito*/
}

#table{
width: 400px;
}

#table2{
width: 550px;
}

#encabezado{
background-color: #787878;
text-align:center;
color:#FFFFFF;
font-family:Helvetica;
}

#titulos{
background-color: #996600;
text-align:center;
color:#FFFFFF;
font-family:Helvetica;
font-size: small;
}

#impar{
background-color: #E0E0E0;
}


#par{
background-color: #F8F8F8;
}

#imagen{
text-align: center;
}

#comentario{
font-size: small;
}

#votos{
width: 90px;
text-align: right;
}


-->
</style>

</head>
<body>
	<%
	Usuario usuario = (Usuario) session.getAttribute("dd.usuario");
	IPLeyProcessor pp = new PLeyProcessor();
	%>
	<div id="contenedor">
		<div id="lateralIzd">
			<p><u><b>Nombre:</b></u> <%=usuario.getNombre()%></p>
			<p><u><b>Nick:</b></u> <%=usuario.getNick()%></p>
			<p><u><b>Email:</b></u> <%=usuario.getEmail()%></p>
			
			<table id="table">
				<tr id="encabezado">
					<th>Propuestas que has creado</th>
				</tr>
			</table>
			<table id="table">
				<tr id="titulos">
					<th>Nombre</th>
					<th>Editar</th>
					<th>Borrar(*)</th>
				</tr>
				<%
				int contador = 1;
				String posicion = "impar";
				for(PLey p:pp.getPLeyesPorUsuario(usuario)){
					if(contador%2==0){
						posicion="par";
					}else{
						posicion="impar";
					}
					
					
					%>
					
				<tr id="<%=posicion%>">
						<th><b><a href="FrontController?res=muestraPLey.jsp?idPLey=<%=p.getId()%>"><%=p.getNombre()%></a></b>
						<%
						if(p.isActiva()&&(p.getVotos()<11)){
							%>
							<th id="imagen"><a href="FrontController?res=editPley.jsp?idPLey=<%=p.getId()%>&accion=edit&confirmar=no""><img src='img/editar.png'></a></th>
							<th id="imagen"><a href="FrontController?res=editPley.jsp?idPLey=<%=p.getId()%>&accion=delete&confirmar=no""><img src='img/borrar.png'></a></th>
							<%
						}
					contador++;
				}
				%>
				
			</table>
			<br>
			<div id="comentario">(*)Sólo podrás eliminar aquellas propuestas que no tengan más de 10 votos</div>
			
		</div>
	
	
	
			<div id="principal">
			<table id="table2">
				<tr id="encabezado">
					<th>Propuestas que has votado</th>
				</tr>
			</table>
			<table id="table2">
				<tr id="titulos">
					<th>Nombre</th>
					<th>Votos</th>
				</tr>
			<%
			for(PLey p:pp.getPLeyesVotadasPorUsuario(usuario)){
				if(contador%2==0){
					posicion="par";
				}else{
					posicion="impar";
				}
				%>
				<tr id="<%=posicion%>">
						<th><b><a href="FrontController?res=muestraPLey.jsp?idPLey=<%=p.getId()%>"><%=p.getNombre()%></a></b></th>
						<th id="votos"><b><%=p.getVotos() %></b>
				</tr>
			<%
				contador++;
			}
			%>
			</table>
			</div>
	</div>
	
	
</body>
</html>