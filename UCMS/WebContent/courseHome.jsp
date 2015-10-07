<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>UCMS - Course Home</title>
	
	<!-- JQuery -->
	<script src="js/jquery.js"></script>

	<!-- Bootstrap -->
	<link rel="stylesheet" href="css/bootstrap.min.css">
	<link rel="stylesheet" href="css/style.css">
	<script src="js/bootstrap.min.js"></script>
	
	<!-- Star Rating -->
	<link rel="stylesheet" href="css/star-rating.min.css">
	<script src="js/star-rating.min.js"></script>
	
</head>
<body>
	<%
		if(session.getAttribute("loggedInUser") == null){
            response.sendRedirect(request.getContextPath() + "/login.jsp");
         }  
   %>
   
   <%String personType = (String)session.getAttribute("personType");%>
   
   <div class="container">
   	
   	<form action="logout" method="post" name="logout" class="logout-form">
		<button type="submit" name="logout" id="logout" class="btn login-button">Logout</button>
	</form>
	
	<!-- HEADER -->
	
	<div class="row about padding-top-bottom">   	
   		<div class="col-md-4">
   			<center><img src="" class="picture profile-picture" /></center>
   		</div>
   		<div class="col-md-8">
   			<h2><span class="name"></span></h2>
   			<p class="details"></p>
   			<p class="about-email">Professor : <span class="prof"></span></p><br />
   			<p class="about-email">Average Rating : <span class="avg-rating"></span></p><br />
   		</div>
   	</div><!-- /row -->
   	
   	<!-- /HEADER -->
   	
   	<!-- REST -->
   	
   	<div class="row rest padding-top-bottom" style="padding-bottom: 0;">
   		<div class="col-md-10 col-md-offset-1">
   			<h3>Assignments:</h3>
   			
   			<!-- DISPLAY ASSIGNMENTS -->
   			
   			<div class="row">
   				<div class="col-md-12 assignments">

   				</div>
   			</div><!-- /row -->
   			
   			<div class="row">
   				<div class="col-md-12">
   					<div class='alert alert-success alert-dismissible delete-assignment-success' role='alert' style="display: none;">
						<button type='button' class='close' data-dismiss='alert'>
							<span aria-hidden='true'>&times;</span><span class='sr-only'>Close</span>
						</button>
						<strong>Deleted!</strong> You successfully removed as assignment.
					</div>
   				</div>
   			</div>
   			
   			<!-- /DISPLAY ASSIGNMENTS -->
   			
   			<!-- ADD ASSIGNMENT -->
   			
   			<% if(personType.equals("professor")){ %>
   			<div class="row">
   				<div class="col-md-1">
					<div class="list-group">
						<a class="list-group-item list-group-item-danger add-assignment" href="javascript:void(0)" style="text-align: center;">&#43;</a>
					</div>
   				</div>
   			</div><!-- /row -->
   			<div class="row show-assignment" style="display: none;">
   				<div class="col-md-12">
					<input type="text" class="form-control margin-10" id="title" name="title" placeholder="Title" />
					<input type="text" class="form-control margin-10" id="date" name="date" placeholder="Due Date (yyyy-mm-dd)" />
					<textarea rows="10" class="form-control margin-10" id="content" name="content" placeholder="Content"></textarea>
					<div class="row">
						<div class="col-md-8">
							<div class='alert alert-success alert-dismissible assignment-success' role='alert' style="display: none;">
								<button type='button' class='close' data-dismiss='alert'>
									<span aria-hidden='true'>&times;</span><span class='sr-only'>Close</span>
								</button>
								<strong>Well done!</strong> You successfully added an assignment.
							</div>
						</div>
						<div class="col-md-4">
							<button id="assignment-create" class="btn login-button">Create</button>
						</div>
					</div><!-- /row -->
   				</div>
   			</div><!-- /row -->
   			<%} %>
   			
   			<!-- /ADD ASSIGNMENT -->
   			
   			<hr style="border-top: 1px solid #ffffff;" />
   			
   			<!-- TABS FOR NOTIFICATIONS AND REVIEWS -->
   			
   			<div class="row margin-40">
   				<div class="col-md-12">
   					<div role="tabpanel">
   					
					  <!-- Nav tabs -->
					  
					  <ul class="nav nav-tabs" role="tablist">
					    <li role="presentation" class="active"><a href="#notifications" aria-controls="notifications" role="tab" data-toggle="tab">Notifications</a></li>
					    <li role="presentation"><a href="#reviews" aria-controls="reviews" role="tab" data-toggle="tab">Course Reviews</a></li>
					  </ul>
					  
					  <!-- Tab panes -->
					  
					  <div class="tab-content">
					    <div role="tabpanel" class="tab-pane fade in active" id="notifications" style="padding-top: 20px;">
							<div class="col-md-12 events"></div>
							
							<div class="row">
				   				<div class="col-md-12">
				   					<div class='alert alert-success alert-dismissible delete-event-success' role='alert' style="display: none;">
										<button type='button' class='close' data-dismiss='alert'>
											<span aria-hidden='true'>&times;</span><span class='sr-only'>Close</span>
										</button>
										<strong>Deleted!</strong> You successfully removed as event.
									</div>
				   				</div>
				   			</div>
							
							<!-- ADD EVENT -->
				   			
				   			<% if(personType.equals("professor")){ %>
				   			<div class="col-md-12">
					   			<div class="row">
					   				<div class="col-md-1">
										<div class="list-group">
											<a class="list-group-item list-group-item-danger add-event" href="javascript:void(0)" style="text-align: center;">&#43;</a>
										</div>
					   				</div>
					   			</div><!-- /row -->
					   			<div class="row show-event" style="display: none;">
					   				<div class="col-md-12">
										<input type="text" class="form-control margin-10" id="eventName" name="eventName" placeholder="Event Name" />
										<textarea rows="10" class="form-control margin-10" id="description" name="description" placeholder="Description"></textarea>
										<div class="row">
											<div class="col-md-8">
												<div class='alert alert-success alert-dismissible event-success' role='alert' style="display: none;">
													<button type='button' class='close' data-dismiss='alert'>
														<span aria-hidden='true'>&times;</span><span class='sr-only'>Close</span>
													</button>
													<strong>Well done!</strong> You successfully added a notification.
												</div>
											</div>
											<div class="col-md-4">
												<button id="event-create" class="btn login-button">Create</button>
											</div>
										</div><!-- /row -->
					   				</div>
					   			</div><!-- /row -->
				   			</div>
				   			<%} %>
				   			
				   			<!-- /ADD EVENT -->
							
						</div>
					    <div role="tabpanel" class="tab-pane fade" id="reviews" style="padding-top: 20px;">
							<div class="col-md-12 student-reviews"></div>
							
							<!-- ADD REVIEW -->
				   			
				   			<% if(personType.equals("student")){ %>
				   			<div class="col-md-12">
					   			<div class="row">
					   				<div class="col-md-1">
										<div class="list-group">
											<a class="list-group-item list-group-item-danger add-review" href="javascript:void(0)" style="text-align: center;">&#43;</a>
										</div>
					   				</div>
					   			</div><!-- /row -->
					   			<div class="row show-review" style="display: none;">
					   				<div class="col-md-12">
										<input type="text" class="form-control margin-10" id="reviewTitle" name="reviewTitle" placeholder="Title" />
										<input id="input-id" type="number" data-symbol="&#9733;" class="rating" data-min="0" data-max="5" data-step="1" data-size="xs" data-rtl="false" data-glyphicon="false">
										<textarea rows="10" class="form-control margin-10" id="comment" name="comment" placeholder="Comment"></textarea>
										<div class="row">
											<div class="col-md-8">
												<div class='alert alert-success alert-dismissible review-success' role='alert' style="display: none;">
													<button type='button' class='close' data-dismiss='alert'>
														<span aria-hidden='true'>&times;</span><span class='sr-only'>Close</span>
													</button>
													<strong>Well done!</strong> You successfully added a review.
												</div>
											</div>
											<div class="col-md-4">
												<button id="review-create" class="btn login-button">Create</button>
											</div>
										</div><!-- /row -->
					   				</div>
					   			</div><!-- /row -->
				   			</div>
				   			<%} %>
				   			
				   			<!-- /ADD REVIEW -->
							
						</div>
					  </div>
					</div>
   				</div>
   			</div>
   			
   			<!-- /TABS FOR NOTIFICATIONS AND REVIEWS -->
   			
   		</div>
   	</div><!-- /row -->
   	
   	<!-- /REST -->
	
   </div><!-- /container -->
	
	<script type="text/javascript">
		$(function(){
			
			var personId = <%=session.getAttribute("id")%>
			var personType = "<%=session.getAttribute("personType")%>"
			var courseId = <%=request.getParameter("courseId")%>
			
			// get course object using course ID
			$.ajax({
				url : "http://localhost:8080/UCMS/api/course/" + courseId,
				type: "get",
				data: JSON.stringify(),
				dataType: "json",
				contentType: "application/json",
				success:function(data){					
					$.each(data, function(){
						var courseName = data["courseName"];
						var picture = data["coursePic"];
						var details = data["details"];
						
						$('.name').html(courseName);
						$( '.picture' ).attr( "src", picture );
						$('.details').html(details);
					});
				}
			});
			
			// get professor object using course ID (current semester)
			$.ajax({
				url : "http://localhost:8080/UCMS/api/person/professor/course/" + courseId,
				type: "get",
				data: JSON.stringify(),
				dataType: "json",
				contentType: "application/json",
				success:function(data){
					$.each(data, function(key, value){
						$(".prof").html(value.firstName + ' ' + value.lastName);
					});
				}
			});
			
			// get assignment objects using course ID
			$.ajax({
				url : "http://localhost:8080/UCMS/api/assignment/course/" + courseId,
				type: "get",
				data: JSON.stringify(),
				dataType: "json",
				contentType: "application/json",
				success:function(data){
					$.each(data, function(key, value){
						$(".assignments").append('<div class="row"><div class="col-md-11"><div class="list-group"><a class="list-group-item" href="http://localhost:8080/UCMS/assignment.jsp?assignmentId='+ value.id +'">'+ value.title +'</a></div></div><div class="col-md-1"><div class="list-group"><a class="list-group-item non-link-assignment" assignment-id="'+ value.id +'" href="javascript:void(0)">&#8210;</a></div></div></div>');
					});
				}
			});
			
			// get event objects using course ID
			$.ajax({
				url : "http://localhost:8080/UCMS/api/event/course/" + courseId,
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
						$(".events").append('<div class="row"><div class="col-md-11"><div class="panel panel-default"><div class="panel-heading">' + value.eventName + '<span style="float: right;">[ ' + myDate + ' ]</span></div><div class="panel-body">'+value.description+'</div></div></div><div class="col-md-1"><div class="list-group"><a class="list-group-item non-link-event" event-id="'+ value.id +'" href="javascript:void(0)">&#8210;</a></div></div>');
					});
				}
			});
			
			// get review objects using course ID
			$.ajax({
				url : "http://localhost:8080/UCMS/api/review/course/" + courseId,
				type: "get",
				data: JSON.stringify(),
				dataType: "json",
				contentType: "application/json",
				success:function(data){
					$.each(data, function(key, value){
						$(".student-reviews").append('<ul class="list-group"><li class="list-group-item"><span class="badge">Rated: ' + value.rating + '</span><h4>' + value.title + '</h4><p>' + value.comment + '</p></li></ul>');
					});
				}
			});
			
			// get average rating from course Id
			$.ajax({
				url : "http://localhost:8080/UCMS/api/review/rating/average/course/" + courseId,
				type: "get",
				data: JSON.stringify(),
				dataType: "text" ,
				contentType: "application/json",
				success:function(data){
						$(".avg-rating").html(data);
				}
			});
			
			$(".add-assignment").click(function() {
				$(".show-assignment").toggle("slow");
			});
			
			$(".add-event").click(function() {
				$(".show-event").toggle("slow");
			});
			
			$(".add-review").click(function() {
				$(".show-review").toggle("slow");
			});
			
			var cname = $(".name").html();
			var cpic = $(".picture").attr('src');
			var cdetails = $(".details").html();
			var currentCourse = {
					"id" : courseId,
					"courseName" : cname,
					"coursePic" : cpic,
					"details" : cdetails,
			}
			
			$( "#assignment-create" ).click(function() {
				createAssignmentHandler(currentCourse);
			});
			
			$( "#event-create" ).click(function() {
				createEventHandler(currentCourse);
			});
			
			$( "#review-create" ).click(function() {
				createReviewHandler(currentCourse);
			});
			
			setTimeout(function(){
				$("a.non-link-assignment").click(function() {
					var linkAssignmentId = $(this).attr("assignment-id");
					deleteAssignmentHandler(linkAssignmentId);
				});
			}, 100);
			
			setTimeout(function(){
				$("a.non-link-event").click(function() {
					var linkEventId = $(this).attr("event-id");
					deleteEventHandler(linkEventId);
				});
			}, 100);
			
		});
		
		function deleteAssignmentHandler(linkAssignmentId){
			deleteAssignment(linkAssignmentId);
		}
		
		function deleteEventHandler(linkEventId){
			deleteEvent(linkEventId);
		}
		
		// delete event by event ID
		function deleteEvent(linkEventId){
			$.ajax({
				url : "http://localhost:8080/UCMS/api/event/" + linkEventId,
				type:"delete",
				data: JSON.stringify(),
				dataType: "json",
				contentType: "application/json",
				success:function(response) {
					$( ".delete-event-success" ).css( "display", "block" );
					setTimeout(function(){
				         window.location.reload();
					}, 2000);
				}
			});
			
		}
		
		// delete assignment by assignment ID
		function deleteAssignment(linkAssignmentId){
			$.ajax({
				url : "http://localhost:8080/UCMS/api/assignment/" + linkAssignmentId,
				type:"delete",
				data: JSON.stringify(),
				dataType: "json",
				contentType: "application/json",
				success:function(response) {
					$( ".delete-assignment-success" ).css( "display", "block" );
					setTimeout(function(){
				         window.location.reload();
					}, 2000);
				}
			});
			
		}
		
		function createAssignmentHandler(currentCourse) {
			var title = $("#title").val();
			var date = $("#date").val();
			var content = $("#content").val();
			var newAssignment = {
					"id": 1,
					"title": title,
					"content": content,
					"dueDate": date,
					"course" : currentCourse,
			};
			createAssignment(newAssignment);
		}
		
		// create assignment object using course ID
		function createAssignment(newAssignment){
			$.ajax({
				url : "http://localhost:8080/UCMS/api/assignment",
				type: "post",
				data: JSON.stringify(newAssignment),
				dataType: "json",
				contentType: "application/json",
				success:function(response){
					$( ".assignment-success" ).css( "display", "block" );
					setTimeout(function(){
				         window.location.reload();
					}, 2000);
				}
			});
		}
		
		function createEventHandler(currentCourse) {
			var eventName = $("#eventName").val();
			
			var today = new Date();
		    var dd = today.getDate()+1;
		    var mm = today.getMonth()+1; //January is 0!

		    var yyyy = today.getFullYear();
		    if(dd<10){
		        dd='0'+dd
		    } 
		    if(mm<10){
		        mm='0'+mm
		    } 
		    var today = yyyy+'-'+mm+'-'+dd;
		    
			var description = $("#description").val();
			var newEvent = {
					"id": 1,
					"eventName": eventName,
					"description": description,
					"date": today,
					"course" : currentCourse,
			};
			createEvent(newEvent);
		}
		
		// create event object using course ID
		function createEvent(newEvent){
			$.ajax({
				url : "http://localhost:8080/UCMS/api/event",
				type: "post",
				data: JSON.stringify(newEvent),
				dataType: "json",
				contentType: "application/json",
				success:function(response){
					$( ".event-success" ).css( "display", "block" );
					setTimeout(function(){
				         window.location.reload();
					}, 2000);
				}
			});
		}
		
		function createReviewHandler(currentCourse) {
			var rtitle = $("#reviewTitle").val();
			var rating = $("#input-id").val();
			var rcomment = $("#comment").val();
			var newReview = {
					"id": 1,
					"title": rtitle,
					"rating": rating,
					"comment": rcomment,
					"course" : currentCourse,
			};
			createReview(newReview);
		}
		
		// create review object using course ID
		function createReview(newReview){
			$.ajax({
				url : "http://localhost:8080/UCMS/api/review",
				type: "post",
				data: JSON.stringify(newReview),
				dataType: "json",
				contentType: "application/json",
				success:function(response){
					$( ".review-success" ).css( "display", "block" );
					setTimeout(function(){
				         window.location.reload();
					}, 2000);
				}
			});
		}
		
	</script>
	
</body>
</html>