package UNIV;

/**
 * Write a description of class CS here.
 *
 * @author Ajai Gill
 */
 
import UserClasses.Student;
import UserClasses.Attempt;
import java.util.ArrayList;
import java.io.ObjectOutputStream;
import java.io.FileOutputStream;
import java.io.Serializable;
 
public class CS extends HonoursDegree implements Serializable
{
    
    private static final double TOTALCREDITS = 20.0;
    private static final double AREAOFAPPLICATION = 8.25;
    private static final double CISLEVELTHREEORABOVEEXTRA = 1.5;
    private static final double CISLEVELFOUREXTRA = 1.5;
    
    private String majorTitle;
    private String requiredCourses;
    
    /**
     * This is the constructor of the CS class. It initializes the catalog to be used
     * and the major's title.
     * 
     * @param courses this is the catalog to be copied.
     */
    public CS(CourseCatalog courses) throws NullPointerException
    {
        super(courses);
        System.out.println("SETTING UP CS");
        majorTitle = "CS";
        requiredCourses = "CIS*1500,MATH*1200,CIS*1910,CIS*2500,CIS*2030,CIS*2430,CIS*2520,CIS*2910,CIS*2750,CIS*3110,CIS*3490,CIS*3150,CIS*3750,STAT*2040,CIS*3760,CIS*4650";
        setRequiredCourses(requiredCourses);
    }
    
    
    /**
     * The is the overidden equals method. checks if the object is an instace of the CS class.
     * 
     * @param obj this is the object that is being compared
     * @return boolean this returns true if is an instance and false if it isn't
     */
    public boolean equals(Object obj)
    {
        if(obj instanceof CS)
        {
            return true;
        }
        return false;
    }
    
    /**
     * This is the overidden toString method. it returns the major's title an the degree title.
     * 
     * @return String this returns the formatted string.
     */
    public String toString()
    {
        return majorTitle +", "+ getDegreeTitle();
    }
    
    public String getMajorTitle()
    {
        return majorTitle;
    }
    
    /**
     * This method checks if the plan of study meets the requirements for the major.
     * 
     * @param thePlan the plan of study to reference to.
     * @return boolean
     */
    public boolean meetsRequirements(Student thePlan)
    {
        if(!remainingRequiredCoursesTranscript(thePlan).isEmpty())
        {
            System.out.println("Didn't complete all required courses!");
            return false;
        }
        else if(thePlan.amountOfCreditsEarned() < TOTALCREDITS)
        {
            System.out.println("Not enough credits!");
            return false;
        }
        else if(!completedExtraCredits(thePlan))
        {
            System.out.println("have not fulfilled the elective credit requirements!");
            return false;
        }
        return true;
    }
    
    /**
     * This is a helper method that checks for the extra courses that are required for the degree.
     * 
     * @param thePlan the plan of study to reference to
     * @return boolean returns true if all requirements are met or false if not.
     */
    public boolean completedExtraCredits(Student thePlan)
    {
        double totalLevelThreeOrAbove = 0.0;
        double totalLevelFour = 0.0;
        double totalAreaOfApplication = 0.0;
        ArrayList<Attempt> courseList = thePlan.getTranscriptCourseList();
        
        for(int i = 0; i < courseList.size(); i++)
        {
            
            if(totalLevelThreeOrAbove < CISLEVELTHREEORABOVEEXTRA &&
               (courseList.get(i).getCourseAttempted().getCourseCode().split("\\*")[1].indexOf('3') == 0 ||
               courseList.get(i).getCourseAttempted().getCourseCode().split("\\*")[1].indexOf('4') == 0) &&
               courseList.get(i).getCourseAttempted().getCourseCode().split("\\*")[0].equals("CIS") &&
               !contains(courseList.get(i))) 
            {         
                totalLevelThreeOrAbove += courseList.get(i).getCourseAttempted().getCourseCredit();
                totalAreaOfApplication += courseList.get(i).getCourseAttempted().getCourseCredit();
            }
            else if(totalLevelFour < CISLEVELFOUREXTRA &&
                    courseList.get(i).getCourseAttempted().getCourseCode().split("\\*")[1].indexOf('4') == 0 &&
                    courseList.get(i).getCourseAttempted().getCourseCode().split("\\*")[0].equals("CIS") &&
                    !contains(courseList.get(i)))
            {
                totalLevelFour += courseList.get(i).getCourseAttempted().getCourseCredit();
                totalAreaOfApplication += courseList.get(i).getCourseAttempted().getCourseCredit();
            }
            else if(totalAreaOfApplication < AREAOFAPPLICATION &&
                    !contains(courseList.get(i)))
            {
                totalAreaOfApplication += courseList.get(i).getCourseAttempted().getCourseCredit();
            }
        }
        
        if(totalAreaOfApplication >= AREAOFAPPLICATION && totalLevelFour >= CISLEVELFOUREXTRA && totalLevelThreeOrAbove >= CISLEVELTHREEORABOVEEXTRA)
        {
            return true;
        }
        else
        {
            return false;
        }
    }
    
    /**
     * This is a helper method that checks the course to compare is contained in the required courses list.
     * 
     * @param toCompare the course to check.
     * @return boolean returns true or false
     */
    public boolean contains(Attempt toCompare)
    {
        boolean contain = false;
        
        for(int j = 0; j < getRequiredCourses().size(); j++)
        {
            if(getRequiredCourses().get(j).getCourseCode().equals(toCompare.getCourseAttempted().getCourseCode()))
            {
                contain = true;
            }
        }
        
        return contain;
    }
    
    /**
     * This method calculates and returns the remaining course credits left.
     * 
     * @return double this returns number of credits left.
     */
    
    public double numberOfCreditsRemaining(Student thePlan)
    {
        return TOTALCREDITS - thePlan.amountOfCreditsEarned();
    }
    
    /**
     * This method save the state of the major and degree.
     * 
     */
    
    protected void saveDegree()
    {
        try
        {
            ObjectOutputStream degreeSave = new ObjectOutputStream(new FileOutputStream(majorTitle + "Save.sav"));
            degreeSave.writeObject(this);
            degreeSave.close();
        }
        catch(Exception e)
        {
           System.out.println(e);
        }
    }
    
}
