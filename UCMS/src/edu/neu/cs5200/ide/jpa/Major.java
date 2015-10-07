package edu.neu.cs5200.ide.jpa;

import java.io.Serializable;
import java.lang.String;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;

@Entity
@NamedQuery(name="readAllMajors", query="SELECT m FROM Major m")

public class Major implements Serializable {
	   
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int id;
	@Column(length = 500)
	private String name;
	@OneToMany(mappedBy="major")
	private List<Student> students;
	@OneToMany(mappedBy="major")
	private List<Course> courses;
	
	private static final long serialVersionUID = 1L;

	public Major() {
		super();
	}   
	public Major(int id, String name, List<Student> students, List<Course> courses) {
		this.id = id;
		this.name = name;
		this.students = students;
		this.courses = courses;
	}
	public int getId() {
		return this.id;
	}

	public void setId(int id) {
		this.id = id;
	}   
	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}
	public List<Course> getCourses() {
		return courses;
	}
	public void setCourses(List<Course> courses) {
		this.courses = courses;
	}
   
}
