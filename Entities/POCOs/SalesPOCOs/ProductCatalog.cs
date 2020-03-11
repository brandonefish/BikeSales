using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eBikes.Entities.POCOs.SalesPOCOs
{
    public class ProductCatalog
    {
        public int PartID { get; set; }
        public int CartQuantity { get; set; }
        public string PartName { get; set; }
        public decimal UnitPrice { get; set; }
        public int QtyInStock { get; set; }
    }
}
