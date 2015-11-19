package com.blog.controllers;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.blog.entidades.Usuario;
import com.blog.services.UsuarioService;

/**
 * Servlet implementation class AdministradorController
 */
@WebServlet("/administrador")
public class AdministradorController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	public static final String CARGAR_USUARIOS = "cargar";
	public static final String ELIMINAR_USUARIOS = "eliminar";
	public static final String VALIDAR_ADMIN = "validar";

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("(GET)[ URL = /administrador ] [SERVLET = AdminController ]");

		if (isSesionIniciada(request)) {
			String operacion = request.getParameter("operacion");
			System.out.println("La operacion que llego es '" + operacion + "'");
			// Si hay una sesion de administrador activa y si hay una operacion
			// invocada
			if (operacion != null && !operacion.isEmpty()) {
				switch (operacion) {
				case VALIDAR_ADMIN:
					validarAdmin(request, response);
					break;

				case CARGAR_USUARIOS:
					cargarNuevoUsuario(request, response);
					break;

				case ELIMINAR_USUARIOS:

					eliminarUsuario(request, response);
					break;

				}

			}
			refrescarNavegador(request, response);
		}

		else {
			validarAdmin(request, response);
		}
	}

	private void validarAdmin(HttpServletRequest request, HttpServletResponse response) {
		System.out.println("(POST)[ URL = /administrador ] [SERVLET = AdminController ]");
		Usuario usuario = obtenerUsuario(request);
		try {
			if (isDatosValidados(usuario)) {
				if (UsuarioService.isAdministrador(usuario)) {
					request.getSession().setAttribute("administrador", usuario);
					List<Usuario> usuarios = UsuarioService.listarUsuarios();
					request.setAttribute("usuarios", usuarios);
					request.getSession().setAttribute("usuarios", usuarios);
					request.getRequestDispatcher("/vistas/admin/admin.jsp").forward(request, response);

				} else {
					request.setAttribute("errorAdmin", "Error, usuario o contraseña incorrectos");
					request.getRequestDispatcher("/vistas/admin/login.jsp").forward(request, response);
				}
			} else {
				request.setAttribute("iniciar", "Ingrese los datos de su cuenta para administrar el blog");
				request.getRequestDispatcher("/vistas/admin/login.jsp").forward(request, response);
			}

		} catch (Exception e) {
			throw new RuntimeException("Error validando administrador " + e);
		}

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

	private void eliminarUsuario(HttpServletRequest request, HttpServletResponse response) {
		try {
			System.out.println("Apunto de eliminar al usuario con email " + request.getParameter("email"));
			UsuarioService.eliminarUsuario(request.getParameter("email"));
		} catch (Exception e) {
			throw new RuntimeException("Error eliminando usuario");
		}

	}

	private void cargarNuevoUsuario(HttpServletRequest request, HttpServletResponse response) {
		Usuario usuario = new Usuario(request.getParameter("email"), request.getParameter("password"), request.getParameter("nick"), request.getParameter("rol"));
		if (isDatosValidados(usuario)) {
			UsuarioService.registrarUsuario(usuario);
		} else {
			request.getSession().setAttribute("errorCarga", "Información: Para cargar un usuario debe rellenar su email y su contraseña");
		}

	}

	private void refrescarNavegador(HttpServletRequest request, HttpServletResponse response) {

		try {
			List<Usuario> usuarios = UsuarioService.listarUsuarios();
			request.setAttribute("usuarios", usuarios);
			request.getRequestDispatcher("/vistas/admin/admin.jsp").forward(request, response);
		} catch (Exception e) {
			throw new RuntimeException("Error refrescando " + e);
		}

	}

	private boolean isDatosValidados(Usuario usuario) {

		return (usuario.getEmail() != null && !usuario.getEmail().isEmpty() && usuario.getPassword() != null && !usuario.getPassword().isEmpty());
	}

	private Usuario obtenerUsuario(HttpServletRequest request) {

		return new Usuario(request.getParameter("email"), request.getParameter("password"), "", "");
	}

	private boolean isSesionIniciada(HttpServletRequest request) {

		return (request.getSession().getAttribute("administrador") != null);
	}

}
