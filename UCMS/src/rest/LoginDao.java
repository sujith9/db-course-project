package rest;

import java.sql.ResultSet;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.Query;

import edu.neu.cs5200.ide.jpa.Person;

public class LoginDao {
	
	EntityManagerFactory factory = Persistence.createEntityManagerFactory("UCMS");
	static EntityManager em = null;

	public LoginDao() {
		em = factory.createEntityManager();
	}
	
	public Person checkPerson(String userName, String password) {
		Person person = null;
		em.getTransaction().begin();

		Query query = em.createQuery("select p from Person p where p.username=:uname and p.password=:pass");
		System.out.println("from check person");
		query.setParameter("uname", userName);
		query.setParameter("pass", password);		 
         try{
              person = (Person) query.getSingleResult();
           if (userName.equalsIgnoreCase(person.getUsername())&&password.equals(person.getPassword())) {
              return person;
           }
         }catch(Exception e){      
             return null;
         }
		em.getTransaction().commit();
	  return person;
	}
	
	public static void main(String[] args) {

		LoginDao dao = new LoginDao();
		Person rs = dao.checkPerson("abhi", "password");
		if(rs == null){
			System.out.println("No person");
		}else{
			System.out.println(rs.getEmail());
		}

	}

}
