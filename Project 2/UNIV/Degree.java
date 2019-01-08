package UNIV;

/**
 * Abstract class Degree - write a description of the class here
 *
 * @author Ajai Gill
 */

import UserClasses.Student;
import java.util.ArrayList;
import java.io.Serializable;

public abstract class Degree implements Serializable
{
    private ArrayList<Course> requiredCourses;
    private CourseCatalog catalog;
    
    /**
     * This is the constructor of the abstract degree class. It initializes the catalog to be used
     * and the required courses list
     * 
     * @param courses this is the catalog to be copied.
     */
    public Degree(CourseCatalog courses)
    {
        requiredCourses = new ArrayList<>();
        catalog = courses;
    }
    
    /**
     * Sets the required courses for the degree/major.
     * 
     * @param listOfRequiredCourseCodes this is the list of course codes used to set up the required courses.
     */
    
    protected void setRequiredCourses(String listOfRequiredCourseCodes) throws NullPointerException
    {   
        for(int i = 0; i < listOfRequiredCourseCodes.split(",").length; i++)
        {
            requiredCourses.add(catalog.findCourse(listOfRequiredCourseCodes.split(",")[i]));
        }
    }
    
   /**
     * Getter for the required courses for the degree/major.
     * 
     * @return ArrayList of Courses
     */
    public ArrayList<Course> getRequiredCourses()
    {
        return requiredCourses;
    }
    
   /**
     * method that finds the remaining required courses in the transcript
     * @param thePlan the plan from the student
     * @return ArrayList of Courses
     */
    public ArrayList<Course> remainingRequiredCoursesTranscript(Student thePlan)
    {
        ArrayList<Course> coursesRemaining = new ArrayList<>();
        
        for(int i = 0; i < requiredCourses.size(); i++)
        {
            if(thePlan.getCourse(requiredCourses.get(i).getCourseCode(), thePlan.getTranscriptCourseList()) == null ||
               !thePlan.getCourse(requiredCourses.get(i).getCourseCode(), thePlan.getTranscriptCourseList()).getCourseStatus().equals("Completed"))
            {
                coursesRemaining.add(requiredCourses.get(i));
            }
        }
        
       return coursesRemaining;
    }
    
    /**
     * method that finds the remaining required courses in both the transcript and the plan
     * @param thePlan the plan from the student
     * @return ArrayList of Courses
     */
    public ArrayList<Course> remainingRequiredCoursesTranscriptAndPlan(Student thePlan)
    {
        ArrayList<Course> coursesRemaining = new ArrayList<>();
        
        for(int i = 0; i < requiredCourses.size(); i++)
        {
            if(thePlan.getCourse(requiredCourses.get(i).getCourseCode(), thePlan.getTranscriptCourseList()) == null &&
               thePlan.getCourse(requiredCourses.get(i).getCourseCode(), thePlan.getPlannedCourseList()) == null)
            {
                coursesRemaining.add(requiredCourses.get(i));
            }
        }
        
       return coursesRemaining;
    }
    
    abstract protected void saveDegree();
    abstract public boolean meetsRequirements(Student thePlan);
    abstract public double numberOfCreditsRemaining(Student thePlan);
}
