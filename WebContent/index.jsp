<!DOCTYPE html>
<!-- welcomesession.jsp -->
<!-- JSP front-end that processes a "get" request containing data. -->
<!-- and sends it to a servlet for processing and returning result to -->
<!-- the original user page -->

<%-- start scriptlet --%>
<%
   String firstName = (String) session.getAttribute("firstName");

   String message = (String) session.getAttribute("message");
   if (message ==null) message = " ";
%>

<html lang="en">
   <!-- head section of document -->
   <head>
      <title>A JSP that processes "get" requests with data</title>
	  <meta charset="utf-8">
	  <style type="text/css">
   	  <!--
   		body { background-color: blue; color:lime; font-family: verdana, arial, sans-serif; font-size: 1.4em;  }
         h1 { color:yellow; font-size: 1.3em; }
         input[type="submit"] {background-color: yellow; font-weight:bold;}
         input[type="text"]{background-color:blue; color:white;}
         span {color: red;}
         #servlet {color:purple;}
         #jsp {color:cyan;}
   	  -->
	  </style>
   </head>
   <!-- body section of document -->
   <body>
		<!-- Main Header -->
         <h5 style="color: white; text-align:center">Remote Database Management System</h5>
   <hr>
   </hr>
		<!-- Sub-Header -->
	   <p style="text-align:center; color:white; font-size:9px; padding-left:15%; padding-right:15%">
			You are connected to the Project 4 Enterprise System database. <br>Please enter any valid SQL query or update statement.<br>
			If no query/update command is initially provided, the Execute button will display all supplier information in the database. <br>
			All execution results will appear below. 
	   </p>
	   		<!-- Input Area -->
		   <!--  <form action = "/JSP-Servlet-App/Project4" method = "post"> -->
		   <div style=" text-align:center">
			   <textArea name="inTextArea"style="background-color:black; color:green; font-size:9px" rows="7" cols="70" autofocus>
			   </textArea>
		   </div>
			   <div style="text-align:center">
				<input type = "submit" value = "Execute Command" style="background-color:black; color:yellow; font-size:12px" />
				<!--
				<button style="background-color:black; color:yellow; font-size:12px">
					Reset Form
				</button> -->
				</div>
			<!-- </form> -->
      <hr>
	  	            <div style="color: white; text-align:center; font-size:14px">Database Results:</div>

	  </hr>
	    <table style="font-size: 12px; border-style:groove; border-width:2px; border-color:black; align:center; margin-left:auto; margin-right:auto">
		  <tr style="background-color:red; color:black">
			<td>snum</td>
			<td>sname</td>
			<td>status</td>
			<td>city</td>
		  </tr>
		</table>


      <form action = "/Project4/Project4" method = "post">
               <p>Type your first name and press Submit</p>
               <p><input type = "text" name = "firstName">  </input>
                  <input type = "submit" value = "Submit Your Name" />
               </p>
      </form>

      <br><br><br>
      <h2>
      	<%-- JSP expression to access the message sent from the servlet --%>
      	<%=message%>
      </h2>
   </body>
</html>  <!-- end HTML document -->