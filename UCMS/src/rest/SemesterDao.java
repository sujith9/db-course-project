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

import edu.neu.cs5200.ide.jpa.Semester;

@Path("/semester")
public class SemesterDao {
	
	EntityManagerFactory factory = Persistence.createEntityManagerFactory("UCMS");
	EntityManager em = null;
	
	public SemesterDao() {
		em = factory.createEntityManager();
	}
	
	// Create new Semester
	@POST
	@Path("/")
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	public void createSemester(Semester semester) {
		em.getTransaction().begin();
		em.persist(semester);
		em.getTransaction().commit();
		em.close();
	}
	
	// Read a Semester by ID
	@GET
	@Path("/{id}")
	@Produces(MediaType.APPLICATION_JSON)
	public Semester readSemesterById(@PathParam("id") int id) {
		em.getTransaction().begin();
		Semester semester = em.find(Semester.class, id);
		em.getTransaction().commit();
		em.close();
		return semester;
	}
	
	// Get Semesters for PersonId
	@GET
	@Path("/person/{id}")
	@Produces(MediaType.APPLICATION_JSON)
	public List<Semester> getSemesterByPersonId(@PathParam("id") int id) {
		List<Semester> semesters = null;
		em.getTransaction().begin();
		Query query = em.createQuery("select DISTINCT s from Semester s INNER JOIN s.enrolls e JOIN e.person p where e.person_ID = :personId ORDER BY s.date DESC");
		query.setParameter("personId", id);
        try{
        	semesters = (List<Semester>) query.getResultList();
	          System.out.println(semesters);
	          System.out.println("from get major for personId");
        }catch(Exception e){      
            return null;
        }
		em.getTransaction().commit();
		em.close();
		System.out.println(semesters);
		return semesters;
	}
	
	
	// Read all Semesters
	@GET
	@Path("/")
	@Produces(MediaType.APPLICATION_JSON)
	public List<Semester> readAllSemester() {
		em.getTransaction().begin();
		Query q = em.createNamedQuery("readAllSemesters");
		List<Semester> semester = q.getResultList();
		em.getTransaction().commit();
		em.close();
		return semester;
	}
	
	// Update a Semester
	
	@PUT
	@Path("/{id}")
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	public void updateSemester(@PathParam("id") int semesterId, Semester semester) {
		em.getTransaction().begin();
		semester.setId(semesterId);
		em.merge(semester);
		em.getTransaction().commit();
		em.close();
	}
	
	// Delete a Semester by ID
	@DELETE
	@Path("/{id}")
	@Produces(MediaType.APPLICATION_JSON)
	public void deleteSemesterById(@PathParam("id") int id) {
		em.getTransaction().begin();
		Semester semester = em.find(Semester.class, id);
		em.remove(semester);
		em.getTransaction().commit();
		em.close();
	}

}
