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

import edu.neu.cs5200.ide.jpa.Assignment;
import edu.neu.cs5200.ide.jpa.Professor;


@Path("assignment")
public class AssignmentDao {

	EntityManagerFactory factory = Persistence.createEntityManagerFactory("UCMS");
	EntityManager em = null;

	public AssignmentDao() {
		em = factory.createEntityManager();
	}

	// Create new Assignment
	@POST
	@Path("/")
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	public void createAssignment(Assignment assignment) {
		em.getTransaction().begin();
		em.persist(assignment);
		em.getTransaction().commit();
		em.close();
	}

	// Read a Assignment by ID
	@GET
	@Path("/{id}")
	@Produces(MediaType.APPLICATION_JSON)
	public Assignment readAssignmentById(@PathParam("id") int id) {
		em.getTransaction().begin();
		Assignment assignment = em.find(Assignment.class, id);
		em.getTransaction().commit();
		em.close();
		return assignment;
	}
	
	
	// Get Assignments by courseId
	@GET
	@Path("/course/{cId}")
	@Produces(MediaType.APPLICATION_JSON)
	public List<Assignment> getAssignmentByCourseId(@PathParam("cId") int cId) {
		List<Assignment> assignments = null;
		em.getTransaction().begin();
		Query query = em.createQuery("select a from Assignment a JOIN a.course c where c.id = :cId");
		query.setParameter("cId", cId);
        try{
        	assignments = (List<Assignment>) query.getResultList();
	          System.out.println(assignments);
	          System.out.println("from get assignments for courseId");
        }catch(Exception e){      
            return null;
        }
		em.getTransaction().commit();
		em.close();
		System.out.println(assignments);
		return assignments;
	}

	// Read all Assignments
	@GET
	@Path("/")
	@Produces(MediaType.APPLICATION_JSON)
	public List<Assignment> readAllAssignments() {
		em.getTransaction().begin();
		Query q = em.createNamedQuery("readAllAssignments");
		List<Assignment> assignment = q.getResultList();
		em.getTransaction().commit();
		em.close();
		return assignment;
	}

	// Update a Assignment

	@PUT
	@Path("/{id}")
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	public void updateAssignment(@PathParam("id") int assignmentId, Assignment assignment) {
		em.getTransaction().begin();
		assignment.setId(assignmentId);
		em.merge(assignment);
		em.getTransaction().commit();
		em.close();
	}
	
	// Delete a Assignment by ID
		@DELETE
		@Path("/{id}")
		@Produces(MediaType.APPLICATION_JSON)
		public void deleteAssignmentById(@PathParam("id") int id) {
			em.getTransaction().begin();
			Assignment assignment = em.find(Assignment.class, id);
			em.remove(assignment);
			em.getTransaction().commit();
			em.close();
		}

}
