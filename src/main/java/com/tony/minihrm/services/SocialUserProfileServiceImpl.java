package com.tony.minihrm.services;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map.Entry;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.DefaultHttpClient;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tony.minihrm.beans.Employee;
import com.tony.minihrm.beans.Relation;
import com.tony.minihrm.beans.dao.EmployeeDao;
import com.tony.minihrm.beans.dao.RelationDao;

@Service
public class SocialUserProfileServiceImpl implements SocialUserProfileService {

	org.slf4j.Logger log = LoggerFactory
			.getLogger(SocialUserProfileServiceImpl.class);

	@Autowired
	EmployeeDao employeeDao;

	@Autowired
	RelationDao relationDao;

	public void initUserProfile(String user) {

		if (employeeDao.findByEmail(user) == null) {
			Employee e = null;
			HashMap<String, String> bluepageProfile = null;
			try {
				bluepageProfile = getBluepageProfile("http://bluepages.ibm.com/BpHttpApisv3/wsapi?byInternetAddr="
						+ user);
			} catch (IllegalStateException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			} catch (IOException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}

			for (Entry<String, String> entry : bluepageProfile.entrySet()) {
				log.debug("??????????????????????????" + entry.getKey() + ":"
						+ entry.getValue());
			}

			// bluepageProfile.get("");
			// set name, notesid, sn, manager
			e = new Employee();
			e.setEmail(user);
			e.setName(bluepageProfile.get("NAME"));
			e.setMp(bluepageProfile.get("CELLULAR"));
			e.setNotesid(bluepageProfile.get("NOTESID").replaceAll("CN=", "")
					.replaceAll("OU=", "").replaceAll("O=", "")
					.replaceAll("@IBM.*", ""));
			e.setSn(bluepageProfile.get("EMPNUM"));
			String mgrsn = bluepageProfile.get("MGRNUM");
			try {
				e.setManager(getBluepageProfile(
						"http://bluepages.ibm.com/BpHttpApisv3/wsapi?bySerial="
								+ mgrsn).get("INTERNET"));
			} catch (IllegalStateException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			} catch (IOException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			employeeDao.save(e);
		}
		if (relationDao.findByUsername(user) == null) {
			// init relation db
			Relation r = new Relation();
			r.setUsername(user);
			HashSet<String> following = new HashSet<String>();
			HashSet<String> fans = new HashSet<String>();
			if (!user.equals("wuyuehao@cn.ibm.com")) {
				following.add("wuyuehao@cn.ibm.com");
				fans.add("wuyuehao@cn.ibm.com");
			}
			r.setFollowing(following);
			r.setFans(fans);
			relationDao.save(r);
		}
	}

	private HashMap<String, String> getBluepageProfile(String url)
			throws IllegalStateException, IOException {

		HashMap<String, String> map = new HashMap<String, String>();

		HttpClient httpclient = new DefaultHttpClient();

		// Prepare a request object
		HttpGet httpget = new HttpGet(url);

		// Execute the request
		HttpResponse response = httpclient.execute(httpget);

		// Examine the response status
		System.out.println(response.getStatusLine());

		// Get hold of the response entity
		HttpEntity entity = response.getEntity();

		// If the response does not enclose an entity, there is no need
		// to worry about connection release
		if (entity != null) {
			InputStream instream = entity.getContent();
			try {
				BufferedReader reader = new BufferedReader(
						new InputStreamReader(instream));
				// do something useful with the response
				String line;
				while ((line = reader.readLine()) != null) {
					int index = line.indexOf(':');
					map.put(line.substring(0, index), line.substring(index + 1)
							.trim());
				}
			} catch (IllegalStateException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			} catch (IOException ex) {

				// In case of an IOException the connection will be released
				// back to the connection manager automatically

			} catch (RuntimeException ex) {

				// In case of an unexpected exception you may want to abort
				// the HTTP request in order to shut down the underlying
				// connection and release it back to the connection manager.
				httpget.abort();

			} finally {

				// Closing the input stream will trigger connection release
				try {
					instream.close();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}

			}

			// When HttpClient instance is no longer needed,
			// shut down the connection manager to ensure
			// immediate deallocation of all system resources
			httpclient.getConnectionManager().shutdown();
		}
		return map;
	}

}
