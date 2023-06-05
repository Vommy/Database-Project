using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Deliverable2
{
    internal class Student
    {
        private string _email;
        private string _firstName;
        private string _lastName;
        private string _phoneNumber;

        public string Email { get { return _email; } set { _email = value; } }
        public string FirstName { get { return _firstName; } set { _firstName = value; } }
        public string LastName { get { return _lastName; } set { _lastName = value; } }
        public string PhoneNumber { get { return _phoneNumber; } set { _phoneNumber = value; } }


        public Student(string email, string firstName, string lastName, string phoneNumber)
        {
            _email = email;
            _firstName = firstName;
            _lastName = lastName;
            _phoneNumber = phoneNumber;
        }

        public override string ToString()
        {
            return Email + " " + FirstName + " " + LastName + " " + PhoneNumber;
        }
    }
}
