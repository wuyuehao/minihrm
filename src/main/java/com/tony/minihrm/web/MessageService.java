package com.tony.minihrm.web;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.tony.minihrm.beans.Message;
import com.tony.minihrm.beans.Relation;
import com.tony.minihrm.beans.SocialUser;
import com.tony.minihrm.beans.dao.EmployeeDao;
import com.tony.minihrm.beans.dao.MessageDao;
import com.tony.minihrm.beans.dao.RelationDao;
import com.tony.minihrm.services.SocialUserProfileService;
import com.tony.minihrm.util.Util;

@Controller
@RequestMapping("/timeline")
public class MessageService {

	org.slf4j.Logger log = LoggerFactory.getLogger(MessageService.class);

	@Autowired
	private MessageDao messageDao;

	@Autowired
	private EmployeeDao employeeDao;

	@Autowired
	private RelationDao relationDao;

	@RequestMapping(method = RequestMethod.POST)
	public String addNew(@RequestParam("msg") String msg, HttpServletRequest request, Model model) {
		log.debug("Get Message: " + msg);
		String user = Util.getCurrentUsername();
		log.debug("Get user: " + user);
		log.debug("Get user: " + relationDao.findByUsername(user));
		HashSet<String> fans = relationDao.findByUsername(user).getFans();
		log.debug("Get Fans: " + fans.size());
		for (String receiver : fans) {
			Message newMsg = new Message();
			newMsg.setMsg(msg);
			newMsg.setReceiver(receiver);
			newMsg.setSender(user);
			if (msg.contains("@" + receiver)) {
				newMsg.setAt(true);
			}
			messageDao.save(newMsg);
			log.debug("Message Added: " + user + " to " + receiver + " : "
					+ msg + " @? = " + newMsg.isAt());
		}
		// write for myself
		Message newMsg = new Message();
		newMsg.setMsg(msg);
		newMsg.setReceiver(user);
		newMsg.setSender(user);
		messageDao.save(newMsg);

		return get(request, model);
	}

	@Autowired
	SocialUserProfileService profileService;

	@RequestMapping(method = RequestMethod.GET)
	public String get(HttpServletRequest request, Model model) {
		if (Util.isAuthenticated()) {

			// init when login;
			String user = Util.getCurrentUsername();
			if (employeeDao.findByEmail(user) == null
					|| relationDao.findByUsername(user) == null) {
				profileService.initUserProfile(user);
			}

			// find all msg whose receiver is me
			List<Message> allMsg = messageDao.findByReceiverOrderByIdDesc(user);
			log.debug("find messages: " + allMsg.size());
			model.addAttribute("messages", allMsg);

			Relation relation = relationDao.findByUsername(Util
					.getCurrentUsername());

			List<SocialUser> list = new ArrayList<SocialUser>();

			if (relation != null) {

				HashSet<String> following = relationDao.findByUsername(
						Util.getCurrentUsername()).getFollowing();

				List<Relation> all = relationDao.findAll();

				// list all users to be follow/unfollow
				if (all != null) {
					for (Relation r : relationDao.findAll()) {
						String name = r.getUsername();
						// skip for myself
						if(name.equals(user)){
							continue;
						}
						SocialUser su = new SocialUser();
						su.setUsername(r.getUsername());
						if (following.contains(name)) {
							for (String f : following) {
								log.debug(f);
							}
							su.setFollowed(true);
						}
						log.debug("adding user: " + name);
						list.add(su);
					}
				}
			}
			model.addAttribute("users", list);
		}
		
		// write ip for node server
		
		model.addAttribute("node_server", request.getServerName());
		return "/welcome";
	}
}
