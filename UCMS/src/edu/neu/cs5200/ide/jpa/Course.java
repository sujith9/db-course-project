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
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;

@Entity
@NamedQuery(name="readAllCourses", query="SELECT c FROM Course c")
public class Course implements Serializable {

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int id;
	private String courseName;
	private String coursePic;
	@Column(length = 1500)
	private String details;
	@OneToMany(mappedBy="course", cascade=CascadeType.ALL, orphanRemoval=true)
	private List<Enroll> enrolls;
	@ManyToOne
	@JoinColumn(name="major_ID")
	private Major major;
	@OneToMany(mappedBy="course", cascade=CascadeType.ALL, orphanRemoval=true)
	private List<Event> events;
	@OneToMany(mappedBy="course", cascade=CascadeType.ALL, orphanRemoval=true)
	private List<Review> reviews;
	@OneToMany(mappedBy="course", cascade=CascadeType.ALL, orphanRemoval=true)
	private List<Assignment> assignments;
	
	private static final long serialVersionUID = 1L;

	public Course() {
		super();
	}   
	public Course(int id, String courseName, String coursePic, String details, Major major, List<Event> events, List<Review> reviews, List<Assignment> assignments) {
		super();
		this.id = id;
		this.courseName = courseName;
		this.coursePic = coursePic;
		this.details = details;
		this.major = major;
		this.events = events;
		this.reviews = reviews;
		this.assignments = assignments;
	}
	public int getId() {
		return this.id;
	}

	public void setId(int id) {
		this.id = id;
	}   
	public String getCourseName() {
		return this.courseName;
	}

	public void setCourseName(String courseName) {
		this.courseName = courseName;
	}   
	public String getCoursePic() {
		return this.coursePic;
	}

	public void setCoursePic(String coursePic) {
		this.coursePic = coursePic;
	}   
	public String getDetails() {
		return this.details;
	}

	public void setDetails(String details) {
		this.details = details;
	}
   
}
