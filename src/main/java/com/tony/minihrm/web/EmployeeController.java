package com.tony.minihrm.web;

import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.tony.minihrm.beans.Employee;
import com.tony.minihrm.beans.dao.EmployeeDao;
import com.tony.minihrm.services.BandDataService;
import com.tony.minihrm.util.Util;

@Controller
@RequestMapping("/employees")
public class EmployeeController {

	Logger log = LoggerFactory.getLogger(EmployeeController.class);

	@Autowired
	private EmployeeDao employeeDao;
	@Autowired
	private BandDataService bandData;

	@RequestMapping(method = RequestMethod.GET)
	public String list(Employee employee, Model model) {
		return listSorted("NameAsc", employee, model);
	}

	@RequestMapping(value = "/sort/{sortkey}", method = RequestMethod.GET)
	public String listSorted(@PathVariable("sortkey") String sortkey,
			Employee employee, Model model) {
		return listSortedTwoKeys(sortkey, "NameAsc", employee, model);
	}

	@RequestMapping(value = "/sort/{sortkey}/{sortkey2}", method = RequestMethod.GET)
	public String listSortedTwoKeys(@PathVariable("sortkey") String sortkey,
			@PathVariable("sortkey2") String sortkey2, Employee employee,
			Model model) {
		log.debug((new StringBuilder("!!!!!!!!!!!!!!!!!!!!!! sortkey:"))
				.append(sortkey).append("/").append(sortkey2).toString());
		org.springframework.data.domain.Sort.Order order1 = getOrderFromSortkey(
				"sortdir", "sortby", sortkey, model);
		org.springframework.data.domain.Sort.Order order2 = getOrderFromSortkey(
				"sortdir2", "sortby2", sortkey2, model);
		model.addAttribute("bandmid", bandData.getBandData());
		Sort sort = new Sort(new org.springframework.data.domain.Sort.Order[] {
				order1, order2 });
		List returnList;
		if (isSuperUser()) {
			returnList = employeeDao.findAll(sort);
		} else {
			returnList = employeeDao.findByManager(Util.getCurrentUsername(),
					sort);
			List others = employeeDao.findByManagerNot(Util
					.getCurrentUsername());
			Employee e;
			for (Iterator iterator = others.iterator(); iterator.hasNext(); e
					.setSalary(0.0F)) {
				e = (Employee) iterator.next();
				e.setPbc1("*");
				e.setPbc2("*");
				e.setPbc3("*");
			}

			returnList.addAll(others);
		}
		model.addAttribute("employees", returnList);
		return "employees/list";
	}

	private org.springframework.data.domain.Sort.Order getOrderFromSortkey(
			String attrSortdir, String attrSortby, String sortkey, Model model) {
		model.addAttribute(attrSortdir, "Asc");
		if (!sortkey.endsWith("Desc") && !sortkey.endsWith("Asc"))
			sortkey = (new StringBuilder(String.valueOf(sortkey)))
					.append("Asc").toString();
		String orderby = null;
		org.springframework.data.domain.Sort.Direction direction = org.springframework.data.domain.Sort.Direction.ASC;
		if (sortkey.endsWith("Desc")) {
			orderby = sortkey.substring(0, sortkey.length() - 4);
			direction = org.springframework.data.domain.Sort.Direction.DESC;
			model.addAttribute(attrSortdir, "Desc");
		} else if (sortkey.endsWith("Asc"))
			orderby = sortkey.substring(0, sortkey.length() - 3);
		else
			orderby = sortkey;
		model.addAttribute(attrSortby, orderby);
		return new org.springframework.data.domain.Sort.Order(direction,
				orderby);
	}

	private boolean isSuperUser() {
		return Util
				.getCurrentUserDetails()
				.getAuthorities()
				.contains(
						new SimpleGrantedAuthority(
								"ROLE_CDL B2B SHANGHAI UPLINE MGR"));
	}

	public String show(Long id, Model model) {
		Employee e = employeeDao.findById(id);
		if (e.getManager().equals(Util.getCurrentUsername()))
			model.addAttribute("employee", employeeDao.findById(id));
		return "employees/view";
	}

