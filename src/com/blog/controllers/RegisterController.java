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

@WebServlet("/register")
public class RegisterController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		System.out.println("(GET)[ URL = /register ] [SERVLET = RegisterController ]");
		mantenerVistaRegister(request, response);
		request.getRequestDispatcher("/vistas/login.jsp").forward(request, response);

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		System.out.println("(POST)[ URL = /register ] [SERVLET = RegisterController ]");
		mantenerVistaRegister(request, response);

		// Pido los datos del usuario que intenta registrarse
		Usuario usuarioRegister = getUsuario(request);
		// Obtengo el campo de repiticion de la password
		String confirmaPassword = request.getParameter("password2");

		// Comparto los datos ingresado para que no vuelva a escribir
		request.setAttribute("register", usuarioRegister);

		// Si los datos no son vacios ni nulos y las passwords coinciden
		if (isDatosValidos(usuarioRegister, confirmaPassword)) {

			// Si se logro registrar al usuario
			if (registrarUsuario(usuarioRegister)) {
				// Lo guardo en sesion
				HttpSession sesion = request.getSession();
				sesion.setAttribute("usuario", usuarioRegister);
				request.getRequestDispatcher("/inicio").forward(request, response);

			} else {

				// Borro el usuario de la sesion si es que intento logearse
				// nuevamente
				request.getSession().removeAttribute("usuario");
				request.setAttribute("datosRegister", "Error, eliga otro nombre de usuario o correo electronico");
				request.getRequestDispatcher("/vistas/login.jsp").forward(request, response);
			}

		} else {
			// Borro el usuario de la sesion si es que intento logearse
			// anteriormente
			request.getSession().removeAttribute("usuario");
			request.setAttribute("datosVacios", "Error, verifique los datos");
			request.getRequestDispatcher("/vistas/login.jsp").forward(request, response);
		}
	}

	private Usuario getUsuario(HttpServletRequest request) {
		String email = request.getParameter("emailRegister");
		String password = request.getParameter("password1");
		String nick = request.getParameter("nick");
		Usuario user = new Usuario(email, password, nick, "");
		return user;
	}

	private boolean registrarUsuario(Usuario usuario) {
		return UsuarioService.registrarUsuario(usuario);

	}

	private boolean isDatosValidos(Usuario usuarioRegister, String confirmaPass) {

		return (usuarioRegister.getEmail() != null && !usuarioRegister.getEmail().isEmpty() && usuarioRegister.getNick() != null && !usuarioRegister.getNick().isEmpty() && usuarioRegister.getPassword() != null && confirmaPass != null && usuarioRegister.getPassword().equals(confirmaPass));
	}

	private void mantenerVistaRegister(HttpServletRequest request, HttpServletResponse response) {
		request.setAttribute("register", "mantenerRegistro");

	}

}
