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
		System.out.println("Start session is called");
		ModelAndView model = new ModelAndView();
		String sessionUrl = allRequestParams.get("sessionUrl");
		String email = allRequestParams.get("email");
		
		
		if(sessionUrl == null || sessionUrl.trim().isEmpty()) {
			System.out.println("has no session url");
			//has no session url
			model.setViewName("login");
			return model;
		} 
		
		if(email == null || email.trim().isEmpty()) {
			//has session url but no email
			model.setViewName("joinSession");
			model.addObject("sessionUrl", sessionUrl);
			return model;
		}
		
		Participant user = getUser(email);
		if(user.getEmail() == null || user.getEmail().isEmpty()) {
			//has session url and email, but email is invalid
			model.setViewName("joinSession");
			model.addObject("sessionUrl", sessionUrl);
			return model;
		}
		
		PokerSession pokerSession = planningService.fetchPokerSession(sessionUrl);
		
		if(pokerSession == null) {
			//has session url, but invalid session url
			model.setViewName("login");
			return model;
		}
		
		boolean isAuthorized = planningService.isAuthorizedUser(pokerSession.getSessionId(), user.getEmail());
		if(!isAuthorized) {
			System.out.println("is authorized user");
			model.setViewName("login");
			return model;
		}
		
		
		List<Story> storiesList = planningService.fetchStories(pokerSession.getSessionId());
		List<Participant> participantList = planningService.fetchParticipantsJoined(pokerSession.getSessionId());
		
		if (participantList.size() > 0) {
			boolean isParticipantExist = false;
			for(int i = 0; i < participantList.size(); i++) {
				if (participantList.get(i).getName().equals(user.getName())) {
					
					isParticipantExist = true;
					break;
				}
				
			}
			
			if (!isParticipantExist) {
                try {	
				    planningService.updateSessionParticipant(pokerSession.getSessionId(), user.getEmail(), 1);
				    participantList.add(user);
			    } catch (Exception ex) {
				    log.error("Exception while update the participants status");
				    log.error(ex.getMessage());
				    ex.printStackTrace();
        		}
			}
		}
		
		model.setViewName("pokerSession");
		model.addObject("stories", storiesList);
		model.addObject("participants", participantList);
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
	
	
	private void joinSession() {
		
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
