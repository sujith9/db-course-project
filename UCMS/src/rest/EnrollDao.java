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

import edu.neu.cs5200.ide.jpa.Enroll;
import edu.neu.cs5200.ide.jpa.Event;


@Path("/enroll")
public class EnrollDao {

	EntityManagerFactory factory = Persistence.createEntityManagerFactory("UCMS");
	EntityManager em = null;

	public EnrollDao() {
		em = factory.createEntityManager();
	}

	// Create new Enroll
	@POST
	@Path("/")
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	public void createEnroll(Enroll enroll) {
		em.getTransaction().begin();
		em.persist(enroll);
		em.getTransaction().commit();
		em.close();
	}

	// Read all Enrolls
	@GET
	@Path("/")
	@Produces(MediaType.APPLICATION_JSON)
	public List<Enroll> readAllEnroll() {
		em.getTransaction().begin();
		Query q = em.createNamedQuery("readAllEnrolls");
		List<Enroll> enroll = q.getResultList();
		em.getTransaction().commit();
		em.close();
		return enroll;
	}

	// Un-enroll using personId and courseId
	@DELETE
	@Path("/professor/course/{pId}/{cId}")
	@Produces(MediaType.APPLICATION_JSON)
	public void deleteEnrollById(@PathParam("pId") int pId, @PathParam("cId") int cId) {
		em.getTransaction().begin();
		int semId;
		Query query0 = em.createQuery("select s.id from Semester s order by s.date DESC").setMaxResults(1);
		semId = (int) query0.getSingleResult();
		System.out.println(semId);
		Query query = em.createNativeQuery("delete from Enroll where person_id = ? and course_id = ? and semester_id = ?");
		query.setParameter(1, pId);
		query.setParameter(2, cId);
		query.setParameter(3, semId);
		query.executeUpdate();
		System.out.println("unenroll");
		em.getTransaction().commit();
		em.close();
	}


}
