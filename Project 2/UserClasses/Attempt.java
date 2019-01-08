/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package UserClasses;
import Exceptions.InvalidGradeException;
import UNIV.Course;
/**
 *
 * @author Ajai Gill
 */
public class Attempt implements Comparable {
    
    private String courseStatus;
    private String courseGrade;
    private String semesterTaken;
    private String typeOfCourse;
    private Course course;
    
    public Attempt(Course course)
    {
        courseStatus = new String();
        setAttemptGrade("INC");
        semesterTaken = new String();
        this.course = course;
    }
    
    public Attempt()
    {
        courseStatus = new String();
        setAttemptGrade("INC");
        semesterTaken = new String();
        course = new Course();
    }
    
    @Override
    public boolean equals(Object obj)
    {
        
        if(obj instanceof Attempt)
        {
            Attempt c = (Attempt) obj;
            if(c.getCourseAttempted().getCourseCode().equals(getCourseAttempted().getCourseCode())
               && c.getSemesterTaken().equals(semesterTaken))
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
    
    
    public void setCourseStatus(String status)
    {
        courseStatus = status;
    }
    
    public String getCourseStatus()
    {
        return courseStatus;
    }
    
    public void setAttemptGrade(String grade) throws InvalidGradeException
    {
        courseGrade = grade;
        
        try
        {
            if(Integer.valueOf(grade) > 49)
            {
                setCourseStatus("Completed");
            }
            else
            {
                setCourseStatus("Failed");
            }
        }
        catch(NumberFormatException e)
        {
            switch (grade) {
                case "INC":
                case "MNR":
                    setCourseStatus("In Progress");
                    break;
                case "F":
                    setCourseStatus("Failed");
                    break;
                case "P":
                    setCourseStatus("Completed");
                    break;
                default:
                    throw new InvalidGradeException();
            }
        }
    }
    
    public String getAttemptGrade()
    {
        return courseGrade;
    }
    
    public void setSemesterTaken(String semester)
    {
        semesterTaken = semester;
    }
    
    public String getSemesterTaken()
    {
        return semesterTaken;
    }
    
    public void setCourseAttempted(Course course)
    {
        this.course = course;
    }
    
    public Course getCourseAttempted()
    {
        return course;
    }
    
    public String PlanPrint()
    {
        return getCourseAttempted().getCourseCode() + "-" + getCourseAttempted().getCourseCredit() + "-" + getSemesterTaken() + "-" + getCourseAttempted().getCoursePrereqString();
    }
    
    public String TranscriptPrint()
    {
        return getCourseAttempted().getCourseCode() + "-" + courseGrade + "-" + getCourseAttempted().getCourseCredit() + "-" + getSemesterTaken() + "-" + getCourseStatus() +"-"+ getCourseAttempted().getCoursePrereqString();
    }

    @Override
    public int compareTo(Object o) {
        String compareSem = ((Attempt)o).getSemesterTaken();
        
        if(semesterTaken.charAt(0) == 'W' && compareSem.charAt(0) == 'W' && semesterTaken.substring(1).equals(compareSem.substring(1)))
        {
            return 0;
        }
        else if(semesterTaken.charAt(0) == 'W' && compareSem.charAt(0) == 'W' && Integer.parseInt(semesterTaken.substring(1)) > Integer.parseInt(compareSem.substring(1)))
        {
            return 1;
        }
        else if(semesterTaken.charAt(0) == 'W' && compareSem.charAt(0) == 'W' && Integer.parseInt(semesterTaken.substring(1)) < Integer.parseInt(compareSem.substring(1)))
        {
            return -1;
        }
        else if(semesterTaken.charAt(0) == 'W' && compareSem.charAt(0) == 'F' && semesterTaken.substring(1).equals(compareSem.substring(1)))
        {
            return -1;
        }
        else if(semesterTaken.charAt(0) == 'W' && compareSem.charAt(0) == 'F' && Integer.parseInt(semesterTaken.substring(1)) > Integer.parseInt(compareSem.substring(1)))
        {
            return 1;
        }
        else if(semesterTaken.charAt(0) == 'W' && compareSem.charAt(0) == 'F' && Integer.parseInt(semesterTaken.substring(1)) < Integer.parseInt(compareSem.substring(1)))
        {
            return -1;
        }
        else if(semesterTaken.charAt(0) == 'F' && compareSem.charAt(0) == 'W' && semesterTaken.substring(1).equals(compareSem.substring(1)))
        {
            return 1;
        }
        else if(semesterTaken.charAt(0) == 'F' && compareSem.charAt(0) == 'W' && Integer.parseInt(semesterTaken.substring(1)) > Integer.parseInt(compareSem.substring(1)))
        {
            return 1;
        }
        else if(semesterTaken.charAt(0) == 'F' && compareSem.charAt(0) == 'W' && Integer.parseInt(semesterTaken.substring(1)) < Integer.parseInt(compareSem.substring(1)))
        {
            return -1;
        }
        else if(semesterTaken.charAt(0) == 'F' && compareSem.charAt(0) == 'F' && semesterTaken.substring(1).equals(compareSem.substring(1)))
        {
            return 0;
        }
        else if(semesterTaken.charAt(0) == 'F' && compareSem.charAt(0) == 'F' && Integer.parseInt(semesterTaken.substring(1)) > Integer.parseInt(compareSem.substring(1)))
        {
            return 1;
        }
        else
        {
            return -1;
        }
    }
}
