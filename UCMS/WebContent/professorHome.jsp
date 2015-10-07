<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>UCMS - Professor Home</title>
	
	<!-- JQuery -->
	<script src="js/jquery.js"></script>

	<!-- Bootstrap -->
	<link rel="stylesheet" href="css/bootstrap.min.css">
	<link rel="stylesheet" href="css/style.css">
	<script src="js/bootstrap.min.js"></script>
	
</head>
<body>
	<%
		if(session.getAttribute("loggedInUser") == null){
            response.sendRedirect(request.getContextPath() + "/login.jsp");
         }  
   %>
   
   <div class="container">
   
   		<p style="display:none;" class="user"></p>
   	
		<form action="logout" method="post" name="logout" class="logout-form">
			<button type="submit" name="logout" id="logout" class="btn login-button">Logout</button>
		</form>
		
   	<div class="row about padding-top-bottom">   	
   		<div class="col-md-4">
   			<center><img src="" class="picture profile-picture" /></center>
   		</div>
   		<div class="col-md-8">
   			<h2><span class="name"></span>&nbsp;<span class="last"></span></h2>
   			<p class="details"></p>
   			<p class="about-email">Email : <span class="email"></span></p><br />
   		</div>
   	</div><!-- /row -->
   	<div class="row rest padding-top-bottom" style="padding-bottom: 0;">
   		<div class="col-md-10 col-md-offset-1">
   			<h3>Courses this semester:</h3>
   			<div class="row">
   				<div class="col-md-12 courses">

   				</div>
   			</div>
   			<div class="row">
   				<div class="col-md-12">
   					<div class='alert alert-success alert-dismissible delete-success' role='alert' style="display: none;">
						<button type='button' class='close' data-dismiss='alert'>
							<span aria-hidden='true'>&times;</span><span class='sr-only'>Close</span>
						</button>
						<strong>Deleted!</strong> You successfully removed a course from your current semester.
					</div>
   				</div>
   			</div>
   		</div>
   	</div><!-- /row -->
   	
   	<hr style="border-top: 1px solid #ffffff;" />
   	
   	<div class="row rest" style="margin-bottom: 20px;">
   		<div class="col-md-10 col-md-offset-1">
   			<h3>Account Settings:</h3>
			<input type="text" class="form-control margin-10" id="firstname" name="firstname" placeholder="First Name" />
			<input type="text" class="form-control margin-10" id="lastname" name="lastname" placeholder="Last Name" />
			<input type="password" class="form-control margin-10" id="password" name="password" placeholder="Password" />
			<input type="text" class="form-control margin-10" id="email" name="email" placeholder="Email" value="" />
			<textarea rows="10" class="form-control margin-10" id="details" name="details" placeholder="Details"></textarea>
			<div class="row">
				<div class="col-md-8">
					<div class='alert alert-success alert-dismissible update-success' role='alert' style="display: none;">
						<button type='button' class='close' data-dismiss='alert'>
							<span aria-hidden='true'>&times;</span><span class='sr-only'>Close</span>
						</button>
						<strong>Well done!</strong> You successfully updated your information.
					</div>
				</div>
				<div class="col-md-4">
					<button id="update" class="btn login-button">Submit</button>
				</div>
			</div>						
		</div>
   	</div><!-- /row -->   	
   </div><!-- /container -->
   
   <script type="text/javascript">
		$(function(){
			
			var personId = <%=session.getAttribute("id")%>
			var personType = "<%=session.getAttribute("personType")%>"
			
			var enroll = null;
			var submission = null;
			
			// get person object using person ID
			$.ajax({
				url : "http://localhost:8080/UCMS/api/person/" + personId,
				type: "get",
				data: JSON.stringify(),
				dataType: "json",
				contentType: "application/json",
				success:function(data){					
					$.each(data, function(){
						var firstName = data["firstName"];
						var lastName = data["lastName"];
						var user = data["username"];
						var pass = data["password"];
						var email = data["email"];
						var picture = data["profilePic"];
						var details = data["details"];
						enroll = data["enrolls"];
						submission = data["submissions"];
						
						$('.name').html(firstName);
						$('.last').html(lastName);
						$('.email').html(email);
						$( '.picture' ).attr( "src", picture );
						$('.details').html(details);
						$('.user').html( user );
						
						appendToFields(firstName, lastName, user, pass, email, picture, details);
					});
				}
			});
			
			// get course objects using person ID (current semester courses)
			$.ajax({
				url : "http://localhost:8080/UCMS/api/course/person/" + personId,
				type: "get",
				data: JSON.stringify(),
				dataType: "json",
				contentType: "application/json",
				success:function(data){
					$.each(data, function(key, value){
						$(".courses").append('<div class="row"><div class="col-md-11"><div class="list-group"><a class="list-group-item" href="http://localhost:8080/UCMS/courseHome.jsp?courseId='+ value.id +'">'+ value.courseName +'</a></div></div><div class="col-md-1"><div class="list-group"><a class="list-group-item non-link" course="'+ value.id +'" href="javascript:void(0)">&#8210;</a></div></div></div>');
					});
				}
			});
			
			$( "#update" ).click(function() {
				updateHandler(personId, enroll, submission);
			});
			
			setTimeout(function(){
				$(".non-link").click(function() {
					var courseId = $(this).attr("course");
					deleteHandler(personId, courseId);
				});
			}, 100);
			
		});
		
		function updateHandler(personId, enroll, submission) {
			var pic = $("img.profile-picture").attr("src");
			var us = $(".user").html();
			console.log(us);
			var newPerson = {
					"id": personId,
					"firstName":$("#firstname").val(),
					"lastName":$("#lastname").val(),
					"username": us,
					"password":$("#password").val(),
					"email":$("#email").val(),
					"profilePic": pic,
					"details":$("#details").val(),
					"enrolls":enroll,
					"submissions":submission,
			};
			updatePerson(personId, newPerson);
		}
		
		// update person object using person ID
		function updatePerson(personId, person){
			$.ajax({
				url : "http://localhost:8080/UCMS/api/person/" + personId,
				type: "put",
				data: JSON.stringify(person),
				dataType: "json",
				contentType: "application/json",
				success:function(response){
					$( ".update-success" ).css( "display", "block" );
					setTimeout(function(){
				         window.location.reload();
					}, 2000);
				}
			});
		}
		
		function deleteHandler(personId, courseId){
			deleteEnroll(personId, courseId);
		}
		
		function deleteEnroll(personId, courseId){
			$.ajax({
				url : "http://localhost:8080/UCMS/api/enroll/professor/course/" + personId + "/" + courseId,
				type:"delete",
				data: JSON.stringify(),
				dataType: "json",
				contentType: "application/json",
				success:function(response) {
					$( ".delete-success" ).css( "display", "block" );
					setTimeout(function(){
				         window.location.reload();
					}, 2000);
				}
			});
			
		}
		
		function appendToFields(firstName, lastName, user, pass, email, picture, details){
			// Put values in the fields
			$('#firstname').val( firstName );
			$('#lastname').val( lastName );
			$('#password').val( pass );
			$('#email').val( email );
			$('#details').val( details );
		}
   </script>
   
</body>
</html>