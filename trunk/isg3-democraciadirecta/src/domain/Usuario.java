package domain;

import java.util.List;

public class Usuario {
	
	private String id;
	private String nick;
	private String password;
	private String email;
	private String nombre;
	private List<Tag> newsletter;
	
	public String getId() {
		return id;
	}
	
	public void setId(String id) {
		this.id = id;
	}
	
	public String getNick() {
		return nick;
	}
	
	public void setNick(String nick) {
		this.nick = nick;
	}
	
	public String getPassword() {
		return password;
	}
	
	public void setPassword(String password) {
		this.password = password;
	}
	
	public String getEmail() {
		return email;
	}
	
	public void setEmail(String email) {
		this.email = email;
	}
	
	public String getNombre() {
		return nombre;
	}
	
	public void setNombre(String nombre) {
		this.nombre = nombre;
	}

	public void setNewsletter(List<Tag> newsletter) {
		this.newsletter = newsletter;
	}

	public List<Tag> getNewsletter() {
		return newsletter;
	}
	
}
