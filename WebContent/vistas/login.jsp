<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
<script
	src="${pageContext.request.contextPath}/resources/js/jquery-1.11.2.min.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>
<title>Blog::Login</title>
<style>
	.espacio{
		margin-bottom: 20px;
	
	}
</style>
</head>
<body>


	<!-- Nav tabs -->
	<ul class="nav nav-tabs" role="tablist">
		<li role="presentation" class="${not empty login ? 'active ': ''}"><a
			href="#iniciar" aria-controls="home" role="tab" data-toggle="tab">Iniciar
				sesión</a></li>
		<li role="presentation" class="${not empty register ? 'active' : ''}"><a
			href="#registrarse" aria-controls="home" role="tab" data-toggle="tab">Registrarse</a></li>
	</ul>

	<!-- Tab panes -->
	<div class="tab-content">
		<div role="tabpanel"
			class="tab-pane fade ${not empty login ? 'in active' : ''  }"
			id="iniciar">
			<h2 class="container page-header">Inicie sesión</h2>

			<form action="login" method="post" class="container form-horizontal">
				<div class="form-group">
					<label class="col-lg-2 control-label">Ingrese su email</label>
					<div class="col-lg-6">
						<input class="form-control" type="text" name="email"
							placeholder="email@ejemplo.com" value="${usuario.email}">
					</div>
				</div>
				<div class="form-group">
					<label class="col-lg-2 control-label">Ingrese su password</label>
					<div class="col-lg-6">
						<input type="password" name="password" class="form-control"
							placeholder="contraseña" value="${usuario.password}" id="pass">
					</div>
				</div>

				<div class="form-group">
					<div class="col-sm-offset-2 col-sm-10">
						<button type="submit" class="btn btn-primary btn-md">Enviar</button>
					</div>
				</div>
			</form>
			<hr>
			<c:if test="${not empty datos}">
				<div class="col-sm-offset-2 col-sm-7 alert alert-danger text-center"
					id="datos">
					<p>&raquo;${datos}!&laquo;</p>
				</div>

			</c:if>
			<c:if test="${not empty usuarioInvalido}">
				<div class="col-sm-offset-2 col-sm-7 alert alert-warning text-center"
					id="usuarioInvalido">
					<p>&raquo;${usuarioInvalido}!&laquo;</p>
				</div>

			</c:if>
			<c:if test="${not empty sesion}">
				<div class="col-sm-offset-2 col-sm-7 alert alert-info text-center"
					id="sesion">
					<p>&raquo;${sesion}!&laquo;</p>
				</div>

			</c:if>


		</div>

		<div role="tabpanel"
			class="tab-pane fade ${not empty register ? 'in active': '' }"
			id="registrarse">

			<h2 class="container page-header">Registro de usuario</h2>
			<form action="register" method="post"
				class="container form-horizontal">
				<div class="form-group">
					<label class="col-lg-2 control-label">Ingrese su email</label>
					<div class="col-lg-6">
						<input id="email" class="form-control" type="text"
							name="emailRegister" placeholder="email@ejemplo.com"
							value="${register.email}">
					</div>
				</div>
				<div class="form-group">
					<label class="col-lg-2 control-label">Ingrese su usuario</label>
					<div class="col-lg-6">
						<input placeholder="Ingrese un usuario" class="form-control"
							type="text" name="nick" value="${register.nick}">
					</div>
				</div>
				<div class="form-group">
					<label class="col-lg-2 control-label">Ingrese su contraseña</label>
					<div class="col-lg-6">
						<input type="password" name="password1" class="form-control"
							placeholder="Ingrese su password" value="${register.password}" id="pass2">
					</div>
				</div>

				<div class="form-group">
					<label class="col-lg-2 control-label">Repita su contraseña</label>
					<div class="col-lg-6">
						<input type="password" name="password2" class="form-control"
							placeholder="Repita su password" value="${password2}">
					</div>
				</div>

				<div class="form-group">
					<div class="col-sm-offset-2 col-sm-10">
						<input type="submit" value="Registrarse"
							class="btn btn-success btn-md">
					</div>
				</div>
			</form>


			<hr>
			<c:if test="${not empty datosVacios}">
				<div class="col-sm-offset-2 col-sm-7 alert alert-info text-center"
					id="datosVacios">
					<p>&raquo;${datosVacios}!&laquo;</p>
				</div>

			</c:if>
			<c:if test="${not empty datosRegister}">
				<div class="col-sm-offset-2 col-sm-7 alert alert-warning text-center"
					id="datosRegister">
					<p>&raquo;${datosRegister}!&laquo;</p>
				</div>

			</c:if>
		</div>
	</div>





</body>
</html>