package com.tony.minihrm.util;

import java.util.Collection;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;

public class Util {
	public static boolean isAuthenticated() {
		return getCurrentUserDetails() != null;
	}

	public static UserDetails getCurrentUserDetails() {
		Authentication auth = SecurityContextHolder.getContext()
				.getAuthentication();
		Object principal = auth.getPrincipal(); // get logged in username
		if (principal instanceof UserDetails) {
			return (UserDetails) principal;
		} else {
			return null;
		}
	}

	public static String getCurrentUsername() {
		return getCurrentUserDetails() == null ? "Anonymous"
				: getCurrentUserDetails().getUsername();
	}

	public static Collection<?> getAuthorities() {
		return getCurrentUserDetails() == null ? null : getCurrentUserDetails()
				.getAuthorities();
	}
}
