using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using System.Windows.Forms;
using static System.Windows.Forms.VisualStyles.VisualStyleElement.ListView;

namespace Deliverable2
{
    //Name: Veren Villegas 
    //Student ID: 1574646
    public partial class RecordStudent : Form
    {
        Regex emailPattern = new Regex(@"[\w]+(\.[\w]+)*@[a-z]+(\.[a-z]+)+$");
        Regex namePattern = new Regex(@"[A-Za-z]+$");
        Regex phonePattern = new Regex(@"[0-9]+$");
        Dictionary<string, SqlDbType> storedProcPairs = new Dictionary<string, SqlDbType>();
        List<String> studentEmails = new List<string>();
        List<Student> students = new List<Student>();
        public RecordStudent()
        {
            InitializeComponent();
            groupBoxStudentForm.Visible = false;
            groupBoxGradeForm.Visible = false;
            labelResult.Visible = false;
            labelFnameError.Visible = false;
            labelSnameError.Visible = false;
            labelEmailError.Visible = false;
            labelPNError.Visible = false;
            initializeEmailSearch();
            initializeGradeForm();
        }

        private void initializeEmailSearch()
        {
            try
            {
                comboBoxSearch.Items.Clear();
                studentEmails.Clear();
                students.Clear();
                SQL.ExecuteStoredProc("findStudentEmail");
                if (SQL.read.HasRows)
                {
                    while (SQL.read.Read())
                    {
                        string email = SQL.read[0].ToString();
                        string fname = SQL.read[1].ToString();
                        string lname = SQL.read[2].ToString();
                        string phone = SQL.read[3].ToString();
                        comboBoxSearch.Items.Add(email);
                        studentEmails.Add(email);
                        Student student2Add = new Student(email, fname, lname, phone);
                        Console.WriteLine(student2Add.ToString());
                        students.Add(student2Add);
                    }
                }
            }
            catch(Exception ex) {
               Console.WriteLine(ex.Message);
            }
        }

        /**
         * <summary>
         * Calls FormPage.showCreateClassForm().
         * </summary>
         */
        private void createClassToolStripMenuItem_Click(object sender, EventArgs e)
        {
            FormPage.showCreateClassForm(this);
        }

        /**
         * <summary>
         * Calls FormPage.showClassSearchForm().
         * </summary>
         */
        private void searchClassesToolStripMenuItem_Click(object sender, EventArgs e)
        {
            FormPage.showClassSearchForm(this);
        }

        /**
         * <summary>
         * Calls FormPage.showViewStatsForm().
         * </summary>
         */
        private void viewStatisticsToolStripMenuItem_Click(object sender, EventArgs e)
        {
            FormPage.showViewStatsForm(this);
        }

        private void initializeGradeForm()
        {
            try
            {
                comboBoxClasses.Items.Clear();
                SQL.ExecuteStoredProc("getClassIDs");
                if (SQL.read.HasRows)
                {
                    while (SQL.read.Read())
                    {
                        string courseID = "";
                        string classID = "";

                        if (SQL.read.FieldCount == 2)
                        {
                            courseID = SQL.read[0].ToString();
                            classID = SQL.read[1].ToString();
                            comboBoxClasses.Items.Add(courseID + ": Class " + classID);
                        }
                    }
                }
            }
            catch(Exception ex)
            {
                Console.WriteLine(ex.Message);
            }
        }

        private void buttonSearch_Click(object sender, EventArgs e)
        {
            try
            {
                string email = comboBoxSearch.Text;
                if(emailPattern.IsMatch(email))
                {
                    groupBoxStudentForm.Visible = true;
                    //The student exists in the database.
                    if (studentEmails.Contains(email))
                    {
                        setupGradeForm(email);
                    }
                    else
                    {
                        setupRegisterForm();
                    }
                }
                else
                {
                    groupBoxStudentForm.Visible = false;
                    MessageBox.Show("Please enter a valid email.");
                    labelResult.Visible = false;
                    comboBoxSearch.Focus();
                }
            }
            catch(Exception ex )
            {
                Console.WriteLine(ex.Message);
            }
            
        }

