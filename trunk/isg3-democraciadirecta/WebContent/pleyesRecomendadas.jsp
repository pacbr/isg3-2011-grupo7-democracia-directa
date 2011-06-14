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
width: 1200;
margin: auto;
}

#principal{
margin-left:200px; 
margin-right:200px;
background-color: #FFFFFF;
border:#000000 2px solid;
}

#titulos{
background-color: #CCCCCC;
text-align:center;
color:#FFFFFF;
font-family:Helvetica;
}

#imagecenter {
display: block;
font-size: 100%;
width: 22px;
height: 20px;
margin: 0 auto 0 auto;
background-image: url("img/votado.gif");
}

#default2{

}

#default{
background-color: #f7f9aa;
}

-->
</style>
</head>
<body>
	<div align="center">
		<a href="FrontController?res=index.jsp">Volver al inicio</a>
	</div>

	<div id="contenedor">
		<div id="principal">
			<div align="center">
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
					String posicion = "default";
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
		
		                	<th id="titulos">Proyectos de Ley</th>
		                	
		                	<th id="titulos">Tags</th>
		                	
		                	<th id="titulos" style="width:20px">Votada</th>
		            		
		            		
						
						</tr>
						<%
							for (PLey e : pr.recomienda(favoritos, nick, p1, p2)){
								auxPrint.add(e);
							}
							
							int cont = 1;
							for (PLey p : auxPrint){
								if(cont%2==0){
									posicion="default2";
								}else{
									posicion="default";
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
									<td>	
										<b>
											<a href="FrontController?res=muestraPLey.jsp?idPLey=<%=	p.getId()%>">
											<%
												out.println(p.getNombre());
											%>
											</a>
										</b>
									</td>
									<td>
										<%	
											List<Tag> aux = p.getTags();
											for(Tag t : aux){
												out.println(t.getNombre()+"  ");					
											}
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