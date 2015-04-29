using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
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

		public ObservableCollection<Station> DestinationStations
		{
			get { return new ObservableCollection<Station>(); }
		}

		public event PropertyChangedEventHandler PropertyChanged;
	}
}
