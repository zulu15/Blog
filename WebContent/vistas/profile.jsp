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
	margin-top: 6%;
}
</style>
</head>

<body>
	<h1 class="page-header text-center">Perfil del usuario
		${usuario.email}</h1>

	<div style="text-align: center;">
		<img alt=""
			src="${pageContext.request.contextPath}/resources/imgs/profile_icon.jpg" />
		<p>
			<b>Nick: </b>${usuario.nick}</p>
		<p>
			<b>Rol: </b>${usuario.rol}</p>

	</div>


	<div class="espacio container">
		<h2 class="text-center">Entradas publicadas por ${usuario.nick}</h2>
		<p class="espacio"></p>
		<c:forEach items="${publicaciones}" var="entrada">
			<div class="panel panel-primary">
				<div class="panel-heading">

					<b class="">Titulo: ${entrada.titulo}</b>

				</div>
				<div class="panel-body">

					<p>${entrada.descripcion}</p>
				</div>
				<div class="panel-footer">
					<strong>Fecha de publicacion: ${entrada.fecha}</strong> <span
						class="pull-right">Autor: <a
						href="${pageContext.request.contextPath}/profile?user=${entrada.emailUsuario}">${entrada.emailUsuario}</a></span>
				</div>
			</div>
			<div class="espacio"></div>
		</c:forEach>
	</div>







</body>
</html>