using eBikes.Entities.POCOs.SalesPOCOs;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eBikes.Entities.DTOs
{
    public class CartCheckout
    {
        public decimal SubTotal { get; set; }
        public decimal Total { get; set; }
        public decimal Discount { get; set; }

        public List<CartItems> ShoppingCartItems { get; set; }
    }
}
