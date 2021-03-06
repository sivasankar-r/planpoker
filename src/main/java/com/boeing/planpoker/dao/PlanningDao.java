package com.boeing.planpoker.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;
import org.springframework.dao.DataAccessException;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.namedparam.BeanPropertySqlParameterSource;
import org.springframework.jdbc.core.simple.SimpleJdbcInsert;
import org.springframework.stereotype.Repository;

import com.boeing.planpoker.model.Participant;
import com.boeing.planpoker.model.PokerSession;
import com.boeing.planpoker.model.Story;

@PropertySource({ "classpath:query.properties" })
@Repository
public class PlanningDao implements IPlanningDao {
	private static final Logger log = Logger.getLogger(PlanningDao.class.getName());
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Resource
	private Environment env;
	
	@Override
	public int createPlanningSession(PokerSession pokerSession) throws SQLException {
		log.info("Creating session with name : "+pokerSession.getSessionName()+" for the Host with email id : " + pokerSession.getHostEmail());
		int id = -1;
		SimpleJdbcInsert jdbcInsert = new SimpleJdbcInsert(jdbcTemplate);
		jdbcInsert.withTableName("poker_session");
		jdbcInsert.setGeneratedKeyName("session_id");
		Number key = jdbcInsert.executeAndReturnKey(new BeanPropertySqlParameterSource(pokerSession));
		if (key != null) {
			id = key.intValue();
		}
		return id;
	}
	
	@Override
	public boolean updateParticipantsStatus(int sessionId, String email, int status) {
		boolean flag = false;
		int rowsUpdated = jdbcTemplate.update("update session_participants set joined = ? where session_id = ? and email = ?", new Object[] { status, sessionId, email });
		if(rowsUpdated ==1) {
			flag = true;
			log.info("Updated participant "+ email + " status to the session id : " +  sessionId);
		} else {
			log.error("Failed to update the participant "+ email + " status to the session id : " +  sessionId);
		}	
		return flag;
	 }
	

	@Override
	public List<PokerSession> getAllPlanSessions(String hostEmail) throws SQLException {
		String query = "SELECT session_id, session_name, planning_card_set,	voting_time_limit, host_email, session_url FROM poker_session ORDER BY session_id ";
		return jdbcTemplate.query(query, new BeanPropertyRowMapper<PokerSession>(PokerSession.class));
	}

	@Override
	public void addParticipant(String participant, int sessionId) throws SQLException {
		int rowsUpdated = jdbcTemplate.update("INSERT INTO session_participants (session_id, email) VALUES(?,?)", new Object[] { sessionId, participant });
		if(rowsUpdated ==1){
			log.info("Added "+participant+" to the session id : "+sessionId);
		} else {
			log.error("Failed to add "+participant+" to the session id : "+sessionId);
		}
	}
	
	@Override
	public void addParticipant(String hostEmail, int sessionId, int joinedFlag) {
		int rowsUpdated = jdbcTemplate.update("INSERT INTO session_participants (session_id, email, joined) VALUES(?, ?, ?)", new Object[] { sessionId, hostEmail, joinedFlag });
		if(rowsUpdated ==1){
			log.info("Added "+hostEmail+" to the session id : "+sessionId);
		} else {
			log.error("Failed to add "+hostEmail+" to the session id : "+sessionId);
		}
	}

	@Override
	public int addStory(Story story) throws SQLException {
		int id = -1;
		SimpleJdbcInsert jdbcInsert = new SimpleJdbcInsert(jdbcTemplate);
		jdbcInsert.withTableName("stories");
		jdbcInsert.setGeneratedKeyName("story_id");
		Number key = jdbcInsert.executeAndReturnKey(new BeanPropertySqlParameterSource(story));
		if (key != null) {
			id = key.intValue();
			log.info("New Story with id:"+ id +" added to the session :"+story.getSessionId());
		}
		return id;
	}

	@Override
	public Participant isUserExist(String email) throws Exception {
		String query = "SELECT email, name, project FROM participant WHERE email='"+email+"'";
		Participant user = null;
		try {
			user = jdbcTemplate.queryForObject(query, new BeanPropertyRowMapper<Participant>(Participant.class));
		} catch(DataAccessException e){
			if(e instanceof EmptyResultDataAccessException){
				throw new Exception("Not authorised. Please contact administrator for access", e);
			}else{
				throw e;
			}
		}
		return user;
	}

	
	@Override
	public PokerSession fetchPokerSession(String sessionUrl) {
		PokerSession session = null;
		String query = "SELECT session_id, session_name, planning_card_set,	voting_time_limit, host_email, session_url FROM poker_session where session_url = ?";
		List<PokerSession> list = jdbcTemplate.query(query, new Object[]{sessionUrl}, new BeanPropertyRowMapper<PokerSession>(PokerSession.class));
		if(list!=null && !list.isEmpty()) {
			session = list.get(0);
		}
		return session;
	}
	
