<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Planning Ninjas</title>
<meta name="description" content="This is my fucking planning poker">
<meta name="author" content="sivasankar_r">

<link
	href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath}/resources/css/pokerroom-style.css"
	rel="stylesheet">
<style type="text/css">
	body {
			padding-top: 20px;
			padding-bottom: 20px;
		}
</style>
</head>
<body>
	<noscript>
		<h2 style="color: #ff0000">
			Seems your browser doesn't support Javascript! Websocket relies on Javascript being enabled. Please enable Javascript and reload this page!
    	</h2>
    </noscript>
	<div class="container-fluid">
		<div class="row">
			<div class="col-md-1">
				<a id="modal-stories" href="#modal-container-stories" role="button" class="btn btn-primary btn-default" data-toggle="modal">Add Stories</a>
				<div class="modal fade" id="modal-container-stories" role="dialog" aria-labelledby="addStoriesLabel" aria-hidden="true">
					<div class="modal-dialog">
						<form class="form-horizontal" role="form">
							<div class="modal-content">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal" aria-hidden="true">X</button>
									<h4 class="modal-title" id="addStoriesLabel">Add new stories to the list</h4>
								</div>
								<div class="modal-body">
									<textarea class="form-control" rows="5" id="stories" placeholder="Paste a list of user stories here (separated by new line)"></textarea>
								</div>
								<div class="modal-footer">
									<button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button> 
									<button type="button" class="btn btn-primary" onclick="addStories();">Add Stories</button>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
			<div class="col-md-1">
				<a id="show-results" href="#" role="button" class="btn btn-primary btn-default">Show Results</a>
			</div>
			<div class="col-md-1">
				<a id="vote-again" href="#" role="button" class="btn btn-primary btn-default">Re-Vote</a>
			</div>
			<div class="col-md-7">
			</div>
			<div class="col-md-2">
				<a id="modal-invite" href="#modal-container-invite" role="button" class="btn btn-primary btn-default" data-toggle="modal">Invite People</a>
				<div class="modal fade" id="modal-container-invite" role="dialog" aria-labelledby="invitePeopleLabel" aria-hidden="true">
					<div class="modal-dialog">
						<form class="form-horizontal" role="form">
							<div class="modal-content">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal" aria-hidden="true">X</button>
									<h4 class="modal-title" id="invitePeopleLabel">Invite People</h4>
								</div>
								<div class="modal-body">
									<textarea class="form-control" rows="5" id="peopleEmailList" placeholder="Paste a list of email ids of people you want to invite for the session (separated by new line)"></textarea>
								</div>
								<div class="modal-footer">
									<button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button> 
									<button type="button" class="btn btn-primary" onclick="invitePeople();">Invite</button>
								</div>
							</div>
						</form>
					</div>
					
				</div>
			</div>
			<div class="col-md-6" id="col-md-6"></div>
		</div>
		<div class="row">
			<div class="col-md-4" id="storiesDiv">
				<table class="table table-hover" id="storiesList">
					<thead>
						<tr>
							<th>#</th>
							<th>Story</th>
							<th>Points</th>
							<th></th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="story" items="${stories}" varStatus="loop">
							<tr class="${story.voted == 1 ? 'success' : 'danger'}">
								<td>${(loop.index)+1}</td>
								<td>${story.storyTitle}</td>
								<td>${story.finalPoints}</td>
								<td><a id="broadCast" href="#" title="Broadcast for voting" onclick="broadCastStory(${story.storyId})"><span class="glyphicon glyphicon-bullhorn"></span></a>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<ul class="pagination pagination-sm">
					<li><a href="#">Prev</a></li>
					<li><a href="#">1</a></li>
					<li><a href="#">2</a></li>
					<li><a href="#">Next</a></li>
				</ul>
			</div>
			<div class="col-md-6">
				<div class="panel panel-primary" id="storyPanel">
					<div class="panel-heading">
						<h3 class="panel-title"># Story Title</h3>
					</div>
					<div class="panel-body" id="panel-body">
						<p id="storyDiv">Here comes the description of the story. Here comes the
							description of the story.Here comes the description of the
							story.Here comes the description of the story.Here comes the
							description of the story.Here comes the description of the story.</p>
						<p>
						<a class="btn" href="#">View details »</a>
					</div>
					<div class="panel-footer clearfix">
						<form role="form" class="form-inline">
							<div class="form-group">
								<label for="voteValue"> My vote is </label>
								<select class="form-control" id="voteValue">
									<option>0 </option>
									<option>1 </option>
									<option>2 </option>
									<option>3 </option>
									<option>5 </option>
									<option>8 </option>
									<option>13 </option>
									<option>21 </option>
									<option>34 </option>
									<option>55 </option>
									<option>89 </option>
									<option>??????? </option>
									<option>Pass</option>
									<option>Break</option>
								</select>
								<button type="button" class="btn btn-primary" onclick="castVote();">Cast My Vote</button>
							</div>
						</form>
					</div>
				</div>
			</div>
			
			<div class="col-md-2" id="participantsDiv">
				<table class="table table-hover">
					<thead>
						<tr>
							<th>#</th>
							<th>Participant</th>
							<th>Points</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="participant" items="${participants}" varStatus="loop">
							<tr class="${participant.currentStoryVote == -1 ? 'danger' : 'success'}">
								<td>${(loop.index)+1}</td>
								<td>${participant.name}</td>
								<td>${participant.currentStoryVote == -1 ? '-' : 'participant.currentStoryVote'}</td>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	<script src="${pageContext.request.contextPath}/resources/js/jquery.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/sockjs-0.3.4.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/stomp.js"></script>
    
	<script type="text/javascript">
		var stompClient = null;
		var stompClientForVote = null;
		
		var currentStroyID = null;
		$(document).ready(function () {
  			connectToBroadCast();
  			connectToVote();
  			
		});
		
		function connectToBroadCast() {
		
		    alert("connect");
		    var currentURL = window.location.protocol + "//" + window.location.host;
		    var socket = new SockJS(currentURL + '/planpoker/broadCast');
            stompClient = Stomp.over(socket);            
            stompClient.connect({}, function(frame) {
                console.log('Connected....: ' + frame);
                stompClient.subscribe('/pokerSession/broadCastStories', function(story) {
                    console.log("json value....bilgates" + (JSON.parse(story.body).storyTitle));
                    
                    currentStroyID = JSON.parse(story.body).storyId;
                    console.log("current story id........in connectToBroadCast.." + currentStroyID);
                    
                    showGreeting((JSON.parse(story.body).storyTitle));
                    
                    
                   //showGreeting(JSON.parse(testName.body).name);
                });
                });
        }
        
       function connectToVote() {
		   alert("connect to vote");
		   var currentURL = window.location.protocol + "//" + window.location.host;
		    var socket = new SockJS(currentURL + '/planpoker/castVote');
            stompClientForVote = Stomp.over(socket);            
            stompClientForVote.connect({}, function(frame) {
                console.log('Connected..to vote..: ' + frame);
                stompClientForVote.subscribe('/pokerSession/vote', function(vote) {
                  //   console.log("json value....for vote..." + (JSON.parse(vote.body)));
                    console.log("bilgates....how are you....." + vote.body);
                    
                    //showGreeting((JSON.parse(story.bodybilgates).storyTitle));
                   //showGreeting(JSON.parse(testName.body).name);
                });
                });
        }
        
    
        function broadCastStory(storyId) {
           currentStroyID = storyId;
           //alert(storyContent);
         /*   console.log(".............." + window.location.protocol + "//" + window.location.host);
            var newURL = window.location.protocol + "//" + window.location.host;
            //var socket = new SockJS('/planpoker/broadCast');
            var socket = new SockJS(newURL + '/planpoker/broadCast');
            stompClient = Stomp.over(socket);            
            stompClient.connect({}, function(frame) {
                console.log('Connected....: ' + frame);
                stompClient.subscribe('/pokerSession/broadCastStories', function(story) {
                    console.log("json value....bilgates." + (JSON.parse(story.body).storyTitle));
                    currentStroyID = JSON.parse(story.body).storyId;
                    console.log("current story id........in broadcast.." + currentStroyID);
                    showGreeting((JSON.parse(story.body).storyTitle));
                   //showGreeting(JSON.parse(testName.body).name);
                });
                });*/
                
       
               stompClient.send("/app/broadCast", {}, storyId);
           
        }
        
        
        function getQueryVariable(variable) {
            var query = window.location.search.substring(1);
            var vars = query.split("&");
            for (var i=0;i<vars.length;i++) {
                var pair = vars[i].split("=");
                if(pair[0] == variable){
                    return pair[1];
                }
            }
            return(false);
        }
        
         function castVote() {
              console.log("current sttory id in cast" + currentStroyID);
              var participantEmail = getQueryVariable('email');
              console.log("voter email..." + participantEmail);
              
              // Get the selected value from drop down
              var e = document.getElementById('voteValue');
              var points = e.options[e.selectedIndex].value;
              points = points.trim();
              
              console.log("votePoint..." + points);
              stompClientForVote.send("/app/castVote", {}, JSON.stringify({ 'storyId' :  currentStroyID, 'participantEmail' : participantEmail, 'points' : points}));
         }
        
        
        function sendName() {
            /* var name = document.getElementById('name').value;
            stompClient.send("/app/hello", {}, JSON.stringify({ 'name': name })); */
        }
        
        function showGreeting(message) {
           console.log("********************Message" + message);
           /*  var response = document.getElementById('response');
            var p = document.createElement('p');
            p.style.wordWrap = 'break-word';
            p.appendChild(document.createTextNode(message));
            response.appendChild(p); */
            
            var storyDiv = document.getElementById("storyDiv");
            
            var mainDiv = document.getElementById("col-md-6");
            
            var mainDivWidth = mainDiv.offsetWidth;
            
            console.log("story div width..first" + storyDiv.offsetWidth);
            
            storyDiv.innerHTML = message;
            
            //mainDiv.setAttribute("style", "width:storyDivWidth);
           // console.log("maindiv second.." +  mainDiv.offsetWidth);
           // mainDiv.style.width = mainDivWidth;
            
            console.log("maindiv third.." +  mainDiv.offsetWidth);
           /* var p = document.createElement('p');
            p.style.wordWrap = 'break-word';
            p.appendChild(document.createTextNode(message));
            
            storyDiv.appendChild(p);*/
        }
        
	</script>
</body>
</html>