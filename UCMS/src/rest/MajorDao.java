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

import edu.neu.cs5200.ide.jpa.Major;

@Path("/major")
public class MajorDao {
	
	EntityManagerFactory factory = Persistence.createEntityManagerFactory("UCMS");
	EntityManager em = null;
	
	public MajorDao() {
		em = factory.createEntityManager();
	}
	
	// Get Major by Course Id
	@GET
	@Path("/course/{id}")
	@Produces(MediaType.APPLICATION_JSON)
	public String getMajorByCourseId(@PathParam("id") int id) {
		String major = null;
		em.getTransaction().begin();
		Query query = em.createQuery("select m.name from Course c JOIN c.major m  where c.id = :courseId");
		query.setParameter("courseId", id);
	          major = (String) query.getSingleResult();
	          System.out.println(major);
	          System.out.println("from get major for personId");
		em.getTransaction().commit();
		em.close();
		System.out.println(major);
		return major;
	}
	
	
	// Create new Major
	@POST
	@Path("/")
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	public void createMajor(Major major) {
		em.getTransaction().begin();
		em.persist(major);
		em.getTransaction().commit();
		em.close();
	}
	
	// Read a Major by ID
	@GET
	@Path("/{id}")
	@Produces(MediaType.APPLICATION_JSON)
	public Major readMajorById(@PathParam("id") int id) {
		em.getTransaction().begin();
		Major major = em.find(Major.class, id);
		em.getTransaction().commit();
		em.close();
		return major;
	}
	

	
	// Read all Majors
	@GET
	@Path("/")
	@Produces(MediaType.APPLICATION_JSON)
	public List<Major> readAllMajor() {
		em.getTransaction().begin();
		Query q = em.createNamedQuery("readAllMajors");
		List<Major> major = q.getResultList();
		em.getTransaction().commit();
		em.close();
		return major;
	}
	
	// Update a Major
	
	@PUT
	@Path("/{id}")
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	public void updateMajor(@PathParam("id") int majorId, Major major) {
		em.getTransaction().begin();
		major.setId(majorId);
		em.merge(major);
		em.getTransaction().commit();
		em.close();
	}
	
	// Delete a Major by ID
	@DELETE
	@Path("/{id}")
	@Produces(MediaType.APPLICATION_JSON)
	public void deleteMajorById(@PathParam("id") int id) {
		em.getTransaction().begin();
		Major major = em.find(Major.class, id);
		em.remove(major);
		em.getTransaction().commit();
		em.close();
	}

	public static void main(String[] args) {
		MajorDao dao = new MajorDao();
		
//		Major m1 = new Major(1, "Computer Science");
//		Major m2 = new Major(2, "Telecom");
//		Major m3 = new Major(3, "Chemical Engineering");
//		dao.createMajor(m1);
//		dao.createMajor(m2);
//		dao.createMajor(m3);
//		
//		m2.setName("Telecommunications Engineering");
//		dao.updateMajor(m2.getId(), m2);
//		
//		List<Major> m4 = dao.readAllMajor();
//		System.out.println(m4);
//
//		dao.deleteMajorById(3);
		
	}

}
