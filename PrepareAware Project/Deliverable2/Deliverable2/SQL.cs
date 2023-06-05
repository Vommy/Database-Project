using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Deliverable2
{
    //Name: Veren Villegas 
    //Student ID: 1574646 
    internal class SQL
    {
        //generates the connection to the database       
        //Make sure that in the Database connection you put your Database connection here:
        public static SqlConnection con = new SqlConnection(@"Data Source=cairo.cms.waikato.ac.nz;Database=vv44_D2;Integrated Security=True");
        public static SqlCommand cmd = new SqlCommand();
        public static SqlDataReader read;

        public static void ExecuteStoredProc(string storedProc)
        {
            try
            {
                con.Close();
                cmd = new SqlCommand(storedProc);
                cmd.Connection = con;
                con.Open();
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                read = cmd.ExecuteReader();
            }
            catch(Exception ex)
            {
                Console.WriteLine(ex.Message);
            }
        }
        /**
         * <summary>
         * Executes the specified stored procedure with parameters in the database.
         * </summary>
         * <param name="storedProc" >The name of the stored procedure in the database.</param>
         * <param name="paramTypeDict"> A dictionary of parameter keys and SqlDbType value pairs. 
         * The strings represent the parameters (e.g. @courseID),
         * and the SqlDbType values represent what type the parameter is.</param>
         * <param name="arguments">The values that should be used as arguments to the parameters.</param>
         * <param name="sizes">An array holding the size of the parameter. Useful if the type has a size (like a char). 
         * If the parameter doesn't have a size, the corresponding size should be -1.</param>
         */
        public static void ExecuteStoredProc(string storedProc, Dictionary<string, SqlDbType> paramTypeDict, string[] arguments, int[] sizes)
        {
            try
            {
                con.Close();
                cmd = new SqlCommand(storedProc);
                cmd.Connection = con;
                con.Open();
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                int count = 0;
                foreach (string key in paramTypeDict.Keys)
                {
                    string pattern = @"(@[A-Za-z]+)(_?[A-Z])*";
                    Regex regex = new Regex(pattern);
                    if (regex.IsMatch(key))
                    {
                        if (sizes[count] == -1)
                        {
                            cmd.Parameters.Add(key, paramTypeDict[key]).Value = arguments[count];
                        }
                        else
                        {
                            cmd.Parameters.Add(key, paramTypeDict[key], sizes[count]).Value = arguments[count];
                        }
                        count++;
                    }
                    else
                    {
                        Console.WriteLine("Regex is not working as expected");
                    }
                }
                read = cmd.ExecuteReader();
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
            }
        }

        /// <summary>
        /// Generates an SQL query based on the input
        /// query e.g. "SELECT * FROM staff"
        /// </summary>
        /// <param name="query"></param>
        public static void selectQuery(string query)
        {
            try
            {
                con.Close();
                cmd.Connection = con;
                con.Open();
                cmd.CommandText = query;
                read = cmd.ExecuteReader();
            }
            catch (Exception ex)
            {
                //put a message box in here if you are recieving errors and see if you can find out why?
                return;
            }
        }
    }
}

