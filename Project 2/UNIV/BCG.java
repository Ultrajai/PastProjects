package UNIV;

/**
 * Write a description of class BCG here.
 *
 * @author Ajai Gill
 */
 
import UserClasses.Student;
import UserClasses.Attempt;
import java.util.ArrayList;
import java.io.ObjectOutputStream;
import java.io.FileOutputStream;
import java.io.Serializable;

public class BCG extends GeneralDegree implements Serializable
{
    
    private enum SCIENCE
    {
        BIOL, MATH, ECON, BIOM, ECOL, FOOD, PHYS, CHEM, ZOO, STAT
    }
    
    private static final double TOTALCREDITS = 15.0;
    private static final double ATLEASTLEVELTHREE = 4.0;
    private static final double ATMOSTLEVELONE = 6.0;
    private static final double SCIENCECREDSTOTAL = 2.0;
    private static final double ARTCREDSTOTAL = 2.0;
    
    private double artCreds;
    private double sciCreds;
    private String majorTitle;
    private String requiredCourses;
    
    
    /**
     * This is the constructor of the BCG class. It initializes the catalog to be used
     * , the major's title, the art credits earned and the science credits earned.
     * 
     * @param courses this is the catalog to be copied.
     */
    
    public BCG(CourseCatalog courses)
    {
        super(courses);
        artCreds = 0.0;
        sciCreds = 0.0;
        majorTitle = "BCG";
        requiredCourses = "CIS*1500,CIS*1910,CIS*2430,CIS*2500,CIS*2520,CIS*2750,CIS*2910,CIS*3530";
        setRequiredCourses(requiredCourses);
    }
    
    /**
     * The is the overridden equals method. checks if the object is an instance of the CS class.
     * 
     * @param obj this is the object that is being compared
     * @return boolean this returns true if is an instance and false if it isn't
     */
    @Override
    public boolean equals(Object obj)
    {
        if(obj instanceof BCG)
        {
            return true;
        }
        return false;
    }
    
    /**
     * This is the overridden toString method. it returns the major's title an the degree title.
     * 
     * @return String this returns the formatted string.
     */
    @Override
    public String toString()
    {
        return majorTitle +", "+ getDegreeTitle();
    }
    
    /**
     * This method checks if the plan of study meets the requirements for the major.
     * 
     * @param thePlan the plan of study to reference to.
     */
    public boolean meetsRequirements(Student thePlan)
    {
        
        amountOfScienceAndArtCreds(thePlan);

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
        else if(amountOfLevelOneCreditsEarned(thePlan) > ATMOSTLEVELONE)
        {
            System.out.println("You have too many level one courses!");
            return false;
        }
        else if(amountOfLevelThreeCreditsEarned(thePlan) < ATLEASTLEVELTHREE)
        {
            System.out.println("You have too little level three courses!");
            return false;
        }
        else if(artCreds < ARTCREDSTOTAL)
        {
            System.out.println("Not enough arts credits!");
            return false;
        }
        else if(sciCreds < SCIENCECREDSTOTAL)
        {
            System.out.println("Not enough science credits!");
            return false;
        }
        else if(!additionalCisOrStatCreds(thePlan))
        {
            System.out.println("You didn't take an additional CIS or STAT course!");
            return false;
        }
        else
        {
            return true;
        }

    }
    
    /**
     * This is a helper method that checks if it meets the cis and/or stats requirment.
     * 
     * @param thePlan the plan of study to reference to.
     * @return boolean returns true if the additional credit was earned and false if it wasn't.
     */
    private boolean additionalCisOrStatCreds(Student thePlan)
    {
        boolean contains = false;
        ArrayList<Attempt> courseList = thePlan.getTranscriptCourseList();
        
        for(int i = 0; i < courseList.size(); i++)
        {
            contains = false;
            
            if(courseList.get(i).getCourseAttempted().getCourseCode().split("\\*")[1].indexOf('2') == 0 &&
               courseList.get(i).getCourseStatus().equals("Completed") &&
               (courseList.get(i).getCourseAttempted().getCourseCode().split("\\*")[0].equals("CIS") ||
               courseList.get(i).getCourseAttempted().getCourseCode().split("\\*")[0].equals("STAT"))) 
            {
                for(int j = 0; j < getRequiredCourses().size(); j++)
                {
                    if(getRequiredCourses().get(j).getCourseCode().equals(courseList.get(i).getCourseAttempted().getCourseCode()))
                    {
                        contains = true;
                    }
                }
                
                if(!contains)
                {
                    return true;
                }
   
            }
        }
        
        return false;
    }
    
    /**
     * This is a helper method that calculates the amount of level 1 credits are earned.
     * 
     * @param thePlan the plan of study to reference to.
     * @return double returns the amount of credits earned under the criterias
     */
    private double amountOfLevelOneCreditsEarned(Student thePlan)
    {
        double creditsEarned = 0.0;
        ArrayList<Attempt> courseList = thePlan.getTranscriptCourseList();
        
        for(int i = 0; i < courseList.size(); i++)
        {
            if(courseList.get(i).getCourseAttempted().getCourseCode().split("\\*")[1].indexOf('1') == 0 &&
               courseList.get(i).getCourseStatus().equals("Completed")) 
            {
                creditsEarned += courseList.get(i).getCourseAttempted().getCourseCredit();    
            }
        }
        
        return creditsEarned;
    }
    /**
     * This is a helper method that calculates the amount of level 3 credits are earned.
     * 
     * @param thePlan the plan of study to reference to.
     * @return double returns the amount of credits earned under the criterias
     */
    private double amountOfLevelThreeCreditsEarned(Student thePlan)
    {
        double creditsEarned = 0.0;
        ArrayList<Attempt> courseList = thePlan.getTranscriptCourseList();
        
        for(int i = 0; i < courseList.size(); i++)
        {
            if(courseList.get(i).getCourseAttempted().getCourseCode().split("\\*")[1].indexOf('3') == 0 &&
               courseList.get(i).getCourseStatus().equals("Completed")) 
            {
                creditsEarned += courseList.get(i).getCourseAttempted().getCourseCredit();    
            }
        }
        
        return creditsEarned;
    }
    
    /**
     * This is a helper method that calculates the amount of arts and science credits are earned.
     * 
     * @param thePlan the plan of study to reference to.
     */
    private void amountOfScienceAndArtCreds(Student thePlan)
    {
        SCIENCE theCourse = null;
        ArrayList<Attempt> courseList = thePlan.getTranscriptCourseList();
        
        artCreds = 0.0;
        sciCreds = 0.0;
        
        for(int i = 0; i < courseList.size(); i++)
        {
            try
            {
               if(courseList.get(i).getCourseStatus().equals("Completed"))
               {
                   theCourse = SCIENCE.valueOf(courseList.get(i).getCourseAttempted().getCourseCode().split("\\*")[0]);
                   sciCreds += courseList.get(i).getCourseAttempted().getCourseCredit();
               }

            }
            catch(Exception e)
            {
                if(!courseList.get(i).getCourseAttempted().getCourseCode().split("\\*")[0].equals("CIS") &&
                   courseList.get(i).getCourseStatus().equals("Completed"))
                {
                    artCreds += courseList.get(i).getCourseAttempted().getCourseCredit();
                }
            }
        }
        
    }
    
    /**
     * This method calculates and returns the remaining course credits left.
     * 
     * @return double this returns number of credits left.
     */
    @Override
    public double numberOfCreditsRemaining(Student thePlan)
    {
        return TOTALCREDITS - thePlan.amountOfCreditsEarned();
    }
    
    /**
     * This method save the state of the major and degree.
     */
    @Override
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
