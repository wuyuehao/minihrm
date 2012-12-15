package com.tony.minihrm.web;

import java.util.List;

import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.tony.minihrm.beans.Employee;
import com.tony.minihrm.beans.dao.EmployeeDao;
import com.tony.minihrm.services.SocialUserProfileService;
import com.tony.minihrm.util.Util;

@Controller
@RequestMapping("/profile")
public class ProfileController {

	org.slf4j.Logger log = LoggerFactory.getLogger(EmployeeController.class);

	@Autowired
	EmployeeDao employeeDao;

	@Autowired
	SocialUserProfileService profileService;

	@RequestMapping(method = RequestMethod.GET)
	public String getProfile(@ModelAttribute("employee") Employee employee,
			Model model) {
		String user = Util.getCurrentUsername();
		List<Employee> list = employeeDao.findByEmail(user);
		if (list.isEmpty()) {
			profileService.initUserProfile(user);
		}
		model.addAttribute("employee", employeeDao.findByEmail(user).get(0));
		return "employees/profile";
	}

}
