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
    
    public partial class ReservableSpace
    {
        public int CompartmentSeatNumber { get; set; }
    
        public virtual BookingType TypeID { get; set; }
        public virtual Train TrainID { get; set; }
    }
}