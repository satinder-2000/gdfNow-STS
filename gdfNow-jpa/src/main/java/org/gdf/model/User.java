package org.gdf.model;

import java.time.LocalDate;
import java.time.LocalDateTime;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.springframework.web.multipart.MultipartFile;

@Entity
@Table(name="USER")
public class User {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="ID")
	private int id;
	
	@Column(name="FIRST_NAME")
	private String firstName;
	
	@Column(name="LAST_NAME")
	private String lastName;
	
	@Column(name="EMAIL")
	private String email;
	
	@Column(name="DOB")
	private LocalDate dob;
	
	@Column(name = "PROFILE_FILE")
    private String profileFile;
    
    @Column(name = "IMAGE")
    private byte[] image;
    
    @Column(name = "CREATED_ON")
    private LocalDateTime createdOn;
    
    @Column(name = "UPDATED_ON")
    private LocalDateTime updatedOn;
	
	@OneToOne(targetEntity = UserAddress.class, cascade = CascadeType.ALL)
	private UserAddress userAddress;
	
	@Transient
	private MultipartFile uploadedFile;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public LocalDate getDob() {
		return dob;
	}

	public void setDob(LocalDate dob) {
		this.dob = dob;
	}
	
	

	public String getProfileFile() {
		return profileFile;
	}

	public void setProfileFile(String profileFile) {
		this.profileFile = profileFile;
	}

	public byte[] getImage() {
		return image;
	}

	public void setImage(byte[] image) {
		this.image = image;
	}

	public LocalDateTime getCreatedOn() {
		return createdOn;
	}

	public void setCreatedOn(LocalDateTime createdOn) {
		this.createdOn = createdOn;
	}

	public LocalDateTime getUpdatedOn() {
		return updatedOn;
	}

	public void setUpdatedOn(LocalDateTime updatedOn) {
		this.updatedOn = updatedOn;
	}

	public UserAddress getUserAddress() {
		return userAddress;
	}

	public void setUserAddress(UserAddress userAddress) {
		this.userAddress = userAddress;
	}

	public MultipartFile getUploadedFile() {
		return uploadedFile;
	}

	public void setUploadedFile(MultipartFile uploadedFile) {
		this.uploadedFile = uploadedFile;
	}
	
	
	

}
