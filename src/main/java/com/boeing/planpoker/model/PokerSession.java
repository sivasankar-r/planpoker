package com.boeing.planpoker.model;

import org.apache.log4j.Logger;


public class PokerSession {
	private static final Logger log = Logger.getLogger(PokerSession.class.getName());
	private int sessionId;
	private String sessionName;
	private int planningCardSet;
	private int votingTimeLimit;
	private String hostEmail;
	private String sessionUrl;
	private String stories;
	private String peopleEmailList;
	private String tfsIterationPath;
	
	public int getSessionId() {
		return sessionId;
	}

	public void setSessionId(int sessionId) {
		this.sessionId = sessionId;
	}

	public String getSessionName() {
		return sessionName;
	}

	public void setSessionName(String sessionName) {
		this.sessionName = sessionName;
	}

	public int getPlanningCardSet() {
		return planningCardSet;
	}

	public void setPlanningCardSet(int planningCardSet) {
		this.planningCardSet = planningCardSet;
	}

	public int getVotingTimeLimit() {
		return votingTimeLimit;
	}

	public void setVotingTimeLimit(int votingTimeLimit) {
		this.votingTimeLimit = votingTimeLimit;
	}

	public String getHostEmail() {
		return hostEmail;
	}

	public void setHostEmail(String hostEmail) {
		this.hostEmail = hostEmail;
	}

	public String getSessionUrl() {
		return sessionUrl;
	}

	public void setSessionUrl(String sessionUrl) {
		this.sessionUrl = sessionUrl;
	}

	public String getStories() {
		return stories;
	}

	public void setStories(String stories) {
		this.stories = stories;
	}

	public String getPeopleEmailList() {
		return peopleEmailList;
	}

	public void setPeopleEmailList(String peopleEmailList) {
		this.peopleEmailList = peopleEmailList;
	}
	
	public void printState(){
		log.debug("Session ID : " + sessionId);
		log.debug("Card Set : " + planningCardSet);
		log.debug("Participant Email List : " + peopleEmailList);
		log.debug("Session Name : " + sessionName);
		log.debug("Session URL : " + sessionUrl);
		log.debug("Stories for the session : " + stories);
		log.debug("Time Limit for each story : " + votingTimeLimit);
	}

	public String getTfsIterationPath() {
		return tfsIterationPath;
	}

	public void setTfsIterationPath(String tfsIterationPath) {
		this.tfsIterationPath = tfsIterationPath;
	}
}