	// need specify contentType : "application/json" in client side.
	@RequestMapping(value = "/json", method = RequestMethod.POST)
	public @ResponseBody String createFromJSON(@RequestBody Employee e) throws JsonParseException,
			JsonMappingException, IOException {
		e.setManager(Util.getCurrentUsername());
		try {
			employeeDao.save(e);
		} catch (Exception e1) {
			return "Already Exist";
		}
		return "OK";
	}

	@RequestMapping(method = RequestMethod.POST)
	public String create(@Valid Employee e, BindingResult result) {
		log.debug((new StringBuilder("!!!!!!!!!!!!!!!!!!!!!! Employees:"))
				.append(e.getName()).toString());
		if (result.hasErrors()) {
			return "employees/create";
		} else {
			e.setManager(Util.getCurrentUsername());
			employeeDao.save(e);
			return "redirect:/employees/";
		}
	}

	@RequestMapping(value = "/{id}", method = RequestMethod.PUT)
	public @ResponseBody String update(@PathVariable("id") Long id, @RequestBody String body) {
		Employee e = employeeDao.findById(id);
		if (!e.getEmail().equals(Util.getCurrentUsername())
				&& !e.getManager().equals(Util.getCurrentUsername())
				&& !isSuperUser())
			return "Not Authorized!";
		String key = body.split(":")[0];
		String value = body.split(":")[1];
		log.debug((new StringBuilder(
				"!!!!!!!!!!!!!!!!!!!!!! Messages from xhr Put:")).append(body)
				.toString());
		Method method = getMethodByName((new StringBuilder("set")).append(key)
				.toString(), Employee.class);
		if (method != null) {
			log.debug((new StringBuilder("get a method: ")).append(
					method.getName()).toString());
			Class type = method.getParameterTypes()[0];
			invoke(e, method, new ValueTypePairs[] { new ValueTypePairs(value,
					type) });
			log.debug((new StringBuilder("set a field to : ")).append(
					e.getName()).toString());
		} else {
			log.debug((new StringBuilder("No set method for key : ")).append(
					key).toString());
		}
		Employee r = (Employee) employeeDao.save(e);
		log.debug((new StringBuilder("???????????????????????????????Saved?:"))
				.append(r.equals(e)).toString());
		return "Updated";
	}

	private Object invoke(Object instance, Method method,
			ValueTypePairs... pairs) {
		List params = new ArrayList();
		if (pairs != null && pairs.length != 0) {
			for (int i = 0; i < pairs.length; i++) {
				Class type = pairs[i].getType();
				if (type.equals(Integer.TYPE))
					params.add(Integer.valueOf(Integer
							.parseInt((String) pairs[i].getValue())));
				else if (type.equals(Long.TYPE))
					params.add(Long.valueOf(Long.parseLong((String) pairs[i]
							.getValue())));
				else if (type.equals(Float.TYPE))
					params.add(Float.valueOf(Float.parseFloat((String) pairs[i]
							.getValue())));
				else if (type.equals(Date.class))
					try {
						params.add((new SimpleDateFormat("yyyy-MM-dd"))
								.parse((String) pairs[i].getValue()));
					} catch (ParseException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				else
					params.add(pairs[i].getValue());
			}

		}
		try {
			return method.invoke(instance, params.toArray());
		} catch (IllegalArgumentException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}

	private Method getMethodByName(String key, Class clazz) {
		Method methods[] = clazz.getDeclaredMethods();
		Method amethod[];
		int j = (amethod = methods).length;
		for (int i = 0; i < j; i++) {
			Method method = amethod[i];
			log.debug((new StringBuilder("!!!!!!!!!!!!!!!!!!!!!!get a method: "))
					.append(method).toString());
			if (method.getName().equalsIgnoreCase(key))
				return method;
		}

		return null;
	}

	@RequestMapping(value="/{id}", method = RequestMethod.DELETE)
	public String delete(@PathVariable("id") Long id, Model model) {
		Employee e = employeeDao.findById(id);
		if (!e.getManager().equals(Util.getCurrentUsername()) && !isSuperUser()) {
			return "Not Authorized!";
		} else {
			employeeDao.delete(id);
			return "Deleted";
		}
	}
}