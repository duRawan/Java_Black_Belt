<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.util.*"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@page import="com.Rawanproject.blackbelt.models.Course"%>
<%@page import="com.Rawanproject.blackbelt.models.User"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://fonts.googleapis.com/css?family=PT+Sans&display=swap" rel="stylesheet">
<style>
*{
font-family: 'PT Sans', sans-serif;
}
#courses {
  border-collapse: collapse;
  width: 40%;
}

#courses td, #customers th {
  border: 1px solid #ddd;
  padding: 5px;
}

#courses tr:nth-child(even){background-color: #f2f2f2;}

#courses tr:hover {background-color: #ddd;}

#courses th {
  padding-top: 12px;
  padding-bottom: 12px;
  text-align: left;
  background-color: #7a6083;
  color: white;
}
.button {
  font-family: 'PT Sans', sans-serif;
  background-color: #7a6083;
  border: none;
  color: white;
  padding: 10px 15px;
  text-align: center;
  text-decoration: none;
  display: inline-block;
  margin: 4px 2px;
  cursor: pointer;
  position: relative;
}
.button a {
text-decoration:none;
color: white;
font-family: 'PT Sans', sans-serif;
font-size:14px;
}
</style>
</head>
<body>
<h1>Welcome <c:out value="${currentUser.firstname}"></c:out>!</h1>
<form id="logoutForm" method="POST" action="/logout">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        <input class="button" type="submit" value="Logout!" />
    </form>
<h3>Courses</h3>
    <table id="courses">
    		<tr>
    			<th>Name</th>
    			<th>Instructor</th>
    			<th>SignUps</th>
    			<th>Actions</th>
    		</tr>
    		<% List<Course> allcourse = (List<Course>) request.getAttribute("allcourse"); %>
    		<% for(int i = 0; i < allcourse.size(); i++) { %>
    			<% Course course = allcourse.get(i); %>
    				<tr>
    				<%User user= (User) request.getAttribute("currentUser");%>
    					<td><a href="/courses/<%= course.getId()%>"> <%= course.getName() %></a></td>
    					<td><%= course.getInstructor() %></td>
    					<td><%= course.getSignups() %>/<%= course.getCapacity() %></td>
    					<%  if(course.getSignups()==course.getCapacity()&&!(user.getCourse().contains(course))) { %>
    					<td>Full</td>
    					  <% }else if(user.getCourse().contains(course)) { %> 
    						<td>Already added</td>
    						<%} else{ %>
    							<td><a href="/signup/<%= course.getId()%>">Add</a> </td>
    					 	 <% } %>
    					 	 
    					<%} %>
    				</tr>
    </table><br>
    <button class="button"> <a href="/courses/new"> Create a course</a></button>
    
    
</body>
</html>