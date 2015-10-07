package edu.neu.cs5200.ide.jpa;

import java.io.Serializable;
import java.lang.String;
import java.util.Date;
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
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

@Entity
@NamedQuery(name="readAllAssignments", query="SELECT a FROM Assignment a")
public class Assignment implements Serializable {

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int id;
	private String title;
	@Temporal(TemporalType.DATE)
	private Date dueDate;
	@Column(length = 10000)
	private String content;
	@ManyToOne
	@JoinColumn(name="course_ID")
	private Course course;
	@OneToMany(mappedBy="assignment", cascade=CascadeType.ALL, orphanRemoval=true)
	private List<Submission> submissions;
	
	
	private static final long serialVersionUID = 1L;

	public Assignment() {
		super();
	}   
	public Assignment(int id, String title, Date dueDate, String content, Course course) {
		super();
		this.id = id;
		this.title = title;
		this.dueDate = dueDate;
		this.content = content;
		this.course = course;
	}
	public int getId() {
		return this.id;
	}

	public void setId(int id) {
		this.id = id;
	}   
	public String getTitle() {
		return this.title;
	}

	public void setTitle(String title) {
		this.title = title;
	}   
	public Date getDueDate() {
		return this.dueDate;
	}

	public void setDueDate(Date dueDate) {
		this.dueDate = dueDate;
	}   
	public String getContent() {
		return this.content;
	}

	public void setContent(String content) {
		this.content = content;
	}
	public Course getCourse() {
		return course;
	}
	public void setCourse(Course course) {
		this.course = course;
	}
   
}
