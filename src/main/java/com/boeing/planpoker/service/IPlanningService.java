package com.boeing.planpoker.service;

import java.util.List;

import com.boeing.planpoker.model.Participant;
import com.boeing.planpoker.model.PokerSession;
import com.boeing.planpoker.model.Story;

public interface IPlanningService {

	void createPlanSession(PokerSession pokerSession) throws Exception;
	void getAllPlanSessions(String hostEmail) throws Exception;
	Participant isValidUser(String email) throws Exception;
	PokerSession fetchPokerSession(String sessionUrl);
	List<Story> fetchStories(int sessionId);
	List<Participant> fetchParticipantsJoined(int sessionId);
	List<Participant> fetchStoryVotes(int sessionId, int storyId);
	boolean isAuthorizedUser(int sessionId, String email);
}
