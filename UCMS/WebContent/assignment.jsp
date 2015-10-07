<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>UCMS - Assignment</title>
	
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

	<%String personType = (String)session.getAttribute("personType");%>
	<% String assignment_Id = (String)request.getParameter("assignmentId");%>

	<div class="container">

		<form action="logout" method="post" name="logout" class="logout-form">
			<button type="submit" name="logout" id="logout"
				class="btn login-button">Logout</button>
		</form>

		<!-- REST -->

		<div class="row rest padding-top-bottom" style="padding-bottom: 0;">
			<div class="col-md-10 col-md-offset-1">
				<div class="page-header" style="border:none;">
					<h3 class="title"></h3>
					<h3>
						<span class="label label-default">Due : <span class="date"></span></span>
					</h3>
				</div>
				
				<% if(personType.equals("professor")){ %>

				<div class="update-form" style="display: none;">
					<input type="text" class="form-control margin-10" id="title" name="title" placeholder="Title" />
					<input type="text" class="form-control margin-10" id="date" name="date" placeholder="Due Date (yyyy-mm-dd)" />
					<textarea rows="10" class="form-control margin-10" id="content" name="content" placeholder="Content"></textarea>

					<div class="row">
						<div class="col-md-8">
							<div class='alert alert-success alert-dismissible update-success' role='alert' style="display: none;">
								<button type='button' class='close' data-dismiss='alert'>
									<span aria-hidden='true'>&times;</span><span class='sr-only'>Close</span>
								</button>
								<strong>Well done!</strong> You successfully updated this assignment.
							</div>
						</div>
						<div class="col-md-4">
							<button id="update-assgn" class="btn login-button">Update</button>
						</div>
					</div>
					<!-- /row -->
				</div>
					
				<% } %>

				<div class="well content"></div>

				<% if(personType.equals("professor")){ %>

				<div class="row" style="padding-bottom: 20px;">
					<div class="col-md-6 col-md-offset-6">
						<button id="update-assignment" class="btn login-button">Edit Assignment</button>
					</div>
				</div>
				<!-- /row -->
				
				<div class="row" style="padding-bottom: 30px;">
					<div class="col-md-12"><h4 style="margin-bottom: 20px;">Assignment Submissions: </h4></div>
					<div class="col-md-12 student-submissions"></div>
				</div><!-- /row -->

				<% }else{ %>

				<div class="row" style="padding-bottom: 30px;">
					<div class="col-md-6 col-md-offset-6">
						<a href="http://localhost:8080/UCMS/submission.jsp?assignmentId=<%= assignment_Id %>" class="btn login-button">View Submission</a>
					</div>
				</div>
				<!-- /row -->

				<% } %>

			</div>
		</div>
		<!-- /row -->

		<!-- /REST -->

	</div>
	<!-- /container -->

	<script type="text/javascript">
		$(function(){
			
			var personId = <%=session.getAttribute("id")%>
			var personType = "<%=session.getAttribute("personType")%>"
			var assignmentId = <%=request.getParameter("assignmentId")%>
			
			var course = null;
			
			// get assignment object using assignment ID
			$.ajax({
				url : "http://localhost:8080/UCMS/api/assignment/" + assignmentId,
				type: "get",
				data: JSON.stringify(),
				dataType: "json",
				contentType: "application/json",
				success:function(data){					
					$.each(data, function(){
						var title = data["title"];
						var dueDate = data["dueDate"];
						var content = data["content"];
						course = data["course"];
						
						var currentTime = new Date(parseInt(dueDate));
						var month = currentTime.getMonth() + 1;
						var day = currentTime.getDate();
						var year = currentTime.getFullYear();
						var myDate = day + "/" + month + "/" + year;
						var otherDate = year + "-" + month + "-" + day;
						
						$('.title').html(title);
						$( '.date' ).html(myDate);
						$('.content').html(content);
						
						appendToFields(title, otherDate, content);
					});
				}
			});
			
			// get submission objects using assignment ID
			$.ajax({
				url : "http://localhost:8080/UCMS/api/submission/assignment/" + assignmentId,
				type: "get",
				data: JSON.stringify(),
				dataType: "json",
				contentType: "application/json",
				success:function(data){
					$.each(data, function(key, value){
						var person = value.person;
						$(".student-submissions").append('<div class="row"><div class="col-md-12"><div class="list-group"><a class="list-group-item" href="http://localhost:8080/UCMS/submission.jsp?personId='+ person.id +'&assignmentId=' + assignmentId + '">'+ person.firstName + ' ' + person.lastName +'</a></div></div></div>');
					});
				}
			});
			
			$( "#update-assignment" ).click(function() {
				$(".content").slideUp();
				$(".update-form").slideDown();
				$("#update-assignment").hide();
			});
			
			$( "#update-assgn" ).click(function() {
				updateHandler(assignmentId, course);
			});
			
		});
		
		function updateHandler(assignmentId, course) {
			var title = $("#title").val();
			var date = $("#date").val();
			var n = new Date(date);
			var newDate = n.getTime();
			var content = $("#content").val();
			var newAssignment = {
					"id": assignmentId,
					"title": title,
					"dueDate": newDate,
					"content": content,
					"course" : course,
			};
			updateAssignment(assignmentId, newAssignment);
		}
		
		// update assignment object using assignment ID
		function updateAssignment(assignmentId, newAssignment){
			$.ajax({
				url : "http://localhost:8080/UCMS/api/assignment/" + assignmentId,
				type: "put",
				data: JSON.stringify(newAssignment),
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

		function appendToFields(title, dueDate, content){
			// Put values in the fields
			$('#title').val( title );
			$('#date').val( dueDate );
			$('#content').val( content );
		}
	</script>

</body>
</html>