package com.boeing.planpoker.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;

import com.boeing.planpoker.model.AddStory;
import com.boeing.planpoker.model.BroadCast;
import com.boeing.planpoker.model.JoinSessionVo;
import com.boeing.planpoker.model.Participant;
import com.boeing.planpoker.model.PokerSession;
import com.boeing.planpoker.model.Story;
import com.boeing.planpoker.model.StoryVotes;
import com.boeing.planpoker.service.IPlanningService;


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
		
		//String participantName = "";
		try {
		    planningService.updateStoryVote(storyId, participant_email, votePoint);
		    //participantName = planningService.getUserNameByEmail(participant_email);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return participant_email;
	}
	
	@MessageMapping("/revealVotes")
    @SendTo("/pokerSession/showVotes")
	public List<Participant> getResults(int storyId) {
		List<Participant> participantList = null;
		int sessionId = planningService.fetchSessionIdByStoryId(storyId);
		participantList = planningService.fetchStoryVotes(sessionId, storyId);
		int points = calculateAvgPoints(participantList);
		if(points != -1){
			planningService.setVotingCompleted(storyId, points);	
		}
		return participantList;
	}
	

	@MessageMapping("/addStories")
    @SendTo("/pokerSession/addUserStory")
	public List<Story> addUserStory(AddStory addStory) {
		List<Story> storyList = null;
		String stories = addStory.getStories();
		String sessionURL = addStory.getSessionUrl();
		int sessionId = planningService.fetchPokerSession(sessionURL).getSessionId();
		try {
		    planningService.addStoriesFromPoker(stories, sessionId);   
		    storyList = planningService.fetchStories(sessionId);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return storyList;
	}

	@MessageMapping("/editSp")
	@SendTo("/pokerSession/editStoryPoint")
	public Story updateStoryPoint(Story story) {
		if(story!=null){
			planningService.setVotingCompleted(story.getStoryId(), story.getFinalPoints());
		}
		return story;
	}

	private int calculateAvgPoints(List<Participant> participantList) {
		int total = 0;
		int finalPoints = 0;
		int avg = 0;
		int count = 0;
		
		int[] fibonacci = {0, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144};
		if(participantList!=null){
			for(Participant participant : participantList){
				if(participant.getCurrentStoryVote() >= 0){
					total = total + participant.getCurrentStoryVote();
					count++;
				}
			}
			
			if(count > 0){
				avg = (int) Math.ceil(total/count);
				
				for(int i : fibonacci){
					if(i >= avg){
						finalPoints = i;
						break;
					}
				}
			} else {
				finalPoints = -1;
			}
		}
		
		return finalPoints;
	}
	
	
}
		
