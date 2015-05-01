using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Collections.Specialized;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TrainProject.Model
{
	public class MainWindowModel : INotifyPropertyChanged 
	{
		public ObservableCollection<Station> OriginStations
		{
			get {return new ObservableCollection<Station>(TrainUtils.GetOrigins());}
		}

		private Station selectedOrigin;

		public Station SelectedOrigin
		{
			get { return selectedOrigin; }
			set { selectedOrigin = value; }
		}

		public ObservableCollection<Station> DestinationStations
		{
			get
			{
				if (SelectedOrigin != null)
				{
					return new ObservableCollection<Station>(TrainUtils.GetDestinations(SelectedOrigin.StationID));
				}
				return new ObservableCollection<Station>();
			}
		}



		public event PropertyChangedEventHandler PropertyChanged;
	}
}
