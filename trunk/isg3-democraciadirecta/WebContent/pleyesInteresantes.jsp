<%@ page language="java" import="java.util.*,domain.*"  
	contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Propuestas de Leyes actuales mas interesantes</title>
</head>
<body>
	
		<div>
 		<%
		//PLey p = new PLey();
 		//p.setId(""+System.currentTimeMillis());
 		//p.setNombre(nombre);
 		//p.setTags(tags);
 		//p.setDescripcion(descripcion);
 		//p.setUsuario(usuario);
		%>
		</div>
		<div>
		<form action="FrontController?res=index.jsp" method="post">
			<input type="submit" value="Inicio">
		</form>
 		</div>
		<div>
			<form action="" method="post">
				<div>
				<input type="submit" value="Recargar">
				
				<% 
				IProccesorInteres pi = new ProccesorInteres();
				List<Usuario> usuarios = pi.getUsers();
				SortedMap<Integer,List<PLey>> smapaUsuario = new TreeMap<Integer,List<PLey>>();
				SortedMap<Integer,List<PLey>> smapaFinal = new TreeMap<Integer,List<PLey>>();
				List<PLey> lista;
				for(Usuario u:usuarios){
					smapaUsuario = pi.getPleysInteresantesByUser(u);
					
					//smapaFinal.putAll(smapaUsuario);
					for(Integer interesPLey:smapaUsuario.keySet()){
						if(smapaFinal.containsKey(interesPLey)){
							smapaFinal.get(interesPLey).addAll(smapaUsuario.get(interesPLey));
						}else{
							List<PLey> listaInteres = new ArrayList<PLey>();
							listaInteres.addAll(smapaUsuario.get(interesPLey));
							smapaFinal.put(interesPLey,listaInteres);
						}
					}
				
				}
				%><b><%//out.println("Hay "+smapaFinal.size()+" leyes activas interesantes:");%></b>
				<br><%
				Integer interesPLey;
				int contador = 1;
				while(!smapaFinal.isEmpty()){
					
				
				//for(Integer interesPLey:smapaFinal.keySet()){
					interesPLey = smapaFinal.lastKey();
					for(PLey p:smapaFinal.remove(smapaFinal.lastKey())){
						%><p>
						<b><%out.println(contador+":: ");%></b>
						<%out.println(interesPLey+":"+p.getNombre()+" ("+p.getVotos()+" votos). Usuario: "+p.getUsuario().getNick());
						%></p><%
					contador++;
						}
					}
				//}
				%>
				</div>
				
			</form>
			</div>
	
	
</body>
</html>