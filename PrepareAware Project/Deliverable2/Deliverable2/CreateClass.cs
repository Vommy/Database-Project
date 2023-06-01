using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Deliverable2
{
    //Name: Veren Villegas 
    //Student ID: 1574646
    public partial class CreateClass : Form
    {
        public CreateClass()
        {
            InitializeComponent();
            dateTimePickerStartTime.Format = DateTimePickerFormat.Time;
            dateTimePickerStartTime.ShowUpDown = true;
            dateTimePickerStartTime.Format = DateTimePickerFormat.Time;
            dateTimePickerEndTime.ShowUpDown = true;
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

        private void label3_Click(object sender, EventArgs e)
        {

        }

        private void CreateClass_Load(object sender, EventArgs e)
        {

        }
    }
}
