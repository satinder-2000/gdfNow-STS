package org.gdf.controller;

import java.io.IOException;
import java.io.InputStream;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;

import org.gdf.model.Country;
import org.gdf.model.User;
import org.gdf.model.UserAddress;
import org.gdf.repository.CountryRepository;
import org.gdf.repository.UserRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

@Controller
@RequestMapping(path="/user")
public class UserController {
	
	private static Logger logger=LoggerFactory.getLogger(UserController.class);
	
	@Autowired
	private UserRepository userRepository;
	
	@Autowired
	private CountryRepository countryRepository;
	
	
	@GetMapping("/init")
	String initNewUser() {
		return "userRegister";
	}
	
	
	@PostMapping("/register")
	String addNewUser(HttpServletRequest request, Model model) throws IOException {
		Map<String, String> map = new HashMap<>();
		String firstName=request.getParameter("firstName");
		String lastName=request.getParameter("lastName");
		String email=request.getParameter("email");
		String dobStr=request.getParameter("dob");
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-d");
		LocalDate dob= LocalDate.parse(dobStr, formatter);
		User user=new User();
		user.setFirstName(firstName);
		user.setLastName(lastName);
		user.setEmail(email);
		user.setDob(dob);
		user.setCreatedOn(LocalDateTime.now());
        user.setUpdatedOn(LocalDateTime.now());
        
        try {
			InputStream profileFileIS=request.getPart("profileImage").getInputStream();
			byte[] profileImageBytes=new byte[profileFileIS.available()];
			user.setImage(profileImageBytes);
			user.setProfileFile(request.getPart("profileImage").getSubmittedFileName());
			
			//profileFileIS.
			
		} catch (IOException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} catch (ServletException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
        
        if (user.getUploadedFile()==null) {
        	logger.warn("Implement the Logic is the User doe not upload profile pic");
        	map.put("noProfileFile", "Profile picture is required");
        }else {
        	MultipartFile profileImage=user.getUploadedFile();
        	try {
				user.setImage(profileImage.getBytes());
				user.setProfileFile(profileImage.getOriginalFilename());
			} catch (IOException e) {
				logger.error(e.getMessage());
				map.put("errorProfileImg", "Error while processing Profile picture: "+e.getMessage());
			}
        }
        //User Address now
        UserAddress address=new UserAddress();
        address.setAddressLine(request.getParameter("addressLine"));
        address.setPostCode(request.getParameter("postCode"));
        address.setCity(request.getParameter("city"));
        address.setState(request.getParameter("state"));
        String countryCode=request.getParameter("countryCode");
        Iterable<Country> countries=countryRepository.findAll();
        for (Country c: countries) {
        	if (c.getCode().equals(countryCode)) {
        		address.setCountry(c);
        		logger.info("Country set to: "+countryCode);
        	}
        }
        
        user.setUserAddress(address);
        user=userRepository.save(user);
		return "success";
	}
	
	

}