        private void setupGradeForm(string email)
        {
            //Set the register buttons to false.
            if (setRegisterButtons())
            {
                setRegisterButtons();
            }
            //Set the register textboxes to readonly.
            if (!enableRegisterTextBoxes())
            {
                enableRegisterTextBoxes();
            }
            labelResult.Text = "Student found!";
            labelResult.Visible = true;
            int index = studentEmails.IndexOf(email);
            Student student = students.ElementAt(index);
            textBoxStudentEmail.Text = student.Email;
            textBoxStudentFname.Text = student.FirstName;
            textBoxStudentLname.Text = student.LastName;
            textBoxStudentPN.Text = student.PhoneNumber;
            groupBoxGradeForm.Visible = true;
        }

        private void setupRegisterForm()
        {
            //Set the register buttons to true.
            groupBoxGradeForm.Visible = false;
            labelResult.Text = "Student not found. Please register the student.";
            labelResult.Visible = true;
            if (!setRegisterButtons())
            {
                setRegisterButtons();
            }
            clearRegisterTBoxes();
            textBoxStudentEmail.Text = comboBoxSearch.Text;
            if(enableRegisterTextBoxes())
            {
                enableRegisterTextBoxes();
            }
        }

        private bool enableRegisterTextBoxes()
        {
            textBoxStudentFname.ReadOnly = !textBoxStudentFname.ReadOnly;
            textBoxStudentLname.ReadOnly = !textBoxStudentLname.ReadOnly;
            textBoxStudentPN.ReadOnly = !textBoxStudentPN.ReadOnly;
            return textBoxStudentFname.ReadOnly;
        }

        /**
         * <summary>
         * Clears all the textboxes in the register form.
         * </summary>
         */
        private void clearRegisterTBoxes()
        {
            textBoxStudentEmail.Clear();
            textBoxStudentFname.Clear();
            textBoxStudentLname.Clear();
            textBoxStudentPN.Clear();
        }

        /**
         * <summary>
         * Sets the register and clear buttons for the register form to the opposing value.
         * </summary>
         */
        private bool setRegisterButtons()
        {
            buttonRegister.Enabled = !buttonRegister.Enabled;
            buttonClearRegister.Enabled = !buttonClearRegister.Enabled;
            return buttonRegister.Enabled;
        }

        private void textBox1_TextChanged(object sender, EventArgs e)
        {

        }

        /**
         * <summary>
         * Calls clearRegisterTBoxes() to clear the textboxes.
         * </summary>
         */
        private void buttonClearRegister_Click(object sender, EventArgs e)
        {
            clearRegisterTBoxes();
        }

        /**
         * <summary>
         * Validates the register form. 
         * IF the form is valid then it will add the student as a customer in the database. 
         * It will then add the email into the email search comboBox and allow the user to enter a grade for the student.
         * </summary>
         */
        private void buttonRegister_Click(object sender, EventArgs e)
        {
            try
            {
                string sFname = textBoxStudentFname.Text.Trim();
                string sLname = textBoxStudentLname.Text.Trim();
                string sEmail = textBoxStudentEmail.Text.Trim();
                string sPN = textBoxStudentPN.Text.Trim();
                if (validateRegisterForm(sFname, sLname, sEmail, sPN))
                {
                    labelFnameError.Visible = false;
                    labelSnameError.Visible = false;
                    labelEmailError.Visible = false;
                    labelPNError.Visible = false;
                    //Add the student to the database then call initializeSearch()
                    string[] param = {sEmail, sFname, sLname, sPN};
                    int[] sizes = { 255, 50, 50, 20 };
                    Dictionary<string, SqlDbType> storedProcPairs = new Dictionary<string, SqlDbType>();
                    storedProcPairs.Add("@sEmail", SqlDbType.VarChar);
                    storedProcPairs.Add("@sFname", SqlDbType.VarChar);
                    storedProcPairs.Add("@sLname", SqlDbType.VarChar);
                    storedProcPairs.Add("@sPhoneNumber", SqlDbType.VarChar);
                    SQL.ExecuteStoredProc("addNewStudent", storedProcPairs, param, sizes);
                    initializeEmailSearch();
                    setupGradeForm(sEmail);
                    MessageBox.Show("Successfully registered student.");
                }
            }
            catch(Exception ex) 
            { 
                Console.WriteLine(ex.Message); 
            }
        }

