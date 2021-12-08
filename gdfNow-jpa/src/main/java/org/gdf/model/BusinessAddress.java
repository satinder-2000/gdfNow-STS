package org.gdf.model;

import javax.persistence.CascadeType;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;

public class BusinessAddress {
	
	
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "BUSINESS_ID")
	private Business business;
	
	@OneToOne(targetEntity = Country.class, cascade = CascadeType.DETACH)
	private Country country;


}
