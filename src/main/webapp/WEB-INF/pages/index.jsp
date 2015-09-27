<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Planning Ninjas</title>
<meta name="description" content="This is my fucking planning poker">
<meta name="author" content="sivasankar_r">
<link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/img/poker_ninja.ico">
<link href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/css/style.css" rel="stylesheet">

</head>
<body>
	<div class="container-fluid">
		<div class="row">
			<div class="col-md-1"></div>
			<div class="col-md-10">
				<h3 class="text-center text-primary">Create a planning poker session</h3>
			</div>
			<div class="col-md-1"></div>
		</div>
		<div class="row">
			<div class="col-md-2"></div>
			<div class="col-md-8">
				<form class="form-horizontal" role="form">
					<div class="form-group">

						<label for="sessionName" class="col-sm-2 control-label"> Session
							Name </label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="sessionName"
								placeholder="Eg: Shopview Sprint 4 Planning" />
						</div>
					</div>
					<div class="form-group">

						<label for="stories" class="col-sm-2 control-label">
							Stories </label>
						<div class="col-sm-10">
							<textarea class="form-control" rows="5" id="stories"
								placeholder="Paste / Enter the list of user stories (separated by new line)"></textarea>
						</div>
					</div>
					<div class="form-group">
						<label for="cardSet" class="col-sm-2 control-label"> Card
							Set</label>
						<div class="col-sm-10">
							<div class="radio">
								<label> <input type="radio" name="cardSet"
									id="cardSet1" value="0" checked> Fibonacci
									( 0, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, ?, Pass, Break )
								</label>
							</div>
							<div class="radio ">
								<label> <input type="radio" name="cardSet"
									id="cardSet2" value="1" disabled> Modified
									Fibonacci ( 0, ½, 1, 2, 3, 5, 8, 13, 20, 40, 100, ?, Pass,
									Break )
								</label>
							</div>
							<div class="radio ">
								<label> <input type="radio" name="cardSet"
									id="cardSet3" value="2" disabled> T-shirts
									( xxs, xs, s, m, l, xl, xxl, ?, Pass, Break )
								</label>
							</div>
							<div class="radio ">
								<label> <input type="radio" name="cardSet"
									id="cardSet4" value="3" disabled> Powers of
									2 ( 0, 1, 2, 4, 8, 16, 32, 64, ?, Pass, Break )
								</label>
							</div>
						</div>
					</div>
					<div class="form-group">
						<label for="timer" class="col-sm-2 control-label"> Voting
							Time </label>
						<div class="col-sm-10">
							<select class="form-control" id="timer"  >
								<option value="60">1 min</option>
								<option value="120">2 mins</option>
								<option value="180">3 mins</option>
								<option value="240">4 mins</option>
								<option value="300">5 mins</option>
							</select>
						</div>
					</div>
					<div class="form-group">
						<label for="hostEmail" class="col-sm-2 control-label"> Your
							Email </label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="hostEmail" value="${email}" disabled/>
						</div>
					</div>
					<div class="form-group">
						<label for="peopleEmailList" class="col-sm-2 control-label"> Participants Email List</label>
						<div class="col-sm-10">
							<textarea  class="form-control" rows="3" id="peopleEmailList" placeholder="Paste / Enter the list of email ids of people you want to invite for the session (separated by new line)"></textarea>
						</div>
					</div>
					<div class="form-group">
						<div class="col-sm-offset-5 col-sm-8">
							<button type="submit" class="btn btn-primary" onclick="createAndJoin();">Create &amp; Join</button>
						</div>
					</div>
				</form>
			</div>
			<div class="col-md-2"></div>
		</div>
	</div>

	<script src="${pageContext.request.contextPath}/resources/js/jquery.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/scripts.js"></script>

	<script type="text/javascript">
		function createAndJoin() {
			event.preventDefault();
			var sessionName = $('#sessionName').val();
			var hostEmail = $('#hostEmail').val();
			var stories = $('#stories').val();
			var cardSet = $('input[name=cardSet]:checked').val();
			var timer = $('#timer').val();
			var peopleEmailList = $('#peopleEmailList').val();
			
			var json = {
				"sessionName" : sessionName,
				"hostEmail" : hostEmail,
				"stories": stories,
				"planningCardSet" : cardSet,
				"votingTimeLimit" : timer,
				"peopleEmailList"  : peopleEmailList
			};
			$.ajax({
				url : location.protocol + "//" + location.host + "/planpoker/create",
				type : 'POST',
				data : JSON.stringify(json),
				cache : false,
				async:false,
				beforeSend : function(xhr) {
					xhr.setRequestHeader("Accept", "text/plain");
					xhr.setRequestHeader("Content-Type", "application/json");
				},
				success : function(response) {
					var pokerSession = jQuery.parseJSON(response);
					window.location.href = 'http://'+location.host + '/planpoker/session/?sessionUrl='+pokerSession.sessionUrl+'&email='+hostEmail;
				},
				error : function(jqXhr, textStatus, errorThrown) {
					alert(jqXHR.responseText);
				}
			});
			return false;
		}
	</script>
</body>
</html>