	@Override
	public String getUserNameByEmail(String email) {
		String query = "SELECT name FROM participant WHERE email = ?";
		 
		String name = jdbcTemplate.queryForObject(
				query, String.class, email);
		
		return name;
		
	}
	
	@Override
	public Story fetchStoryById(int storyId) {
		Story story = null;
		String query = "SELECT story_id, story_external_id, story_title, story_description, session_id, final_points, voted FROM stories WHERE story_id = ?";
		
		List<Story> list = jdbcTemplate.query(query, new Object[]{storyId}, new BeanPropertyRowMapper<Story>(Story.class));
		if(list != null && !list.isEmpty()) {
			story = list.get(0);
		}
		return story;
	}
	
	@Override
	public void updateStoryVote(int storyId, String participant_email, int votePint) throws SQLException {
		int rowsUpdated = jdbcTemplate.update("update story_votes set vote_points = ? where story_id = ? and participant_email = ?", 
				new Object[] {votePint, storyId, participant_email});
		if(rowsUpdated == 0){
			int rowsInserted = jdbcTemplate.update("INSERT INTO story_votes (story_id, participant_email, vote_points) VALUES(?,?,?)", new Object[] { storyId, participant_email, votePint });
			if(rowsInserted ==1) {
				log.info("inserted StoryVotes by "+ participant_email + " for the Story : " + storyId);
			} else {
				log.info("Failed to inserted StoryVotes by "+ participant_email + " for the Story : " + storyId);
			}
		} else {
			log.info("Updated StoryVotes by "+ participant_email + " for the Story : " + storyId);
		} 
	 }

	@Override
	public List<Story> fetchStories(int sessionId) {
		List<Story> stories = null;
		String query = "SELECT story_id, story_external_id, story_title, story_description, session_id, final_points, voted FROM stories WHERE session_id = ?";
		stories = jdbcTemplate.query(query, new Object[]{sessionId}, new BeanPropertyRowMapper<Story>(Story.class));
		return stories;
	}

	@Override
	public List<Participant> fetchParticipantsJoined(int sessionId) {
		List<Participant> participants = null;
		String query = "SELECT a.email, b.name FROM session_participants a join participant b on a.email = b.email where a.session_id = ? and a.joined = ?";
		participants = jdbcTemplate.query(query, new Object[]{sessionId, 1}, new BeanPropertyRowMapper<Participant>(Participant.class));
		if(participants!=null){
			for(Participant participant : participants) {
				participant.setCurrentStoryVote(-1);
			}
		}
		return participants;
	}
	
	@Override
	public List<String> fetchParticipantListBySessionId(int sessionId) {
		List<String> participants = new ArrayList<String>();
		String query = "SELECT email FROM session_participants where session_id = " + sessionId;
		participants = jdbcTemplate.query(query, new RowMapper<String>(){
            public String mapRow(ResultSet rs, int rowNum) 
                                         throws SQLException {
                    return rs.getString(1);
            }
       });
		
		//participants =  jdbcTemplate.query(query, new Object[]{sessionId}, ResultSetExtractor<String.class>(Str));
		
		System.out.println("participantEmail...." + participants);
		
		
		
		return participants;
	}
	
		@Override 
	public int fetchSessionIdByStoryId(int storyId) {
		String query = "SELECT session_id FROM stories WHERE story_id = ?";
		 
		int sessionId = jdbcTemplate.queryForObject(
				query, Integer.class, storyId);
		
		return sessionId;
	}

	@Override
	public List<Participant> fetchStoryVotes(int sessionId, int storyId) {
		List<Participant> participants = fetchParticipantsJoined(sessionId);
			if(participants!=null) {
			for(Participant participant : participants) {
				String voteQuery = "SELECT vote_points FROM story_votes WHERE participant_email = ? AND story_id = ?";
				Integer value = null;
				try {
					value = jdbcTemplate.queryForObject(voteQuery, new Object[]{participant.getEmail(), storyId}, Integer.class);
				} catch (EmptyResultDataAccessException e) {
					
				}
				if(value!=null){
					participant.setCurrentStoryVote(value);	
				} else {
					participant.setCurrentStoryVote(-1);
				}
			}
		}
		return participants;
	}

	@Override
	public boolean isAuthorizedUser(int sessionId, String email) {
		String query = "SELECT count(*) FROM session_participants WHERE email= ? AND session_id = ?";
		boolean valid = false;
		try {
			Integer value = jdbcTemplate.queryForObject(query, new Object[]{email, sessionId}, Integer.class);
			if(value == 1) {
				valid = true;
			}
		} catch(Exception e){
			log.error(e.getLocalizedMessage());
		}
		return valid;
	}

	@Override
	public void setVotingCompleted(int storyId, int points) {
		int rowsUpdated = jdbcTemplate.update("update stories SET final_points = ?, voted = ? WHERE story_id = ?",	new Object[] {points, 1, storyId});
		if(rowsUpdated == 0){
			log.info("Failed to update voting completed for the Story : " + storyId);
		} else {
			log.info("Updated voting completed for the Story : " + storyId);
		} 
	}
}
