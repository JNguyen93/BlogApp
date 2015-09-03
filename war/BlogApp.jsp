<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Collections" %>
<%@ page import="java.util.ListIterator" %>
<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>
<%@ page import="com.google.appengine.api.datastore.Query" %>
<%@ page import="com.google.appengine.api.datastore.Entity" %>
<%@ page import="com.google.appengine.api.datastore.FetchOptions" %>
<%@ page import="com.google.appengine.api.datastore.Key" %>
<%@ page import="com.google.appengine.api.datastore.KeyFactory" %>
<%@ page import="com.googlecode.objectify.*" %>
<%@ page import="com.googlecode.objectify.ObjectifyService" %>
<%@ page import="blogapp.Blog" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
 
<html>
 <head>
   <link type="text/css" rel="stylesheet" href="/stylesheets/main.css" />
   <title>Welcome to UTRecipe!</title>
 </head>
 
  <body>
 
<%
    String blogName = request.getParameter("blogName");
    if (blogName == null) {
        blogName = "default";
    }
    pageContext.setAttribute("blogName", blogName);
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

<h2>UTRecipes!</h2>
<p><sup>Check out these blogs from other students!</sup></p>

<img src="http://investorplace.com/wp-content/uploads/2013/09/steak.jpg" alt="Steak!">
<div><form action="/subscribe" method="post">
		<div><textarea name="address" rows="1" cols="30"></textarea></div>
      	<div><input type="submit" value="Subscribe!"/></div>
	</form>
	<form action="/subscribe" method="get">
		<div><textarea name="address" rows="1" cols="30"></textarea></div>
      	<div><input type="submit" value="Unsubscribe"/></div>
	</form>
</div>

<%
    
	ObjectifyService.register(Blog.class);
	List<Blog> blogs = ObjectifyService.ofy().load().type(Blog.class).list();   
	Collections.sort(blogs);
    if (blogs.isEmpty()) {
        %>
        <p>There are no blogs.</p>
        <%
    } else {
    		ListIterator<Blog> it = blogs.listIterator(blogs.size());
    		int b = blogs.size();
    		if(b > 3)
    			b = 3;
        for (; b > 0; b--) {
        	Blog blog = (Blog) it.previous();
            pageContext.setAttribute("blog_content",
                                     blog.getContent());
            pageContext.setAttribute("blog_user",
                                     blog.getUser());
            pageContext.setAttribute("blog_date",
            						 blog.getDate());
            pageContext.setAttribute("blog_title",
            						 blog.getTitle());
            %>
            <h3>${fn:escapeXml(blog_title)}</h3>
            <p>by: ${fn:escapeXml(blog_user.nickname)}</p>
            <p><sub>${fn:escapeXml(blog_date)}</sub></p>
            <blockquote>${fn:escapeXml(blog_content)}</blockquote>
            <%
        }
    }
%>

	<form method="link" action="list.jsp">
	<input type="submit" value="View the rest here!">
	</form>
	<%
		if(user != null){
		%>
		<form method="link" action="create.jsp">
		<input type="submit" value="Create your own!">
		</form>
		<%
		} else{
			%>
			<h4>
			<a href="<%= userService.createLoginURL(request.getRequestURI()) %>">Log in</a>
			to write your own blog!</h4>
			<%
			}
		%>
  </body>
</html>
 