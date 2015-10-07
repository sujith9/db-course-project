package edu.neu.cs5200.ide.jpa;

import java.util.List;

import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

@Entity

public class Student extends Person{

	@ManyToOne
	@JoinColumn(name="major_ID")
	private Major major;
	private static final long serialVersionUID = 1L;

	public Student() {
		super();
	}
	public Student(int id, String firstName, String lastName, String username,
			String password, String email, String profilePic, String details, List<Submission> submissions, List<Enroll> enrolls) {
		super(id, firstName, lastName, username, password, email, profilePic, details, enrolls, submissions);
	}
}
