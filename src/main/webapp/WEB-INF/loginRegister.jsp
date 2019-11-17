<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Login and Register</title>
<link href="https://fonts.googleapis.com/css?family=PT+Sans&display=swap" rel="stylesheet">
<style>
*{
font-family: 'PT Sans', sans-serif;
}
input[type=text], [type=password] {
  width: 30%;
  padding: 12px 20px;
  margin: 8px 0;
  display: inline-block;
  border: 1px solid #ccc;
  border-radius: 4px;
  box-sizing: border-box;
}

input[type=submit] {
  width: 20%;
  background-color: #7a6083;
  color: white;
  font-size:14px;
  padding: 14px 20px;
  margin: 8px 0;
  border: none;
  border-radius: 4px;
  cursor: pointer;
}



#container {
  width:1000px;
  border-radius: 5px;
  background-color: #f2f2f2;
  padding: 20px;
 
}
.error{
color:red;
}
.sucess{
color:green;
}
#reg{
display:inline;
position:relative;
left:430px;
top:-290px;
}
</style>
</head>
<body>
<div id="container">
    <c:if test="${logoutMessage != null}">
       <p class="sucess"> <c:out value="${logoutMessage}"></c:out></p>
    </c:if>
    
	<c:if test="${errorMessage != null}">
        <p class="error"><c:out value="${errorMessage}"></c:out></p>
    </c:if>
    <h1>Login</h1>
    
    <form method="POST" action="/login">
        <p>
            <label for="username">Email: </label>
            <input type="text" id="username" name="username"/>
        </p>
        <p>
            <label for="password">Password: </label>
            <input type="password" id="password" name="password"/>
        </p>
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        <input type="submit" value="Login!"/>
    </form>
    <div id="reg">
     <h1>Register!</h1>
    
    <p><form:errors path="user.*"/></p>
    
    <form:form method="POST" action="/registration" modelAttribute="user">
        <p>
            <form:label path="firstname">First Name:</form:label>
            <form:input path="firstname"/>
        </p>
        <p>
            <form:label path="lastname">Last Name:</form:label>
            <form:input path="lastname"/>
        </p>
        <p>
            <form:label path="email">Email:</form:label>
            <form:input path="email"/>
        </p>
        <p>
            <form:label path="password">Password:</form:label>
            <form:password path="password"/>
        </p>
        <p>
            <form:label path="passwordConfirmation">Password Confirmation:</form:label>
            <form:password path="passwordConfirmation"/>
        </p>
        <input type="submit" value="Register!"/>
    </form:form>
    </div>
    
    </div>
</body>
</html>