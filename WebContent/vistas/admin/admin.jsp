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
<body>
	<div class="container">

		<form class="form-horizontal" id="usuario">
			<fieldset>

				<!-- Form Name -->
				<legend>Administración de usuarios</legend>
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
				<c:forEach items="${usuarios}" var="usuario">
					<tr>
						<td>${usuario.email}</td>
						<td>${usuario.nick}</td>
						<td>${usuario.password}</td>
						<td>${usuario.rol}</td>
						<td>


							<button class="btn btn-danger btn-sm"
								onClick="eliminar('${usuario.email}')">
								<span class='glyphicon glyphicon-trash' aria-hidden='true'></span>
							</button>
						</td>
					</tr>

				</c:forEach>
			</tbody>
		</table>

	</div>






	<script type="text/javascript">
		$(document).ready(function() {

			$("#cargar").click(function() {

				$.ajax({
					url : '${pageContext.request.contextPath}/administrador?operacion=cargar',
					type : 'POST',
					data : $("#usuario").serialize(),
					dataType : 'json',
					success : function() {
						alert("Ok");
					},
					error : function(data) {
						window.location = "${pageContext.request.contextPath}/administrador?operacion=listar";
					}
				});

			});

		});

		function eliminar(email) {
			var emailAdministrador = '${administrador.email}';
			var respuesta = confirm("¿Esta seguro que desea eliminar esta publicación?");
			if (respuesta == true && emailAdministrador != email) {
				$.ajax({
					url : '${pageContext.request.contextPath}/administrador?operacion=eliminar&email=' + email,
					type : 'GET',
					success : function(data) {
						if (data.error != null) {
							alert(data.error);
						} else {

							window.location = "${pageContext.request.contextPath}/administrador?operacion=listar";

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