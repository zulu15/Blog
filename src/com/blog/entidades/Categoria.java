package com.blog.entidades;

import java.io.Serializable;

public class Categoria implements Serializable {

	private static final long serialVersionUID = 1L;

	private long id;
	private String nombre;

	@Override
	public String toString() {
		return "Categoria [id=" + id + ", nombre=" + nombre + "]";
	}

	public Categoria() {
	}

	public Categoria(long id, String nombre) {

		this.id = id;
		this.nombre = nombre;
	}

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getNombre() {
		return nombre;
	}

	public void setNombre(String nombre) {
		this.nombre = nombre;
	}

}
