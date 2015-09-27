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
<link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/img/poker_ninja.ico">
<link
	href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath}/resources/css/pokerroom-style.css"
	rel="stylesheet">
<link	
    href="${pageContext.request.contextPath}/resources/css/style.css"
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
		<div class = "row">
			<div class="col-md-3">
				<a id="modal-stories" href="#modal-container-stories" role="button" class="btn btn-primary btn-sm text-center hostControls" data-toggle="modal"><span class="glyphicon glyphicon-plus"></span> Add Stories</a>
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
			<div class="col-md-6 branding">
				<h4 align="center" id="sessionName">${pokerSession.sessionName}</h4>
			</div>
			<div class="col-md-3" align="right">
				<a id="targetMailLink" style="display:none;">test link</a>
				<a id="modal-invite" href="#modal-container-invite" role="button" class="btn btn-primary btn-sm text-center hostControls" onclick="getParticipants()" data-toggle="modal"><span class="glyphicon glyphicon-send"></span> Invite People</a>
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
		</div>
		
		<div class="row">
			<div class="col-md-3" id="storiesDiv">
				<table class="table table-hover tableHeaders" id="storiesList">
					<thead>
						<tr>
							<th style="text-align:center">#</th>
							<th style="text-align:center;width:250px">Story Title</th>
							<th style="text-align:center">Points</th>
							<th class="hostControls" style="text-align:center">Action</th>
							<th style="display: none;">StoryId</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="story" items="${stories}" varStatus="loop">
							<tr class="${story.voted == 1 ? 'success' : 'danger'}">
								<td style="text-align:center">${(loop.index)+1}</td>
								<td>${story.storyTitle}</td>
								<td style="text-align:center" class="storyfinalPoints">${story.voted == 1 ? story.finalPoints : '-'}</td>
								<td class="hostControls" style="text-align:center"><a id="broadCast" href="#" title="Broadcast for voting" onclick="broadCastStory(${story.storyId})"><span class="glyphicon glyphicon-bullhorn"></span></a>
								</td>
								<td style="display: none;">${story.storyId}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<div style="text-align: center">
					<ul class="pagination pagination-sm">
						<li><a href="#">Prev</a></li>
						<li><a href="#">1</a></li>
						<li><a href="#">2</a></li>
						<li><a href="#">Next</a></li>
					</ul>
				</div>
			</div>
			<div class="col-md-6">
				<div class="panel panel-primary" id="storyPanel">
					<div class="panel-heading tableHeaders">
						<h3 class="panel-title" id="storyTitleId"># Story Title</h3>
					</div>
					<div class="panel-body" id="panel-body">
						<p id="storyDiv">Here comes the description of the story. Here comes the
							description of the story.Here comes the description of the
							story.Here comes the description of the story.Here comes the
							description of the story.Here comes the description of the story.</p>
						<p>
						<a id="modal-tfs" class="btn" href="#modal-container-tfs" data-toggle="modal" >View in Team Foundation Server »</a>
						<div class="modal fade" id="modal-container-tfs" role="dialog" aria-labelledby="tfsLabel" aria-hidden="true">
							<div class="modal-dialog">
								<form class="form-horizontal" role="form">
									<div class="modal-content">
										<div class="modal-header">
											<button type="button" class="close" data-dismiss="modal" aria-hidden="true">X</button>
											<h4 class="modal-title" id="tfsLabel">View in TFS</h4>
										</div>
										<div class="modal-body">
											<img width="100%" height="80%" alt="smiley" src="${pageContext.request.contextPath}/resources/img/smiley.jpeg">
										</div>
										<div class="modal-footer">
											<button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button> 
										</div>
									</div>
								</form>
							</div>
							
						</div>
					</div>
					<div class="panel-footer clearfix">
						<form role="form" class="form-inline">
							<div class="form-group">
								<label for="voteValue"> My vote is </label>
								<select class="form-control" id="voteValue">
									<option value="0">0 </option>
									<option value="1">1 </option>
									<option value="2">2 </option>
									<option value="3">3 </option>
									<option value="4">5 </option>
									<option value="8">8 </option>
									<option value="13">13 </option>
									<option value="21">21 </option>
									<option value="34">34 </option>
									<option value="55">55 </option>
									<option value="89">89 </option>
									<option value="-2">??????? </option>
									<option value="-3">Pass</option>
									<option value="-4">Break</option>
								</select>
								<button type="button" class="btn btn-primary" onclick="castVote();">Cast My Vote</button>
							</div>
						</form>
					</div>
				</div>
			</div>
			
			<div class="col-md-3" id="participantsDiv">
				<table class="table table-hover tableHeaders" id="participantsTbl">
					<thead>
						<tr>
							<th>#</th>
							<th>Participant</th>
							<th>Points</th>
							<th style="display:none;">Email</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="participant" items="${participants}" varStatus="loop">
							<tr class="${participant.currentStoryVote == -1 ? 'danger' : 'success'}">
								<td>${(loop.index)+1}</td>
								<td>${participant.name}</td>
								<td>${participant.currentStoryVote == -1 ? '-' : participant.currentStoryVote}</td>
								<td style="display:none;">${participant.email}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
		
		<div class="row hostControls" align="center">
			<div class="col-md-3" align="center">
			</div>
			<div class="col-md-6" align="center">
				<div class="col-md-4" align="center">
					<a id="show-results" href="#" role="button" onClick="revealVotes()" class="btn btn-success btn-lg text-center"><span class="glyphicon glyphicon-eye-open"></span><br/>Reveal Votes</a>
				</div>
				<div class="col-md-4" align="center">
					<a id="vote-again" href="#" role="button" class="btn btn-warning btn-lg text-center"><span class="glyphicon glyphicon-refresh"></span><br/>Re-Vote Story</a>
				</div>
				<div class="col-md-4" align="center">
					<a id="modal-edit-score" href="#modal-container-editsp" role="button" class="btn btn-primary btn-lg text-center" data-toggle="modal"><span class="glyphicon glyphicon-pencil"></span><br/>Edit Story Points</a>
					<div class="modal fade" id="modal-container-editsp" role="dialog" aria-labelledby="editSpLabel" aria-hidden="true">
						<div class="modal-dialog">
							<form class="form-horizontal" role="form">
								<div class="modal-content">
									
									<div class="modal-body">
										<label for="spInput">Enter a desired story point value</label>
										<input id="spInput" type="number" min="0" max="100"/>
									</div>
									<div class="modal-footer">
										<button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button> 
										<button type="button" class="btn btn-primary" onclick="editSP();">Submit</button>
									</div>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
			<div class="col-md-3" align="center"></div>
		</div>
	</div>
	
	<script src="${pageContext.request.contextPath}/resources/js/jquery.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/sockjs-0.3.4.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/stomp.js"></script>
    
	<script type="text/javascript">
		var stompClientForBroadcasting = null;
		var stompClientForVote = null;
		var currentVoter = null;
		var stompClientForResults = null;
		var stompClientForJoining = null;
		var stompClientToEditSp = null;
		var stompClientToAddStories = null;
		var hostEMail;
		var currentStoryId = null;
		$(document).ready(function () {
			getHostMail();
			connectToSessionJoiningWS();
			connectToBroadCast();
  			connectToVote();
			connectToResults();
			connectToEditSP();
			connectToAddStories();
		});
		
		function getHostMail() {
			var sessionURL = getQueryVariable("sessionUrl");
			var urlValue = location.protocol + "//" + location.host + "/planpoker/getHostEmail";
			var hostMail = "";
		    $.ajax({
			  url : urlValue,
			  type: "get", //send it through get method
			  data : {"sessionUrl" : sessionURL},
			  async: false,
			  beforeSend : function(xhr) {
					xhr.setRequestHeader("Accept", "text/plain");
					xhr.setRequestHeader("Content-Type", "application/json");
				},
			  success: function(response) {
			    hostMail = response;
			    hostEMail = hostMail;
			  },
			  error: function(xhr) {
				  alert("error");
			  }
			});
		
			if (hostMail != getQueryVariable("email")) {
				$(".hostControls" ).hide();
			}
			
		}
		
		function joinSession() {
			var participantEmail = getQueryVariable('email');
			var sessionUrl = getQueryVariable('sessionUrl');
			stompClientForJoining.send("/app/joinSession", {}, JSON.stringify({ 'email' :  participantEmail, 'sessionUrl' : sessionUrl}));
		}
		
		function connectToSessionJoiningWS() {
			var currentURL = window.location.protocol + "//" + window.location.host;
		    var socket = new SockJS(currentURL + '/planpoker/joinSession');
            stompClientForJoining = Stomp.over(socket);            
            stompClientForJoining.connect({}, function(frame) {
                //console.log('Connected to the session joining websocket: ' + frame);
                console.log('Connected to the session joining websocket: ');
                stompClientForJoining.subscribe('/pokerSession/sessionJoining', function(participantList) {
                	var participantData = JSON.parse(participantList.body);
                    updateParticipants(participantData);
                });
                joinSession();
			});
		}
		
		function updateStoryPoint(participantData) {
			var total = 0;
			var count = 0;
			var average = 0;
			var closestGreaterFibonacci = 0;
			var fibonacci = [0, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144];
			
			$.each(participantData, function(idx, participant) {
				if(participant.currentStoryVote >= 0 ){
					total = total + participant.currentStoryVote;
					count++;
				}
			});
			
			average = Math.ceil(total/count);
			
			for (var i=0; i < fibonacci.length; i++){
				if(fibonacci[i] >= average) {
					closestGreaterFibonacci = fibonacci[i];
					break;
				}
			}

			var targetRow = $("#storiesList tr td").filter(function() {
        	    return $(this).text() == currentStoryId;  	        
        	}).parent('tr');
        	
        	$(targetRow).find("td").eq(2).html(closestGreaterFibonacci);
			targetRow.removeClass('danger');
        	targetRow.addClass('success');
		}
		
		function updateParticipants(participantData){
			$("#participantsTbl tbody").empty();
			$.each(participantData, function(idx, participant) {
				var style = participant.currentStoryVote == -1 ? "danger" : "success";
				var vote = '-';
				if(participant.currentStoryVote == -1){
					vote = '-';
				} else if(participant.currentStoryVote == -2){
					vote = '???????';
				} else if(participant.currentStoryVote == -3){
					vote = 'Pass';
				} else if(participant.currentStoryVote == -4){
					vote = 'Break';
				} else {
					vote = participant.currentStoryVote;
				}
				$('#participantsTbl > tbody').append('<tr class="'+style+'"><td>'+(idx+1)+'</td><td>'+participant.name+'</td><td>'+vote+'</td><td style="display:none;">' + participant.email + '</td></tr>');
			});
		}
		
		function updateStories(userStories) {
		    $('#stories').val('');
			$('#modal-container-stories').modal('hide');
			
			$("#storiesList tbody").empty();
			$.each(userStories, function(idx, story) {
				var finalPoints = story.voted == 1 ? story.finalPoints : '-';
				var style = story.voted == 1 ? "success" : "danger";
				
				 
				$('#storiesList > tbody').append('<tr class="' + style + '"><td>'+(idx+1)+'</td><td>'+story.storyTitle+'</td><td>'
						+ finalPoints + '<td class="hostControls"><a id="broadCast" href="#" title="Broadcast for voting" onclick="broadCastStory(' + story.storyId + ')"><span class="glyphicon glyphicon-bullhorn"></span></a>' +
						'</td><td style="display:none;">' + story.storyId + '</td></td></tr>');
			});
			
			if (hostEMail != getQueryVariable("email")) {
				$(".hostControls" ).hide();
			}
			
		}
		
		function connectToBroadCast() {
		    var currentURL = window.location.protocol + "//" + window.location.host;
		    var socket = new SockJS(currentURL + '/planpoker/broadCast');
            stompClientForBroadcasting = Stomp.over(socket);            
            stompClientForBroadcasting.connect({}, function(frame) {
               // console.log('Connected to the story broadcasting websocket: ' + frame);
               console.log('Connected to the story broadcasting websocket: ');
                stompClientForBroadcasting.subscribe('/pokerSession/broadCastStories', function(content) {
                	var storyData = JSON.parse(content.body);
					updateCurrentStory(storyData);
					updateParticipants(storyData.participantList);
                });
			});
        }
        
       function connectToVote() {
		   var currentURL = window.location.protocol + "//" + window.location.host;
		    var socket = new SockJS(currentURL + '/planpoker/castVote');
            stompClientForVote = Stomp.over(socket);            
            stompClientForVote.connect({}, function(frame) {
                stompClientForVote.subscribe('/pokerSession/vote', function(vote) {
					updateVoterStatus(vote.body);
                });
			});
        }
        
        function connectToResults() {
		   var currentURL = window.location.protocol + "//" + window.location.host;
		   var socket = new SockJS(currentURL + '/planpoker/revealVotes');
           stompClientForResults = Stomp.over(socket);            
           stompClientForResults.connect({}, function(frame) {
        	   stompClientForResults.subscribe('/pokerSession/showVotes', function(results) {
					var participants = JSON.parse(results.body);
					updateParticipants(participants);
					updateStoryPoint(participants);
                });
           });
        }
    
    
    	function connectToAddStories() {
        	console.log("add stories called..........")
           var currentURL = window.location.protocol + "//" + window.location.host;
   		   var socket = new SockJS(currentURL + '/planpoker/addStories');
              stompClientToAddStories = Stomp.over(socket);            
              stompClientToAddStories.connect({}, function(frame) {
             	 stompClientToAddStories.subscribe('/pokerSession/addUserStory', function(stories) {
   					var userStories = JSON.parse(stories.body);
   					updateStories(userStories);
   					
                   });
              });
         }
	 
	 
        function broadCastStory(storyId) {
			currentStoryId = storyId;
			stompClientForBroadcasting.send("/app/broadCast", {}, storyId);
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
         	if(currentStoryId == undefined || currentStoryId < 1){
         		alert("No story is active to vote..! \n Ask your host to broadcast a story to vote!");
         		return false;
         	} else {
         		var participantEmail = getQueryVariable('email');
				var e = document.getElementById('voteValue');
				var points = e.options[e.selectedIndex].value;
				points = points.trim();
				stompClientForVote.send("/app/castVote", {}, JSON.stringify({ 'storyId' :  currentStoryId, 'participantEmail' : participantEmail, 'points' : points}));
         	}
         }
        
        function revealVotes() {
        	stompClientForResults.send("/app/revealVotes", {}, currentStoryId);
        }
        
        function updateVoterStatus(voterEmail) {
        	console.log("voter email from response : "+voterEmail);
        	var targetRow = $("#participantsTbl tr td").filter(function() {
        	    return $(this).text() == voterEmail;  	        
        	}).parent('tr');
        	targetRow.removeClass('danger');
        	targetRow.addClass('success');    
        }
	
	function addStories() {
        	var storiesToAdd = $('#stories').val();
        	console.log("............................add stories is called..." + storiesToAdd);
        	if (storiesToAdd == "") {
        	    alert("Please enter atleast one story");
        	    return;
        	}
        	var sessionURL = getQueryVariable("sessionUrl");
        	
        	console.log("session url value in add stories...." + sessionURL);
        	var storyData = {"sessionUrl" : sessionURL, "stories" : storiesToAdd};
        	
			stompClientToAddStories.send("/app/addStories", {}, JSON.stringify(storyData));
        }
      	
	
	function getParticipants() {
        	var sessionURL = getQueryVariable("sessionUrl");
			console.log("session url...." + sessionURL);
			var urlValue = location.protocol + "//" + location.host + "/planpoker/getParticipants";
			var participantsEmail;
			
        	$.ajax({
   			    url : urlValue,
   			    type: "get", //send it through get method
   			    data : {"sessionUrl" : sessionURL},
   			    async: false,
   			    beforeSend : function(xhr) {
   					xhr.setRequestHeader("Accept", "text/plain");
   					xhr.setRequestHeader("Content-Type", "application/json");
   				},
    			success: function(response) {
   			        participantsEmail = response;
   			      console.log("response is...in ajax request" + participantsEmail);
   			        
   			       /* var data = response.d;
                     $.each(data, function(index, item) {
                         alert(item);//Here you will get items of your list
                     });*/
   			        processParticipantsEmail(participantsEmail);
   			        
   			  },
   			  error: function(xhr) {
   				  alert("error");
   			  }
   			});
        	
        	console.log("after async request");
        	
        }
        
        function processParticipantsEmail(participantsEmail) {
        	alert("......." + participantsEmail);
        	if (participantsEmail == "") {
        		return;
        	}
        	
        	var participantsEmailArray = participantsEmail.split(':');
        	
        	if (participantsEmailArray.length == 1) {
        		if (participantsEmailArray[0] == hostEMail) {
        			// No need of admin mail id
        			alert("admi host");
        			return
        		}
        	}
        	
        	
        	var mailDataToPopulateInModel = "";
        	for (var i = 0; i < participantsEmailArray.length; i++) {
        		mailDataToPopulateInModel = mailDataToPopulateInModel + "\n" + participantsEmailArray[i];
        	}
        	mailDataToPopulateInModel = mailDataToPopulateInModel.substring(1, mailDataToPopulateInModel.length);
        	
        	console.log("mailDataToPopulatInModel.........." + mailDataToPopulateInModel);
        	$('#peopleEmailList').val(mailDataToPopulateInModel);
        	
        	
        }
        
        function invitePeople() {
        	var participantEmailList = $('#peopleEmailList').val();
        	
        	if (participantEmailList == undefined || participantEmailList == ""){
        		alert("Please enter atleast one participant email");
        		return;
        	}
        	
        	var sessionURL = getQueryVariable("sessionUrl");
        	var json = {
    				"sessionUrl" : sessionURL,
    				"participantEmail" : participantEmailList
    		};
        	
        	var inviteResponse = "";
        	$.ajax({
				url : location.protocol + "//" + location.host + "/planpoker/invitepeople",
				type : 'POST',
				data : JSON.stringify(json),
				cache : false,
				async: false,
				beforeSend : function(xhr) {
					xhr.setRequestHeader("Accept", "text/plain");
					xhr.setRequestHeader("Content-Type", "application/json");
				},
				success : function(response) {
					console.log("response..." + response);
					inviteResponse = response;
				},
				error : function(jqXHR, status, error) {
					if(jqXHR.status && jqXHR.status==400){
                    	alert(jqXHR.responseText); 
               		}else{
                   		alert(jqXHR.responseText);
               		}
				}
			});
        	
        	if (inviteResponse == "SUCCESS") {
        		console.log("Invited successfully...");
        		var emailListArray = participantEmailList.split('\n');
        		var emailsToSendInvite = "";
        		for (var i = 0; i < emailListArray.length; i++) {
        			emailsToSendInvite = emailsToSendInvite + ";" + emailListArray[i];
        		}
        		emailsToSendInvite = emailsToSendInvite.substring(1, emailsToSendInvite.length);
        		
        		var sessionName = $('#sessionName').val();
        		sendToEmail(emailsToSendInvite, sessionURL, sessionName);
        	} else {
        		alert("Unable to invite")
        	}
        	
        	$('#peopleEmailList').val('');
 			$('#modal-container-invite').modal('hide');
        }
        
        function sendToEmail(emailList, sessionURL, sessionName) {
        	var hrefVal = 'mailto:' + emailList + '?subject=Planning Ninja Invite : '+sessionName+'&body=Hi, Join the Planning poker session for the Session '+sessionName+' at '
        			+ location.protocol + "//" + location.host + '/planpoker/session?sessionUrl=' + sessionURL;
        	$('#targetMailLink').attr('href', hrefVal);
        	$('#targetMailLink')[0].click();
        }
		var progressStory;
        var previousStory;
        function updateCurrentStory(storyData) {
        	var storyTitle = storyData.storyTitle;
        	currentStoryId = storyData.storyId;
			$("#storyTitleId").text(storyTitle);
        	if (progressStory != undefined) {
        		previousStory = progressStory;
        		progressStory = storyTitle
        	}
        	
        	var targetStoryRow = $("#storiesList tr td").filter(function() {
        	    return $(this).text() == currentStoryId;
        	}).parent('tr');
        	
        	targetStoryRow.css('border', '2px solid black');
            
            progressStory = currentStoryId;
            
            if (previousStory != undefined) {
            	var previousStoryRow = $("#storiesList tr td").filter(function() {
            	    return $(this).text() == previousStory;
            	}).parent('tr');
            	
            	//previousStoryRow.removeClass('progress');
            	//previousStoryRow.addClass('danger');
            	previousStoryRow.css('border', '0px solid black');
            }
        }
        //******************* Edit Story Point Logic begins here ***********************//
        function connectToEditSP() {
			var currentURL = window.location.protocol + "//" + window.location.host;
		    var socket = new SockJS(currentURL + '/planpoker/editSp');
            stompClientToEditSp = Stomp.over(socket);            
            stompClientToEditSp.connect({}, function(frame) {
                //console.log('Connected to the edit story point websocket: ' + frame);
                console.log('Connected to the edit story point websocket: ');
                stompClientToEditSp.subscribe('/pokerSession/editStoryPoint', function(content) {
                	var story = JSON.parse(content.body);
                    updateStoryTable(story);
                });
			});
		}
		
        function editSP() {
			var newSpValue = $('#spInput').val();
			console.log("edit story point value :" + newSpValue);
        	if (newSpValue == undefined || newSpValue == "") {
        		console.warn("new sp value is undefined or empty");
        	    return false;
        	} else if(currentStoryId == undefined || currentStoryId == 0){
        		console.warn("current story id is undefined or zero");
        		return false;
        	} else {
        		var data = {"storyId" : currentStoryId, "finalPoints" : newSpValue};
        		stompClientToEditSp.send("/app/editSp", {}, JSON.stringify(data));
        	}
		}
		
		function updateStoryTable(story){
			$('#modal-container-editsp').modal('hide');
			var targetRow = $("#storiesList tr td").filter(function() {
        	    return $(this).text() == currentStoryId;  	        
        	}).parent('tr');
        	
        	$(targetRow).find("td").eq(2).html(story.finalPoints);
        	targetRow.removeClass('danger');
        	targetRow.addClass('success');
		}
		
        
	</script>
</body>
</html>