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

        public ClassSearch()
        {
            InitializeComponent();
            comboBoxClassFilter.Items.Add("Upcoming Classes");
            comboBoxClassFilter.Items.Add("Current Classes");
            comboBoxClassFilter.Items.Add("Past Classes");
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
            SQL.executeStoredProc(storedProc);
            if (SQL.read.HasRows)
            {
                listBoxClassResults.Items.Add("Class Results:\n ");
                try
                {
                    string courseID = "";
                    string courseLocation = "";
                    string courseStartTime = "";
                    string courseEndTime = "";
                    string instructorFname = "";
                    string instructorLname = "";

                    while (SQL.read.Read())
                    {
                        if (SQL.read.FieldCount == 6)
                        courseID = SQL.read[0].ToString();
                        courseLocation = SQL.read[1].ToString();
                        courseStartTime = SQL.read[2].ToString();
                        courseEndTime = SQL.read[3].ToString();
                        instructorFname = SQL.read[4].ToString();
                        instructorLname = SQL.read[5].ToString();
                        listBoxClassResults.Items.Add(courseID.PadRight(SMALL_PAD_SIZE) + courseLocation.PadRight(SMALL_PAD_SIZE) + courseStartTime.PadRight(LARGE_PAD_SIZE) + courseEndTime.PadRight(LARGE_PAD_SIZE) + instructorFname + " " + instructorLname);
                    }
                }
                catch (Exception ex)
                {
                    Console.WriteLine("ERROR Occurred in displayClassResults():\n " + ex.Message);
                }
            }
            else
            {
                listBoxClassResults.Items.Add("Class Results:\n No Results Found...");
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

        private void comboBoxClassFilter_SelectedIndexChanged(object sender, EventArgs e)
        {
            if(comboBoxClassFilter.SelectedIndex == 0)
            {
                displayClassResults("getUpcomingClasses");
            }
            else if(comboBoxClassFilter.SelectedIndex == 1)
            {
                displayClassResults("getCurrentClasses");
            }
            else if(comboBoxClassFilter.SelectedIndex == 2)
            {
                displayClassResults("getPastClasses");
            }
        }
    }
}
