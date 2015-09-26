package com.boeing.planpoker.dao;

import java.sql.SQLException;
import java.util.List;

import com.boeing.planpoker.model.Participant;
import com.boeing.planpoker.model.PokerSession;
import com.boeing.planpoker.model.Story;

public interface IPlanningDao {

	int createPlanningSession(PokerSession pokerSession) throws SQLException;

	List<PokerSession> getAllPlanSessions(String hostEmail) throws SQLException;

	void addParticipant(String participant, int sessionId) throws SQLException;

	int addStory(Story story) throws SQLException;

	Participant isUserExist(String email) throws Exception;

	PokerSession fetchPokerSession(String sessionUrl);

	List<Story> fetchStories(int sessionId);

	List<Participant> fetchParticipantsJoined(int sessionId);

	void addParticipant(String hostEmail, int sessionId, int i);

	List<Participant> fetchStoryVotes(int sessionId, int storyId);

	boolean isAuthorizedUser(int sessionId, String email);
	
	boolean updateParticipantsStatus(int sessionId, String email, int status);
	
	Story fetchStoryById(int storyId);
	
	void updateStoryVote(int storyId, String participant_email, int votePint) throws SQLException;
	
	String getUserNameByEmail(String email);
	
	int fetchSessionIdByStoryId(int storyId);

}
