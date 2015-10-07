package rest;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.Query;
import javax.ws.rs.Consumes;
import javax.ws.rs.DELETE;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

import edu.neu.cs5200.ide.jpa.Course;
import edu.neu.cs5200.ide.jpa.Semester;

@Path("/course")
public class CourseDao {

	EntityManagerFactory factory = Persistence.createEntityManagerFactory("UCMS");
	EntityManager em = null;

	public CourseDao() {
		em = factory.createEntityManager();
	}

	// Create new Course
	@POST
	@Path("/")
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	public void createCourse(Course course) {
		em.getTransaction().begin();
		em.persist(course);
		em.getTransaction().commit();
		em.close();
	}

	// Read a Course by ID
	@GET
	@Path("/{id}")
	@Produces(MediaType.APPLICATION_JSON)
	public Course readCourseById(@PathParam("id") int id) {
		em.getTransaction().begin();
		Course course = em.find(Course.class, id);
		em.getTransaction().commit();
		em.close();
		return course;
	}

	// Read Courses by PersonId and SemesterId
	@GET
	@Path("/{personId}/{semesterId}")
	@Produces(MediaType.APPLICATION_JSON)
	public List<Course> readCoursesByPersonIdandSemesterId(@PathParam("personId") int pId, @PathParam("semesterId") int sId) {
		List<Course> courses = null;
		em.getTransaction().begin();

		Query query = em.createQuery("select c from Course c INNER JOIN c.enrolls e where e.person_ID = :personId and e.semester_ID = :semesterId");
		query.setParameter("personId", pId);
		query.setParameter("semesterId", sId);
		try{
			courses = (List<Course>) query.getResultList();
			System.out.println(courses);
			System.out.println("from get major for personId");
		}catch(Exception e){      
			return null;
		}
		em.getTransaction().commit();
		em.close();
		System.out.println(courses);
		return courses;
	}
	
	
	// Read Courses by PersonId for current semester
	@GET
	@Path("/person/{personId}")
	@Produces(MediaType.APPLICATION_JSON)
	public List<Course> readCoursesByPersonId(@PathParam("personId") int pId) {
		List<Course> courses = null;
		int semId;
		em.getTransaction().begin();
		Query query0 = em.createQuery("select s.id from Semester s order by s.date DESC").setMaxResults(1);
		try{
			semId = (int) query0.getSingleResult();
			System.out.println(semId);
			System.out.println("from get current courses for personId");
		}catch(Exception e){      
			return null;
		}
		
		Query query = em.createQuery("select c from Course c INNER JOIN c.enrolls e where e.person_ID = :personId and e.semester_ID = :semId");
		query.setParameter("personId", pId);
		query.setParameter("semId", semId);
		try{
			courses = (List<Course>) query.getResultList();
			System.out.println(courses);
			System.out.println("from get major for personId");
		}catch(Exception e){      
			return null;
		}
		em.getTransaction().commit();
		em.close();
		System.out.println(courses);
		return courses;
	}






	// Read all Courses
	@GET
	@Path("/")
	@Produces(MediaType.APPLICATION_JSON)
	public List<Course> readAllCourse() {
		em.getTransaction().begin();
		Query q = em.createNamedQuery("readAllCourses");
		List<Course> course = q.getResultList();
		em.getTransaction().commit();
		em.close();
		return course;
	}

	// Update a Course

	@PUT
	@Path("/{id}")
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	public void updateCourseById(@PathParam("id") int courseId, Course course) {
		em.getTransaction().begin();
		course.setId(courseId);
		em.merge(course);
		em.getTransaction().commit();
		em.close();
	}

	// Delete a Course by ID
	@DELETE
	@Path("/{id}")
	@Produces(MediaType.APPLICATION_JSON)
	public void deleteCourseById(@PathParam("id") int id) {
		em.getTransaction().begin();
		Course course = em.find(Course.class, id);
		em.remove(course);
		em.getTransaction().commit();
		em.close();
	}

}
