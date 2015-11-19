package com.blog.controllers;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.blog.entidades.Usuario;
import com.blog.services.UsuarioService;

@WebServlet(name = "/prueba", urlPatterns = { "/login" })
public class LoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("(GET)[ URL = /login ] [SERVLET = LoginController ]");
		mantenerVistaLogin(request, response);
		request.getRequestDispatcher("/vistas/login.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		mantenerVistaLogin(request, response);

		System.out.println("(POST)[ URL = /login ] [SERVLET = LoginController ]");

		// Obtengo los datos que envio por el formulario
		Usuario usuario = getUsuario(request);
		// Los guardo para que el usuario no tenga que escribir todo de
		// vuelta si puso algo mal
		request.setAttribute("usuario", usuario);

		if (isDatosValidos(usuario)) {

			if (isUsuarioValido(usuario)) {
				// Si el usuario existe y coinciden sus campos lo guardo en la
				// sesion
				Usuario usuarioFinal = UsuarioService.buscarUsuarioPorEmail(usuario.getEmail());
				HttpSession sesion = request.getSession();
				sesion.setAttribute("usuario", usuarioFinal);
				request.getRequestDispatcher("/inicio").forward(request, response);

			} else {
				// Borro el usuario de la sesion si es que intento logearse
				// nuevamente
				request.getSession().removeAttribute("usuario");
				request.setAttribute("usuarioInvalido", "Error, contraseña o email incorrectos");
				request.getRequestDispatcher("/vistas/login.jsp").forward(request, response);
			}
		} else {
			// Borro el usuario de la sesion si es que intento logearse
			// nuevamente
			request.getSession().removeAttribute("usuario");
			request.setAttribute("datos", "Error, los campos no pueden ser vacios o nulos");
			request.getRequestDispatcher("/vistas/login.jsp").forward(request, response);
		}
	}

	private Usuario getUsuario(HttpServletRequest request) {
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		Usuario usr = new Usuario(email, password, "", "");
		return usr;
	}

	private boolean isUsuarioValido(Usuario user) {
		Usuario usuario = UsuarioService.buscarUsuarioPorEmail(user.getEmail());
		return (usuario != null && usuario.getPassword().equals(user.getPassword()));
	}

	private boolean isDatosValidos(Usuario usuario) {
		return (usuario.getEmail() != null && !usuario.getEmail().isEmpty() && usuario.getPassword() != null && !usuario.getPassword().isEmpty());
	}

	private void mantenerVistaLogin(HttpServletRequest request, HttpServletResponse response) {
		request.setAttribute("login", "mantenerLogin");
	}

}
