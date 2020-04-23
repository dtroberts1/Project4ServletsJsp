<!DOCTYPE html>
<!-- welcomesession.jsp -->
<!-- JSP front-end that processes a "get" request containing data. -->
<!-- and sends it to a servlet for processing and returning result to -->
<!-- the original user page -->

<%-- start scriptlet --%>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.ResultSetMetaData" %>


<%

	
   String firstName = (String) session.getAttribute("firstName");
   String errorOut = (String) session.getAttribute("errorOutput");
   String busLogDet = (String) session.getAttribute("logicDetected");
   String nbrRowsAffected = (String)session.getAttribute("nbrRowsAffected");
   String statusMarks = (String)session.getAttribute("statusMarks");

   String outputResultSet = null;

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
		     <form action = "/Project4/Project4" method = "post">
		   <div style=" text-align:center">
			   <textArea name="inTextArea"style="background-color:black; color:#66ff33; font-size:9px" rows="7" cols="70" autofocus>
			   </textArea>
		   </div>
			   <div style="text-align:center">
				<input type = "submit" value = "Execute Command" style="background-color:black; color:yellow; font-size:12px" />
				<!--
				<button style="background-color:black; color:yellow; font-size:12px">
					Reset Form
				</button> -->
				</div>
			</form>
      <hr>
	  	            <div style="color: white; text-align:center; font-size:14px">Database Results:</div>

	  </hr>
	  <%
	  		  	if (request.getAttribute("errorOutput") != null){
		  		int i = 0;
		  		%><div style="background-color:red;font-size: 12px; margin-left:33%; width:33%; color:white; display:inline-block; padding: 2px; border-width:3px; 
		  		border-style:solid; border-color:black; text-align:center">
		  		Error Executing SQL Statement: <br/>
		  			<%=request.getAttribute("errorOutput").toString()%>
		  		</div><%
		  	}
   %>
   	  <%
	  		  	if (request.getAttribute("logicDetected") != null){
		  		int i = 0;
		  		%><div style="background-color:green;font-size: 12px; margin-left:33%; width:33%; color:white; display:inline-block; padding: 2px; border-width:3px; 
		  		border-style:solid; border-color:black; text-align:center">
		  		<span style="color:black">
		  		The Statement Executed Successfully <br/>
		  		<%=request.getAttribute("nbrRowsAffected").toString()%> row(s) affected <br/>
		  		</span>
		  		<span style="color:white"><%=request.getAttribute("logicDetected").toString()%></span>
		  		<span style="color:white">Business Logic Updated <%=request.getAttribute("statusMarks").toString() %> Supplier Marks </span>
		  			<br />
		  		</div><%
		  	}
   %>
	    <table style="font-size: 12px; border-style:groove; border-width:2px; border-color:black; align:center; margin-left:auto; margin-right:auto">
		  <%
		  	if (request.getSession().getAttribute("outputResultSet") != null){
		  		int currentRow;
		  		if ((request.getSession() != null) && (request.getSession().getAttribute("outputResultSet") != null))
		  		{
				  	ResultSet rs = (ResultSet)request.getSession().getAttribute("outputResultSet");
				  	if ((rs != null) && (!rs.isClosed())){
						//System.out.print(rs.toString());
						//rs.beforeFirst();
						System.out.println();
						System.out.println();

						ResultSetMetaData metaData = rs.getMetaData();
						if (metaData != null){
							int nbrCols = metaData.getColumnCount();
							// Display Columns in the first row
							%><tr style="background-color:red; color:black"><%
							for (int i = 1; i <= nbrCols; i++){
								%><td><%= metaData.getColumnName(i)
								%></td><%
							}
							%></tr><%
							rs.beforeFirst();
							currentRow = 0;
							while (rs.next()) {
								if (currentRow % 2 != 0)
								{
									%><tr style="background-color:#b1d3eb; color:black"><%
								}
								else{
									%><tr style="background-color:white; color:black"><%
								}
								for (int currentCol = 1; currentCol < (nbrCols + 1); currentCol++)
								{
									%><td><%= rs.getString(metaData.getColumnName(currentCol))
											%></td><%
								}
								%></tr><%
								currentRow++;
							}
						}
						rs.close();

				  	}
				  	else if (rs.isClosed()){
						System.out.println();

				  	}
		  		}

		  	}
		  
		  %>
		</table>

      <br><br><br>
      <h2>
      	<%-- JSP expression to access the message sent from the servlet --%>
      	<%=message%>
      </h2>
   </body>
</html>  <!-- end HTML document -->