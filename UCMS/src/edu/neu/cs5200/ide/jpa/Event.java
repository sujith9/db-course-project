package edu.neu.cs5200.ide.jpa;

import java.io.Serializable;
import java.lang.String;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQuery;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

@Entity
@NamedQuery(name="readAllEvents", query="SELECT e FROM Event e")
public class Event implements Serializable {

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int id;
	@Temporal(TemporalType.DATE)
	private Date date;
	private String eventName;
	@Column(length = 1500)
	private String description;
	@ManyToOne
	@JoinColumn(name="course_ID")
	private Course course;
	
	private static final long serialVersionUID = 1L;

	public Event() {
		super();
	}   
	public Event(int id, Date date, String eventName, String description, Course course) {
		super();
		this.id = id;
		this.date = date;
		this.eventName = eventName;
		this.description = description;
		this.course = course;
	}
	public int getId() {
		return this.id;
	}

	public void setId(int id) {
		this.id = id;
	}   
	public Date getDate() {
		return this.date;
	}

	public void setDate(Date date) {
		this.date = date;
	}   
	public String getEventName() {
		return this.eventName;
	}

	public void setEventName(String eventName) {
		this.eventName = eventName;
	}   
	public String getDescription() {
		return this.description;
	}

	public void setDescription(String description) {
		this.description = description;
	}
	public Course getCourse() {
		return course;
	}
	public void setCourse(Course course) {
		this.course = course;
	}
   
}
