//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace TrainProject
{
    using System;
    using System.Collections.Generic;
    
    public partial class Ticket
    {
        public Ticket()
        {
            this.TicketedSpaceInts = new HashSet<TicketedSpaceInt>();
        }
    
        public int TicketNumber { get; set; }
        public string Type { get; set; }
    
        public virtual Station StartStationID { get; set; }
        public virtual Station EndStationID { get; set; }
        public virtual Schedule TrainRouteID { get; set; }
        public virtual Customer CustomerID { get; set; }
        public virtual ICollection<TicketedSpaceInt> TicketedSpaceInts { get; set; }
    }
}