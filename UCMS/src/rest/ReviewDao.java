package rest;

import java.math.BigDecimal;
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
import edu.neu.cs5200.ide.jpa.Review;

@Path("review")
public class ReviewDao {

	EntityManagerFactory factory = Persistence.createEntityManagerFactory("UCMS");
	EntityManager em = null;

	public ReviewDao() {
		em = factory.createEntityManager();
	}

	// Create new Review
	@POST
	@Path("/")
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	public void createReview(Review review) {
		em.getTransaction().begin();
		em.persist(review);
		em.getTransaction().commit();
		em.close();
	}

	// Read a Review by ID
	@GET
	@Path("/{id}")
	@Produces(MediaType.APPLICATION_JSON)
	public Review readReviewById(@PathParam("id") int id) {
		em.getTransaction().begin();
		Review review = em.find(Review.class, id);
		em.getTransaction().commit();
		em.close();
		return review;
	}
	
	
	// Get Reviews by courseId
		@GET
		@Path("/course/{cId}")
		@Produces(MediaType.APPLICATION_JSON)
		public List<Review> getReviewByCourseId(@PathParam("cId") int cId) {
			List<Review> reviews = null;
			em.getTransaction().begin();
			Query query = em.createQuery("select r from Review r JOIN r.course c where c.id = :cId ORDER BY r.id DESC");
			query.setParameter("cId", cId);
	        try{
	        	reviews = (List<Review>) query.getResultList();
		          System.out.println(reviews);
		          System.out.println("from get assignments for courseId");
	        }catch(Exception e){      
	            return null;
	        }
			em.getTransaction().commit();
			em.close();
			System.out.println(reviews);
			return reviews;
		}
		
		// Get average of rating by courseId
		@GET
		@Path("/rating/average/course/{cId}")
		@Produces(MediaType.APPLICATION_JSON)
		public float getAverageRatingByCourseId(@PathParam("cId") int cId) {
			float avg = 0;
			BigDecimal avrg = null;
			System.out.println("from avg rating");
			em.getTransaction().begin();
			Query query = em.createNativeQuery("select AVG(result.rating) from (select * from review where review.course_ID = ?) result");
			query.setParameter(1, cId);
	        try{
	        	avrg = (BigDecimal) query.getSingleResult();
		          System.out.println("avg rating");
	        }catch(Exception e){ 
	        	System.out.println(e);
	        }
			em.getTransaction().commit();
			em.close();
			System.out.println(avg);
			return avrg.floatValue();
		}

	// Read all Reviews
	@GET
	@Path("/")
	@Produces(MediaType.APPLICATION_JSON)
	public List<Review> readAllReview() {
		em.getTransaction().begin();
		Query q = em.createNamedQuery("readAllReviews");
		List<Review> review = q.getResultList();
		em.getTransaction().commit();
		em.close();
		return review;
	}

	// Update a Review

	@PUT
	@Path("/{id}")
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	public void updateReviewById(@PathParam("id") int reviewId, Review review) {
		em.getTransaction().begin();
		review.setId(reviewId);
		em.merge(review);
		em.getTransaction().commit();
		em.close();
	}

	// Delete a Review by ID
	@DELETE
	@Path("/{id}")
	@Produces(MediaType.APPLICATION_JSON)
	public void deleteReviewById(@PathParam("id") int id) {
		em.getTransaction().begin();
		Review review = em.find(Review.class, id);
		em.remove(review);
		em.getTransaction().commit();
		em.close();
	}

}
