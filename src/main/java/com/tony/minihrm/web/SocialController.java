package com.tony.minihrm.web;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;

import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.tony.minihrm.beans.Relation;
import com.tony.minihrm.beans.SocialUser;
import com.tony.minihrm.beans.dao.RelationDao;
import com.tony.minihrm.services.SocialUserProfileService;
import com.tony.minihrm.util.Util;

@Controller
@RequestMapping("/social")
public class SocialController {
	
	org.slf4j.Logger log = LoggerFactory.getLogger(SocialController.class);

	@Autowired
	RelationDao relationDao;
	
	@Autowired
	SocialUserProfileService profileService;

	@RequestMapping("/init")
	public String init(Model model) {
		profileService.initUserProfile("linsiri@cn.ibm.com");
		profileService.initUserProfile("linyy@cn.ibm.com");
		profileService.initUserProfile("guohanmo@cn.ibm.com");
		profileService.initUserProfile("vfong@cn.ibm.com");
		return getAll(model);
	}

	@RequestMapping(method = RequestMethod.GET)
	public String getAll(Model model) {

		HashSet<String> following = relationDao
				.findByUsername(Util.getCurrentUsername())
				.getFollowing();

		List<SocialUser> list = new ArrayList<SocialUser>();

		
		// find all users in the system to be follow/unfollow
		for (Relation r : relationDao.findAll()) {
			SocialUser su = new SocialUser();
			String name = r.getUsername();
			su.setUsername(r.getUsername());
			if (following.contains(name)) {
				for (String f : following) {
					log.debug(f);
				}
				su.setFollowed(true);
			}
			log.debug("adding user: "+ name);
			list.add(su);
		}
		model.addAttribute("users", list);
		
		return "social/follow";
	}

	@RequestMapping(value = "/follow/{name}", method = RequestMethod.POST)
	public @ResponseBody
	String follow(@PathVariable String name) {
		name +=".com";// odd
		Relation r = relationDao.findByUsername(Util.getCurrentUsername());
		HashSet<String> following = r.getFollowing();
		log.debug("name passed: " + name);
		if (following.contains(name)) {
			following.remove(name);
			r.setFollowing(following);
			relationDao.save(r);
			return "Follow";
		} else {
			following.add(name);
			r.setFollowing(following);
			relationDao.save(r);
			return "Unfollow";
		}
	}

}
