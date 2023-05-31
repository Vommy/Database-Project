using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Deliverable2
{
    //Name: Veren Villegas 
    //Student ID: 1574646

    internal abstract class FormPage
    {
        /**
         * <summary>
         * Closes the current Form and opens up the designer for the CreateClass Form, 
         * allowing the user to create classes for PrepareAware.
         * </summary>
         */
        public static void showCreateClassForm(Form currentForm)
        {
            currentForm.Hide();
            CreateClass createClassForm = new CreateClass();
            createClassForm.ShowDialog();
            currentForm.Close();
        }

        /**
         * <summary>
         * Closes the current Form and opens up the designer for the ClassSearch Form,
         * allowing the user to search classes from PrepareAware.
         * </summary>
         */
        public static void showClassSearchForm(Form currentForm)
        {
            currentForm.Hide();
            ClassSearch classSearchForm = new ClassSearch();
            classSearchForm.ShowDialog();
            currentForm.Close();
        }

        /**
         * <summary>
         * Closes the current Form and opens up the designer for the ViewStats Form,
         * allowing the user to view statistics about classes from PrepareAware.
         * </summary>
         */
        public static void showViewStatsForm(Form currentForm)
        {
            currentForm.Hide();
            ViewStats viewStatsForm = new ViewStats();
            viewStatsForm.ShowDialog();
            currentForm.Close();
        }

        /**
         * <summary>
         * Closes the current Form and opens up the designer for the RecordStudent Form, 
         * allowing the user if they are an instructor to record student data for PrepareAware.
         * </summary> 
         */
        public static void showRecordStudentsForm(Form currentForm)
        {
            currentForm.Hide();
            RecordStudent recordStudentForm = new RecordStudent();
            recordStudentForm.ShowDialog();
            currentForm.Close();
        }

    }
}
