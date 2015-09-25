package com.boeing.planpoker.controller;

import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;

import com.boeing.planpoker.model.Participant;

@Controller
public class PokerSessionController {

	@MessageMapping("/joinPokerSession")
    @SendTo("/pokerSession/newParticipant")
	public Participant joinParticipant(Participant participant){
		participant.setName("Shakalaka joined");
		return participant;
	}
	
	@MessageMapping("/castVote")
    @SendTo("/pokerSession/vote")
	public Participant castVote(Participant participant){
		participant.setName("Shakalaka Casted a vote");
		return participant;
	}
}
