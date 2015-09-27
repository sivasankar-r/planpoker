package com.boeing.planpoker.model;

public class InvitePeople {

	private String sessionUrl;
	private String participantEmail;

	public String getSessionUrl() {
		return sessionUrl;
	}

	public void getSessionUrl(String sessionUrl) {
		this.sessionUrl = sessionUrl;
	}

	public String getParticipantEmail() {
		return participantEmail;
	}

	public void setParticipantEmail(String participantEmail) {
		this.participantEmail = participantEmail;
	}
}
