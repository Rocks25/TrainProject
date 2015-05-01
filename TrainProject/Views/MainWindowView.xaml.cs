using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Collections.Specialized;
using System.Data.Entity;
using System.Data.Entity.Core.Objects;
using System.Data.Entity.Infrastructure;
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
	/// Interaction logic for MainWindowView.xaml
	/// </summary>
	public partial class MainWindowView : Window
	{
		private List<Schedule> choiceKeys = new List<Schedule>();
		public MainWindowView()
		{
			DataContext = new MainWindowModel();
			InitializeComponent();
		}

		private void OriginInput_OnSelectionChanged(object sender, SelectionChangedEventArgs e)
		{
			DestinationInput.ItemsSource = ((MainWindowModel)DataContext).DestinationStations;
		}

		private void SubmitButton_OnClick(object sender, RoutedEventArgs e)
		{
			Station originStation = ((MainWindowModel)DataContext).SelectedOrigin;
			Station destinationStation = (Station)DestinationInput.SelectionBoxItem;

			var stopGroups = from stop in TrainUtils.db.StopsAscs
							 group stop by stop.Schedule.TrainRouteID into schedules
							 orderby schedules.Key
							 select schedules;
			stopGroups.AsNoTracking();

			var filteredStops = stopGroups.Where(sg => sg.Any(g => g.Station.StationID == originStation.StationID)).Where(sg => sg.Any(g => g.Station.StationID == destinationStation.StationID));
			filteredStops.AsNoTracking();

			List<String> choices = new List<string>();

			foreach (var schedules in filteredStops)
			{
				bool foundOrigin = false;
				string stopsString = "";

				foreach (var stop in schedules)
				{
					if (!foundOrigin)
					{
						if (stop.Station.StationID.Equals(originStation.StationID))
						{
							foundOrigin = true;
							stopsString += "Departure: " + stop.Station.StationName + " (" + stop.DepartureTime + ")" + "\r\n" + "Via: ";
						}
					}
					else if (stop.Station.StationID != destinationStation.StationID)
					{
						stopsString += stop.Station.StationName + " -> ";
					}
					else
					{
						stopsString += stop.Station.StationName + "" + "Arrival: " + stop.Station.StationName + " (" + stop.ArrivalTime + ")";
						break;
					}
				}

				choices.Add(stopsString);
				choiceKeys.Add(schedules.First().Schedule);
			}


			ScheduleOptions.ItemsSource = choices;
		}

		private void BookButton_OnClick(object sender, RoutedEventArgs e)
		{
			Ticket ticket = new Ticket();
			Schedule index = choiceKeys[ScheduleOptions.SelectedIndex];

			IEnumerable<Schedule> linq1 = (TrainUtils.db.Schedules.Where(schedule => schedule.TrainRouteID == index.TrainRouteID));

			((DbQuery<Schedule>) linq1).AsNoTracking();

			ticket.TrainRouteID = linq1.Single();

			IEnumerable<Customer> linq2 = (TrainUtils.db.Customers.Select(customer => customer));

			((DbQuery<Customer>) linq2).AsNoTracking();

			ticket.CustomerID = linq2.First();
			ticket.Date = DateTime.Now;
			ticket.StartStationID = (Station)OriginInput.SelectedItem;
			ticket.EndStationID = (Station) DestinationInput.SelectedItem;
			ticket.Type = "";

			TrainUtils.db.Tickets.Add(ticket);
			TrainUtils.db.SaveChanges();

			Window win2 = new SeatOptions();
			win2.Show();
			this.Close();


		}
	}
}
