using Microsoft.Win32;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Deliverable2
{
    //Name: Veren Villegas 
    //Student ID: 1574646
    public partial class CreateClass : Form
    {
        private Dictionary<string, SqlDbType> storedProcPairs = new Dictionary<string, SqlDbType>();
        public CreateClass()
        {
            InitializeComponent();
            dateTimePickerStartTime.MinDate = DateTime.Now;
            TimeSpan timeSpan = new TimeSpan(0, 1, 0);
            dateTimePickerEndTime.MinDate = DateTime.Now + timeSpan;
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
         * Calls FormPage.showRecordStudentsForm().
         * </summary>
         */
        private void recordStudentsToolStripMenuItem_Click(object sender, EventArgs e)
        {
            FormPage.showRecordStudentsForm(this);
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

        static void SystemEvents_TimeChanged(object sender, EventArgs e)
        {

        }

        /**
         * <summary>Checks if the end datetime is greater than the start datetime.</summary>
         */
        private void validateTime()
        {
            if (dateTimePickerEndTime.Value < dateTimePickerStartTime.Value)
            {
                dateTimePickerEndTime.Value = dateTimePickerStartTime.Value;
            }
        }

        private void dateTimePickerEndTime_ValueChanged(object sender, EventArgs e)
        {
            validateTime();
        }

        private void dateTimePickerStartTime_ValueChanged(object sender, EventArgs e)
        {
            validateTime();
        }

        /**
         * <summary>
         * Fills the instructor combox box with a list of all the qualified instructors for a course each time the user types in a course ID that exists within the database. 
         * </summary>
         */
        private void textBoxID_TextChanged(object sender, EventArgs e)
        {
            comboBoxInstructors.Text = "";
            comboBoxInstructors.Items.Clear();
            if(textBoxID.Text.Length == 5)
            {
                //Retrieve all of the qualified instructors using the SQL.executeStoredProc function.
                comboBoxInstructors.Items.Clear();
                string[] param = new string[1];
                param[0] = textBoxID.Text;
                int[] size = { -1 };
                storedProcPairs.Clear();
                storedProcPairs.Add("@courseID", SqlDbType.VarChar);
                SQL.ExecuteStoredProc("getAllQualifiedInstructorNames",storedProcPairs, param, size);
                try
                {
                    if (SQL.read.HasRows)
                    {
                        try
                        {
                            while (SQL.read.Read())
                            {
                                if(SQL.read.FieldCount == 2){
                                    string instructorFname = SQL.read[0].ToString();
                                    string instructorLname = SQL.read[1].ToString();
                                    string fullname = instructorFname + " " + instructorLname;
                                    comboBoxInstructors.Items.Add(fullname);
                                }
                            }
                            comboBoxInstructors.Text = comboBoxInstructors.Items[0].ToString();
                        }
                        catch (Exception ex)
                        {
                            Console.WriteLine(ex.Message);
                        }
                    }
                    else
                    {
                        Console.WriteLine("Nothing read");
                    }
                }
                catch(Exception ex)
                {
                    Console.WriteLine(ex.Message);
                }
            }
        }

        /**
         * <summary>
         * Validates the class form and IF all inputs are valid, creates a new row in the Class
         * and Teaches table in the database.
         * </summary>
         */
        private void buttonCreateClass_Click(object sender, EventArgs e)
        {
            string courseID = null;
            string courseLocation = null;
            DateTime courseEndTime = DateTime.Now;
            DateTime courseStartTime = DateTime.Now;
            string courseInstructor = null;
            try
            {
                courseID = textBoxID.Text.Trim();
                courseLocation = textBoxLocation.Text;
                courseStartTime = dateTimePickerStartTime.Value;
                courseEndTime = dateTimePickerEndTime.Value;
                courseInstructor = comboBoxInstructors.Text;
                if (isValidClassForm(courseID, courseLocation, courseStartTime, courseEndTime, courseInstructor))
                {
                    //Execute the stored procedure with the values from the form.
                    string[] iNames = courseInstructor.Split(' ');
                    string iFname = iNames[0];
                    string iLname = iNames[iNames.Length - 1];
                    string[] param = { courseID, courseLocation, courseStartTime.ToString(), courseEndTime.ToString(), iFname, iLname};
                    int[] sizes = { 5, 100, -1, -1, 50, 50 };
                    storedProcPairs.Clear();
                    storedProcPairs.Add("@courseID", SqlDbType.Char);
                    storedProcPairs.Add("@courseLocation", SqlDbType.VarChar);
                    storedProcPairs.Add("@courseStart", SqlDbType.DateTime);
                    storedProcPairs.Add("@courseEnd", SqlDbType.DateTime);
                    storedProcPairs.Add("@iFname", SqlDbType.VarChar);
                    storedProcPairs.Add("@iLname", SqlDbType.VarChar);
                    SQL.ExecuteStoredProc("createNewClass", storedProcPairs, param, sizes);
                    MessageBox.Show("Successfully added class!");
                }
            }
            catch(Exception ex)
            {
                Console.WriteLine(ex.Message);
            }
        }

        /**
         * <summary>
         * Validates the inputs in the class form to make sure that the inputs are not invalid, empty values or malicious SQL injection.
         * </summary>
         */
        private bool isValidClassForm(string courseID, string courseLocation, DateTime startTime, DateTime endTime, string courseInstructor)
        {
            Regex regexID = new Regex(@"[^A-Za-z0-9]");
            Regex regexLocation = new Regex(@"[^A-Za-z0-9\s]+");
            Regex regexInstructor = new Regex(@"[A-Za-z] [A-Za-z]");
            if (courseID != null && courseID.Length == 5 && !regexID.IsMatch(courseID))
            {
                if (courseLocation != null && !String.IsNullOrEmpty(courseLocation) && !regexLocation.IsMatch(courseLocation))
                {
                    if (dateTimePickerEndTime.Value >= DateTime.Now)
                    {
                        if (courseInstructor != null && !String.IsNullOrEmpty(courseInstructor) && regexInstructor.IsMatch(courseInstructor))
                        {
                            return true;
                        }
                        else { MessageBox.Show("Invalid form: Please assign an instructor with [Firstname] [Surname]."); }
                    }
                    else { MessageBox.Show("Invalid form: Please create a valid timeframe for this class."); }
                }
                else { MessageBox.Show("Invalid form: Please specify a valid location."); }
            }
            else { MessageBox.Show("Invalid form: Please specify a valid course ID."); }
            return false;
        }
    }
}
