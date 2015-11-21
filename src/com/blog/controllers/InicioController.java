package com.blog.controllers;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.blog.entidades.Categoria;
import com.blog.entidades.Entrada;
import com.blog.entidades.Usuario;
import com.blog.services.CategoriaService;
import com.blog.services.EntradaService;

@WebServlet(name = "/entradas", urlPatterns = { "/inicio" })
public class InicioController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("(GET)[ URL = /inicio ] [SERVLET = InicioController ]" + "[operacion = " + request.getParameter("operacion") + "]");

		// Muestro las entradas y envio al usuario a la pagina de inicio
		List<Entrada> entradass = EntradaService.listarEntradas();
		request.setAttribute("entradas", entradass);

		// Guardo las categorias
		List<Categoria> categorias = CategoriaService.listarCategorias();
		request.setAttribute("listaCategorias", categorias);

		// Obtengo las operaciones enviadas a traves del metodo GET con Ajax
		String operacion = request.getParameter("operacion");

		if (operacion != null && !operacion.isEmpty()) {
			switch (operacion) {

			case "salir":

				cerrarSesion(request, response);

				break;

			case "listar":

				listarEntradas(request, response);

				break;

			case "guardar":

				guardarNuevaEntrada(request, response);

				break;
			case "eliminar":

				eliminarEntrada(request, response);

				break;
			default:
				System.err.println("Parametro ingresado no coincide con los disponibles");
				break;

			}
		} else {
			// Tira error de procesamiento de los otros forwards sino
			// incluyo el else..
			request.getRequestDispatcher("vistas/inicio.jsp").forward(request, response);
		}

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("(POST)[ URL = /inicio ] [SERVLET = InicioController ]");
		doGet(request, response);
	}

	private void eliminarEntrada(HttpServletRequest request, HttpServletResponse response) {

		String id = request.getParameter("id");
		if (isAutorEntrada(id, (Usuario) request.getSession().getAttribute("usuario"))) {
			EntradaService.eliminarEntrada(id, (Usuario) request.getSession().getAttribute("usuario"));
		} else {
			String mensaje = "No puede eliminar entradas de otros usuarios";
			request.setAttribute("errorEliminando", mensaje);
		}

	}

	private void listarEntradas(HttpServletRequest request, HttpServletResponse response) {

		try {
			List<Entrada> entradas = EntradaService.listarEntradas();
			request.setAttribute("entradas", entradas);
			request.getRequestDispatcher("vistas/inicio.jsp").forward(request, response);
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	private void guardarNuevaEntrada(HttpServletRequest request, HttpServletResponse response) throws IOException {
		try {

			Entrada entrada = getEntrada(request);

			if (isEntradaCorrecta(entrada)) {
				// Persisto la entrada
				EntradaService.guardarEntrada(entrada);
			} else {
				throw new RuntimeException("No cumple los requisitos!!");

			}

		} catch (Exception e) {
			e.printStackTrace();

		}

	}

	private void cerrarSesion(HttpServletRequest request, HttpServletResponse response) {

		try {
			// Obtengo la sesion
			HttpSession session = request.getSession();
			// Remuevo el usuario guardado
			session.removeAttribute("usuario");
			// Invalido la sesion "por las dudas"
			session.invalidate();
			// Redirijo al login
			request.setAttribute("login", "mostrame el login");
			request.getRequestDispatcher("/vistas/login.jsp").forward(request, response);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	private static boolean isEntradaCorrecta(Entrada entrada) {
		return (entrada.getTitulo() != null && !entrada.getTitulo().isEmpty() && entrada.getDescripcion() != null && !entrada.getDescripcion().isEmpty() && entrada.getEmailUsuario() != null && !entrada.getEmailUsuario().isEmpty());
	}

	private static boolean isAutorEntrada(String id, Usuario usuarioSesion) {
		List<Entrada> entradas = EntradaService.listarEntradas();
		for (Entrada entrada : entradas) {
			if (String.valueOf(entrada.getId()).equals(id) && entrada.getEmailUsuario().equals(usuarioSesion.getEmail())) {
				return true;
			}
		}
		return false;
	}

	private Entrada getEntrada(HttpServletRequest request) {
		// Obtengo el titulo de la entrada
		String tituloEntrada = request.getParameter("titulo");
		// Obtengo la descripcion de la entrada
		String descripcionEntrada = request.getParameter("descripcion");
		// Obtengo el email del autor de la entrada
		String emailAutor = request.getParameter("email");
		// Obtengo la categoria a la que pertenece la publicacion
		String idCat = request.getParameter("cat");

		return new Entrada(tituloEntrada, descripcionEntrada, emailAutor, getCurrentDate(), Long.parseLong(idCat));
	}

	private static java.sql.Date getCurrentDate() {
		java.util.Date today = new java.util.Date();
		return new java.sql.Date(today.getTime());
	}

}
