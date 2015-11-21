package com.blog.controllers;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.blog.entidades.Categoria;
import com.blog.entidades.Usuario;
import com.blog.services.CategoriaService;
import com.blog.services.UsuarioService;
import com.sun.org.apache.regexp.internal.RE;

/**
 * Servlet implementation class AdministradorController
 */
@WebServlet("/administrador")
public class AdministradorController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	public static final String CARGAR_USUARIOS = "cargarUsuario";
	public static final String CARGAR_CATEGORIAS = "cargarCategoria";
	public static final String ELIMINAR_USUARIOS = "eliminarUsuario";
	public static final String LISTAR_USUARIOS = "listarUsuarios";
	public static final String ELIMINAR_CATEGORIA = "eliminarCategoria";
	public static final String LISTAR_CATEGORIAS = "listarCategorias";
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
					mantenerVistaUsuarios(request);
					break;

				case LISTAR_USUARIOS:

					listarUsuarios(request, response);
					break;

					
				case CARGAR_CATEGORIAS:
					cargarNuevaCategoria(request, response);

					break;
				case ELIMINAR_CATEGORIA:

					eliminarCategoria(request, response);
					mantenerVistaCategoria(request);
					break;

				case LISTAR_CATEGORIAS:

					listarCategorias(request, response);
					break;

				}

			} else {
				listarUsuarios(request, response);
			}

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
					mantenerVistaUsuarios(request);
					request.getSession().setAttribute("administrador", usuario);
					List<Categoria> categorias = CategoriaService.listarCategorias();
					request.setAttribute("categorias", categorias);
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
		System.out.println("(POST)[ URL = /administrador ] [SERVLET = AdminController ]");
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
		System.out.println("A punto de cargar el usuario " + usuario);
		if (isDatosValidados(usuario)) {
			UsuarioService.registrarUsuario(usuario);
		} else {
			request.getSession().setAttribute("errorCarga", "Información: Para cargar un usuario debe rellenar su email y su contraseña");
		}

	}

	private void listarUsuarios(HttpServletRequest request, HttpServletResponse response) {

		try {
			mantenerVistaUsuarios(request);
			List<Categoria> categorias = CategoriaService.listarCategorias();
			request.setAttribute("categorias", categorias);
			List<Usuario> usuarios = UsuarioService.listarUsuarios();
			request.setAttribute("usuarios", usuarios);
			request.getRequestDispatcher("/vistas/admin/admin.jsp").forward(request, response);
		} catch (Exception e) {
			throw new RuntimeException("(Error listando usuarios) " + e);
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

	private void mantenerVistaUsuarios(HttpServletRequest request) {
		request.setAttribute("usuarioVista", "se esta usando el panel de administracion de usuarios");

	}
	
	
	private void listarCategorias(HttpServletRequest request, HttpServletResponse response) {

		try {
			mantenerVistaCategoria(request);
			List<Categoria> categorias = CategoriaService.listarCategorias();
			request.setAttribute("categorias", categorias);
			List<Usuario> usuarios = UsuarioService.listarUsuarios();
			request.setAttribute("usuarios", usuarios);
			request.getRequestDispatcher("/vistas/admin/admin.jsp").forward(request, response);
		} catch (Exception e) {
			throw new RuntimeException("(Error listando categorias) " + e);
		}

		
	}

	private void mantenerVistaCategoria(HttpServletRequest request) {
		request.setAttribute("categoriaVista", "se esta usando el panel de administracion de categorias");
		
	}

	private void cargarNuevaCategoria(HttpServletRequest request, HttpServletResponse response) {
		Categoria categoria= new Categoria(0, request.getParameter("categoriaNombre"));
		System.out.println("A punto de cargar la categoria " + categoria);
		if (categoria.getNombre()!=null && !categoria.getNombre().isEmpty()){
			CategoriaService.registrarCategoria(categoria);
		} else {
			request.getSession().setAttribute("errorCategoria", "Información: Para cargar una categoria rellene su nombre.");
		}

	}
	
	private void eliminarCategoria(HttpServletRequest request, HttpServletResponse response) {
		try {
			System.out.println("A punto de eliminar categoria con id" + request.getParameter("id"));
			CategoriaService.eliminarCategoria(Long.parseLong(request.getParameter("id")));
		} catch (Exception e) {
			throw new RuntimeException("Error eliminando categoria");
		}
		
	}
}
