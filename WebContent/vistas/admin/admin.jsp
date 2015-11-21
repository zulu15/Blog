<%@page import="com.blog.entidades.Usuario"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script
	src="${pageContext.request.contextPath}/resources/js/jquery-1.11.2.min.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/js/bootstrap.js"></script>
<link
	href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css"
	rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Administrador:Blog</title>
</head>
<%
	Usuario usuario = (Usuario) request.getSession().getAttribute(
			"administrador");
	if (usuario == null) {
		response.sendRedirect("login.jsp");
	}
%>

<body class="container">




	<!--  ADMINISTRACION -->


	<div>

		<!-- Nav tabs -->
		<ul class="nav nav-tabs" role="tablist">
			<li role="presentation"
				class="${not empty usuarioVista ? 'active' : '' }"><a
				href="#usuario" aria-controls="home" role="tab" data-toggle="tab">Administrar
					usuarios</a></li>
			<li role="presentation"
				class="${not empty categoriaVista ? 'active' : '' }"><a
				href="#categoria" aria-controls="profile" role="tab"
				data-toggle="tab">Administrar categorias</a></li>
		</ul>

		<!-- Tab panes -->
		<div class="tab-content">
			<div role="tabpanel"
				class="tab-pane fade ${not empty usuarioVista ? 'in active' : ''}"
				id="usuario">

				<!--  PANEL DE ADMINISTRACION DE USUARIOS -->
				<div class="container">

					<form class="form-horizontal" id="usuarioForm" method="post">
						<fieldset>

							
						
							<div class="well">
								<h4 class="text-primary text-center">Creación de un nuevo
									usuario:</h4>
								<br>
								<!-- Text input-->
								<div class="form-group">
									<label class="col-md-4 control-label" for="textinput">Email</label>
									<div class="col-md-4">
										<input id="textinput" name="email" type="text"
											placeholder="Email del usuario" class="form-control input-md">
									</div>
								</div>

								<div class="form-group">
									<label class="col-md-4 control-label" for="textinput">Nick</label>
									<div class="col-md-4">
										<input id="textinput" name="nick" type="text"
											placeholder="Nick usuario" class="form-control input-md">
									</div>
								</div>

								<div class="form-group">
									<label class="col-md-4 control-label" for="textinput">Privilegios</label>
									<div class="col-md-4">
										<input id="textinput" name="rol" type="text"
											placeholder="Privilegio" class="form-control input-md">
									</div>
								</div>


								<!-- Password input-->
								<div class="form-group">
									<label class="col-md-4 control-label" for="passwordinput">Contraseña</label>
									<div class="col-md-4">
										<input id="passwordinput" name="password" type="password"
											placeholder="Contraseña del usuario"
											class="form-control input-md">

									</div>
								</div>

								<!-- Button -->
								<div class="row">
									<div class="col-md-2 col-md-offset-4">
										<button class="btn btn-primary" id="cargar">Cargar</button>
									</div>
								</div>
							</div>
						</fieldset>
					</form>
					<c:if test="${not empty errorCarga }">

						<div class="alert alert-info alert-dismissible text-center"
							role="alert">

							<button type="button" class="close" data-dismiss="alert"
								aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
							<span class="glyphicon glyphicon-exclamation-sign"
								aria-hidden="true"></span> <span class="sr-only">Error:</span>
							${errorCarga}
						</div>
					</c:if>
					<br> <br> <br> <br>


					<legend class="text-center">Listado de usuarios</legend>
					<table class="table table-striped">
						<thead>
							<tr>
								<th>Email</th>
								<th>Nick</th>
								<th>Password</th>
								<th>Rol</th>
								<th>Acciones</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${usuarios}" var="user">
								<tr>
									<td>${user.email}</td>
									<td>${user.nick}</td>
									<td>${user.password}</td>
									<td>${user.rol}</td>
									<td>


										<button class="btn btn-danger btn-sm"
											onClick="eliminar('${user.email}')">
											<span class='glyphicon glyphicon-trash' aria-hidden='true'></span>
										</button>
									</td>
								</tr>

							</c:forEach>
						</tbody>
					</table>

				</div>


				<!--  FIN PANEL DE ADMINISTRACION DE USUARIOS -->

			</div>
			<div role="tabpanel"
				class="tab-pane fade ${not empty categoriaVista ? 'in active' : ''}"
				id="categoria">
				<!-- Form Name -->
				<br> <br>
				<form class="form-horizontal" id="categoriaForm" method="post">
					<fieldset class="well">
						<h4 class="container text-center text-success ">Añadir una
							nueva Categoria</h4><br>


						<!-- Text input-->
						<div class="form-group">
							<label class="col-md-4 control-label" for="categoriaNombre">Ingrese
								nombre</label>
							<div class="col-md-5">
								<input id="categoriaNombre" name="categoriaNombre" type="text"
									placeholder="Nombre.." class="form-control input-md">

							</div>
						</div>

						<!-- Button -->
						<div class="form-group">
							<label class="col-md-4 control-label" for=""></label>
							<div class="col-md-4">
								<button id="" name="" class="btn btn-success"
									onclick="cargarCategoria()">Añadir</button>
							</div>
						</div>

					</fieldset>
					<c:if test="${not empty errorCategoria }">

						<div class="alert alert-info alert-dismissible text-center"
							role="alert">

							<button type="button" class="close" data-dismiss="alert"
								aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
							<span class="glyphicon glyphicon-exclamation-sign"
								aria-hidden="true"></span> <span class="sr-only">Error:</span>
							${errorCategoria}
						</div>
					</c:if>
				</form>




				<!--  TABLA CON LAS CATEGORIAS -->

		<br>
				<legend class="text-center">Listado de categorias</legend>
				<table class="table table-striped">
					<thead>
						<tr>
							<th>ID</th>
							<th>NOMBRE</th>
							<th>ACCIONES</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${categorias}" var="cat">
							<tr>
								<td>${cat.id}</td>
								<td>${cat.nombre}</td>
								<td>


									<button class="btn btn-danger btn-sm"
										onClick="eliminarCategoria(${cat.id})">
										<span class='glyphicon glyphicon-trash' aria-hidden='true'></span>
									</button>
								</td>
							</tr>

						</c:forEach>
					</tbody>
				</table>


			</div>

		</div>
	</div>












	<script type="text/javascript">
		$(document).ready(function() {

			$("#cargar").click(function() {

				$.ajax({
					url : '${pageContext.request.contextPath}/administrador?operacion=cargarUsuario',
					type : 'POST',
					data : $("#usuarioForm").serialize(),
					dataType : 'json',
					success : function() {
						alert("Ok");
					},
					error : function(data) {
						window.location = "${pageContext.request.contextPath}/administrador?operacion=listarUsuarios";
					}
				});

			});

		});
		
		
		function cargarCategoria() {
			
	
			$.ajax({
				url : '${pageContext.request.contextPath}/administrador?operacion=cargarCategoria',
				type : 'POST',
				data : $("#categoriaForm").serialize(),
				dataType : 'json',
				success : function() {
					alert("Ok");
				},
				error : function(data) {
					window.location = "${pageContext.request.contextPath}/administrador?operacion=listarCategorias";
				}
			});

			

		}
		
		
		
		
		
		
		function eliminarCategoria(id) {
			
			var respuesta = confirm("¿Esta seguro que desea eliminar esta categoria?");
			if (respuesta == true) {
				$.ajax({
					url : '${pageContext.request.contextPath}/administrador?operacion=eliminarCategoria&id=' + id,
					type : 'POST',
					success : function(data) {
						if (data.error != null) {
							alert(data.error);
						} else {

							window.location = "${pageContext.request.contextPath}/administrador?operacion=listarCategorias";

						}
					}

				});

			} else {
				alert("No puedes eliminar un administrador");
			}

		}
		
		
		
		
		

		function eliminar(email) {
			var emailAdministrador = '${administrador.email}';
			var respuesta = confirm("¿Esta seguro que desea eliminar esta publicación?");
			if (respuesta == true && emailAdministrador != email) {
				$.ajax({
					url : '${pageContext.request.contextPath}/administrador?operacion=eliminarUsuario&email=' + email,
					type : 'POST',
					success : function(data) {
						if (data.error != null) {
							alert(data.error);
						} else {

							window.location = "${pageContext.request.contextPath}/administrador?operacion=listarUsuarios";

						}
					}

				});

			} else {
				alert("No puedes eliminar un administrador");
			}

		}
	</script>

</body>
</html>