using System;
using System.Collections;
using System.Collections.Generic;
using System.Data.Entity;
using System.Data.SqlTypes;
using System.Linq;
using System.Runtime.InteropServices.ComTypes;
using System.Text;
using System.Threading.Tasks;

namespace TrainProject
{
	class TrainUtils
	{
		private TrainDataModelContainer db = new TrainDataModelContainer();

		IEnumerable<Station> ShortestRoute(Station originStation, Station destinationStation, Train t)
		{
			IEnumerable<Station> stations = from station in db.Stations
											select station;

			IEnumerable<Segment> segments = from segment in db.Segments
											select segment;

			Hashtable dist = new Hashtable();
			Hashtable prev = new Hashtable();
			List<int> unvisited = new List<int>();

			dist.Add(originStation.StationID, 0);
			unvisited.Add(originStation.StationID);

			foreach (Station s in stations.Where(s => s != originStation))
			{
				dist.Add(s.StationID, int.MaxValue);
				prev.Add(s.StationID, -1);
				unvisited.Add(s.StationID);
			}

			while (unvisited.Count > 0)
			{
				int u = unvisited[0];
				unvisited.RemoveAt(0);

				if (u == destinationStation.StationID)
				{
					break;
				}

				foreach (var s in segments.Where(s => s.StationIDA.StationID == u || s.StationsIDB.StationID == u))
				{
					int neighbor = ((s.StationIDA.StationID == u) ? s.StationIDA.StationID : s.StationsIDB.StationID);
					int alt = (int)dist[u] + neighbor;

					if (alt < (int)dist[neighbor])
					{
						dist[neighbor] = alt;
						prev[neighbor] = alt;
					}
				}

			}



			return null;
		}
	}
}
