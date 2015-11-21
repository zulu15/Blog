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

public class UsuarioService {

	public static List<Usuario> listarUsuarios() {
		ArrayList<Usuario> usuarios = new ArrayList<Usuario>();
		Connection conexion = Conexion.getConexion();
		String sql = "SELECT * FROM usuario";
		try {
			PreparedStatement pst = conexion.prepareStatement(sql);
			ResultSet rs = pst.executeQuery();
			Usuario usuario = null;
			while (rs.next()) {
				usuario = new Usuario();
				usuario.setEmail(rs.getString("usr_email"));
				usuario.setPassword(rs.getString("usr_password"));
				usuario.setNick(rs.getString("usr_nick"));
				usuario.setRol(rs.getString("usr_rol"));
				usuarios.add(usuario);
			}
		} catch (SQLException e) {
			System.err.println("Error listando usuarios (" + e + ")");
		}

		return usuarios;
	}

	public static Usuario buscarUsuarioPorEmail(String email) {
		Usuario usuario = null;
		try {
			Connection conexion = Conexion.getConexion();
			String sql = "SELECT * FROM usuario WHERE usr_email = ?";
			PreparedStatement pstm = conexion.prepareStatement(sql);
			pstm.setString(1, email);
			ResultSet rs = pstm.executeQuery();

			while (rs.next()) {
				usuario = new Usuario();
				usuario.setEmail(rs.getString("usr_email"));
				usuario.setPassword(rs.getString("usr_password"));
				usuario.setNick(rs.getString("usr_nick"));
				usuario.setRol(rs.getString("usr_rol"));
			}

		} catch (Exception e) {
			System.err.println("Error recuperando el usuario con email (" + e + ")");
		}
		return usuario;
	}

	public static boolean registrarUsuario(Usuario usuario) {
		boolean registro = false;
		try {
			Connection conexion = Conexion.getConexion();
			String sql = "INSERT INTO usuario (usr_email, usr_password, usr_nick, usr_rol) VALUES (?,?,?,?);";
			PreparedStatement pstm = conexion.prepareStatement(sql);
			pstm.setString(1, usuario.getEmail());
			pstm.setString(2, usuario.getPassword());
			pstm.setString(3, usuario.getNick());
			pstm.setString(4, usuario.getRol());
			int filas = pstm.executeUpdate();
			if (filas == 1) {
				registro = true;
			} else {
				throw new RuntimeException("No se pudo registrar al usuario " + usuario);
			}

		} catch (Exception e) {

			System.err.println("No pude registrar al usuario " + e);
		}
		return registro;
	}

	public static boolean isAdministrador(Usuario usuario) {

		Connection conexion = Conexion.getConexion();
		PreparedStatement pstm;
		ResultSet resultado;
		try {
			String sql = "SELECT usr_rol FROM usuario WHERE usr_email = ? AND usr_password = ?";
			pstm = conexion.prepareStatement(sql);
			pstm.setString(1, usuario.getEmail());
			pstm.setString(2, usuario.getPassword());
			resultado = pstm.executeQuery();
			if (resultado.next() && resultado.getString("usr_rol").equals("ADMINISTRADOR"))
				return true;

		} catch (Exception e) {
			System.err.println("Error validando admin " + e);
		}

		return false;
	}

	public static void eliminarUsuario(String email) {
		try {

			String sql = "DELETE FROM usuario  WHERE usr_email = ?";
			Connection conexion = Conexion.getConexion();
			PreparedStatement pstm = conexion.prepareStatement(sql);
			pstm.setString(1, email);
			int filasAfectadas = pstm.executeUpdate();
			if (filasAfectadas != 1) {
				System.err.println("Error eliminando usuario !!");
			}

		} catch (Exception e) {
			throw new RuntimeException(e);
		}

	}





}
