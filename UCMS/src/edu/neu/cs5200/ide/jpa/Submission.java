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
@NamedQuery(name="readAllSubmissions", query="SELECT s FROM Submission s")
public class Submission implements Serializable {

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int id;
	@Temporal(TemporalType.DATE)
	private Date subDate;
	@Column(length = 10000)
	private String content;
	private int grade;
	@ManyToOne
	@JoinColumn(name="assignment_ID")
	private Assignment assignment;
	@ManyToOne
	@JoinColumn(name="person_ID")
	private Person person;
	
	private static final long serialVersionUID = 1L;

	public Submission() {
		super();
	}   
	public Submission(int id, Date subDate, String content, int grade, Assignment assignment, Person person) {
		super();
		this.id = id;
		this.subDate = subDate;
		this.content = content;
		this.grade = grade;
		this.assignment = assignment;
		this.person = person;
	}
	public int getId() {
		return this.id;
	}

	public void setId(int id) {
		this.id = id;
	}   
	public Date getSubDate() {
		return this.subDate;
	}

	public void setSubDate(Date subDate) {
		this.subDate = subDate;
	}   
	public String getContent() {
		return this.content;
	}

	public void setContent(String content) {
		this.content = content;
	}
	public int getGrade() {
		return grade;
	}
	public void setGrade(int grade) {
		this.grade = grade;
	}
	public Assignment getAssignment() {
		return assignment;
	}
	public void setAssignment(Assignment assignment) {
		this.assignment = assignment;
	}
	public Person getPerson() {
		return person;
	}
	public void setPerson(Person person) {
		this.person = person;
	}
   
}
