using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eBikes.Entities.POCOs.SalesPOCOs
{
    public class CartItems
    {
        public int ShoppingCartItemID { get; set; }
        public string Description { get; set; }
        public decimal UnitPrice { get; set; }
        public int Qty { get; set; }
        public decimal ItemTotal { get; set; }
        public string Backorder { get; set; }
    }
}
