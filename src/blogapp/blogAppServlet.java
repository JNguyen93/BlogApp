package blogapp;

import static com.googlecode.objectify.ObjectifyService.ofy;
import blogapp.Blog;

import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;
 
import com.googlecode.objectify.ObjectifyService;

import java.io.IOException;
import java.util.Date;
 
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
 

public class blogAppServlet extends HttpServlet {
	
	static {
        ObjectifyService.register(Blog.class);
    }

    public void doPost(HttpServletRequest req, HttpServletResponse resp)
                throws IOException {
    	
        UserService userService = UserServiceFactory.getUserService();
        User user = userService.getCurrentUser();
 
        String title = req.getParameter("title");
        String content = req.getParameter("content");
        Date date = new Date();
        Blog blog = new Blog(user, title, content);
        blog.setUser(user);
        blog.setDate(date);
        blog.setTitle(title);
        blog.setContent(content);
        ofy().save().entity(blog).now();
        resp.sendRedirect("/BlogApp.jsp?");
    }
}