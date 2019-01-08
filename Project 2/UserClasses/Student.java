package UserClasses;
import Exceptions.CannotAddCourseException;
import java.util.ArrayList;
import java.io.Serializable;
import UNIV.CourseCatalog;
import UNIV.Degree;
import UNIV.BCG;
import UNIV.CS;
import UNIV.Course;

/**
 * Write a description of class Student here.
 *
 * @author Ajai Gill
 */
public class Student implements Serializable
{
    private String firstName;
    private String lastName;
    private int studentNumber;
    private ArrayList<Attempt> transcript;
    private ArrayList<Attempt> plan;
    private Degree degree;
    private String degName;
    private CourseCatalog catalog;
    
    
    /*
     * the constructors..
     */
    public Student()
    {
        firstName = new String();
        lastName = new String();
        studentNumber = 0;
        transcript = new ArrayList();
        plan = new ArrayList();
        degree = null;
        degName = new String();
        catalog = null;
    }
    
    public Student(String fName, String lName, String studentNum, String deg, CourseCatalog cat)
    {
        firstName = fName;
        lastName = lName;
        studentNumber = Integer.parseInt(studentNum);
        transcript = new ArrayList();
        plan = new ArrayList();
        catalog = cat;
        setDegreeProgram(deg);
    }
    
    public Student(CourseCatalog cat)
    {
        firstName = new String();
        lastName = new String();
        studentNumber = 0;
        transcript = new ArrayList();
        plan = new ArrayList();
        degree = null;
        degName = new String();
        catalog = cat;
    }
    
   /** This is the overridden method of toString. It returns the first name, last name, and the student number
     * 
     * @return String it returns an empty string.
     */
    
    @Override
    public String toString()
    {
        return firstName + " " + lastName + " " + studentNumber;
    }
    
   /**
     * Overridden equals method that sees if the student is equal
     * on the basis that their full names and student numbers are the same.
     * 
     * @param obj this is the object that is being checked if it is equal.
	 * @return boolean returns true if the equal and false if not equal
     */
    
    @Override
    public boolean equals(Object obj)
    {
        if(obj instanceof Student)
        {
            Student student = (Student) obj;
            
            if(student.getFullName().equals(getFullName()) &&
               student.getStudentNumber() == studentNumber)
            {
                return true;
            }
        
            return false;
        }
        
        return false;
    }
    
    public String getFullName()
    {
        return firstName + lastName;
    }
        
    public void setFirstName(String first)
    {
        firstName = first;
    }
    
    public void setLastName(String last)
    {
        lastName = last;
    }
    
    public String getFirstName()
    {
        return firstName;
    }
    
    public String getLastName()
    {
        return lastName;
    }
    
    public void setStudentNumber(int studentNum)
    {
        studentNumber = studentNum;
    }
    
    public int getStudentNumber()
    {
        return studentNumber;
    }
    
    /**
     * Sets the degree program of the student
     * @param deg the degree name
     */
    public void setDegreeProgram(String deg) throws NullPointerException
    {
        degName = deg;
        
        if(deg.equals("Bachelors of Computing General"))
        {
            degree = new BCG(catalog);
        }
        else
        {
            degree = new CS(catalog);
        }
    }
    
    public Degree getDegreeProgram()
    {
        return degree;
    }
    
    public String getDegreeProgramName()
    {
        return degName;
    }
    
    public void loadCatalog(CourseCatalog cat)
    {
        catalog = cat;
    }
    
