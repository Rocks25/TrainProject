using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;
using TrainProject.Model;

namespace TrainProject.Views
{
	/// <summary>
	/// Interaction logic for CustomerInfoView.xaml
	/// </summary>
	public partial class CustomerInfoView : Window
	{
		public CustomerInfoView()
		{
			DataContext = new TrainProject.Model.CustomerInfoModel();
			InitializeComponent();
		}

		private void SubmitButton_OnClick(object sender, RoutedEventArgs e)
		{
			if (((CustomerInfoModel)DataContext).DOB != null && ((CustomerInfoModel)DataContext).FirstName != null && ((CustomerInfoModel)DataContext).LastName != null)
			{
				TrainDataModelContainer db = new TrainDataModelContainer();
				IEnumerable<Customer> existingCustomer = from customer in db.Customers
														 where
															 customer.DOB == ((CustomerInfoModel)DataContext).DOB &&
															 customer.FirstName == ((CustomerInfoModel)DataContext).FirstName &&
															 customer.LastName == ((CustomerInfoModel)DataContext).LastName
														 select customer;
				if (!existingCustomer.Any())
				{
					Customer customer = new Customer();
					customer.FirstName = ((CustomerInfoModel) DataContext).FirstName;
					customer.LastName = ((CustomerInfoModel) DataContext).LastName;
					customer.DOB = ((CustomerInfoModel) DataContext).DOB;
					db.Customers.Add(customer);
					db.SaveChanges();
				}
				db.Dispose();
				Window win2 = new MainWindowView();
				win2.Show();
				this.Close();
			}
		}
	}
}
