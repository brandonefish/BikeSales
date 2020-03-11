namespace eBikes.Entities
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class Customer
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Customer()
        {
            Jobs = new HashSet<Job>();
        }

        public int CustomerID { get; set; }

        [Required(ErrorMessage = "A LastName is required.")]
        [StringLength(30, ErrorMessage = "The maximum LastName length is 30 characters.")]
        public string LastName { get; set; }

        [Required(ErrorMessage = "A FirstName is required.")]
        [StringLength(30, ErrorMessage = "The maximum FirstName length is 30 characters.")]
        public string FirstName { get; set; }

        [StringLength(40, ErrorMessage = "The maximum Address length is 40 characters.")]
        public string Address { get; set; }

        [StringLength(20, ErrorMessage = "The maximum City length is 20 characters.")]
        public string City { get; set; }

        [StringLength(2, ErrorMessage = "The province length is 2 characters.")]
        public string Province { get; set; }

        [StringLength(6, ErrorMessage = "The maximum PostalCode length is 6 characters.")]
        public string PostalCode { get; set; }

        [StringLength(12, ErrorMessage = "The maximum Phone length is 12 characters.")]
        public string ContactPhone { get; set; }

        [StringLength(30, ErrorMessage = "The maximum Email length is 30 characters.")]
        public string EmailAddress { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Job> Jobs { get; set; }
    }
}
