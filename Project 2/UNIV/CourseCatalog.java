package UNIV;



/**
 * Write a description of class CourseCataloge here.
 *
 * @author Ajai Gill
 */

import Database.DBDetails;
import Database.MyConnection;
import java.util.ArrayList;
import java.io.Serializable;

public class CourseCatalog implements Serializable
{
    
    MyConnection c;
    
 /**
   * This constructor sets up the connection to the database
   */
  
    public CourseCatalog()
    {
        this.c = new MyConnection(DBDetails.username, DBDetails.password);
    }
    
 /**
   * This constructor sets up the connection to the database
   */
    public CourseCatalog(MyConnection c)
    {
        this.c = c;
    }
    
   /** This is the overridden method of toString. It doesn't do anything
     * because there is no functionality of this method that would make sense.
     * 
     * @return String it returns an empty string.
     */
    
    @Override
    public String toString()
    {
        return "";
    }
    
   /** This is the overridden method of equals. It compares the instance of the object
     * then the course lists items
     * 
     * @param obj this is the object that we are comparing with this object.
     * @return boolean it returns true if it the objects are the same and false if it isn't
     * based on the criteria above.
     */
    
    public boolean equals(Object obj)
    {
        return false;
    }
    
    
 /**
   * This method is used to add courses to the database
   * 
   * @param toAdd This is a Course instance that will be added to the database
   */
    protected void addCourse(Course toAdd) throws NullPointerException
    {
        String prereq = new String();
        
        for(int i = 0; i < toAdd.getPrerequisites().size(); i++)
        {
            if(i == 0)
            {
                prereq += toAdd.getPrerequisites().get(i).getCourseCode();
            }
            else
            {
                prereq += ":" + toAdd.getPrerequisites().get(i).getCourseCode();
            }
        }
        
        try
        {
            Course findCourse = findCourse(toAdd.getCourseCode());
        }
        catch(NullPointerException e)
        {
            c.addCourse(toAdd.getCourseCode(), Double.toString(toAdd.getCourseCredit()), toAdd.getCourseTitle(), toAdd.getSemesterOffered(), prereq);
        }
        
    }
    
    
 /**
   * This method is used to remove courses from the ArrayList courses
   * 
   * @param toRemove This is a Course instance that will be removed from the ArrayList
   */
    protected void removeCourse(Course toRemove) throws NullPointerException
    {
        c.deleteCourse(toRemove.getCourseCode());
    }
    
 /**
   * This method is used to find courses that are in the database
   * 
   * @param courseCode this is the string used to search for the correct course in
   * the database.
   * @return Course - This returns null if it cannot find the course or the course if
   * it was found.
   */
    public Course findCourse(String courseCode) throws NullPointerException
    {
        String courseInfo = c.findCourse(courseCode);
        Course course = new Course();
        ArrayList<Course> prereqList = new ArrayList<>();
        
        if(courseInfo == null)
        {
            throw new NullPointerException();
        }
        
        if(!courseInfo.split(",", -1)[0].isEmpty())
            course.setCourseCode(courseInfo.split(",", -1)[0]);

        if(!courseInfo.split(",", -1)[1].isEmpty())
            course.setCourseCredit(Double.parseDouble(courseInfo.split(",", -1)[1]));

        if(!courseInfo.split(",", -1)[2].isEmpty())    
            course.setCourseTitle(courseInfo.split(",", -1)[2]);

        if(!courseInfo.split(",", -1)[3].isEmpty())    
            course.setSemesterOffered(courseInfo.split(",", -1)[3]);

        if(courseInfo.split(",", -1).length == 5 && !courseInfo.split(",", -1)[4].isEmpty())
        {
            for(int i = 0; i < courseInfo.split(",", -1)[4].split(":", -1).length; i++)
            {
               prereqList.add(findCourse(courseInfo.split(",", -1)[4].split(":", -1)[i]));
            }

            course.setPrerequisites(prereqList);
        }

        return course;
    }
   
    
}
