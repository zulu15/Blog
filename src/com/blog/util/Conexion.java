package com.blog.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Conexion {
	// CONSTANTES PARA LA CONEXION
	private static final String USUARIO = "root";
	private static final String PASSWORD = "root";
	private static final String DRIVER = "com.mysql.jdbc.Driver";
	private static final String HOST = "jdbc:mysql://localhost/blog?zeroDateTimeBehavior=convertToNull";
	// Utilizamos singleton para la conexion
	private static Connection conexion = null;

	public static  Connection getConexion() {

		if (conexion == null) {
			try {
				// Levanto el driver
				Class.forName(DRIVER);
				// Obtengo la conexion
				conexion = DriverManager.getConnection(HOST, USUARIO, PASSWORD);
			} catch (ClassNotFoundException | SQLException e) {
				System.err.println("Error intentando establecer la conexión (" + e + ")");
			}
		}
		return conexion;
	}

	//Constructor privado no nos interesa que nadie instancie la conexion
	private Conexion() {
	}
}
