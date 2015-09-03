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
<%@ page import="blogapp.Global" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
 
<html>
 <head>
   <link type="text/css" rel="stylesheet" href="/stylesheets/main.css" />
   <title>Welcome to UTRecipe!</title>
 </head>
 
  <body>
	<%
	Global.reset();
	%>
  </body>
</html>
 