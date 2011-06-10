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
width: 900px;  /*Este será el ancho que tendrá tu columna*/
background-color: ;  /*Aquí pon el color del fondo que quieras para este lateral*/
float:left; /*Aqui determinas de lado quieres quede esta "columna" */
}

#puntuacion{
color: #0000FF;
text-align:right;
font-size: 12px;
}

#muestraPley{
background-color: #FFA2A2;
}

#votos{
text-align:right;
}

#posicion{
text-align:center;
}

#usuario{
text-align:right;
}

#prestigio{
text-align:right;
}

#par{

}

#impar{
background-color: #E0E0E0;
}

#titulos{
background-color: #996600;
text-align:center;
color:#FFFFFF;
font-family:Helvetica;
}

#pley{
font-family:Calibri;
}

#leyenda{
background-color: #808080;
width: 900px;
}

-->
</style>

</head>
<body>
	<div id="contenedor">
		<div id="lateralIzd">
			<div align="center">
			<a href="FrontController?res=index.jsp">Volver al inicio</a>
			</div>
				<div>
							<% 
							IProccesorInteres pi = new ProccesorInteres();
							IProccesorUsuario up = new ProccesorUsuario();
							Integer interesPLey;
							int contador = 1;
							Usuario usuario = (Usuario)session.getAttribute("dd.usuario");
							
							SortedMap<Integer,List<PLey>> mapaPleyesOrdenadas = pi.creaMapaPLeyes();
							
							String posicion = "impar";
							
							%>
							<br>
							<table>
								<tr>
									<th id="titulos"> </th>
		
				                	<th id="titulos">   </th>
				
				                	<th id="titulos">TÍTULO</th>
				                	
				                	<th id="titulos">   </th>
				                	
				                	<th id="titulos" style="width:100px">VOTOS</th>
				                	
				                	<th id="titulos" style="width:100px">VISITAS</th>
				
									<th id="titulos" style="width:100px">PRESTIGIO</th>
								
								</tr>
							<%
							while(!mapaPleyesOrdenadas.isEmpty()){
								interesPLey = mapaPleyesOrdenadas.lastKey();
								for(PLey p:mapaPleyesOrdenadas.remove(mapaPleyesOrdenadas.lastKey())){
									
									if(contador%2==0){
										posicion="par";
									}else{
										posicion="impar";
									}
									
									
									%>
									
								<tr id="<%=posicion%>">
									<td>
										<%
										
										switch(pi.getMovimientoEnLista(p,contador)){
										case -1:
											%>
											<img src='img/ico_bajada.gif'>
											<%
											break;
										case 0:
											%>
											<img src='img/ico_igual.gif'>
											<%
											break;
										case 1:
											%>
											<img src='img/ico_subida.gif'>
											<%
											break;
										default:
											%>
											<img src='img/ico_nueva.gif'>
											<%
											break;
										}
										%><%
										out.println("("+p.getMaxPosicionLista()+")");
										
										
										%>										
									</td>
									<td id="posicion">
										<b>
											<%
												out.println(contador+" ");
											%>
										</b>
									</td>
									
									<td id="pley" style="width:480px">	
										<b><a href="FrontController?res=muestraPLey.jsp?idPLey=<%=p.getId() %>"><%out.println(p.getNombre());%></a></b>
										<br><%out.println("Autor: "+p.getUsuario().getNick());%>
									</td>
									
									<td>
										<%
										if(up.pleyVotada(usuario,p)){
											%>
											<img src='img/votado.gif'>
											<%
										}
										%>
									</td>
									
									<td id=votos><b>
										<%
										session.setAttribute("id",p.getId());
										out.println(p.getVotos());
										%>
										</b>
									</td>
									
									<td id=votos><b>
										<%
										out.println(p.getVisitas());
										%>
										</b>
									</td>
									
									
									<td id="prestigio">
										<% 
										 out.println("("+interesPLey+")");
										%>
									</td>
								</tr>
								<tr>
								</tr>
							
									<%
									contador++;
								}
							}
								
						%>
				</table>
	
	
			</div>
			<div>
			<table id="leyenda">
			<tr height="20 px"></tr><tr></tr>			
				<tr>
					<td>
					<img src='img/ico_subida.gif'></td>
					<td>Subiendo posiciones<br>
					</td>
					<td>
					<img src='img/ico_bajada.gif'></td>
					<td>Bajando posiciones
					</td>
					<td>
					<img src='img/ico_igual.gif'></td>
					<td>Mantiene posición<br>
					</td>
					<td>
					<img src='img/ico_nueva.gif'></td>
					<td>Creada recientemente o con menos de 10 votos<br>
					</td>
					<td>
					<img src='img/votado.gif'></td>
					<td>Propuestas que has votado<br>
					</td>
				</tr>
			</table>
			</div>
		</div>
			
			
	</div>
	
	
</body>
</html>