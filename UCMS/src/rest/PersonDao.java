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

import edu.neu.cs5200.ide.jpa.Person;
import edu.neu.cs5200.ide.jpa.Professor;
import edu.neu.cs5200.ide.jpa.Student;

@Path("/person")
public class PersonDao {

	EntityManagerFactory factory = Persistence.createEntityManagerFactory("UCMS");
	static EntityManager em = null;

	public PersonDao() {
		em = factory.createEntityManager();
	}
	
	
	// Get Major for personId
	@GET
	@Path("/major/{id}")
	@Produces(MediaType.APPLICATION_JSON)
	public String getMajorByPersonId(@PathParam("id") int id) {
		String major = null;
		em.getTransaction().begin();
		Query query = em.createQuery("select m.name from Major m INNER JOIN m.students s where s.id = :personId");
		query.setParameter("personId", id);
        try{
	          major = (String) query.getSingleResult();
	          System.out.println(major);
	          System.out.println("from get major for personId");
        }catch(Exception e){      
            return null;
        }
		em.getTransaction().commit();
		em.close();
		System.out.println(major);
		return major;
	}
	
	
	// Get Professor by courseId
		@GET
		@Path("/professor/course/{cId}")
		@Produces(MediaType.APPLICATION_JSON)
		public List<Professor> getProfessorByCourseId(@PathParam("cId") int cId) {
			List<Professor> profs = null;
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
			Query query = em.createQuery("select p from Professor p INNER JOIN p.enrolls en where en.course_ID = :cId and en.semester_ID = :semId");
			query.setParameter("cId", cId);
			query.setParameter("semId", semId);
	        try{
		          profs = (List<Professor>) query.getResultList();
		          System.out.println(profs);
		          System.out.println("from get professor for courseId");
	        }catch(Exception e){      
	            return null;
	        }
			em.getTransaction().commit();
			em.close();
			System.out.println(profs);
			return profs;
		}
	

	// Create new Person
	@POST
	@Path("/")
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	public void createPerson(Person person) {
		em.getTransaction().begin();
		em.persist(person);
		em.getTransaction().commit();
	}


	// Read a Person by ID
	@GET
	@Path("/{id}")
	@Produces(MediaType.APPLICATION_JSON)
	public Person readPersonById(@PathParam("id") int id) {
		em.getTransaction().begin();
		Person person = em.find(Person.class, id);
		em.getTransaction().commit();
		em.close();
		return person;
	}
	
	// Read all Persons
	@GET
	@Path("/")
	@Produces(MediaType.APPLICATION_JSON)
	public List<Person> readAllPerson() {
		em.getTransaction().begin();
		Query q = em.createNamedQuery("readAllPersons");
		List<Person> person = q.getResultList();
		em.getTransaction().commit();
		em.close();
		return person;
	}

	// Update a Person
	@PUT
	@Path("/{id}")
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	public void updatePerson(@PathParam("id") int id, Person person) {
		em.getTransaction().begin();
		person.setId(id);
		em.merge(person);
		em.getTransaction().commit();
		em.close();
	}

	// Delete a Person by ID
	@DELETE
	@Path("/{id}")
	@Produces(MediaType.APPLICATION_JSON)
	public void deletePersonById(@PathParam("id") int id) {
		em.getTransaction().begin();
		Person person = em.find(Person.class, id);
		em.remove(person);
		em.getTransaction().commit();
		em.close();
	}


}
