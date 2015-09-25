package com.boeing.planpoker.model;

public class Participant {
	private String name;
	private String email;
	private String project;
	private int currentStoryVote;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getProject() {
		return project;
	}

	public void setProject(String project) {
		this.project = project;
	}

	public int getCurrentStoryVote() {
		return currentStoryVote;
	}

	public void setCurrentStoryVote(int currentStoryVote) {
		this.currentStoryVote = currentStoryVote;
	}

}
