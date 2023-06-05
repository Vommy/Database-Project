using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Deliverable2
{
    //Name: Veren Villegas 
    //Student ID: 1574646
    public partial class ClassSearch : Form
    {
        const int LARGE_PAD_SIZE = 28;
        const int SMALL_PAD_SIZE = 10;
        private Dictionary<String, String> storedProc = new Dictionary<string, string>();

        public ClassSearch()
        {
            InitializeComponent();
            //Initializing dictionary.
            storedProc.Add("All Classes", "getAllClasses");
            storedProc.Add("Upcoming Classes", "getUpcomingClasses");
            storedProc.Add("Current Classes", "getCurrentClasses");
            storedProc.Add("Past Classes", "getPastClasses");
            foreach (String key in storedProc.Keys)
            {
                comboBoxClassFilter.Items.Add(key);
            }
            displayClassResults("getAllClasses");
        }

        /**
         * <summary>
         * Displays the columns returned by the SQL class from SQL.executeStoredProc().
         * <paramref name="storedProc"/> The stored procedure to run.
         * </summary>
         */
        private void displayClassResults(string storedProc)
        {
            listBoxClassResults.Items.Clear();
            SQL.ExecuteStoredProc(storedProc);
            try
            {
                if (SQL.read.HasRows)
                {
                    listBoxClassResults.Items.Add("Class Results:\n ");
                    listBoxClassResults.Items.Add("ID".PadRight(SMALL_PAD_SIZE) + "Class".PadRight(SMALL_PAD_SIZE) + "Location".PadRight(SMALL_PAD_SIZE)
                        + "Start Time".PadRight(LARGE_PAD_SIZE) + "End Time".PadRight(LARGE_PAD_SIZE) + "Instructor Name");
                    string courseID = "";
                    string courseLocation = "";
                    string courseStartTime = "";
                    string courseEndTime = "";
                    string instructorFname = "";
                    string instructorLname = "";
                    string classID = "";

                    while (SQL.read.Read())
                    {
                        if (SQL.read.FieldCount == 7)
                        {
                            courseID = SQL.read[0].ToString();
                            courseLocation = SQL.read[1].ToString();
                            courseStartTime = SQL.read[2].ToString();
                            courseEndTime = SQL.read[3].ToString();
                            instructorFname = SQL.read[4].ToString();
                            instructorLname = SQL.read[5].ToString();
                            classID = SQL.read[6].ToString();
                            listBoxClassResults.Items.Add(courseID.PadRight(SMALL_PAD_SIZE) + classID.PadRight(SMALL_PAD_SIZE) + courseLocation.PadRight(SMALL_PAD_SIZE)
                                + courseStartTime.PadRight(LARGE_PAD_SIZE) + courseEndTime.PadRight(LARGE_PAD_SIZE) + instructorFname + " " + instructorLname);
                        }
                    }
                }
                else
                {
                    listBoxClassResults.Items.Add("Class Results:\n No Results Found...");
                }
            }
            catch(Exception ex)
            {
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
         * Calls FormPage.showRecordStudentsForm().
         * </summary>
         */
        private void recordStudentsToolStripMenuItem_Click(object sender, EventArgs e)
        {
            FormPage.showRecordStudentsForm(this);
        }

        /**
         * <summary>
         * Calss FormPage.showViewStatsForm().
         * </summary>
         */
        private void viewStatisticsToolStripMenuItem_Click(object sender, EventArgs e)
        {
            FormPage.showViewStatsForm(this);
        }

        /**
         * <summary>
         * Calls the a stored procedure based on the value selected in the combo box.
         * </summary>
         */
        private void comboBoxClassFilter_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (storedProc.ContainsKey(comboBoxClassFilter.Text))
            {
                displayClassResults(storedProc[comboBoxClassFilter.Text]);
            }
            else
            {
                listBoxClassResults.Items.Clear();
                MessageBox.Show("Error 400: Invalid Value (Does the stored procedure exist?)");
            }
        }
    }
}
