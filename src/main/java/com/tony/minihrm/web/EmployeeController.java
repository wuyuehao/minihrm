package com.tony.minihrm.web;

import java.io.UnsupportedEncodingException;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.joda.time.format.DateTimeFormat;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.util.UriUtils;
import org.springframework.web.util.WebUtils;

import com.tony.minihrm.beans.Employee;
import com.tony.minihrm.beans.dao.EmployeeDAO;
import com.tony.minihrm.beans.dao.ManagerDAO;
import com.tony.minihrm.enums.Gender;
import com.tony.minihrm.enums.JobRole;
import com.tony.minihrm.enums.PBC;
import com.tony.minihrm.enums.Team;

@RequestMapping("/employees")
@Controller
public class EmployeeController {

	@Autowired
	private EmployeeDAO employeeDao;
	
	@Autowired
	private ManagerDAO managerDao; 

	@RequestMapping(method = RequestMethod.POST, produces = "text/html")
	public String create(@Valid Employee employee, BindingResult bindingResult,
			Model uiModel, HttpServletRequest httpServletRequest) {
		if (bindingResult.hasErrors()) {
			populateEditForm(uiModel, employee);
			return "employees/create";
		}
		uiModel.asMap().clear();
		employeeDao.save(employee);
		return "redirect:/employees/"
				+ encodeUrlPathSegment(employee.getId().toString(),
						httpServletRequest);
	}

	@RequestMapping(value = "/{id}", produces = "text/html")
	public String show(@PathVariable("id") Long id, Model uiModel) {
		addDateTimeFormatPatterns(uiModel);
		uiModel.addAttribute("employee", employeeDao.findById(id));
		uiModel.addAttribute("itemId", id);
		return "employees/show";
	}

	@RequestMapping(produces = "text/html")
	public String list(
			@RequestParam(value = "page", required = false) Integer page,
			@RequestParam(value = "size", required = false) Integer size,
			Model uiModel) {
		uiModel.addAttribute("employees", employeeDao.findAll());
		addDateTimeFormatPatterns(uiModel);
		return "employees/list";
	}

	@RequestMapping(method = RequestMethod.PUT, produces = "text/html")
	public String update(@Valid Employee employee, BindingResult bindingResult,
			Model uiModel, HttpServletRequest httpServletRequest) {
		if (bindingResult.hasErrors()) {
			populateEditForm(uiModel, employee);
			return "employees/update";
		}
		uiModel.asMap().clear();
		employeeDao.save(employee);
		return "redirect:/employees/"
				+ encodeUrlPathSegment(employee.getId().toString(),
						httpServletRequest);
	}

	@RequestMapping(value = "/{id}", params = "form", produces = "text/html")
	public String updateForm(@PathVariable("id") Long id, Model uiModel) {
		populateEditForm(uiModel, employeeDao.findById(id));
		return "employees/update";
	}

	@RequestMapping(value = "/{id}", method = RequestMethod.DELETE, produces = "text/html")
	public String delete(@PathVariable("id") Long id,
			@RequestParam(value = "page", required = false) Integer page,
			@RequestParam(value = "size", required = false) Integer size,
			Model uiModel) {
		Employee employee = employeeDao.findById(id);
		employeeDao.delete(employee);
		uiModel.asMap().clear();
		return "redirect:/employees";
	}

	void addDateTimeFormatPatterns(Model uiModel) {
		uiModel.addAttribute(
				"employee_onboarddate_date_format",
				DateTimeFormat.patternForStyle("M-",
						LocaleContextHolder.getLocale()));
		uiModel.addAttribute(
				"employee_onbanddate_date_format",
				DateTimeFormat.patternForStyle("M-",
						LocaleContextHolder.getLocale()));
		uiModel.addAttribute(
				"employee_onteamdate_date_format",
				DateTimeFormat.patternForStyle("M-",
						LocaleContextHolder.getLocale()));
	}

	void populateEditForm(Model uiModel, Employee employee) {
		uiModel.addAttribute("employee", employee);
		addDateTimeFormatPatterns(uiModel);
		uiModel.addAttribute("genders", Gender.values());
		uiModel.addAttribute("jobroles", JobRole.values());
		uiModel.addAttribute("managers", managerDao.findAll());
		uiModel.addAttribute("pbcs", PBC.values());
		uiModel.addAttribute("teams", Team.values());
	}

	String encodeUrlPathSegment(String pathSegment,
			HttpServletRequest httpServletRequest) {
		String enc = httpServletRequest.getCharacterEncoding();
		if (enc == null) {
			enc = WebUtils.DEFAULT_CHARACTER_ENCODING;
		}
		try {
			pathSegment = UriUtils.encodePathSegment(pathSegment, enc);
		} catch (UnsupportedEncodingException uee) {
		}
		return pathSegment;
	}
}
