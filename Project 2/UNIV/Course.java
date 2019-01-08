package UNIV;

/**
 * Write a description of class Course here.
 *
 * @author Ajai Gill
 */

import java.util.ArrayList;
import java.io.Serializable;

public class Course implements Serializable
{
    private String courseCode;
    private String courseTitle;
    private String semesterTaken;
    private double courseCredit;
    private ArrayList<Course> coursePrerequisites;
    
   /**
     * Constructor that creates a deep copy of course.
     * 
     * @param course this is the course that is going to be copied
     */
    public Course(Course course)
    {
        if(course != null)
        {
            courseCode = course.getCourseCode();
            courseTitle = course.getCourseTitle();
            courseCredit = course.getCourseCredit();
            semesterTaken = course.getSemesterOffered();
            coursePrerequisites = new ArrayList<>();
        
            /*deep copy of the array list*/
            for(int i = 0; i < course.getPrerequisites().size(); i++)
            {
                coursePrerequisites.add(new Course(course.getPrerequisites().get(i)));
            }
        }
    }
    
   /**
     * Default constructor.
     */
    
    public Course()
    {
        courseCode = new String();
        courseTitle = new String();
        semesterTaken = new String();
        courseCredit = 0.0;
        coursePrerequisites = new ArrayList<>();
    }
    
    public Course(String cC, Double cCr, String cT, String sT, ArrayList<Course> cP)
    {
        courseCode = cC;
        courseTitle = cT;
        semesterTaken = sT;
        courseCredit = cCr;
        coursePrerequisites = cP;
    }
    
    public Course(String cC)
    {
        courseCode = cC;
        courseTitle = new String();
        semesterTaken = new String();
        courseCredit = 0.0;
        coursePrerequisites = new ArrayList<>();
    }
    
   /**
     * Overridden equals method that sees if the course is equal
     * on the basis that their course code and the semester that 
     * they were taken is the same.
     * 
     * @param obj this is the object that is being checked if it is equal.
     */
    public boolean equals(Object obj)
    {
        
        if(obj instanceof Course)
        {
            Course c = (Course) obj;
            if(c.getCourseCode().equals(courseCode))
            {
                return true;
            }
            else
            {
            return false;
            }
        }
        
        return false;
    }
    
    /** This is the overridden method of toString. It returns the course code the course title and the course credit.
     * 
     * @return String it returns the formatted string.
     */
    
    @Override
    public String toString()
    {
        return courseCode +","+ courseCredit +","+ courseTitle +","+ semesterTaken +",";
    }
    
    public String getCourseCode()
    {
        return courseCode;
    }
    
    protected void setCourseCode(String code)
    {
        courseCode = code;
    }
    
    public String getCourseTitle()
    {
        return courseTitle;
    }
    
    protected void setCourseTitle(String title)
    {
        courseTitle = title;
    }
    
    public double getCourseCredit()
    {
        return courseCredit;
    }
    
    protected void setCourseCredit(double credit)
    {
        courseCredit = credit;
    }
    
    public ArrayList<Course> getPrerequisites()
    {
        return coursePrerequisites;
    }
    
    protected void setPrerequisites(ArrayList<Course> preReqList)
    {
        coursePrerequisites = preReqList;
    }
    
    protected void setSemesterOffered(String semester)
    {
        semesterTaken = semester;
    }
    
    public String getSemesterOffered()
    {
        return semesterTaken;
    }
    
    /**
     * Converts the prerequisites into a string to be returned
     * @return String
     */
    public String getCoursePrereqString()
    {
        String line = new String();
        
        for(int i = 0; i < coursePrerequisites.size(); i++)
        {
            if(i == 0)
            {
                line += coursePrerequisites.get(i).getCourseCode();
            }
            else
            {
                line += ":" + coursePrerequisites.get(i).getCourseCode();
            }
        }
        
        return line;
    }
    
}
