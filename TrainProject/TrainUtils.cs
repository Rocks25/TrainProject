using System;
using System.Collections;
using System.Collections.Generic;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using System.Data.SqlTypes;
using System.Linq;
using System.Runtime.InteropServices.ComTypes;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;

namespace TrainProject
{
	abstract class TrainUtils
	{
		static public TrainDataModelContainer db = new TrainDataModelContainer();

		public static IEnumerable<Station> ShortestRoute(Station originStation, Station destinationStation, Train t)
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

		public static List<String> GetSchedules(Station originStation, Station destinationStation)
		{
			var stopGroups = from stop in db.StopsAscs
							 group stop by stop.Schedule.TrainRouteID into schedules
							 orderby schedules.Key
							 select schedules;

			stopGroups.AsNoTracking();

			var filteredStops = stopGroups.Where(sg => sg.Any(g => g.Station.StationID == originStation.StationID)).Where(sg => sg.Any(g => g.Station.StationID == destinationStation.StationID));

			filteredStops.AsNoTracking();

			List<String> test = new List<string>();

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
						stopsString += stop.Station.StationName + "" + "Arrival: " + stop.Station.StationName + " (" +
						               stop.ArrivalTime + ")";
						break;
					}
				}

				test.Add(stopsString);
			}

			return test;
		}

		public static IEnumerable<Station> GetOrigins()
		{
			IEnumerable<Station> originsStations = from station in db.Stations
												   select station;

			((DbQuery<Station>) originsStations).AsNoTracking();

			return originsStations;
		}

		public static IEnumerable<Station> GetDestinations(int originId)
		{
			IEnumerable<Station> destinationStations = from destination in db.Stations
													   where destination.StationID != originId
													   select destination;
			((DbQuery<Station>) destinationStations).AsNoTracking();
			return destinationStations;
		}



	}
}
