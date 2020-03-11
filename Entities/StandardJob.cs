namespace eBikes.Entities
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class StandardJob
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public StandardJob()
        {
            StandardJobParts = new HashSet<StandardJobPart>();
        }

        public int StandardJobID { get; set; }

        [Required(ErrorMessage = "Description is a required field.")]
        [StringLength(100, ErrorMessage = "Description has a maximum length of 100 characters.")]
        public string Description { get; set; }

        public decimal StandardHours { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<StandardJobPart> StandardJobParts { get; set; }
    }
}
