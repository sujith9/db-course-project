package edu.neu.cs5200.ide.jpa;

import java.io.Serializable;
import java.lang.String;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;

@Entity
@NamedQuery(name="readAllPersons", query="SELECT p FROM Person p")
public class Person implements Serializable {
	   
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int id;
	private String firstName;
	private String lastName;
	@Column(unique=true)
	private String username;
	private String password;
	private String email;
	private String profilePic;
	@Column(length = 2000)
	private String details;
	@OneToMany(mappedBy="person", cascade=CascadeType.ALL, orphanRemoval=true)
	private List<Enroll> enrolls;
	@OneToMany(mappedBy="person", cascade=CascadeType.ALL, orphanRemoval=true)
	private List<Submission> submissions;
	
	private static final long serialVersionUID = 1L;

	public Person() {
		super();
	}   
	public Person(int id, String firstName, String lastName, String username,
			String password, String email, String profilePic, String details, List<Enroll> enrolls, List<Submission> submissions) {
		super();
		this.id = id;
		this.firstName = firstName;
		this.lastName = lastName;
		this.username = username;
		this.password = password;
		this.email = email;
		this.profilePic = profilePic;
		this.details = details;
		this.enrolls = enrolls;
		this.submissions = submissions;
	}
	public int getId() {
		return this.id;
	}

	public void setId(int id) {
		this.id = id;
	}   
	public String getFirstName() {
		return this.firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}   
	public String getLastName() {
		return this.lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}   
	public String getUsername() {
		return this.username;
	}

	public void setUsername(String username) {
		this.username = username;
	}   
	public String getPassword() {
		return this.password;
	}

	public void setPassword(String password) {
		this.password = password;
	}   
	public String getEmail() {
		return this.email;
	}

	public void setEmail(String email) {
		this.email = email;
	}   
	public String getProfilePic() {
		return this.profilePic;
	}

	public void setProfilePic(String profilePic) {
		this.profilePic = profilePic;
	}   
	public String getDetails() {
		return this.details;
	}

	public void setDetails(String details) {
		this.details = details;
	}
	public List<Enroll> getEnrolls() {
		return enrolls;
	}
	public void setEnrolls(List<Enroll> enrolls) {
		this.enrolls = enrolls;
	}
	public List<Submission> getSubmissions() {
		return submissions;
	}
	public void setSubmissions(List<Submission> submissions) {
		this.submissions = submissions;
	}
   
}
