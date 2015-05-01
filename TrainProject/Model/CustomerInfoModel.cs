using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TrainProject.Model
{
    class CustomerInfoModel :  INotifyPropertyChanged
    {
        private string firstname;

        public string FirstName
        {
            get { return firstname; }
            set
            {
                if (value != firstname)
                {
                    firstname = value;
                    OnPropertyChanged("FirstNameInput");
                }
            }
        }

        private string lastname;

        public string LastName
        {
            get { return lastname; }
            set
            {
                if (value != lastname)
                {
                    lastname = value;
                    OnPropertyChanged("LastNameInput");
                }
            }
        }

        private string dob;

        public string DOB
        {
            get { return dob; }
            set
            {
                if (value != dob)
                {
                    dob = value;
                    OnPropertyChanged("DOBInput");
                }
            }
        }
         // this method raises PropertyChanged event


        protected void OnPropertyChanged(string propertyName)
        {
            if (PropertyChanged != null) // if there is any subscribers 
                PropertyChanged(this, new PropertyChangedEventArgs(propertyName));
        }

        public event PropertyChangedEventHandler PropertyChanged;
    }
    
}
