package com.aracomm.base.security.session;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.security.core.session.SessionInformation;
import org.springframework.security.core.session.SessionRegistry;
import org.springframework.security.core.userdetails.User;

public class SessionInformationSupport {
	private final SessionRegistry sessionRegistry;
	
	public SessionInformationSupport(SessionRegistry sessionRegistry) {
		this.sessionRegistry = sessionRegistry;
	}
	
	public List<Information> getSessionInformations() {

		List<SessionInformation> sessionInformations = new ArrayList<SessionInformation>();
		for(Object principal : sessionRegistry.getAllPrincipals()) {
			sessionInformations.addAll(sessionRegistry.getAllSessions(principal, false));
		}

		List<Information> informations = new ArrayList<Information>();
		for(SessionInformation sessionInformation : sessionInformations) {


			Date lastRequest = sessionInformation.getLastRequest();
			String sessionId = sessionInformation.getSessionId();

			String username = null;

			Object principal = sessionInformation.getPrincipal();
			if (principal instanceof User) {
				User user = (User) principal;
				username = user.getUsername();
			}

			Information information = new Information(username, sessionId, lastRequest, principal);

			informations.add(information);
		}

		return informations;
	}
	public boolean userExists(String username) {
		for(Information information : getSessionInformations()) {
			String _username = information.getUsername();
			if (username.equals(_username)) {
				return true;
			}
		}

		return false;
	}
}
