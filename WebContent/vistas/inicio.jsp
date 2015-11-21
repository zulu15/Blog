<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Blog::Inicio</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
<script
	src="${pageContext.request.contextPath}/resources/js/jquery-1.11.2.min.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/js/bootstrap.js"></script>

<script src=""></script>


<style>
.espacio {
	margin-bottom: 6%;
}
</style>
</head>

<body>
	<!-- Static navbar -->
	<nav class="navbar navbar-inverse">
	<div class="container-fluid">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#navbar" aria-expanded="false"
				aria-controls="navbar">
				<span class="sr-only">Toggle navigation</span> <span
					class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="#">Blog programacion</a>
		</div>
		<div id="navbar" class="navbar-collapse collapse">
			<ul class="nav navbar-nav">
				<li class="active"><a href="#">Inicio</a></li>
				<li><a href="#">About</a></li>
				<li><a href="#">Contact</a></li>
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false">Dropdown <span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="#">Action</a></li>
					</ul></li>
			</ul>
			<ul class="nav navbar-nav navbar-right">
				<li><a href="inicio?operacion=salir"><span
						class="glyphicon glyphicon-off" aria-hidden="true"></span></a></li>
			</ul>
		</div>
		<!--/.nav-collapse -->
	</div>
	<!--/.container-fluid --> </nav>

	<div class="container">

		<h2 class="page-header text-center">
			<a type="button" class="btn btn-default pull-left "
				href="inicio?operacion=listar"> <span
				class="glyphicon glyphicon-home" aria-hidden="true"></span>
			</a> Bienvenido al blog
			<!-- Trigger para el modal -->
			<c:if test="${not empty usuario}">
				<button type="button" class="btn btn-default  pull-right"
					data-toggle="modal" data-target="#publicacion" onclick="limpiar()">
					<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
					Publicar
				</button>
			</c:if>
			<c:if test="${empty usuario}">
				<a type="button" class="btn btn-default pull-right " href="login">
					<span class="glyphicon glyphicon-user" aria-hidden="true"></span>
					Iniciar sesión
				</a>
			</c:if>
		</h2>

		<!-- Seccion para la publicacion de nuevas entradas -->
		<!-- Modal -->
		<div id="publicacion" class="modal fade" role="dialog">
			<div class="modal-dialog">

				<!-- Modal content-->
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4 class="modal-title">Publicar una Entrada</h4>
					</div>
					<div class="modal-body">
						<form id="entrada">
							<input type="hidden" name="email" value="${usuario.email}">
							<div class="form-group">
								<label>Titulo de la entrada</label> <input name="titulo"
									type="text" id="titulo" class="form-control">
							</div>
							<div class="form-group">
								<label>Escriba el contenido de la entrada</label>
								<textarea class="form-control" rows="3" id="descripcion"
									name="descripcion"></textarea>
							</div>
							<!--  CATEGORIAS -->
							<div class="form-group">
								<label for="sel1">Seleccionar categoria:</label> <select
									class="form-control" id="" name="cat">
									<c:forEach items="${listaCategorias}" var="categoria">
										<option value="${categoria.id}">${categoria.nombre}</option>
									</c:forEach>
								</select> <br>

							</div>
							<!-- FIN DE LAS CATEGORIAS -->

						</form>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-danger" data-dismiss="modal">Salir</button>
						<button type="button" class="btn btn-primary" id="guardar">Publicar</button>
					</div>
				</div>

			</div>
		</div>

		<div class="jumbotron text-center">
			<h2>
				<u>Ultimas entradas disponibles en el blog</u>
			</h2>

		</div>

		<div class="espacio">
			<!-- Espacio de separacion entre las entradas y el boton de publicacion -->
		</div>


		<c:forEach items="${entradas}" var="entrada">
			<div class="panel panel-primary">
				<c:if test="${entrada.emailUsuario == usuario.email}">
					<button type="button" class="btn btn-primary pull-right"
						onclick="eliminar(${entrada.id})">
						<span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
					</button>
				</c:if>
				<div class="panel-heading">

					<c:forEach items="${listaCategorias}" var="cate">
						<c:if test="${entrada.idCategoria == cate.id}">
							<h2 class="panel-title">${cate.nombre}</h2>
						</c:if>
					</c:forEach>


				</div>
				<div class="panel-body">
					<b class="">Titulo: ${entrada.titulo}</b>
					<hr>
					<p>${entrada.descripcion}</p>
				</div>
				<div class="panel-footer">
					<strong>Fecha de publicacion: ${entrada.fecha}</strong> <span
						class="pull-right">Autor: <a>${entrada.emailUsuario}</a></span>
				</div>
			</div>
			<div class="espacio"></div>
		</c:forEach>

	</div>


	<script>
		$(document).ready(function() {

			$("#guardar").click(function() {

				  $.ajax({
				        url: '${pageContext.request.contextPath}/inicio?operacion=guardar',
				        type: 'POST',
				        data: $("#entrada").serialize(),
				        dataType: 'json',
				        success: function(){
				        	alert("Ok");
				        },
				        error: function(data){
				        	window.location = "${pageContext.request.contextPath}/inicio?operacion=listar";
				        }
				    });

				
				
			});

		});

		function limpiar() {

			$("#tituloEntrada").val("");
			$("#contenidoEntrada").val("");

		}
		
		
		function eliminar(id){
			var respuesta = confirm("¿Esta seguro que desea eliminar esta publicación?");
			if (respuesta == true) {
				$.ajax({
					url : '${pageContext.request.contextPath}/inicio?operacion=eliminar&id='+id,
					type : 'POST',
					success : function(data) {
						if (data.error != null) {
							alert(data.error);
						} else {
	
							window.location = "${pageContext.request.contextPath}/inicio?operacion=listar";
							
						}
					}

				});

			} 
						
		}
		
	</script>




</body>
</html>