package com.blog.controllers;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.blog.entidades.Entrada;
import com.blog.entidades.Usuario;
import com.blog.services.EntradaService;
import com.blog.services.UsuarioService;

@WebServlet("/profile")
public class ProfileController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		final String usuarioEmail = request.getParameter("user");
		if(usuarioEmail!=null && !usuarioEmail.isEmpty()){
			//Enviamos la lista de entradas asociadas y sus datos
			Usuario user = UsuarioService.buscarUsuarioPorEmail(usuarioEmail);
			List<Entrada> entradasAsociadas = EntradaService.listarEntradas(usuarioEmail);
			request.setAttribute("usuario", user);
			request.setAttribute("publicaciones", entradasAsociadas);
			request.getRequestDispatcher("vistas/profile.jsp").forward(request, response);
		}else{
			response.sendRedirect(request.getContextPath()+"/profileNotFound.jsp");
		}
		
	}


}
