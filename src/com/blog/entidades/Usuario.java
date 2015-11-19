package com.blog.entidades;

import java.io.Serializable;

public class Usuario implements Serializable {

	private static final long serialVersionUID = 1L;

	private String email;
	private String password;
	private String nick;
	private String rol;

	public Usuario() {
	}

	public Usuario(String email, String password, String nick, String rol) {

		this.email = email;
		this.password = password;
		this.nick = nick;
		this.rol = rol;
	}

	public String getRol() {
		return rol;
	}

	public void setRol(String rol) {
		this.rol = rol;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getNick() {
		return nick;
	}

	public void setNick(String nick) {
		this.nick = nick;
	}

	@Override
	public String toString() {
		return "Usuario [email=" + email + ", password=" + password + ", nick=" + nick + " rol= " + rol + "]";
	}

}
