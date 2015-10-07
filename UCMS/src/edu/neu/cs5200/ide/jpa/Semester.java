package edu.neu.cs5200.ide.jpa;

import java.io.Serializable;
import java.lang.String;
import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

@Entity
@NamedQuery(name="readAllSemesters", query="SELECT s FROM Semester s")
public class Semester implements Serializable {

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int id;
	private String semester;
	@Temporal(TemporalType.DATE)
	private Date date;
	@OneToMany(mappedBy="semester", cascade=CascadeType.ALL, orphanRemoval=true)
	private List<Enroll> enrolls;
	
	private static final long serialVersionUID = 1L;

	public Semester() {
		super();
	}   
	public Semester(int id, String semester, Date date, List<Enroll> enrolls) {
		super();
		this.id = id;
		this.semester = semester;
		this.date = date;
		this.enrolls = enrolls;
	}
	public int getId() {
		return this.id;
	}

	public void setId(int id) {
		this.id = id;
	}   
	public String getSemester() {
		return this.semester;
	}

	public void setSemester(String semester) {
		this.semester = semester;
	}   
	public Date getDate() {
		return this.date;
	}

	public void setDate(Date date) {
		this.date = date;
	}
	public List<Enroll> getEnrolls() {
		return enrolls;
	}
	public void setEnrolls(List<Enroll> enrolls) {
		this.enrolls = enrolls;
	}
   
}
