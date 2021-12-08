package org.gdf.controller;

import java.io.IOException;

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
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
//@RequestMapping(path="/useraddress")
public class UserAddressController {
private static Logger logger=LoggerFactory.getLogger(UserAddressController.class);
	
	@Autowired
	private UserRepository userRepository;
	
	@Autowired
	private CountryRepository countryRepository;
	
	@GetMapping("/registerAddress")
	String initNewUser(UserAddressForm userAddressForm) {
		return "/userregister/userAddress";
	}
	
	@PostMapping("/registerAddress")
	String addUserAddress(HttpServletRequest request, UserAddressForm addressForm,BindingResult bindingResult) throws IOException {
		if (bindingResult.hasErrors()) {
			return "/userregister/userAddress";
		}else {
			//User Address now
	        UserAddress address=new UserAddress();
	        address.setAddressLine(addressForm.getAddressLine());
	        address.setPostCode(addressForm.getPostCode());
	        address.setCity(addressForm.getCity());
	        address.setState(addressForm.getState());
	        String countryCode=addressForm.getCountryCode();
	        Country country=countryRepository.findByCode(countryCode);
	        address.setCountry(country);
	        HttpSession session=request.getSession();
	        User user=(User)session.getAttribute("user.register.user");
	        user.setUserAddress(address);
	        user=userRepository.save(user);
	        logger.info("User created with ID: "+user.getId());
	        session.setAttribute("user.register.user",user);
			return "/userregister/confirm";
			
		}
	}

}
