package UNIV;

    
/**
 * Abstract class HonoursDegree - write a description of the class here
 *
 * @author Ajai Gill
 */

import java.util.ArrayList;
import java.io.Serializable;

public abstract class HonoursDegree extends Degree implements Serializable
{
    
    private String degreeTitle;
    
    /**
     * This is the constructor of the abstract HonoursDegree class. It initializes the catalog to be used
     * and the degree title.
     * 
     * @param courses this is the catalog to be copied.
     */
    public HonoursDegree(CourseCatalog courses)
    {
        super(courses);
        degreeTitle = new String();
        setDegreeTitle("Bachelors of Computing Honours Degree");
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
