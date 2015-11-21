package com.blog.services;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.blog.entidades.Categoria;
import com.blog.entidades.Usuario;
import com.blog.util.Conexion;

public class CategoriaService {

	public static List<Categoria> listarCategorias() {
		ArrayList<Categoria> categorias = new ArrayList<Categoria>();
		Connection conexion = Conexion.getConexion();
		String sql = "SELECT * FROM categoria";
		try {
			PreparedStatement pst = conexion.prepareStatement(sql);
			ResultSet rs = pst.executeQuery();
			Categoria categoria = null;
			while (rs.next()) {
				categoria = new Categoria();
				categoria.setId(rs.getLong("cat_id"));
				categoria.setNombre(rs.getString("cat_nombre"));
				categorias.add(categoria);
			}
		} catch (SQLException e) {
			System.err.println("Error listando categorias (" + e + ")");
		}

		return categorias;
	}
	
	
	
	public static void eliminarCategoria(long id) {
		try {

			String sql = "DELETE FROM categoria  WHERE cat_id = ?";
			Connection conexion = Conexion.getConexion();
			PreparedStatement pstm = conexion.prepareStatement(sql);
			pstm.setLong(1, id);
			int filasAfectadas = pstm.executeUpdate();
			if (filasAfectadas != 1) {
				System.err.println("Error eliminando categoria !!");
			}

		} catch (Exception e) {
			throw new RuntimeException(e);
		}

	}



	public static void registrarCategoria(Categoria categoria) {
		boolean registro = false;
		try {
			Connection conexion = Conexion.getConexion();
			String sql = "INSERT INTO categoria (cat_id , cat_nombre) VALUES (?,?);";
			PreparedStatement pstm = conexion.prepareStatement(sql);
			pstm.setLong(1, categoria.getId());
			pstm.setString(2, categoria.getNombre());
			int filas = pstm.executeUpdate();
			if (filas == 1) {
				registro = true;
			} else {
				throw new RuntimeException("No se pudo registrar la categoria" + categoria);
			}

		} catch (Exception e) {

			System.err.println("No pude registrar la cat " + e);
		}
		
		
	}

}
