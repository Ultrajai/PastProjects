package UNIV;

/**
 * Abstract class GeneralDegree - write a description of the class here
 *
 * @author Ajai Gill
 */

import java.util.ArrayList;
import java.io.Serializable;

public abstract class GeneralDegree extends Degree implements Serializable
{
    private String degreeTitle;
    
    /**
     * This is the constructor of the abstract GeneralDegree class. It initializes the catalog to be used
     * and the degree title.
     * 
     * @param courses this is the catalog to be copied.
     */
    public GeneralDegree(CourseCatalog courses)
    {
        super(courses);
        degreeTitle = new String();
        setDegreeTitle("Bachelors of Computing General Degree");
    }
    
    public String getDegreeTitle()
    {
        return degreeTitle;
    }
    
    protected void setDegreeTitle(String title)
    {
        degreeTitle = title;
    }
}
