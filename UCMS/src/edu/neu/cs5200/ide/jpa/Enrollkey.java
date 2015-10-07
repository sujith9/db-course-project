package edu.neu.cs5200.ide.jpa;

import java.io.Serializable;

public class Enrollkey implements Serializable {

	private int person_ID;
	private int semester_ID;
	private int course_ID;
	
	private static final long serialVersionUID = 1L;
	
	public int hashCode() {
	  return (int)(person_ID + semester_ID + course_ID);
	}
	 
	public boolean equals(Object object) {
	  if (object instanceof Enrollkey) {
		  Enrollkey otherId = (Enrollkey) object;
	    return (otherId.person_ID == this.person_ID) && (otherId.semester_ID == this.semester_ID) && (otherId.course_ID == this.course_ID);
	  }
	  return false;
	}

}
