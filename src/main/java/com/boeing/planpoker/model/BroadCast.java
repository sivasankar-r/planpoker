package com.boeing.planpoker.model;
import java.util.List;

public class BroadCast {
	private int storyId;
	private String storyTitle;
	private List<Participant> participantList;

	public int getStoryId() {
		return storyId;
	}

	public void setStoryId(int storyId) {
		this.storyId = storyId;
	}
	
	public String getStoryTitle() {
		return storyTitle;
	}

	public void setStoryTitle(String storyTitle) {
		this.storyTitle = storyTitle;
	}

	public List<Participant> getParticipantList() {
		return participantList;
	}
	
	public void setParticipantList(List<Participant> participantList) {
		this.participantList = participantList;
		
	}
	

}