    /**
     *  creates the string arraylist so that the courses can be saved into the database
     * @return Arraylist of Strings
     */
    public ArrayList<String> savePlanAndTranscript()
    {
        ArrayList<String> planAndTranscript = new ArrayList<>();
        
        for(Attempt course: plan)
        {
            planAndTranscript.add(course.getCourseAttempted().getCourseCode() +","+ course.getSemesterTaken());
        }
        
        planAndTranscript.add("NEXT LIST");
        
        for(Attempt course: transcript)
        {
            planAndTranscript.add(course.getCourseAttempted().getCourseCode() +","+ course.getSemesterTaken() +","+ course.getAttemptGrade());
        }
        
        return planAndTranscript;
    }
    
    
    /**
     * Loads the plan and transcript from the string array provided by the database
     * @param planAndTranscript the string array
     */
    public void loadPlanAndTranscript(ArrayList<String> planAndTranscript)
    {
        boolean reachedOtherList = false;
        
        for(String line: planAndTranscript)
        {
            if(line.equals("NEXT LIST"))
            {
                reachedOtherList = true;
            }
            else if(!reachedOtherList)
            {
                Attempt toAdd = new Attempt(new Course(catalog.findCourse(line.split(",", -1)[0])));
                toAdd.setSemesterTaken(line.split(",", -1)[1]);
                plan.add(toAdd);
            }
            else
            {
                Attempt toAdd = new Attempt(new Course(catalog.findCourse(line.split(",", -1)[0])));
                toAdd.setSemesterTaken(line.split(",", -1)[1]);
                toAdd.setAttemptGrade(line.split(",", -1)[2]);
                transcript.add(toAdd);
            }
        }
    }
    
    /**
     * copies course from plan to the transcript
     * @param toAdd
     * @throws Exceptions.CannotAddCourseException
     */
    public void transferToTranscript(Attempt toAdd) throws CannotAddCourseException
    {
        if(!existInArray(toAdd, transcript) && !atSemesterCreditLimit(toAdd, transcript) && completedPrereqs(toAdd, transcript))
        {
            transcript.add(toAdd);
        }
        else
        {
            throw new CannotAddCourseException();
        } 
    }
    
    /**
     * adds a course to the plan based on course code and semester
     * @param courseCode
     * @param semester
     * @throws Exceptions.CannotAddCourseException
     */
    public void addCourseToPlan(String courseCode, String semester) throws CannotAddCourseException
    {
        Attempt toAdd = new Attempt(catalog.findCourse(courseCode));
        toAdd.setSemesterTaken(semester);
        
        if(!existInArray(toAdd, plan) && !atSemesterCreditLimit(toAdd, plan))
        {
            plan.add(toAdd);
        }
        else
        {
            throw new CannotAddCourseException();
        }
    }
    
    public boolean completedPrereqs(Attempt toAdd, ArrayList<Attempt> courseList)
    {
        int amountOfPrereqsDone = 0;
        
        for(int i = 0; i < courseList.size(); i++)
        {
            for(int j = 0; j < toAdd.getCourseAttempted().getPrerequisites().size(); j++)
            {
                if(courseList.get(i).getCourseAttempted().getCourseCode().equals(toAdd.getCourseAttempted().getPrerequisites().get(j).getCourseCode()) &&
                   courseList.get(i).getCourseStatus().equals("Completed"))
                {
                    amountOfPrereqsDone++;
                }
            }
        }

        if(amountOfPrereqsDone < toAdd.getCourseAttempted().getPrerequisites().size())
        {
            System.out.println("Didn't complete all prerequisites!");
            return false;
        }
        else
        {
            return true;
        }
    }
    
    public ArrayList<Course> PrereqsLeft()
    {
        ArrayList<Course> pLeft = new ArrayList<>();
        
        for(int i = 0; i < plan.size(); i++)
        {
            for(int j = 0; j < plan.get(i).getCourseAttempted().getPrerequisites().size(); j++)
            {
               System.out.println(plan.get(i).getCourseAttempted().getPrerequisites().get(j).getCourseCode());
                
               if(getCourse(plan.get(i).getCourseAttempted().getPrerequisites().get(j).getCourseCode(), plan) == null)
               {
                    pLeft.add(plan.get(i).getCourseAttempted().getPrerequisites().get(j));
               }
            }
        }
        
        return pLeft;
    }
    
    public boolean atSemesterCreditLimit(Attempt toAdd, ArrayList<Attempt> courseList)
    {
        double amount = 0;
        
        for(int i = 0; i < courseList.size(); i++)
        {
            if(courseList.get(i).getSemesterTaken().equals(toAdd.getSemesterTaken()))
            {
               amount += courseList.get(i).getCourseAttempted().getCourseCredit(); 
            }
            
        }
        
        if((amount + toAdd.getCourseAttempted().getCourseCredit()) > 2.5)
        {
            System.out.println("Cannot add course because there are too many courses in that semester!");
            return true;
        }
        else
        {
            return false;
        }
    }
    
