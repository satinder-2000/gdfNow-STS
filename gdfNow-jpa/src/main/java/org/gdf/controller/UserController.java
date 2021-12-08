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
import javax.servlet.http.HttpSession;

import org.gdf.form.UserAddressForm;
import org.gdf.form.UserForm;
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
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.view.RedirectView;

@Controller
//@RequestMapping(path="/user")
public class UserController {
	
	private static Logger logger=LoggerFactory.getLogger(UserController.class);
	
	@Autowired
	private UserRepository userRepository;
	
	@Autowired
	private CountryRepository countryRepository;
	
	
	@GetMapping("/register")
	String initNewUser(UserForm userForm) {
		return "/userregister/user";
	}
	
	
	//@PostMapping("/register")
	@RequestMapping(value = "/register", method = RequestMethod.POST)
	public RedirectView addNewUser(HttpServletRequest request, UserForm userForm,BindingResult bindingResult) throws IOException {
		if (bindingResult.hasErrors()) {
			//return "/userregister/user";
			new RedirectView("/userregister/user");
		}else {
			User user=new User();
			user.setFirstName(userForm.getFirstName());
			user.setLastName(userForm.getLastName());
			user.setEmail(userForm.getEmail());
			String dobStr=userForm.getDobStr();
			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-d");
			LocalDate dob= LocalDate.parse(dobStr, formatter);
			user.setDob(dob);
			user.setCreatedOn(LocalDateTime.now());
	        user.setUpdatedOn(LocalDateTime.now());
	        
	        
	        try {
	        
				InputStream profileFileIS=userForm.getProfileImage().getInputStream();//request.getPart("profileImage").getInputStream();
				byte[] profileImageBytes=new byte[profileFileIS.available()];
				user.setImage(profileImageBytes);
				user.setProfileFile(request.getPart("profileImage").getSubmittedFileName());
				HttpSession session=request.getSession(true);
				session.setAttribute("user.register.user", user);
			} catch (IOException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			} catch (ServletException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
		}
		
		return new RedirectView("/useraddress/registerAddress");
	}
	
	
	
}
