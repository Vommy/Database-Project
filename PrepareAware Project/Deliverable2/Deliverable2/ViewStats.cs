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
    public partial class ViewStats : Form
    {
        public ViewStats()
        {
            InitializeComponent();
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
         * Calls FormPage.showRecordStudentsForm().
         * </summary>
         */
        private void recordStudentToolStripMenuItem_Click_1(object sender, EventArgs e)
        {
            FormPage.showRecordStudentsForm(this);
        }
    }
}
