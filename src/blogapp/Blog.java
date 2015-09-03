package blogapp;

import java.util.Date;

import com.google.appengine.api.users.User;
import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;

@Entity
public class Blog implements Comparable<Blog> {
    @Id Long id;
    User user;
    String title;
    String content;
    Date date;
    
    private Blog() {}
    
    public Blog(User user, String title, String content) {
        this.user = user;
        this.title = title;
        this.content = content;
        date = new Date();
    }
    public User getUser() {
        return user;
    }
    public String getTitle(){
    	return title;
    }
    public void setTitle(String title){
    	this.title = title;
    }
    public String getContent() {
        return content;
    }
    public void setUser(User user){
    	this.user = user;
    }
    public void setContent(String content){
    	this.content = content;
    }
    public Date getDate(){
    	return date;
    }
    public void setDate(Date date){
    	this.date = date;
    }
    @Override
    public int compareTo(Blog other) {
        if (date.after(other.date)) {
            return 1;
        } else if (date.before(other.date)) {
            return -1;
        }
        return 0;
    }
}