namespace eBikes.Entities
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("UnorderedPurchaseItemCart")]
    public partial class UnorderedPurchaseItemCart
    {
        [Key]
        public int CartID { get; set; }

        public int PurchaseOrderNumber { get; set; }

        [StringLength(100, ErrorMessage = "Description has a maximum length of 100 characters.")]
        public string Description { get; set; }

        [Required(ErrorMessage = "VendorPartNumber is a required field.")]
        [StringLength(50, ErrorMessage = "VendorPartNumber has a maximum length of 50 characters.")]
        public string VendorPartNumber { get; set; }

        public int Quantity { get; set; }
    }
}
