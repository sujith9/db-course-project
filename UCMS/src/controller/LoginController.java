package controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import edu.neu.cs5200.ide.jpa.Person;
import edu.neu.cs5200.ide.jpa.Professor;
import edu.neu.cs5200.ide.jpa.Student;
import rest.LoginDao;


public class LoginController extends HttpServlet{


	protected void doPost(HttpServletRequest hreq, HttpServletResponse hresp) throws ServletException{

		LoginDao manager = new LoginDao();

		Person person = null;
		RequestDispatcher rd = null;

			try{

				person = manager.checkPerson(hreq.getParameter("username"),hreq.getParameter("user_pass"));

				if (person != null){
					HttpSession	session = hreq.getSession(true);
					if (person instanceof Professor) {
						Professor s = (Professor)person;
						session.setAttribute("id",person.getId());
						session.setAttribute("loggedInUser", "loggedIn");
						session.setAttribute("personType", "professor");
						hresp.sendRedirect("professorHome.jsp");
						System.out.println("prof");
					} else if (person instanceof Student) {
						Student eng = (Student)person;
						System.out.println("student");
						session.setAttribute("id",person.getId());
						session.setAttribute("loggedInUser", "loggedIn");
						session.setAttribute("personType", "student");
						hresp.sendRedirect("studentHome.jsp");
					}
				}
				else{
					rd = getServletContext().getRequestDispatcher("/login.jsp");
					PrintWriter out= hresp.getWriter();
					out.println("<div class='alert alert-danger alert-dismissible' role='alert'><button type='button' class='close' data-dismiss='alert'><span aria-hidden='true'>&times;</span><span class='sr-only'>Close</span></button><strong>OOPS!</strong> Please check your username and password again.</div>");
					rd.include(hreq, hresp);
				}

			}
			catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	}
}
