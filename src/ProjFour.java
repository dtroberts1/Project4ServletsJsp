

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
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
	private HttpSession session;
	
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
    	  ResultSet rs = null;
	      String inTextArea = request.getParameter("inTextArea");
	      String message = "Hello <span>" + inTextArea + "</span>! <br> Welcomeaaa to the world of ";
	      String randomStr;
	      message += "<span id='servlet'>servlet </span> and <span id='jsp'>jsp </span>technology.";
	      HttpSession session = request.getSession();
	      // Parse and handle inTextArea
	      if ((inTextArea != null) && (inTextArea.split(" ") != null) && (inTextArea.split(" ")[0].equals("select"))) {
	    	  rs = populateTableWithDbResults(inTextArea, request, response);
		      session.setAttribute("outputResultSet",  rs);

	      }
	      else if ((inTextArea != null) && (inTextArea.split(" ") != null) && (inTextArea.split(" ")[0].equals("insert") || inTextArea.split(" ")[0].equals("update")))
	      {
	    	  insertDataIntoDb(inTextArea, request, response);
	      }
	      else {
	    	  System.out.println();
	
	      }
	      
	      session.setAttribute("inTextArea",inTextArea);
	      ServletContext context = request.getSession().getServletContext();
	      if (context != null)
	      {
	          RequestDispatcher dispatcher = context.getRequestDispatcher("/index.jsp");
	          dispatcher.forward(request, response);     
	          
	      }
   
    }
    public void insertDataIntoDb(String insertionStr, HttpServletRequest request, HttpServletResponse response) {
    	int nbrRowsUpdated = 0;
    	int nbrSupplierStatus = 0;
    	// Upgrade the status of the supplier
    	 try {
    		 nbrRowsUpdated = statement.executeUpdate(insertionStr);
    		 // If inserting into shipment in which the quantity is greater than 100
    		 String tableName = insertionStr.split(" ")[2];
    		 if (tableName.equals("shipments") || insertionStr.split(" ")[1].equals("shipments"))
    			 nbrSupplierStatus = statement.executeUpdate("UPDATE suppliers Set status = status + 5 where snum in (select snum from shipments where quantity > 100)");
		      request.setAttribute("logicDetected",  "Business Logic Detected! - Updating Supplier Status");
		      String myStr = String.valueOf(nbrRowsUpdated);
		      String strB = String.valueOf(nbrSupplierStatus);
		      request.setAttribute("nbrRowsAffected",  myStr);
		      request.setAttribute("statusMarks",  strB);

	
    	 } catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    }
    
    public void doPost(HttpServletRequest request, HttpServletResponse response )
    	throws IOException, ServletException  {
    		doGet(request, response);
        	}
    public ResultSet populateTableWithDbResults(String inputStr, HttpServletRequest request, HttpServletResponse response) {
    	try {
			ResultSet rs = statement.executeQuery(inputStr);

			return rs;
			/*int rowCount = rs.
			while (rs.next()) {
		    	  System.out.println();
			
			}
			*/
		} catch (SQLException e) {
			// TODO Auto-generated catch block
		      request.setAttribute("errorOutput",  e.getMessage());
		      
			e.printStackTrace();
            // get back to order.jsp page using forward
            try {
				request.getRequestDispatcher("/index.jsp").forward(request, response);
			} catch (ServletException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			} catch (IOException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			return null;
		}
    }
    
} //end WelcomeServlet class

