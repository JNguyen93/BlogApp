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
</div>

<div id="main">
<h2>UTRecipes!</h2>
<p><sup>Check out these blogs from other students!</sup></p>

<%
    
	ObjectifyService.register(Blog.class);
	List<Blog> blogs = ObjectifyService.ofy().load().type(Blog.class).list();   
	Collections.sort(blogs);
    if (blogs.isEmpty()) {
        %>
        <p>There are no blogs.</p>
        <%
    } else {
        for (ListIterator<Blog> i = blogs.listIterator(blogs.size()); i.hasPrevious();) {
        	Blog blog = (Blog) i.previous();
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
	<%
		%>
		<form method="link" action="BlogApp.jsp">
		<input type="submit" value="Back to Home">
		</form>
		
   </div>
  </body>
</html>
 