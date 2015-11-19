<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Admin:Login</title>
<!-- BOOTSTRAP STYLES-->
<link
	href="${pageContext.request.contextPath}/resources/css/bootstrap.css"
	rel="stylesheet" />
<!-- FONTAWESOME STYLES-->
<link
	href="${pageContext.request.contextPath}/resources/css/font-awesome.css"
	rel="stylesheet" />
<!-- CUSTOM STYLES-->
<link href="${pageContext.request.contextPath}/resources/css/custom.css"
	rel="stylesheet" />
<!-- GOOGLE FONTS-->
<link href='http://fonts.googleapis.com/css?family=Open+Sans'
	rel='stylesheet' type='text/css' />

</head>
<body>
	<div class="container">
		<div class="row text-center ">
			<div class="col-md-12">
				<br /> <br />
				<h2>Administrador : Login</h2>

				<h5>Portal de administración del blog</h5>
				<br />
			</div>
		</div>
		<div class="row ">

			<div
				class="col-md-4 col-md-offset-4 col-sm-6 col-sm-offset-3 col-xs-10 col-xs-offset-1">
				<div class="panel panel-default">
					<div class="panel-heading">
						<strong> Complete sus datos: </strong>
					</div>
					<div class="panel-body">
						<form action="/Blog/administrador" method="post">
							<input type="hidden" name="operacion" value="validar"> <br />
							<div class="form-group input-group">
								<span class="input-group-addon"><i class="fa fa-tag"></i></span>
								<input type="text" class="form-control"
									placeholder="Ingrese su email " name="email" />
							</div>
							<div class="form-group input-group">
								<span class="input-group-addon"><i class="fa fa-lock"></i></span>
								<input type="password" class="form-control"
									placeholder="Ingrese su contraseña" name="password" />
							</div>
							<div class="form-group">
								<label class="checkbox-inline"> <input type="checkbox" />
									Recordarme
								</label>
							</div>




							<input type="submit" value="Ingresar"
								class="btn btn-primary btn-block" />


							<hr />
							<c:if test="${not empty errorAdmin }">


								<div class="alert alert-danger" role="alert">
									<span class="glyphicon glyphicon-exclamation-sign"
										aria-hidden="true"></span> <span class="sr-only">Error:</span>
									${errorAdmin}
								</div>
							</c:if>
							<c:if test="${not empty iniciar}">
								<div class="alert alert-info" role="alert">
								<span class="glyphicon glyphicon-user" aria-hidden="true"></span>
								<span class="sr-only">Error:</span>
								Ingrese los datos de su cuenta administrativa
								</div>

							</c:if>


						</form>
					</div>

				</div>
			</div>


		</div>
	</div>


</body>
</html>
