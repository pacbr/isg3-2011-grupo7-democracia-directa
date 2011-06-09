<%@ page language="java" import="java.util.*,domain.*,data.*" 
	contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Pleyes Recomendadas</title>
</head>
<body>
	<% 
		IProcessorRecomendaciones pr = new ProcessorRecomendaciones();
		List<PLey> auxPrint = new ArrayList<PLey>();
		
		String nick = request.getParameter("userID");
		Integer i = new Integer("123");
		Integer p1 = new Integer(request.getParameter("porcentaje1")); 
		Integer p2 = new Integer(request.getParameter("porcentaje2"));
		boolean favoritos ;
		if(request.getParameter("favoritos") == null)
		{
			favoritos = false;			
		}
		else
		{
			favoritos = true;
		}
		
/* 		System.out.println("Porcentaje1 "+p1);
		System.out.println("Porcentaje2 "+p2);
		System.out.println("nick "+nick);
		System.out.println("boolean "+favoritos); */

		for (PLey e : pr.recomienda(true, nick, p1, p2)){
			auxPrint.add(e);
		}
		
		int cont = 1;
		for (PLey p : auxPrint){
	%>
		<br>
			<B>
				<%
					out.println(cont+" ");
				%>
			</B>
			<a href="FrontController?res=muestraPLey.jsp?idPLey=<%=	p.getId()%>">
			<%
				out.println(p.getNombre());
			%>
			</a>
			<BR>
			<B>TAGs :</B>
			<%	
				List<Tag> aux = p.getTags();
				for(Tag t : aux){
					out.println(t.getNombre()+"  ");					
				}
			%>
			<BR>
			<B>Usuario que ha propuesto la ley: </B>
			<%
				out.println(p.getUsuario().getNick());
			%>
			<BR>
			<B>Votos recibidos hasta el momento: </B>
			<%
				out.println("("+p.getVotos()+")");
			%>

		<br>
	<%
		cont++;
	}%>		

</body>
</html>