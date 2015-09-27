package com.boeing.planpoker.controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.boeing.planpoker.model.InvitePeople;
import com.boeing.planpoker.model.Participant;
import com.boeing.planpoker.model.PokerSession;
import com.boeing.planpoker.model.Story;
import com.boeing.planpoker.service.IPlanningService;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;


@Controller
public class MainController {
	private static final Logger log = Logger.getLogger(MainController.class.getName());
	
	@Autowired
	private IPlanningService planningService;
	
	@RequestMapping(value = {"/session/", "/session"}, method = RequestMethod.GET)
	public ModelAndView startSession(@RequestParam Map<String,String> allRequestParams) {
		ModelAndView model = new ModelAndView();
		String sessionUrl = allRequestParams.get("sessionUrl");
		String email = allRequestParams.get("email");
		
		
		if(sessionUrl == null || sessionUrl.trim().isEmpty()) {
			log.info("has no session url");
			model.setViewName("login");
			return model;
		} 
		
		if(email == null || email.trim().isEmpty()) {
			log.info("has session url but no email");
			model.setViewName("joinSession");
			model.addObject("sessionUrl", sessionUrl);
			return model;
		}
		
		Participant user = getUser(email);
		if(user.getEmail() == null || user.getEmail().isEmpty()) {
			log.info("has session url and email, but email is invalid");
			model.setViewName("joinSession");
			model.addObject("sessionUrl", sessionUrl);
			return model;
		}
		
		PokerSession pokerSession = planningService.fetchPokerSession(sessionUrl);
		
		if(pokerSession == null) {
			log.info("has session url, but invalid session url");
			model.setViewName("login");
			return model;
		}
		
		boolean isAuthorized = planningService.isAuthorizedUser(pokerSession.getSessionId(), user.getEmail());
		if(!isAuthorized) {
			log.info("User not authorized");
			model.setViewName("login");
			return model;
		}
		
		
		List<Story> storiesList = planningService.fetchStories(pokerSession.getSessionId());
		//List<Participant> participantList = planningService.fetchParticipantsJoined(pokerSession.getSessionId());
		
		model.setViewName("pokerSession");
		model.addObject("stories", storiesList);
		model.addObject("participants", null);
		model.addObject("pokerSession", pokerSession);
		return model;
	}
	
	@RequestMapping(value = "/welcome/{email:.+}", method = RequestMethod.GET)
	public ModelAndView welcome(@PathVariable("email") String email) {
		log.debug("Redirecting user : "+ email +" to index page...");
		ModelAndView model = new ModelAndView();
		Participant user = getUser(email);
		if(user.getEmail() == null || user.getEmail().isEmpty()) {
			model.setViewName("login");
		} else {
			model.setViewName("index");
			model.addObject("email", email);
			model.addObject("existingSessions", "this is a sample message");	
		}
		return model;
	}
	
	@RequestMapping(value = { "/" })
	public String index() {
		log.debug("Redirecting to login.jsp page");
		return "login";
	}
	
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	@ResponseBody
	public String login(@RequestBody String email) throws Exception {
		Participant user = getUser(email);
		String writeValueAsString = new ObjectMapper().writeValueAsString(user);
		return writeValueAsString;
	}
	
	@RequestMapping(value = "/getHostEmail", method = RequestMethod.GET)
	@ResponseBody
	public String getHostEmail(@RequestParam Map<String,String> allRequestParams) throws Exception {
		String sessionUrl = allRequestParams.get("sessionUrl");
		PokerSession pokerSession = planningService.fetchPokerSession(sessionUrl);
		return pokerSession.getHostEmail();
	}
	
	@RequestMapping(value = "/getParticipants", method = RequestMethod.GET)
	@ResponseBody
	public String getParticipants(@RequestParam Map<String,String> allRequestParams) throws Exception {
		System.out.println("get participants Mail is called");
		String sessionUrl = allRequestParams.get("sessionUrl");
		
		System.out.println("sessionUrl..............." + sessionUrl);
		int sessionId = planningService.fetchPokerSession(sessionUrl).getSessionId();
		List<String> particpantList = planningService.fetchParticipantListBySessionId(sessionId);
		System.out.println("people mail list....." + particpantList);
		
		String responseData = "";
		
		for (String email : particpantList) {
			responseData  = responseData + ":" + email;
		}
		
		responseData = responseData.substring(1, responseData.length());
		
		System.out.println("people mail list....." + responseData);
		return responseData;
	}
	