        /**
         * <summary>
         * Validates the register form by passing each of the inputs through isValidInput().
         * </summary>
         */
        private bool validateRegisterForm(string fname, string lname, string email, string phoneNumber)
        {
            if(isValidInput(fname, namePattern, 1) && isValidInput(lname, namePattern, 2) && isValidInput(email, emailPattern, 3) && isValidInput(phoneNumber, phonePattern, 4)) 
            {
                return true;
            }
            return false;
        }

        /**
         * <summary>
         * Compares an input string against null, whitespace and a supplied regex pattern and returns a boolean value. 
         * </summary>
         * <returns>True if the string is not null, a whitespace string and matches the regex. 
         * False otherwise.</returns>
         */
        private bool isValidInput(string input, Regex pattern, int type)
        {
            //If the string is not empty.
            if (!String.IsNullOrEmpty(input))
            {
                //If the string matches the regex.
                if (pattern.IsMatch(input))
                {   
                    switch (type)
                    {
                        case 1:
                            labelFnameError.Visible = false;
                            break;
                        case 2:
                            labelSnameError.Visible = false;
                            break;
                        case 3:
                            labelEmailError.Visible = false;
                            break;
                        case 4:
                            labelPNError.Visible = false;
                            break;
                    }
                    return true;
                }
                //String does not match regex.
                else
                {
                    switch (type)
                    {
                        case 1:
                            labelFnameError.Text = "Invalid firstname.";
                            labelFnameError.Visible = true;
                            break;
                        case 2:
                            labelSnameError.Text = "Invalid surname.";
                            labelSnameError.Visible = true;
                            break;
                        case 3:
                            labelEmailError.Text = "Invalid email.";
                            labelEmailError.Visible = true;
                            break;
                        case 4:
                            labelPNError.Text = "Invalid phone number.";
                            labelPNError.Visible = true;
                            break;
                    }
                }
            }
            //This is a phone number, which is an optional field.
            else if(type == 4)
            {
                return true;
            }
            //The string is null or whitespace.
            else
            {
                switch (type)
                {
                    case 1:
                        labelFnameError.Text = "Firstname cannot be null or empty.";
                        labelFnameError.Visible = true;
                        break;
                    case 2:
                        labelSnameError.Text = "Surname cannot be null or empty.";
                        labelSnameError.Visible = true;
                        break;
                   case 3:
                        labelEmailError.Text = "Email cannot be null or empty.";
                        labelEmailError.Visible = true;
                        break;
                }
            }
            return false;
        }

        /**
         * <summary>
         * Resets the numeric grade value back to 0. 
         * Would like it to clear the text of the combobox, however it didn't work as expected when setting comboBoxClasses.text = "";
         * </summary>
         */
        private void button3_Click(object sender, EventArgs e)
        {
            numericUpDownGrade.Value = 0;
        }

        private void buttonSubmit_Click(object sender, EventArgs e)
        {
            try
            {
                string email = textBoxStudentEmail.Text;
                if (!string.IsNullOrEmpty(comboBoxClasses.Text))
                {
                    string[] classData = comboBoxClasses.Text.Split(' ');
                    string classID = classData[classData.Length - 1];
                    string mark = numericUpDownGrade.Value.ToString();
                    string[] param = { email, classID, mark };
                    int[] sizes = { 255, -1, -1 };
                    Dictionary<string, SqlDbType> storedProcPairs = new Dictionary<string, SqlDbType>();
                    storedProcPairs.Add("@sEmail", SqlDbType.VarChar);
                    storedProcPairs.Add("@qClassID", SqlDbType.Int);
                    storedProcPairs.Add("@mark", SqlDbType.Decimal);
                    SQL.ExecuteStoredProc("recordNewMark", storedProcPairs, param, sizes);
                    MessageBox.Show("Successfully added new record.");
                }
                else
                {
                    MessageBox.Show("Please select a class.");
                }
            }
            catch(Exception ex)
            {

            }
        }
    }
}
