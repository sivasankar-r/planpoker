package com.boeing.planpoker.controller;

import org.springframework.context.annotation.Configuration;
import org.springframework.messaging.simp.config.MessageBrokerRegistry;
import org.springframework.web.socket.config.annotation.AbstractWebSocketMessageBrokerConfigurer;
import org.springframework.web.socket.config.annotation.EnableWebSocketMessageBroker;
import org.springframework.web.socket.config.annotation.StompEndpointRegistry;

@Configuration
@EnableWebSocketMessageBroker
public class WebSocketConfig extends AbstractWebSocketMessageBrokerConfigurer {

	@Override
	public void configureMessageBroker(MessageBrokerRegistry config) {
		System.out.println("message broker");
		config.enableSimpleBroker("/pokerSession");
		config.setApplicationDestinationPrefixes("/app");
	}

	@Override
	public void registerStompEndpoints(StompEndpointRegistry registry) {
		System.out.println("register stamp ponts");
		registry.addEndpoint("/broadCast").withSockJS();
		registry.addEndpoint("/castVote").withSockJS();
		registry.addEndpoint("/joinSession").withSockJS();
		registry.addEndpoint("/revealVotes").withSockJS();
		registry.addEndpoint("/editSp").withSockJS();
		registry.addEndpoint("/addStories").withSockJS();
	}

}