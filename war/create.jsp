<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>

<html>
 <head>
   <link type="text/css" rel="stylesheet" href="/stylesheets/main.css" />
   <title>Write your own recipe!</title>
 </head>
 
  <body>
 
<%
    UserService userService = UserServiceFactory.getUserService();
    User user = userService.getCurrentUser();
    if (user != null) {
      pageContext.setAttribute("user", user);
%>
<div id="login">
<h1>
<a href="<%= userService.createLogoutURL(request.getRequestURI()) %>">Sign Out</a></h1>
<%
    } else {
%>
<h1>
<a href="<%= userService.createLoginURL(request.getRequestURI()) %>">Sign in</a>
to contribute your own recipe!</h1>
<%
    }
%>
</div>

<div id="main">
<h2>Write your own!</h2>

    <form action="/blogApp" method="post">
      <div><p><b>Title:</b></p></div>
      <div><textarea name="title" rows="1" cols="60"></textarea></div>
      <div><p><b>Your blog:</b></p></div>
      <div><textarea name="content" rows="10" cols="60"></textarea></div>
      <div><input type="submit" value="Post Blog" />
      	   <form method="link" action="BlogApp.jsp">
		   <input type="submit" value="Cancel">
		   </form></div>
    </form>
   </div>
  </body>
</html>