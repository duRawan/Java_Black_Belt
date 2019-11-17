<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
input[type=text], select {
  width: 40%;
  padding: 12px 20px;
  margin: 8px 0;
  display: inline-block;
  border: 1px solid #ccc;
  border-radius: 4px;
  box-sizing: border-box;
}

input[type=submit] {
  width: 40%;
  background-color: #7a6083;
  color: white;
  padding: 14px 20px;
  margin: 8px 0;
  border: none;
  border-radius: 4px;
  cursor: pointer;
}



#container {
  width:500px;
  border-radius: 5px;
  background-color: #f2f2f2;
  padding: 20px;
}
.error{
color:red;
}
</style>
</head>
<body>
<div id="container">
<c:if test="${errormsg != null}">
       <p class="error"> <c:out value="${errormsg}"></c:out></p>
    </c:if>
    <br>
    
<h3>Create a Course </h3>
    <form:form method="POST" modelAttribute="Course" action="/createcourse">
    		<form:label path="name">Course Name:
    			<form:input path="name" type="text"/>
    		</form:label><br>
    		<form:label path="instructor">Instructor Name:
    			<form:input path="instructor" type="text" />
    		</form:label><br>
    		<form:label path="capacity">Capacity:
    			<form:input path="capacity" type="number" />
    		</form:label><br>
    		<input type="submit"/>
    </form:form><br>
    </div>
</body>
</html>