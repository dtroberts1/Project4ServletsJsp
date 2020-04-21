

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.UnavailableException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class ProjFour
 */

public class ProjFour extends HttpServlet {   
	private Connection connection;
	private Statement statement;
	
	public void init(ServletConfig config) throws ServletException{
		// Attempt database connection
		try {
			Class.forName(config.getInitParameter("databaseDriver"));
			connection = DriverManager.getConnection(
					config.getInitParameter("databaseName"),
					config.getInitParameter("username"),
					config.getInitParameter("password"));
			Class.forName("com.mysql.cj.jdbc.Driver");
			//connection = DriverManager.getConnection("jdbc:mysql:localhost:3306/project4", "root", "sky551er");
			statement = connection.createStatement();
		}
		catch(Exception exception){
			exception.printStackTrace();
			throw new UnavailableException(exception.getMessage());
		}
	}
    // process "get" requests from clients
    protected void doGet( HttpServletRequest request, 
                         HttpServletResponse response ) throws ServletException, IOException 
    {
      String firstName = request.getParameter("firstName");
      String message = "Hello <span>" + firstName + "</span>! <br> Welcomeaaa to the world of ";
      message += "<span id='servlet'>servlet </span> and <span id='jsp'>jsp </span>technology.";
      HttpSession session = request.getSession();
      session.setAttribute("message",  message);
      session.setAttribute("firstName",firstName);
      ServletContext context = request.getSession().getServletContext();
      if (context != null)
      {
          RequestDispatcher dispatcher = context.getRequestDispatcher("/index.jsp");
          dispatcher.forward(request, response);     
      }
   
    }
    
    public void doPost(HttpServletRequest request, HttpServletResponse response )
    	throws IOException, ServletException  {
    		doGet(request, response);
        	}

} //end WelcomeServlet class
/*
public class doGet(HttpServletClass request, HttpServletResponse response) throws ServletException, IO Exception{
    String userInput = request.getParameter("inTextArea");
    String message = "Hello <span>" + userInput + "</span>! <br> Welcodme    to the world of ";
    message += "<span id='servlet'>servlet </span> and <span id='jsp'>jsp </span>technology.";
    HttpSession session = request.getSession();
    session.setAttribute("message",  message);;
    session.setAttribute("inTextArea",userInput);
    RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/welcome - SessionVersion.jsp");
    dispatcher.forward(request, response);      
    
}
y*/
