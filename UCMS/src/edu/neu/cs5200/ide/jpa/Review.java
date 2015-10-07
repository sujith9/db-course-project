package edu.neu.cs5200.ide.jpa;

import java.io.Serializable;
import java.lang.String;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQuery;

@Entity
@NamedQuery(name="readAllReviews", query="SELECT r FROM Review r")
public class Review implements Serializable {
	   
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int id;
	private String title;
	@Column(length = 1337)
	private String comment;
	private int rating;
	@ManyToOne
	@JoinColumn(name="course_ID")
	private Course course;
	
	private static final long serialVersionUID = 1L;

	public Review() {
		super();
	}   
	public Review(int id, String title, String comment, int rating, Course course) {
		super();
		this.id = id;
		this.title = title;
		this.comment = comment;
		this.rating = rating;
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
	public String getComment() {
		return this.comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}   
	public int getRating() {
		return this.rating;
	}

	public void setRating(int rating) {
		this.rating = rating;
	}
	public Course getCourse() {
		return course;
	}
	public void setCourse(Course course) {
		this.course = course;
	}
   
}
