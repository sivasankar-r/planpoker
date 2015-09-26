package com.boeing.planpoker.service;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.boeing.planpoker.dao.IPlanningDao;
import com.boeing.planpoker.model.Participant;
import com.boeing.planpoker.model.PokerSession;
import com.boeing.planpoker.model.Story;
import com.boeing.planpoker.util.AppStringUtils;

@Service
public class PlanningService implements IPlanningService {
	private static final Logger log = Logger.getLogger(PlanningService.class.getName());
	@Autowired
	private IPlanningDao planningDao;
	
	@Override
	public void createPlanSession(PokerSession pokerSession) throws Exception {
		System.out.println("what is called");
		pokerSession.setSessionUrl(AppStringUtils.generateRandomString());
		try{
			int sessionId = planningDao.createPlanningSession(pokerSession);
			log.info("New Planning Session Created. Session ID : " + sessionId);
			if(sessionId != -1) {
				pokerSession.setSessionId(sessionId);
				List<Story> stories = generateStories(pokerSession.getStories(), sessionId);
				List<String> participantList = AppStringUtils.parseLineDelimitedString(pokerSession.getPeopleEmailList());
				if(stories!=null) {
					for(Story story : stories) {
						planningDao.addStory(story);
					}
				}

				if(participantList!=null) {
					for(String participant : participantList) {
						planningDao.addParticipant(participant, sessionId);
					}
				}
				
				planningDao.addParticipant(pokerSession.getHostEmail(), sessionId, 1);
				
			}
		} catch (SQLException ex) {
			log.error(ex);
			throw new Exception(ex);
		}
	}
	
	@Override
	public boolean updateSessionParticipant(int sessionId, String email, int status) {
		return planningDao.updateParticipantsStatus(sessionId, email, status);
	}
	
	public List<Story> generateStories(String input, int sessionId) {
		List<String> tempList = AppStringUtils.parseLineDelimitedString(input);
		List<Story> stories = null;
		if(tempList!=null && !tempList.isEmpty()){
			stories = new ArrayList<>();
			for(String title : tempList) {
				Story story = new Story();
				story.setSessionId(sessionId);
				story.setStoryTitle(title);
				stories.add(story);
			}
		}
		return stories;
	}

	@Override
	public void getAllPlanSessions(String hostEmail) throws Exception {
		List<PokerSession> planningSessions;
		try {
			planningSessions = planningDao.getAllPlanSessions(hostEmail);
			if(log.isDebugEnabled()){
				if(planningSessions!=null && !planningSessions.isEmpty()) {
					log.debug("********* Sessions available for the host : "+hostEmail);
					for(PokerSession session : planningSessions){
						log.debug("###########");
						session.printState();
					}
				}
			}
		} catch (SQLException e) {
			log.error(e);
			throw new Exception(e);
		}
	}

	@Override
	public Participant isValidUser(String email) throws Exception {
		return planningDao.isUserExist(email);
	}

	@Override
	public PokerSession fetchPokerSession(String sessionUrl) {
		return planningDao.fetchPokerSession(sessionUrl);
	}
	
	@Override
	public int fetchSessionIdByStoryId(int storyId) {
		return planningDao.fetchSessionIdByStoryId(storyId);
	}

	@Override
	public List<Story> fetchStories(int sessionId) {
		return planningDao.fetchStories(sessionId);
	}

	@Override
	public List<Participant> fetchParticipantsJoined(int sessionId) {
		return planningDao.fetchParticipantsJoined(sessionId);
	}

	@Override
	public List<Participant> fetchStoryVotes(int sessionId, int storyId) {
		return planningDao.fetchStoryVotes(sessionId, storyId);
	}

	@Override
	public boolean isAuthorizedUser(int sessionId, String email) {
		return planningDao.isAuthorizedUser(sessionId, email);
	}
	
	@Override
	public Story fetchStoryById(int storyId) {
		return planningDao.fetchStoryById(storyId);
	}
	
	@Override
	public void updateStoryVote(int storyId, String participant_email, int votePint) throws Exception {
		try {
			planningDao.updateStoryVote(storyId, participant_email, votePint);
		} catch (SQLException ex) {
			//ex.printStackTrace();
			log.error(ex);
			throw new Exception(ex);
		}
	}
	
	@Override
	public String getUserNameByEmail(String email) {
		return planningDao.getUserNameByEmail(email);
		
	}
}