	@RequestMapping(value = "/invitepeople", method = RequestMethod.POST)
	@ResponseBody
	public String invitePeople(@RequestBody String json) throws Exception {
		System.out.println("participants email list..." + json);
		
		String response = null;
		log.debug("inviting people..");
		ObjectMapper mapper = new ObjectMapper();
		InvitePeople invitePeople = null;
		try {
			invitePeople = mapper.readValue(json, InvitePeople.class);
			System.out.println("invitePeople name" + invitePeople.getParticipantEmail());
			System.out.println("invitePeople session url" + invitePeople.getSessionUrl());
			
			String sessionUrl = invitePeople.getSessionUrl();
			String participantEmail = invitePeople.getParticipantEmail();
			int sessionId = planningService.fetchPokerSession(sessionUrl).getSessionId();
			
			planningService.invitePeople(sessionId, participantEmail);  
			
			response = "SUCCESS";
		} catch (Exception e) {
			log.error("Exception created while creating the session");
			log.error(e.getMessage());
			response = "Unable to invite";
		}
		return response;
	}
	
	
	
	private Participant getUser(String email) {
		Participant user = null;
		if(email!=null && !email.trim().isEmpty()) {
			try {
				user = planningService.isValidUser(email.trim());
			} catch (Exception e) {
				user = new Participant();
			}
		}
		return user;
	}
	
	@RequestMapping(value = "/create", method = RequestMethod.POST)
	@ResponseBody
	public String create(@RequestBody String json) throws Exception {
		String response = null;
		log.debug("Creating Session...");
		ObjectMapper mapper = new ObjectMapper();
		PokerSession pokerSession = null;
		try {
			pokerSession = mapper.readValue(json, PokerSession.class);
			planningService.createPlanSession(pokerSession);
			response = toJson(pokerSession);
		} catch (IOException e) {
			log.error("Exception created while creating the session");
			log.error(e.getMessage());
		}
		return response;
	}
	
	@RequestMapping(value = "/sessions/{hostEmail:.+}", method = RequestMethod.GET)
	public void availableSessions(@PathVariable("hostEmail") String hostEmail) throws Exception {
		log.debug("Getting the list of available planning sessions for the host email : "+hostEmail);
		planningService.getAllPlanSessions(hostEmail);
	}
	
	private String toJson(PokerSession session) {
		String value = null;
        ObjectMapper mapper = new ObjectMapper();
        try {
            value = mapper.writeValueAsString(session);
            
        } catch (JsonProcessingException e) {
            log.error(e);
        }
        return value;
    }
	
	@RequestMapping(value = { "/pokerSession" })
	public String navPokerSession() {
		log.debug("Redirecting to pokerSession.jsp page");
		return "pokerSession";
	}
	
	@RequestMapping(value="/hellojson", method = RequestMethod.GET, produces="application/json")
    public @ResponseBody PokerSession jsonGet() {
		log.debug("request = /hellojson, method = get, produces = json");
        return null;
    }
	
	@RequestMapping(value="/hellojson", method = RequestMethod.POST, produces="application/json")
    public @ResponseBody PokerSession jsonPost() {
		log.debug("request = /hellojson, method = post, produces = json");
		PokerSession session = new PokerSession();
        return session;
    }
	
	@RequestMapping(value = "/index/{name:.+}", method = RequestMethod.GET)
	public ModelAndView indexWithPathVariable(@PathVariable("name") String name) {
		log.debug("indexWithPathVariable() is executed - $name {"+name+"}");
 
		ModelAndView model = new ModelAndView();
		model.setViewName("pokerSession");
		model.addObject("title", "title");
		model.addObject("msg", "this is a sample message");
		return model;
	}
}
