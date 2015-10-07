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
import edu.neu.cs5200.ide.jpa.Submission;

@Path("/submission")
public class SubmissionDao {
	
	EntityManagerFactory factory = Persistence.createEntityManagerFactory("UCMS");
	EntityManager em = null;
	
	public SubmissionDao() {
		em = factory.createEntityManager();
	}
	
	// Create new Submission
	@POST
	@Path("/")
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	public void createSubmission(Submission submission) {
		em.getTransaction().begin();
		em.persist(submission);
		em.getTransaction().commit();
		em.close();
	}
	
	// Read a Submission by ID
	@GET
	@Path("/{id}")
	@Produces(MediaType.APPLICATION_JSON)
	public Submission readSubmissionById(@PathParam("id") int id) {
		em.getTransaction().begin();
		Submission submission = em.find(Submission.class, id);
		em.getTransaction().commit();
		em.close();
		return submission;
	}
	
	
	// Read Submission by Assignment Id
		@GET
		@Path("/assignment/{assignmentId}")
		@Produces(MediaType.APPLICATION_JSON)
		public List<Submission> readSubmissionByAssignmentId(@PathParam("assignmentId") int aId) {
			List<Submission> subs = null;
			em.getTransaction().begin();
			Query query = em.createQuery("select s from Assignment a JOIN a.submissions s where a.id = :assignmentId");
			query.setParameter("assignmentId", aId);
			try{
				subs = (List<Submission>) query.getResultList();
			}catch(Exception e){      
				System.out.println(e);
			}
			em.getTransaction().commit();
			em.close();
			return subs;
		}
	
		// Read Submission by Person Id and Assignment Id
		@GET
		@Path("/person/{personId}/{assignmentId}")
		@Produces(MediaType.APPLICATION_JSON)
		public List<Submission> readSubmissionByPersonIdAssignmentId(@PathParam("personId") int pId, @PathParam("assignmentId") int aId) {
			List<Submission> subs = null;
			em.getTransaction().begin();
			Query query = em.createQuery("select s from Assignment a JOIN a.submissions s JOIN s.person p where a.id = :assignmentId and p.id = :personId");
			query.setParameter("assignmentId", aId);
			query.setParameter("personId", pId);
			try{
				subs = (List<Submission>) query.getResultList();
			}catch(Exception e){      
				System.out.println(e);
			}
			System.out.println(pId);
			System.out.println(aId);
			System.out.println(subs);
			em.getTransaction().commit();
			em.close();
			return subs;
		}
		
		
		
	// Read all Submissions
	@GET
	@Path("/")
	@Produces(MediaType.APPLICATION_JSON)
	public List<Submission> readAllSubmission() {
		em.getTransaction().begin();
		Query q = em.createNamedQuery("readAllSubmissions");
		List<Submission> submission = q.getResultList();
		em.getTransaction().commit();
		em.close();
		return submission;
	}
	
	// Update a Submission
	
	@PUT
	@Path("/{id}")
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	public void updateSubmissionById(@PathParam("id") int submissionId, Submission submission) {
		em.getTransaction().begin();
		submission.setId(submissionId);
		em.merge(submission);
		em.getTransaction().commit();
		em.close();
	}
	
	// Delete a Submission by ID
	@DELETE
	@Path("/{id}")
	@Produces(MediaType.APPLICATION_JSON)
	public void deleteSubmissionById(@PathParam("id") int id) {
		em.getTransaction().begin();
		Submission submission = em.find(Submission.class, id);
		em.remove(submission);
		em.getTransaction().commit();
		em.close();
	}

}
