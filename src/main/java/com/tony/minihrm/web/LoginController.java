package com.tony.minihrm.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

//@Controller
public class LoginController {

	@RequestMapping("/login")
	public String login() {
		return "redirect:/timeline/";
	}

	@RequestMapping("/logout")
	public String logout() {
		return "redirect:/timeline/";
	}

}
