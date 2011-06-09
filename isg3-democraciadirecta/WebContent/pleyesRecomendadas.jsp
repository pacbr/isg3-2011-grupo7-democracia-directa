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
		Integer porcentaje1 = new Integer(request.getParameter("porcentaje1")); 
		Integer porcentaje2 = new Integer(request.getParameter("porcentaje2"));
		auxPrint.addAll(pr.recomienda(nick, porcentaje1, porcentaje2));
// 		Integer aux1 = 1;
// 		Integer aux2 = 100;
// 		String aux3 = "3";

		for (PLey e : pr.recomienda(nick, porcentaje1, porcentaje1)){
			auxPrint.add(e);
		}
		
		
		for (PLey p : auxPrint){
	%>
		<br>
		<a href="FrontController?res=muestraPLey.jsp?idPLey=<%=p.getId() %>"><%out.println(p.getNombre());%></a>
		<br>
	<%}%>		

</body>
</html>