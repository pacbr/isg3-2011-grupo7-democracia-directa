<%@ page language="java" import="java.util.*,domain.*,data.*" 
	contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Pleyes Recomendadas</title>
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
color:#FFFFFF;
}

#imagecenter {
display: block;
font-size: 100%;
width: 22px;
height: 20px;
margin: 0 auto 0 auto;
background-image: url("img/votado.gif");
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
					IProcessorRecomendaciones pr = new ProcessorRecomendaciones();
					IProccesorUsuario pu = new ProccesorUsuario();
					List<PLey> auxPrint = new ArrayList<PLey>();
					Usuario usuario = (Usuario)session.getAttribute("dd.usuario");
					String nick = request.getParameter("userID");
					Integer p1 = new Integer(request.getParameter("porcentaje1")); 
					Integer p2 = new Integer(request.getParameter("porcentaje2"));
					boolean favoritos ;
					String posicion = "impar";
					if(request.getParameter("favoritos") == null)
					{
						favoritos = false;			
					}
					else
					{
						favoritos = true;
					}
					%>
					<br>
					<table>
						<tr>
				            <th id="titulos">   </th>
		
		                	<th id="titulos">TÍTULO</th>
		                	
		                	<th id="titulos" style="width:20px">VOTADA</th>
		            		
		            		<th id="titulos">TAGs</th>
		                	
		                	<th id="titulos" style="width:100px">VOTOS</th>
						
						</tr>
						<%
							for (PLey e : pr.recomienda(favoritos, nick, p1, p2)){
								auxPrint.add(e);
							}
							
							int cont = 1;
							for (PLey p : auxPrint){
								if(cont%2==0){
									posicion="par";
								}else{
									posicion="impar";
								}
						%>
						<tr id="<%=posicion%>">
									<td>
										<B>
											<%
												out.println(cont+" ");
											%>
										</B>
									</td>
									<td id="pley" style="width:480px">	
										<b>
											<a href="FrontController?res=muestraPLey.jsp?idPLey=<%=	p.getId()%>">
											<%
												out.println(p.getNombre());
											%>
											</a>
										</b>
										<br>
											<B>Autor: </B>
											<%
												out.println(p.getUsuario().getNick());
											%>
									</td>
									<td>
										<%
										if(pu.pleyVotada(usuario,p)){
											%>
											<div id="imagecenter"></div>
											<!-- <img element="CENTER" src='img/votado.gif'>  -->
											<%
										}
										%>
									</td>
									<td>
										<%	
											List<Tag> aux = p.getTags();
											for(Tag t : aux){
												out.println(t.getNombre()+"  ");					
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
								</tr>
							<%
								cont++;
							}
							%>	
					</table>
							<%
							auxPrint.clear();
							%>	
			</div>
		</div>
	</div>
</body>
</html>