    public boolean existInArray(Attempt toAdd, ArrayList<Attempt> courseList)
    {
        if(getCourse(toAdd.getCourseAttempted().getCourseCode(), toAdd.getSemesterTaken(), courseList) != null)
        {
            System.out.println("You already have that course in that semester!");
            return true;
        }

        return false;
    }
    
    public double amountOfCreditsEarned()
    {
        double creditsEarned = 0.0;
        
        for(int i = 0; i < transcript.size(); i++)
        {
            if(transcript.get(i).getCourseStatus().equals("Completed"))
            {
                creditsEarned += transcript.get(i).getCourseAttempted().getCourseCredit();
            }
        }
        
        return creditsEarned;
    }
    
    public void removeCourse(String courseCode, String semester, ArrayList<Attempt> courseList)
    {
        courseList.remove(getCourse(courseCode, semester, courseList));
    }
    
    public void setCourseStatus(String courseCode, String semester, String courseStatus, ArrayList<Attempt> courseList)
    {
        getCourse(courseCode, semester, courseList).setCourseStatus(courseStatus);
    }
    
    public void setCourseGrade(String courseCode, String semester, String grade, ArrayList<Attempt> courseList)
    {
        getCourse(courseCode, semester, courseList).setAttemptGrade(grade);
    }
    
    public Attempt getCourse(String courseCode, String semester, ArrayList<Attempt> courseList) throws NullPointerException
    {
        for(int i = 0; i < courseList.size(); i++)
        {
            if(courseList.get(i).getCourseAttempted().getCourseCode().equals(courseCode) && 
            courseList.get(i).getSemesterTaken().equals(semester))
            {
                return courseList.get(i);
            }
        }
        return null;
    }
    
    public Attempt getCourse(String courseCode, ArrayList<Attempt> courseList) throws NullPointerException
    {
        for(int i = 0; i < courseList.size(); i++)
        {
            if(courseList.get(i).getCourseAttempted().getCourseCode().equals(courseCode))
            {
                return courseList.get(i);
            }
        }
        return null;
    }
    
    public ArrayList<Attempt> getPlannedCourseList()
    {
        return plan;
    }
    
    public ArrayList<Attempt> getTranscriptCourseList()
    {
        return transcript;
    }
    
    public double overallGPA() throws ArithmeticException 
    {
        int i = 0;
        int gpa = 0;
        
        for(i = 0; i < transcript.size(); i++)
        {
            try
            {
                gpa += Integer.parseInt(transcript.get(i).getAttemptGrade());
            }
            catch(NumberFormatException e)
            {
                gpa += 0.0;
            }
            
        }
        
        return ((double)gpa / (double)i);
    }
    
    public double overallGPAForCIS() throws ArithmeticException 
    {
        int divisor = 0;
        int gpa = 0;
        
        for(int i = 0; i < transcript.size(); i++)
        {
            if(transcript.get(i).getCourseAttempted().getCourseCode().split("\\*")[0].equals("CIS"))
            {
                try
                {
                    gpa += Integer.parseInt(transcript.get(i).getAttemptGrade());
                    divisor += 1;
                }
                catch(NumberFormatException e)
                {
                    gpa += 0.0;
                }
            }
            
        }
        
        return ((double)gpa / (double)divisor);
    }
    
    public double gpaOfRecentTen()
    {
        int i = 0;
        double creditAmount = 0.0;
        int gpa = 0;
       
        
        for(i = 0; i < transcript.size(); i++)
        {
            if(creditAmount != 10.0)
            {
                try
                {
                    gpa += Integer.parseInt(transcript.get(i).getAttemptGrade());
                    creditAmount += transcript.get(i).getCourseAttempted().getCourseCredit();
                }
                catch(NumberFormatException e)
                {
                    gpa += 0.0;
                }
                
            }
            
        }
        
        if(creditAmount != 10.0)
        {
            return 0.0;
        }
        
        return ((double)gpa / 10.0);
    }
}
