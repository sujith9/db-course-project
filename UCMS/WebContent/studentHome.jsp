<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>UCMS - Student Home</title>

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
   			<p class="about-email">Major : <span class="major"></span></p>
   		</div>
   	</div><!-- /row -->
   	<div class="row rest padding-top-bottom">
   		<div class="col-md-3">
   			<p style="text-align: right; padding-top: 6px;">Select semester : </p>
   		</div>
   		<div class="col-md-6">
   			<select class="semesters form-control"></select>
   		</div>
   		<div class="col-md-3">
   			<button class="semester-select btn ucms-button">Get Courses</button>
   		</div>
   	</div><!-- /row -->
   	<div class="row rest">
   		<div class="col-md-8 col-md-offset-2">
   			<div class="list-group courses"></div>
   		</div>
   	</div><!-- /row -->
   	
   	<hr style="border-top: 1px solid #ffffff;" />
   	
   	<div class="row rest padding-top-bottom">
   		<div class="col-md-10 col-md-offset-1">
   		
	   		<div role="tabpanel">
			  <!-- Nav tabs -->
			  <ul class="nav nav-tabs" role="tablist">
			    <li role="presentation" class="active"><a href="#notifications" aria-controls="notifications" role="tab" data-toggle="tab">Notifications</a></li>
			    <li role="presentation"><a href="#account" aria-controls="account" role="tab" data-toggle="tab">Account Settings</a></li>
			  </ul>
			  <!-- Tab panes -->
			  <div class="tab-content">
			    <div role="tabpanel" class="tab-pane fade in active" id="notifications" style="padding-top: 20px;">
					<div class="col-md-10 col-md-offset-1 events"></div>
				</div>
			    <div role="tabpanel" class="tab-pane fade" id="account" style="padding-top: 20px;">
					<div class="col-md-10 col-md-offset-1">
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
				</div>
			  </div>
			</div>
			
		</div>
   	</div><!-- /row -->   	
   </div><!-- /container -->
	
	<script type="text/javascript">
		$(function(){
			
			var personId = <%=session.getAttribute("id")%>
			
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
			
			// get major string using person ID
			$.ajax({
				url : "http://localhost:8080/UCMS/api/person/major/" + personId,
				type: "get",
				data: JSON.stringify(),
				dataType: "text",
				contentType: "application/json",
				success:function(data){
					$('.major').html(data);
				}
			});
			
			// get semester objects using person ID ordered by latest date
			$.ajax({
				url : "http://localhost:8080/UCMS/api/semester/person/" + personId,
				type: "get",
				data: JSON.stringify(),
				dataType: "json",
				contentType: "application/json",
				success:function(data){
					$.each(data, function(key, value){
						$(".semesters").append('<option value="'+value.id+'">'+value.semester+'</option>');
					});
				}
			});
			
			// get event objects using person ID
			$.ajax({
				url : "http://localhost:8080/UCMS/api/event/person/" + personId,
				type: "get",
				data: JSON.stringify(),
				dataType: "json",
				contentType: "application/json",
				success:function(data){
					$.each(data, function(key, value){
						var currentTime = new Date(parseInt(value.date));
						var month = currentTime.getMonth() + 1;
						var day = currentTime.getDate();
						var year = currentTime.getFullYear();
						var myDate = day + "/" + month + "/" + year;
						$(".events").append('<div class="panel panel-default"><div class="panel-heading">' + value.eventName + '<span style="float: right;">[ ' + myDate + ' ]</span></div><div class="panel-body">'+value.description+'</div></div>');
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
						$(".courses").append('<a class="list-group-item" href="http://localhost:8080/UCMS/courseHome.jsp?courseId='+ value.id +'">'+ value.courseName +'</a>');
					});
				}
			});
			
			$( "#update" ).click(function() {
				updateHandler(personId, enroll, submission);
			});
			
			$( ".semester-select" ).click(function() {
				courseHandler(personId);
			});
			
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
		
		function courseHandler(personId){
			semesterCourses(personId, $(".semesters").val());
		}
		
		// get course objects using person ID and semester ID according to semester onclick
		function semesterCourses(personId, semesterId){
			$.ajax({
				url : "http://localhost:8080/UCMS/api/course/" + personId + "/" + semesterId,
				type:"get",
				data: JSON.stringify(),
				dataType: "json",
				contentType: "application/json",
				success:function(data) {
					$(".courses").html('');
					$.each(data, function(key, value){
						$(".courses").append('<a class="list-group-item" href="http://localhost:8080/UCMS/courseHome.jsp?courseId='+ value.id +'">'+ value.courseName +'</a>');
					});
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