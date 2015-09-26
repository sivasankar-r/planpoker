package com.boeing.planpoker.model;

public class StoryVotes {
	private int storyId;
	private String participantEmail;
	private int points;
	
	public int getStoryId() {
		return storyId;
	}
	public void setStoryId(int storyId) {
		this.storyId = storyId;
	}
	public String getParticipantEmail() {
		return participantEmail;
	}
	public void setParticipantEmail(String participantEmail) {
		this.participantEmail = participantEmail;
	}
	public int getPoints() {
		return points;
	}
	public void setPoints(int points) {
		this.points = points;
	}
	
}
