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
    public partial class ClassSearch : Form
    {
        public ClassSearch()
        {
            InitializeComponent();
            comboBoxClassFilter.Items.Add("Upcoming Classes");
            comboBoxClassFilter.Items.Add("Current Classes");
            comboBoxClassFilter.Items.Add("Past Classes");
            string queryAllClasses = "SELECT * FROM Class";

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
    }
}
