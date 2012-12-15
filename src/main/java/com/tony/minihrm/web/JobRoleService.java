package com.tony.minihrm.web;

import java.util.ArrayList;
import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.tony.minihrm.beans.JobRole;
import com.tony.minihrm.beans.dao.JobRoleDao;

@RequestMapping("/jobroles")
@Controller
public class JobRoleService {

	@Autowired
	private JobRoleDao jobRoleDao;

	@RequestMapping(method = RequestMethod.GET)
	public String list(@ModelAttribute("jobrole") JobRole jobRole, Model model) {
		List<JobRole> list = jobRoleDao.findAll();
		List<String> out = new ArrayList<String>();
		for (JobRole j : list) {
			out.add(j.getJobRole());
		}
		model.addAttribute("jobroles", jobRoleDao.findAll());
		model.addAttribute("jobrolestrings", out);
		return "jobroles/list";
	}

	@RequestMapping(method = RequestMethod.POST)
	public String create(@Valid JobRole jobRole, Model model) {
		jobRoleDao.save(jobRole);
		return "redirect:/jobroles";
	}

	@RequestMapping(value = "{id}", method = RequestMethod.DELETE)
	public @ResponseBody
	String delete(@PathVariable Long id, Model model) {
		jobRoleDao.delete(id);
		return "200 ok";
	}

}
