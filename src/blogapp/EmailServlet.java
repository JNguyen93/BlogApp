package blogapp;

import java.io.IOException;
import java.util.Collections;
import java.util.List;
import java.util.ListIterator;
import java.util.Properties;
import java.util.logging.Logger;

import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.googlecode.objectify.ObjectifyService;

import blogapp.EmailServlet;
import static com.googlecode.objectify.ObjectifyService.ofy;
import blogapp.Global;

public class EmailServlet extends HttpServlet {
	public static final Logger _log = Logger.getLogger(EmailServlet.class.getName());
	
	static {
        ObjectifyService.register(Email.class);
    }
	
	public void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {
		doPost(req,resp);
	}
	
	public void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {
		ObjectifyService.register(Blog.class);
		List<Blog> blogs = ObjectifyService.ofy().load().type(Blog.class).list();   
		Collections.sort(blogs);
		
		ObjectifyService.register(Email.class);
		List<Email> emails = ObjectifyService.ofy().load().type(Email.class).list();   
		Collections.sort(emails);
		
		int counter = blogs.size();
		String message = "";
		if(counter > Global.count){
			int num = counter - Global.count;
			Global.count = counter;
			
			ListIterator<Blog> it = blogs.listIterator(blogs.size());
			for(;num > 0; num--){
				Blog blog = (Blog) it.previous();
				message += blog.getTitle() +" "+ blog.getContent() + "\n";
			}
			
			try{
				Properties props = new Properties();
				Session session = Session.getDefaultInstance(props, null);
				MimeMessage outMessage = new MimeMessage(session);
				outMessage.setFrom(new InternetAddress("admin@utrecipeapp.appspotmail.com"));
				outMessage.setSubject("Your UTRecipe Subscription!");
				outMessage.setText(message);
				for(Email email: emails){
					outMessage.addRecipient(MimeMessage.RecipientType.BCC,
							new InternetAddress(email.address));
					}
				Transport.send(outMessage);
				
				// DEBUGGING - DISPLAYING EMAIL IN LOG
							_log.info(message);
				}

				catch(MessagingException e){
					_log.info("ERROR: Could not send out Email Results response : " 
																+ e.getMessage());
			}
		}
	}

}
