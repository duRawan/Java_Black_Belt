<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
    <%@page import="com.Rawanproject.blackbelt.models.User"%>
    <%@page import="com.Rawanproject.blackbelt.models.Course"%>
    <%@page import="java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Course Info</title>
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
	<h1> Course name<c:out value="${course.name}"/></h1>
<p>Instructor: <c:out value="${course.instructor}"/></p>
<p>SignUps: <c:out value="${course.signups}"/></p>
<table id="courses">
			<tr>
    			<th>Name</th>
    			<th>SignUp Date</th>
    			<th>Actions</th>
    		</tr>
    <%--loop over users--%>
        <c:forEach var="user" items="${course.users}" >
        <tr>
        <% User u=(User) request.getAttribute("currentUser"); %>
         <% Course c=(Course) request.getAttribute("course"); %>
         <%List <User> users= (List<User>) request.getAttribute("allusers"); %>
            <td> name: <c:out value="${user.firstname}"/></td>
            <td> Date: <c:out value="${user.updatedAt}"/></td>
            <c:if test="${user.email==currentUser.email}">
            <td><a href="/UnSignUp/${course.id}">Remove</a></td>
            </c:if>
           
            </tr>
        </c:forEach>
    </table>
<a href="/courses/${course.id}/edit">Edit</a>
<a href="/courses/${course.id}/delete">delete</a>
</body>
</html>