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

<link href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/css/login.css" rel="stylesheet">
<style>
.errorMsg {
	font-family: Arial;
	font-weight: bold;
	font-size: 12px;
	color: red;
}

</style>

</head>
<body>
	<div class="container-fluid text-center">
		<div class="row">
			<div class="col-md-4"></div>
			<div class="col-md-4">
				<div class="panel panel-primary">
					<div class="panel-heading">
						<h3 class="panel-title">
						Welcome to Planning Ninjas
					</h3>
					</div>
					<div class="panel-body">
						<img id="ninja" alt="" src="${pageContext.request.contextPath}/resources/img/poker_ninja.png" >
						<br/><br/>
						<input type="text" class="form-control" id="loginEmail" placeholder="Enter your email id"/>
					</div>
					<div class="panel-footer">
						<button type="button" class="btn btn-primary" onclick="login();">Enter</button>
						<div id="errorMsgDiv" class="alert alert-error" style="display:none">
			    			<span id="errorMsg"/>
  						</div>
					</div>
				</div>
			</div>
			<div class="col-md-4"></div>
		</div>
	</div>

	<script src="${pageContext.request.contextPath}/resources/js/jquery.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/scripts.js"></script>

	<script type="text/javascript">
		function login() {
			event.preventDefault();
			var loginEmail = $('#loginEmail').val();
			if(!loginEmail){
				$("#ninja").attr("src", "${pageContext.request.contextPath}/resources/img/poker_ninja_blood.png");
				$("#errorMsg").text('Dont waste your time testing this application :@');
				$("#errorMsgDiv").show();
				return false;
			}
			$.ajax({
				url : "login.mth",
				type : 'POST',
				data : loginEmail,
				dataType: 'json',
				cache : false,
				async:false,
				beforeSend : function(xhr) {
					xhr.setRequestHeader("Accept", "application/json");
					xhr.setRequestHeader("Content-Type", "text/plain");
				},
				success : function(response) {
					if(!response.email || response.email === ''){
						$("#errorMsg").text('Not Authorised. Contact Administrator');
						$("#ninja").attr("src", "${pageContext.request.contextPath}/resources/img/poker_ninja_blood.png");
						$("#errorMsgDiv").show();
					} else {
						window.location.href = 'http://'+location.host + location.pathname + 'welcome/'+response.email;
					}
				},
				error : function(jqXHR, status, error) {
					if(jqXHR.status && jqXHR.status==400){
                    	alert(jqXHR.responseText); 
               		}else{
                   		alert(jqXHR.responseText);
               		}
				}
			});
			return false;
		}
	</script>
</body>
</html>