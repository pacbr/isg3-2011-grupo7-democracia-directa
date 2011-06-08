<%@ page language="java" import="java.util.*,domain.*,data.*" 
	contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%
	IProcessorUserTags proUserTags = new ProcessorUserTags();
	ITagDAO tagDAO = new JDBCTagDAO();
	Usuario usuario = (Usuario)session.getAttribute("dd.usuario");
	String acepta = request.getParameter("acepta");
	String tagid = request.getParameter("tagid");
	String accion = request.getParameter("accion");
	if(acepta!=null && accion!=null){
		if(acepta.compareTo("yes")==0 && accion.compareTo("add")==0){
			proUserTags.insertaUserTag(tagDAO.select(tagid),usuario);
			response.sendRedirect("FrontController?res=userTags.jsp");
		}else if(acepta.compareTo("yes")==0 && accion.compareTo("delete")==0){
			proUserTags.eliminaUserTag(tagDAO.select(tagid),usuario);
			response.sendRedirect("FrontController?res=userTags.jsp");
		}
	}else{
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Añade user tag</title>
</head>
<body>

Se va a <%
if(accion.equals("add")){ 
%>anadir el tag "<%out.println(tagDAO.select(tagid).getNombre());%>" a tus
 favoritos. ¿Estás seguro?
  <br>
 	<a href="FrontController?res=addUserTag.jsp?tagid=<%=tagid%>&accion=add&acepta=yes">Sí</a>
 	<a href="FrontController?res=userTags.jsp">No</a>
	<a href="FrontController?res=userTags.jsp">Volver a UserTags</a>
<%}else{%>
	eliminar el tag "<%out.println(tagDAO.select(tagid).getNombre());%>" a tus
 favoritos. ¿Estás seguro?
 <br>
 	<a href="FrontController?res=addUserTag.jsp?tagid=<%=tagid%>&accion=delete&acepta=yes">Sí</a>
 	<a href="FrontController?res=userTags.jsp">No</a>
	<a href="FrontController?res=userTags.jsp">Volver a UserTags</a>
<%}%>
</body>
</html>

<%
	//acepta = request.getParameter("acepta");
	
	//IUsuarioDAO user = new JDBCUsuarioDAO();
	//user.select(usuario.getId());
	}
	
%>