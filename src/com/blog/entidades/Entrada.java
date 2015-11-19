package com.blog.entidades;

import java.io.Serializable;
import java.sql.Date;

public class Entrada implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private long id;
	private String titulo;
	private String descripcion;
	private String emailUsuario;
	private Date fecha;
	private long idCategoria;

	public Entrada() {
	}

	public Entrada(String titulo, String descripcion, String emailUsuario, Date fecha, long idCategoria) {
		this.titulo = titulo;
		this.descripcion = descripcion;
		this.emailUsuario = emailUsuario;
		this.fecha = fecha;
		this.idCategoria=idCategoria;
	}

	
	public long getIdCategoria() {
		return idCategoria;
	}
	
	public void setIdCategoria(long id) {
		this.idCategoria = id;
	}
	
	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getTitulo() {
		return titulo;
	}

	public void setTitulo(String titulo) {
		this.titulo = titulo;
	}

	public String getDescripcion() {
		return descripcion;
	}

	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}

	public String getEmailUsuario() {
		return emailUsuario;
	}

	public void setEmailUsuario(String emailUsuario) {
		this.emailUsuario = emailUsuario;
	}

	public Date getFecha() {
		return fecha;
	}

	public void setFecha(Date fecha) {
		this.fecha = fecha;
	}

	@Override
	public String toString() {
		return "Entrada [titulo=" + titulo + ", descripcion=" + descripcion + ", emailUsuario=" + emailUsuario + ", fecha=" + fecha + "idCategoria = "+idCategoria+"]";
	}

}
