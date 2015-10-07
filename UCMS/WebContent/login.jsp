<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>UCMS - Login</title>

	<!-- JQuery -->
	<script src="js/jquery.js"></script>

	<!-- Bootstrap -->
	<link rel="stylesheet" href="css/bootstrap.min.css">
	<link rel="stylesheet" href="css/style.css">
	<script src="js/bootstrap.min.js"></script>
</head>

<body>
	<div class="container-fluid" style="margin: 20px 0;">
		<div class="row margin-40">
			<div class="col-md-4 col-md-offset-4">
				<img src="img/ucms-logo.png" class="logo" />
			</div>
		</div><!-- /row -->
		<div class="row">
			<div class="col-md-6 col-md-offset-3 login-col">
				<div class="row">
					<div class="col-md-6 login-ack login-padding">
						<p style="margin-top: 10px;">We would like to express our thanks of gratitude to our teacher (Dr. Jose Annunziato) who gave us the golden opportunity to do this wonderful project on the topic (University Course Management System).</p>
					</div>
					<div class="col-md-6 login-padding">
						<form action="login" method="post" name="form">
							<input type="text" class="form-control margin-10" id="username" name="username" placeholder="Username" />
							<input type="password" class="form-control margin-10" id="password" name="user_pass" placeholder="Password" />
							<button type="submit" class="btn login-button">Login</button>
						</form>
					</div>
				</div><!-- /row -->
			</div>
		</div><!-- /row -->
	</div><!-- /container -->
	
</body>

</html>