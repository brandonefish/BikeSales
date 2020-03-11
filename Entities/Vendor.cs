namespace eBikes.Entities
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class Vendor
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Vendor()
        {
            Parts = new HashSet<Part>();
            PurchaseOrders = new HashSet<PurchaseOrder>();
        }

        public int VendorID { get; set; }

        [Required(ErrorMessage = "VendorName is a required field.")]
        [StringLength(100, ErrorMessage = "VendorName has a maximum length of 100 characters.")]
        public string VendorName { get; set; }

        [Required(ErrorMessage = "Phone is a required field.")]
        [StringLength(12, ErrorMessage = "The maximum Phone length is 12 characters.")]
        public string Phone { get; set; }

        [Required(ErrorMessage = "Address is a required field.")]
        [StringLength(30, ErrorMessage = "The maximum Address length is 30 characters.")]
        public string Address { get; set; }

        [Required(ErrorMessage = "City is a required field.")]
        [StringLength(30, ErrorMessage = "The maximum City length is 30 characters.")]
        public string City { get; set; }

        [Required(ErrorMessage = "ProvinceID is a required field.")]
        [StringLength(2, ErrorMessage = "ProvinceID is 2 charcters long.")]
        public string ProvinceID { get; set; }

        [Required(ErrorMessage = "Postal Code is a required field.")]
        [StringLength(6, ErrorMessage = "The maximum PostalCode length is 6 characters.")]
        public string PostalCode { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Part> Parts { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<PurchaseOrder> PurchaseOrders { get; set; }
    }
}
