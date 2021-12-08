package org.gdf.model;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name = "BUSINESS")
public class Business implements Serializable {
	
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "ID")
	private int id;
	
	@Column(name = "NAME")
	private String name;
	
	@Column(name = "EMAIL")
	private String email;
	
	@Column(name = "DESCRIPTION")
	private String description;
	
	@Column(name = "WEBSITE")
	private String website;
	
	@Column(name = "PROFILE_FILE")
	private String profileFile;
	
	@Column(name = "IMAGE")
	private byte[] image;
	
	@Column(name = "CONFIRMED")
	private boolean confirmed;
	
	@Column(name = "CREATED_ON")
	private LocalDateTime createdOn;
	
	@Column(name = "UDATED_ON")
	private LocalDateTime updatedOn;
	
	
	@OneToMany(mappedBy = "business")
	private List<BusinessAddress> addresses;

}
