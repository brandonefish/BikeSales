namespace eBikes.Entities
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class ReturnedOrderDetail
    {
        public int ReturnedOrderDetailID { get; set; }

        public int ReceiveOrderID { get; set; }

        public int? PurchaseOrderDetailID { get; set; }

        [StringLength(50, ErrorMessage = "Description must be less the 50 characters.")]
        public string ItemDescription { get; set; }

        public int Quantity { get; set; }

        [Required(ErrorMessage = "Reason is a required field.")]
        [StringLength(50, ErrorMessage = "Reason has a maximum length of 50 characters.")]
        public string Reason { get; set; }

        [StringLength(50, ErrorMessage = "VendorPartNumber has a maximum length of 50 characters.")]
        public string VendorPartNumber { get; set; }

        public virtual PurchaseOrderDetail PurchaseOrderDetail { get; set; }

        public virtual ReceiveOrder ReceiveOrder { get; set; }
    }
}
