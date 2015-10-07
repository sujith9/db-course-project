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
import edu.neu.cs5200.ide.jpa.Course;
import edu.neu.cs5200.ide.jpa.Event;

@Path("/event")
public class EventDao {
	
	EntityManagerFactory factory = Persistence.createEntityManagerFactory("UCMS");
	EntityManager em = null;
	
	public EventDao() {
		em = factory.createEntityManager();
	}
	
	// Create new Event
	@POST
	@Path("/")
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	public void createEvent(Event event) {
		em.getTransaction().begin();
		em.persist(event);
		em.getTransaction().commit();
		em.close();
	}
	
	// Read a Event by ID
	@GET
	@Path("/{id}")
	@Produces(MediaType.APPLICATION_JSON)
	public Event readEventById(@PathParam("id") int id) {
		em.getTransaction().begin();
		Event event = em.find(Event.class, id);
		em.getTransaction().commit();
		em.close();
		return event;
	}
	
	
	// Get Events by courseId
	@GET
	@Path("/course/{cId}")
	@Produces(MediaType.APPLICATION_JSON)
	public List<Event> getEventsByCourseId(@PathParam("cId") int cId) {
		List<Event> events = null;
		em.getTransaction().begin();
		Query query = em.createQuery("select e from Event e JOIN e.course c where c.id = :cId ORDER BY e.date DESC");
		query.setParameter("cId", cId);
        try{
        	events = (List<Event>) query.getResultList();
	          System.out.println(events);
	          System.out.println("from get assignments for courseId");
        }catch(Exception e){      
            return null;
        }
		em.getTransaction().commit();
		em.close();
		System.out.println(events);
		return events;
	}

	// Read Events by personId
	@GET
	@Path("/person/{personId}")
	@Produces(MediaType.APPLICATION_JSON)
	public List<Course> readEventsByPersonId(@PathParam("personId") int cId) {
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
		
		Query query = em.createQuery("select e from Event e JOIN e.course c JOIN c.enrolls en JOIN en.semester s where en.person_ID = :personId and en.semester_ID = :semId ORDER BY e.date DESC");
		query.setParameter("personId", cId);
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
	
	
	// Read all Events
	@GET
	@Path("/")
	@Produces(MediaType.APPLICATION_JSON)
	public List<Event> readAllEvent() {
		em.getTransaction().begin();
		Query q = em.createNamedQuery("readAllEvents");
		List<Event> event = q.getResultList();
		em.getTransaction().commit();
		em.close();
		return event;
	}
	
	// Update a Event
	
	@PUT
	@Path("/{id}")
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	public void updateEventById(@PathParam("id") int eventId, Event event) {
		em.getTransaction().begin();
		event.setId(eventId);
		em.merge(event);
		em.getTransaction().commit();
		em.close();
	}
	
	// Delete a Event by ID
	@DELETE
	@Path("/{id}")
	@Produces(MediaType.APPLICATION_JSON)
	public void deleteEventById(@PathParam("id") int id) {
		em.getTransaction().begin();
		Event event = em.find(Event.class, id);
		em.remove(event);
		em.getTransaction().commit();
		em.close();
	}


}
