package com.boeing.planpoker.model;

public class Story {
	private int storyId;
	private String storyExternalId;
	private String storyTitle;
	private String storyDescription;
	private int sessionId;
	private int finalPoints;
	private int voted;
	
	public int getStoryId() {
		return storyId;
	}

	public void setStoryId(int storyId) {
		this.storyId = storyId;
	}

	public String getStoryExternalId() {
		return storyExternalId;
	}

	public void setStoryExternalId(String storyExternalId) {
		this.storyExternalId = storyExternalId;
	}

	public int getSessionId() {
		return sessionId;
	}

	public void setSessionId(int sessionId) {
		this.sessionId = sessionId;
	}

	public String getStoryTitle() {
		return storyTitle;
	}

	public void setStoryTitle(String storyTitle) {
		this.storyTitle = storyTitle;
	}

	public String getStoryDescription() {
		return storyDescription;
	}

	public void setStoryDescription(String storyDescription) {
		this.storyDescription = storyDescription;
	}

	public int getFinalPoints() {
		return finalPoints;
	}

	public void setFinalPoints(int finalPoints) {
		this.finalPoints = finalPoints;
	}

	public int getVoted() {
		return voted;
	}

	public void setVoted(int voted) {
		this.voted = voted;
	}


}
