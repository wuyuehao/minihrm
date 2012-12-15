package com.tony.minihrm.web;

import java.util.List;

import javax.validation.Valid;

import org.jasypt.digest.StandardStringDigester;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.tony.minihrm.beans.Manager;
import com.tony.minihrm.beans.dao.ManagerDao;

@RequestMapping("/accounts")
@Controller
public class ManagerController implements UserDetailsService {

	@Autowired
	private ManagerDao managerDao;

	// @InitBinder
	// protected void initBinder(WebDataBinder binder) {
	// binder.setValidator(new ManagerValidator());
	// }

	@Autowired
	StandardStringDigester digester;

	@RequestMapping(method = RequestMethod.GET)
	@Secured("ROLE_ADMIN")
	public String list(@ModelAttribute("manager") Manager manager, Model model) {
		List<Manager> list = managerDao.findAll();
		// clear the password
		for (Manager j : list) {
			j.setPassword("");
		}
		model.addAttribute("accounts", list);
		return "accounts/list";
	}

	@RequestMapping(method = RequestMethod.POST)
	public String create(@Valid Manager manager, BindingResult result,
			Model model) {

		if (result.hasErrors()) {
			return "account/list";
		}
		manager.setPassword(digester.digest(manager.getPassword()));
		try {
			managerDao.save(manager);
		} catch (Exception e) {
			result.rejectValue("username", "username.duplicate");
			return "accounts/list";
		}
		model.addAttribute("msg", "Registeration Completed.Please Login");
		return "redirect:/login";
	}

	// for registration
	@RequestMapping(value = "/register", method = RequestMethod.POST)
	public String create(@Valid Manager manager, Model model,
			BindingResult result) {
		
		manager.setPassword(digester.digest(manager.getPassword()));
		manager.setEnabled(true);
		manager.setAuthority("ROLE_USER");
		try {
			managerDao.save(manager);
		} catch (Exception e) {
			result.rejectValue("username", "username.duplicate");
			return "accounts/register";
		}
		model.addAttribute("RESPONSE_MSG",
				"Registration Completed. Please Login");
		return "redirect:/login";
	}

	// for registration
	@RequestMapping(value = "/register", method = RequestMethod.GET)
	public String create(@ModelAttribute("manager") Manager manager, Model model) {
		return "accounts/register";
	}

	@Secured("ROLE_ADMIN")
	@RequestMapping(value = "{id}", method = RequestMethod.DELETE)
	public @ResponseBody
	String delete(@PathVariable Long id, Model model) {
		managerDao.delete(id);
		return "200 ok";
	}

	@Override
	public UserDetails loadUserByUsername(String username)
			throws UsernameNotFoundException {
		return managerDao.findByUsername(username).get(0);
	}

}
