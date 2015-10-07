package edu.neu.cs5200.ide.jpa;

import java.util.List;

import javax.persistence.Entity;

@Entity

public class Professor extends Person {

	
	private static final long serialVersionUID = 1L;

	public Professor() {
		super();
	}

	public Professor(int id, String firstName, String lastName, String username, String password,
			String email, String profilePic, String details, List<Enroll> enrolls, List<Submission> submissions) {
		super(id, firstName, lastName, username, password, email, profilePic, details, enrolls, submissions);
	}
   
}
