package com.boeing.planpoker.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;

import com.boeing.planpoker.model.Story;
import com.boeing.planpoker.model.StoryVotes;
import com.boeing.planpoker.service.IPlanningService;


@Controller
public class PokerSessionController {

	@Autowired
	private IPlanningService planningService;
	
	/*@MessageMapping("/joinPokerSession")
    @SendTo("/pokerSession/newParticipant")
	public Participant joinParticipant(Participant participant) {
		participant.setName("Shakalaka joined");
		return participant;
	}*/
	
	@MessageMapping("/broadCast")
	@SendTo("/pokerSession/broadCastStories")
	public Story broadCastStories(int storyId) {
		Story story = planningService.fetchStoryById(storyId);
		return story;
	}

	
	@MessageMapping("/castVote")
    @SendTo("/pokerSession/vote")
	public String castVote(StoryVotes storyVote) {
		int storyId = storyVote.getStoryId();
		int votePoint = storyVote.getPoints();
		String participant_email = storyVote.getParticipantEmail();
		
		String participantName = "";
		try {
		    planningService.updateStoryVote(storyId, participant_email, votePoint);
		    
		    participantName = planningService.getUserNameByEmail(participant_email);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		
		//int votePoint = 0;
		/*try {
		    votePoint = Integer.parseInt(vote);
		} catch(Exception ex) {
			// If any string is came then set the votePoint is 0
			votePoint = -1;
		}*/
		
		return participantName;
	}
}
		
