package UserGUI;
import Database.DBDetails;
import Database.DBStudent;
import Database.MyConnection;
import UserClasses.Student;
import java.awt.*;
import java.awt.event.*;
import javax.swing.*;
import UNIV.CourseCatalog;
/**
 *
 * @author Ajai Gill
 */
public class UserProgram {
    
    JFrame login;
    JFrame newStudent;
    MyConnection c;
    DBStudent dbstudent;
    Student student;
    CourseCatalog catalog;
    
    public UserProgram()
    {
        c = new MyConnection(DBDetails.username, DBDetails.password);
        dbstudent = new DBStudent();
        catalog = new CourseCatalog(c);
        LoginFrame();
    }
    /*
     * Sets up the login frame
     */
    private void LoginFrame()
    {
        /*set up login fields*/
        login = new JFrame("Login Window");
        Container contentPane = login.getContentPane();
        
        contentPane.setPreferredSize(new Dimension(200,100));
        contentPane.setLayout(new BorderLayout());
        
        JPanel loginPanel = new JPanel(new GridLayout(2,1,5,5));   
        JPanel usernamePanel = new JPanel(new FlowLayout());
        JPanel passwordPanel = new JPanel(new FlowLayout());
        
        JLabel userName = new JLabel("Username:");
        usernamePanel.add(userName);
        JTextField usernameField = new JTextField("username");
        usernameField.setPreferredSize(new Dimension(100,25));
        usernamePanel.add(usernameField);
        JLabel password = new JLabel("Password:");
        passwordPanel.add(password);
        JPasswordField passwordField = new JPasswordField("password");
        passwordField.setPreferredSize(new Dimension(100,25));
        passwordPanel.add(passwordField);
        
        loginPanel.add(usernamePanel);
        loginPanel.add(passwordPanel);
        contentPane.add(loginPanel, BorderLayout.CENTER);
        
        /*set up login buttons*/
        JPanel okPanel = new JPanel(new FlowLayout());
        JButton ok = new JButton("login");
        ok.addActionListener(new LoginActionEvent(usernameField, passwordField));
        okPanel.add(ok);
        contentPane.add(okPanel, BorderLayout.SOUTH);
        JButton newUser = new JButton("New User?");
        newUser.addActionListener(new LoadStudentCreationActionEvent());
        okPanel.add(newUser);
        
        login.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        login.setResizable(false);
        
        login.pack();
        login.setVisible(true);
    }
    
    
    /*
     * Sets up the student creation frame
     */
    private void StudentCreationFrame()
    {
        newStudent = new JFrame("Student Creation");
        Container contentPane = newStudent.getContentPane();
        
        contentPane.setPreferredSize(new Dimension(300,125));
        contentPane.setLayout(new BorderLayout());
      
        JPanel items = new JPanel();
        items.setLayout(new BoxLayout(items ,BoxLayout.Y_AXIS));
        JPanel name = new JPanel(new FlowLayout());
        JPanel id = new JPanel(new FlowLayout());
        JPanel degree = new JPanel(new FlowLayout());
        
        
        JLabel firstName = new JLabel("First Name:");
        JTextField fName = new JTextField();
        fName.setPreferredSize(new Dimension(75,25));
        JLabel lastName = new JLabel("Last Name:");
        JTextField lName = new JTextField();
        lName.setPreferredSize(new Dimension(75,25));
        
        name.add(firstName);
        name.add(fName);
        name.add(lastName);
        name.add(lName);
        
        JLabel idNumber = new JLabel("ID:");
        JTextField idNum = new JTextField();
        idNum.setPreferredSize(new Dimension(100,25));
        
        id.add(idNumber);
        id.add(idNum);
        
        JLabel degreeLabel = new JLabel("Degree:");
        JComboBox degreeType = new JComboBox();
        degreeType.addItem("Bachelors of Computing General");
        degreeType.addItem("Computer Science Honours");
        
        degree.add(degreeLabel);
        degree.add(degreeType);
        
        items.add(name);
        items.add(id);
        items.add(degree);
        contentPane.add(items, BorderLayout.CENTER);
        
        JButton ok = new JButton("OK");
        ok.addActionListener(new SetUpStudentEvent(idNum, fName, lName, degreeType));
        contentPane.add(ok, BorderLayout.SOUTH);
        
        newStudent.setResizable(false);
        newStudent.pack();
        newStudent.setVisible(true);
        
    }
    
    /*
     * the action listener for setting up the student
     */
    private class SetUpStudentEvent implements ActionListener{
        JTextField id;
        JTextField fName;
        JTextField lName;
        JComboBox degree;
        
        public SetUpStudentEvent(JTextField id,  JTextField fName, JTextField lName, JComboBox degree)
        {
            this.id = id;
            this.fName = fName;
            this.lName = lName;
            this.degree = degree;
        }
                
        
        @Override
        public void actionPerformed(ActionEvent e) {
            if(!id.getText().isEmpty() && !fName.getText().isEmpty() && !lName.getText().isEmpty())
            {
                student = new Student(fName.getText(), lName.getText(), id.getText(), (String) degree.getSelectedItem(), catalog);
                newStudent.dispatchEvent(new WindowEvent(newStudent, WindowEvent.WINDOW_CLOSING));
                JOptionPane.showMessageDialog(login, "You have sucessfully added yourself to the system.");
                login.setVisible(false);
                new UserPlannerWindow(student, c, login).setVisible(true);
            }
            else
            {
                JOptionPane.showMessageDialog(newStudent, "One or more fields are empty.");
            }
        }
            
    }
        
    /*
     * The action listener for initiating the login into the system
     */
    private class LoginActionEvent implements ActionListener{
        
        String username;
        String password;
        JTextField usernameField;
        JPasswordField passwordField;
        
        
        public LoginActionEvent(JTextField u, JPasswordField p)
        {
            super();
            usernameField = u;
            passwordField = p;
        }
        
        public void AttemptLogin()
        {
            username = usernameField.getText();
            password = new String(passwordField.getPassword());
            dbstudent = c.loadStudent(password, username);
                
            if(username.isEmpty() || password.isEmpty())
            {
                JOptionPane.showMessageDialog(login, "Username or Password is Empty");
            }
            else if(dbstudent.getId() == null || dbstudent.getName() == null)
            {
                JOptionPane.showMessageDialog(login,"You are not in the system");
            }
            else
            {
                try
                {
                    student = new Student(catalog);
                    student.setFirstName(username);
                    student.setStudentNumber(Integer.parseInt(password));
                    student.setDegreeProgram(dbstudent.getDegree());
                    student.loadPlanAndTranscript(dbstudent.getCourses());
                    login.setVisible(false);
                    new UserPlannerWindow(student, c, login).setVisible(true);
                }
                catch(NullPointerException e)
                {
                    JOptionPane.showMessageDialog(login, "There was a problem loging into the system\n");
                }
            }
        }

        @Override
        public void actionPerformed(ActionEvent e) 
        {
            AttemptLogin();
        }
    }
    
    /*
     * The Action event that initiates the student creation frame
     */
    private class LoadStudentCreationActionEvent implements ActionListener{

        public LoadStudentCreationActionEvent()
        {
            
        }
        
        @Override
        public void actionPerformed(ActionEvent e) {
            StudentCreationFrame();
        }
        
    }
    
    public static void main (String[] args){
		UserProgram p = new UserProgram();
	}
    
}
