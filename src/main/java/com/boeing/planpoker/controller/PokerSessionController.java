package com.boeing.planpoker.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;

import com.boeing.planpoker.model.JoinSessionVo;
import com.boeing.planpoker.model.Participant;
import com.boeing.planpoker.model.PokerSession;
import com.boeing.planpoker.model.Story;
import com.boeing.planpoker.model.StoryVotes;
import com.boeing.planpoker.service.IPlanningService;
import com.boeing.planpoker.model.Participant;
import com.boeing.planpoker.model.BroadCast;


@Controller
public class PokerSessionController {

	@Autowired
	private IPlanningService planningService;
	
	@MessageMapping("/joinSession")
	@SendTo("/pokerSession/sessionJoining")
	public List<Participant> joinSession(JoinSessionVo joinSessionVo) {
		PokerSession session = planningService.fetchPokerSession(joinSessionVo.getSessionUrl());
		boolean success = planningService.updateSessionParticipant(session.getSessionId(), joinSessionVo.getEmail(), 1);
		
		List<Participant> participantList = planningService.fetchParticipantsJoined(session.getSessionId());
		boolean alreadyExist = false;
		if(participantList != null){
			for(Participant participant : participantList) {
				if(participant.getEmail().equals(joinSessionVo.getEmail())){
					alreadyExist = true;
					break;
				}
			}
			
			if(success && !alreadyExist) {
				Participant newParticipant = new Participant();
				newParticipant.setCurrentStoryVote(-1);
				newParticipant.setEmail(joinSessionVo.getEmail());
				newParticipant.setName(planningService.getUserNameByEmail(joinSessionVo.getEmail()));
				participantList.add(newParticipant);
			}
		} else {
			participantList = new ArrayList<>();
			Participant newParticipant = new Participant();
			newParticipant.setCurrentStoryVote(-1);
			newParticipant.setEmail(joinSessionVo.getEmail());
			newParticipant.setName(planningService.getUserNameByEmail(joinSessionVo.getEmail()));
			participantList.add(newParticipant);
		}
		return participantList;
	}
		
	@MessageMapping("/broadCast")
	@SendTo("/pokerSession/broadCastStories")
	public BroadCast broadCastStories(int storyId) {
		System.out.println("data....." + storyId);
		
		Story story = planningService.fetchStoryById(storyId);
		
		int sessionId = planningService.fetchSessionIdByStoryId(storyId);
		
		List<Participant> participantList = planningService.fetchParticipantsJoined(sessionId);
		
		BroadCast broadCast = new BroadCast();
		broadCast.setStoryId(storyId);
		broadCast.setStoryTitle(story.getStoryTitle());
		broadCast.setParticipantList(participantList);
		
		
	
		return broadCast;
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
		return participantName;
	}
	
	@MessageMapping("/getResults")
    @SendTo("/pokerSession/results")
	public List<Participant> getResults(int storyId) {
		
		 List<Participant> participantList = null;
		try {
			int sessionId = planningService.fetchSessionIdByStoryId(storyId);
		    
		    participantList = planningService.fetchStoryVotes(sessionId, storyId);
		    
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		
		return participantList;
	}
	
	
}
		
