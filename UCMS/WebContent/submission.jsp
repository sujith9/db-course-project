<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>UCMS - Submission</title>

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

	<%  String personType = (String)session.getAttribute("personType");
		String pId = null;
		Integer id = (Integer)session.getAttribute("id");
		String id2 = String.valueOf(id);
		String person_Id = (String)request.getParameter("personId");
		if(personType.equals("professor")){
		pId =person_Id;
		}else{
			pId = id2;
		}
	%>
	
	<div class="container">

		<form action="logout" method="post" name="logout" class="logout-form">
			<button type="submit" name="logout" id="logout"
				class="btn login-button">Logout</button>
		</form>

		<!-- REST -->

		<div class="row rest padding-top-bottom" style="padding-bottom: 0;">
			<div class="col-md-10 col-md-offset-1">
				<div class="page-header" style="border:none;">
					<h2><span class="student-name"></span> : <span class="ass-name"></span></h2>
					<h3>Submitted: <span class="date"></span></h3>
					<h3><span class="label label-default">Grade : <span class="grade"></span></span></h3>
				</div>
				
				<% if(personType.equals("student")){ %>

				<div class="update-form" style="display: none;">
					<textarea rows="10" class="form-control margin-10" id="content" name="content" placeholder="Content"></textarea>

					<div class="row">
						<div class="col-md-8">
							<div class='alert alert-success alert-dismissible update-success' role='alert' style="display: none;">
								<button type='button' class='close' data-dismiss='alert'>
									<span aria-hidden='true'>&times;</span><span class='sr-only'>Close</span>
								</button>
								<strong>Well done!</strong> You successfully updated this submission.
							</div>
						</div>
						<div class="col-md-4">
							<button id="create-sub" class="btn login-button">Create Submission</button>
							<button id="update-sub" class="btn login-button">Update Submission</button>
						</div>
					</div>
					<!-- /row -->
				</div>
					
				<% } %>
				
				<div class="well content"></div>

				<% if(personType.equals("professor")){ %>
				
				<div class="grade-form" style="display: none;">
					<input type="text" class="form-control margin-10" id="grade-input" name="grade-input" placeholder="Grade" />

					<div class="row">
						<div class="col-md-8">
							<div class='alert alert-success alert-dismissible grade-success' role='alert' style="display: none;">
								<button type='button' class='close' data-dismiss='alert'>
									<span aria-hidden='true'>&times;</span><span class='sr-only'>Close</span>
								</button>
								<strong>Well done!</strong> You successfully graded this submission.
							</div>
						</div>
						<div class="col-md-4">
							<button id="update-grade" class="btn login-button">Submit</button>
						</div>
					</div>
					<!-- /row -->
				</div>

				<div class="row" style="padding-bottom: 30px;">
					<div class="col-md-6 col-md-offset-6">
						<button id="grade" class="btn login-button">Grade</button>
					</div>
				</div><!-- /row -->

				<% }else{ %>
				
				<div class="row" style="padding-bottom: 30px;">
					<div class="col-md-6 col-md-offset-6">
						<button id="submission" class="btn login-button">Submit</button>
					</div>
				</div><!-- /row -->
				
				<% } %>
				
			</div>
		</div><!-- /row -->
		
		<!-- /REST -->
		
	</div><!-- /container -->

	<script type="text/javascript">
		$(function(){
			
			var personId = <%=pId%>;
			var assignmentId = <%=request.getParameter("assignmentId")%>
			
			var submissionId = null;
			var subDate = null;
			var assignment = null;
			var person = null;
			var newDate = null;
			var grade = null;
			
			var newPerson = null;
			var newAssignment = null;
			var newToday = null;
			
			// get submission object using assignment ID and person ID
			$.ajax({
				url : "http://localhost:8080/UCMS/api/submission/person/" + personId + "/" + assignmentId,
				type: "get",
				data: JSON.stringify(),
				dataType: "json",
				contentType: "application/json",
				success:function(data){
					if(data.length == 0){
						
						// generating current date
						newToday = new Date();
						var dd = newToday.getDate();
						var mm = newToday.getMonth()+1; //January is 0!
						var yyyy = newToday.getFullYear();

						if(dd<10) {
						    dd='0'+dd
						} 

						if(mm<10) {
						    mm='0'+mm
						} 

						var today = mm+'/'+dd+'/'+yyyy;
						var n = new Date(today);
						newToday = n.getTime();
						
						// get person object using person ID
						$.ajax({
							url : "http://localhost:8080/UCMS/api/person/" + personId,
							type: "get",
							data: JSON.stringify(),
							dataType: "json",
							contentType: "application/json",
							success:function(data){
								newPerson = data;
								$.each(data, function(){
									var firstName = data["firstName"];
									var lastName = data["lastName"];
									var myName = firstName + " " + lastName;
									
									$('.student-name').html(myName);
								});
							}
						});
						
						// get assignment object using assignment ID
						$.ajax({
							url : "http://localhost:8080/UCMS/api/assignment/" + assignmentId,
							type: "get",
							data: JSON.stringify(),
							dataType: "json",
							contentType: "application/json",
							success:function(data){
								newAssignment = data;
								$.each(data, function(){
									var title = data["title"];
									
									$('.ass-name').html(title);
								});
							}
						});
						
						$(".date").html("not submitted");
						$(".grade").html("not graded");
						$("#update-sub").hide();
						
					}
					$.each(data, function(key, value){
						var content = value.content;
						subDate = value.subDate;
						grade = value.grade;
						assignment = value.assignment;
						var assignmentDate = assignment.dueDate;
						var assignmentName = assignment.title;
						person = value.person;
						var personName = person.firstName + " " + person.lastName;
						submissionId = value.id;
						
						// generating current date
						today = new Date();
						var dd = today.getDate();
						var mm = today.getMonth()+1; //January is 0!
						var yyyy = today.getFullYear();

						if(dd<10) {
						    dd='0'+dd
						} 

						if(mm<10) {
						    mm='0'+mm
						} 

						var today = mm+'/'+dd+'/'+yyyy;
						var n = new Date(today);
						newDate = n.getTime();
						
						// parsing submission date
						var currentTime = new Date(parseInt(subDate));
						var month = currentTime.getMonth() + 1;
						var day = currentTime.getDate();
						var year = currentTime.getFullYear();
						var myDate = day + "/" + month + "/" + year;
						var otherDate = year + "-" + month + "-" + day;
						
						if(grade == 0){
							grade = "not graded";
						}
						
						$('.grade').html(grade);
						$( '.date' ).html(myDate);
						$('.content').html(content);
						
						if ((newDate - assignmentDate) > 0){
							$("#update-sub").hide();
							$("#create-sub").hide();
						}else{
							$("#create-sub").hide();
						}
						
						appendToFields(content, assignmentName, personName);
					});
				}
			});
			
			$( "#grade" ).click(function() {
				$(".grade-form").slideDown();
				$("#grade").hide();
			});
			
			$( "#submission" ).click(function() {
				$(".content").slideUp();
				$(".update-form").slideDown();
				$("#submission").hide();
			});
			
			$( "#update-grade" ).click(function() {
				updateGradeHandler(submissionId, subDate, assignment, person);
			});
			
			$( "#update-sub" ).click(function() {
				if(grade == "not graded"){
					grade = 0;
				}
				updateSubHandler(submissionId, newDate, grade, assignment, person);
			});
			
			$( "#create-sub" ).click(function() {
				if(grade == "not graded"){
					grade = 0;
				}
				createSubHandler(newToday, grade, newAssignment, newPerson);
			});
			
		});
		
		function updateGradeHandler(submissionId, subDate, assignment, person) {
			var content = $(".content").html();
			var grade = $("#grade-input").val();
			var newSubmission = {
					"id": submissionId,
					"content": content,
					"grade": grade,
					"subDate": subDate,
					"assignment" : assignment,
					"person" : person,
			};
			updateSubmission(submissionId, newSubmission);
		}
		
		function updateSubHandler(submissionId, today, grade, assignment, person) {
			var content = $("#content").val();
			var newSubmission = {
					"id": submissionId,
					"content": content,
					"grade": grade,
					"subDate": today,
					"assignment" : assignment,
					"person" : person,
			};
			updateSubmissionContent(submissionId, newSubmission);
		}
		
		function createSubHandler(today, grade, assignment, person) {
			var content = $("#content").val();
			var newSubmission = {
					"id": 1,
					"content": content,
					"grade": grade,
					"subDate": today,
					"assignment" : assignment,
					"person" : person,
			};
			createSubmissionContent(newSubmission);
		}
		
		// update submission object using submission ID
		function updateSubmission(submissionId, newSubmission){
			$.ajax({
				url : "http://localhost:8080/UCMS/api/submission/" + submissionId,
				type: "put",
				data: JSON.stringify(newSubmission),
				dataType: "json",
				contentType: "application/json",
				success:function(response){
					$( ".grade-success" ).css( "display", "block" );
					setTimeout(function(){
				         window.location.reload();
					}, 2000);
				}
			});
		}
		
		// update submission object using submission ID
		function updateSubmissionContent(submissionId, newSubmission){
			$.ajax({
				url : "http://localhost:8080/UCMS/api/submission/" + submissionId,
				type: "put",
				data: JSON.stringify(newSubmission),
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
		
		// create submission object using submission ID
		function createSubmissionContent(newSubmission){
			$.ajax({
				url : "http://localhost:8080/UCMS/api/submission/",
				type: "post",
				data: JSON.stringify(newSubmission),
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

		function appendToFields(content, assignmentName, personName){
			// Put values in the fields
			$(".ass-name").html(assignmentName);
			$(".student-name").html(personName);
			$('#content').val( content );
		}
	</script>

</body>
</html>