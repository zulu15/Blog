package com.blog.services;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import com.blog.entidades.Entrada;
import com.blog.entidades.Usuario;
import com.blog.util.Conexion;

//Service

public class EntradaService {


	/**
	DEVUELVE TODAS LAS ENTRADAS DISPONIBLES EN EL BLOG
	**/
	public static List<Entrada> listarEntradas() {
		ArrayList<Entrada> entradas = new ArrayList<Entrada>();
		Connection conexion = Conexion.getConexion();
		String sql = "SELECT * FROM entrada ORDER BY ent_id DESC";
		try {
			PreparedStatement pst = conexion.prepareStatement(sql);
			ResultSet rs = pst.executeQuery();
			Entrada entrada = null;
			while (rs.next()) {
				entrada = new Entrada();
				entrada.setId(rs.getLong("ent_id"));
				entrada.setEmailUsuario(rs.getString("ent_usr_email"));
				entrada.setFecha(rs.getDate("ent_fecha"));
				entrada.setDescripcion(rs.getString("ent_descripcion"));
				entrada.setTitulo(rs.getString("ent_titulo"));
				entrada.setIdCategoria(rs.getLong("ent_cat_id"));
				entradas.add(entrada);
			}
		} catch (SQLException e) {
			System.err.println("Error listando las entradas (" + e + ")");
		}

		return entradas;
	}


	/**
	PERSISTE UNA NUEVA ENTRADA EN EL BLOG
	**/
	public static void guardarEntrada(Entrada entrada) {

		try {

			Connection conexion = Conexion.getConexion();
			String sql = "INSERT INTO entrada (ent_usr_email, ent_fecha, ent_descripcion, ent_titulo, ent_cat_id) VALUES (?,?,?,?,?);";
			PreparedStatement pstm = conexion.prepareStatement(sql);
			pstm.setString(1, entrada.getEmailUsuario());
			pstm.setDate(2, entrada.getFecha());
			pstm.setString(3, entrada.getDescripcion());
			pstm.setString(4, entrada.getTitulo());
			pstm.setLong(5, entrada.getIdCategoria());
			int filas = pstm.executeUpdate();
			if (filas != 1) {
				throw new RuntimeException("No se pudo registrar la entrada: " + entrada);
			}
		} catch (SQLException e) {
			System.err.println("Error guardando una entrada " + e);
		}

	}

	/**
	ELIMINA UNA ENTRADA DEL BLOG
	**/
	public static void eliminarEntrada(String id, Usuario usuarioSesion) {
		try {

			String sql = "DELETE FROM entrada  WHERE ent_id = ?";
			Connection conexion = Conexion.getConexion();
			PreparedStatement pstm = conexion.prepareStatement(sql);
			pstm.setString(1, id);
			int filasAfectadas = pstm.executeUpdate();
			if (filasAfectadas != 1) {
				System.err.println("Error eliminando entrada !!");
			}

		} catch (Exception e) {
			throw new RuntimeException(e);
		}

	}



}
