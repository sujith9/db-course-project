package edu.neu.cs5200.ide.jpa;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.IdClass;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQuery;
import javax.persistence.PrimaryKeyJoinColumn;

@Entity
@NamedQuery(name="readAllEnrolls", query="SELECT e FROM Enroll e")
@IdClass(Enrollkey.class)

public class Enroll {
	
	@Id
	private int person_ID;
	@Id
	private int semester_ID;
	@Id
	private int course_ID;
	@ManyToOne
	@PrimaryKeyJoinColumn(name="person_ID", referencedColumnName="id")
	private Person person;
	@ManyToOne
	@PrimaryKeyJoinColumn(name="semester_ID", referencedColumnName="id")
	private Semester semester;
	@ManyToOne
	@PrimaryKeyJoinColumn(name="course_ID", referencedColumnName="id")
	private Course course;
	
	public Enroll() {
		super();
	}
	public Enroll(int person_ID, int semester_ID, int course_ID) {
		super();
		this.person_ID = person_ID;
		this.semester_ID = semester_ID;
		this.course_ID = course_ID;
	}

	public int getPerson_ID() {
		return person_ID;
	}
	public void setPerson_ID(int person_ID) {
		this.person_ID = person_ID;
	}
	public int getSemester_ID() {
		return semester_ID;
	}
	public void setSemester_ID(int semester_ID) {
		this.semester_ID = semester_ID;
	}
	public int getCourse_ID() {
		return course_ID;
	}
	public void setCourse_ID(int course_ID) {
		this.course_ID = course_ID;
	}

}
