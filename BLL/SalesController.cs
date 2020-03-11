using eBikes.DAL;
using eBikes.Entities;
using eBikes.Entities.DTOs;
using eBikes.Entities.POCOs.SalesPOCOs;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data.Entity;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eBikes.BLL
{
    [DataObject]
    public class SalesController
    {
        
        // BUSINESS LOGIC TO ADD NEW ONLINECUSTOMER

            public void AddOnlineCustomer(string username)
        {
            using (var context = new EBContext())
            {
                var customer = (from data in context.OnlineCustomers
                              where data.UserName.Equals(username)
                              select data).FirstOrDefault();

                if (customer == null)
                {
                    Guid trackingCookie;
                    trackingCookie = Guid.NewGuid();
                    customer = new OnlineCustomer();
                    customer.UserName = username;
                    customer.CreatedOn = DateTime.Now;
                    customer.TrackingCookie = trackingCookie;
                    context.OnlineCustomers.Add(customer);
                    context.SaveChanges();
                }
            }
        }

        // END ADD ONLINECUSTOMER


        //BUSINESS LOGIC FOR PRODUCT CATALOG TO LIST PARTS BY CATEGORY

        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public List<ProductCatalog> PartsByCategory(int catID, String username)
        {
            using (var context = new EBContext())
            {
                List<ProductCatalog> results = new List<ProductCatalog>();

                if (catID == 0)
                {
                    results = (from products in context.Parts
                               orderby products.Description
                               where products.Discontinued == false
                               select new ProductCatalog
                               {
                                   PartID = products.PartID,
                                   PartName = products.Description,
                                   UnitPrice = products.SellingPrice,
                                   QtyInStock = products.QuantityOnHand,
                                   CartQuantity = (from cartItems in products.ShoppingCartItems
                                                   where cartItems.ShoppingCart.OnlineCustomer.UserName.Equals(username)
                                                   select cartItems.Quantity).FirstOrDefault()
                               }).ToList();
                         
                }
                else
                {
                    results = (from products in context.Parts
                               orderby products.Description
                               where products.CategoryID == catID && products.Discontinued == false
                               select new ProductCatalog
                               {
                                   PartID = products.PartID,
                                   PartName = products.Description,
                                   UnitPrice = products.SellingPrice,
                                   QtyInStock = products.QuantityOnHand,
                                   CartQuantity = (from cartItems in products.ShoppingCartItems
                                                   where cartItems.ShoppingCart.OnlineCustomer.UserName.Equals(username)
                                                   select cartItems.Quantity).FirstOrDefault()
                               }).ToList();
                }
                return results;
            }
        }

        //PARTS CATALOG BY CATEGORY CLOSED

        //BUSINESS LOGIC TO LIST ALL CATEGORIES AND COUNTS

        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public List<ProductCategories> ListProductCategories()
        {
            using (var context = new EBContext())
            {
                var results = (from cat in context.Categories
                               orderby cat.Description
                               select new ProductCategories
                               {
                                   CategoryID = cat.CategoryID,
                                   Description = cat.Description,
                                   Count = cat.Parts.Count(p => p.Discontinued == false)
                               }).ToList();

                return results;
            }
        }

        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public ProductCategories AllCategoriesCount()
        {
            using (var context = new EBContext())
            {
                var results = (from cat in context.Categories
                               select new ProductCategories
                               {
                                   CategoryID = 0,
                                   Description = "All Products",
                                   Count = context.Parts.Count(p => p.Discontinued == false)
                               }).FirstOrDefault();
                return results;
            }
        }

        // CATEGORY LOGIC CLOSED

        // SHOPPING CART LOGIC
        //LIST ALL ITEMS IN CART
        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public List<CartItems> ListShoppingCartItems(string username)
        {
            using (var context = new EBContext())
            {
                var results = (from items in context.ShoppingCartItems
                               orderby items.Part.Description
                               where items.ShoppingCart.OnlineCustomer.UserName.Equals(username)
                               select new CartItems
                               {
                                   ShoppingCartItemID = items.ShoppingCartItemID,
                                   Description = items.Part.Description,
                                   Qty = items.Quantity,
                                   UnitPrice = items.Part.SellingPrice,
                                   ItemTotal = items.Part.SellingPrice * items.Quantity,
                                   Backorder = (items.Part.QuantityOnHand - items.Quantity) >=0 ? "" : "On Back Order"
                               }).ToList();
                return results;
            }
        }

    //GET THE CURRENT TOTALS AT CHECKOUT
    [DataObjectMethod(DataObjectMethodType.Select, false)]
    public CartCheckout GetCurrentCheckoutInformation(string username)
        {
            using (var context = new EBContext())
            {
                CartCheckout result = (from items in context.ShoppingCarts
                                       where items.OnlineCustomer.UserName.Equals(username)
                                       select new CartCheckout
                                       {
                                           SubTotal = items.ShoppingCartItems.Sum(p => p.Quantity * p.Part.SellingPrice),
                                           Total = items.ShoppingCartItems.Sum(p => p.Quantity * p.Part.SellingPrice),
                                           ShoppingCartItems = (from data in items.ShoppingCartItems
                                                                orderby data.Part.Description
                                                                select new CartItems
                                                                {
                                                                    Description = data.Part.Description,
                                                                    Qty = data.Quantity,
                                                                    UnitPrice = data.Part.SellingPrice,
                                                                    ItemTotal = data.Quantity * data.Part.SellingPrice,
                                                                    ShoppingCartItemID = data.ShoppingCartItemID
                                                                }).ToList()
                                       }).FirstOrDefault();
                return result;
            }
        }

        // GET THE TOTAL PRICES FROM CART

        public decimal GetShoppingCartTotal(string username)
        {
            using (var context = new EBContext())
            {
                decimal total = 0;
                int exists = (from data in context.ShoppingCarts
                              where data.OnlineCustomer.UserName.Equals(username)
                              select data.ShoppingCartItems.Count(x => x.ShoppingCartItemID > 0)).SingleOrDefault();

                if (exists > 0)
                {
                    total = (from data in context.ShoppingCarts
                             where data.OnlineCustomer.UserName.Equals(username)
                             select data.ShoppingCartItems.Sum(x => x.Quantity * x.Part.SellingPrice)).FirstOrDefault();
                }
                return total;
            }
        }

        public string ShowCartQuantity(string username)
        {
            using (var context = new EBContext())
            {
                string count = "";
                int cart = (from data in context.ShoppingCarts
                              where data.OnlineCustomer.UserName.Equals(username)
                              select data.ShoppingCartItems.Count(y => y.ShoppingCartItemID > 0)).SingleOrDefault();

                if (cart > 0)
                {
                    int currentCount = (from data in context.ShoppingCarts
                                        where data.OnlineCustomer.UserName.Equals(username)
                                        select data.ShoppingCartItems.Sum(y => y.Quantity)).SingleOrDefault();
                    count = currentCount.ToString();
                }
                return count;
            }
        }

        public bool CheckForShoppingCartItems(string username)
        {
            using (var context = new EBContext())
            {
                bool check = true;
                var result = (from items in context.ShoppingCartItems
                              where items.ShoppingCart.OnlineCustomer.UserName.Equals(username)
                              select items).FirstOrDefault();
                if (result == null)
                {
                    check = false;
                }
                return check;

            }
        }

        public void AddProductToCart(string username, int productId, int quantity)
        {
            using (var context = new EBContext())
            {
                ShoppingCart exists = (from data in context.ShoppingCarts
                                       where data.OnlineCustomer.UserName.Equals(username)
                                       select data).FirstOrDefault();
                ShoppingCartItem newItem = null;
                if (exists == null)
                {
                    exists = new ShoppingCart();
                    exists.OnlineCustomerID = (from data in context.OnlineCustomers
                                               where data.UserName == username
                                               select data.OnlineCustomerID).SingleOrDefault();
                    exists.CreatedOn = DateTime.Now;
                    exists = context.ShoppingCarts.Add(exists);
                }

                newItem = exists.ShoppingCartItems.SingleOrDefault(x => x.PartID == productId);
                if (newItem != null)
                {
                    newItem.Quantity += quantity;
                }
                else
                {
                    newItem = new ShoppingCartItem();
                    newItem.PartID = productId;
                    newItem.Quantity = quantity;

                    exists.ShoppingCartItems.Add(newItem);
                }

                context.SaveChanges();
            }
        }

        //DELETE ITEM FROM CART

        public void DeleteItem(string username, int shoppingcartitemid)
        {
            using (var context = new EBContext())
            {
                ShoppingCart currentCart = (from data in context.ShoppingCartItems
                                            where data.ShoppingCart.OnlineCustomer.UserName.Equals(username)
                                            select data.ShoppingCart).FirstOrDefault();
                if (currentCart == null)
                {
                    throw new Exception("Shopping cart was deleted.");
                }
                else
                {
                    ShoppingCartItem deleteItem = currentCart.ShoppingCartItems.Where(i => i.ShoppingCartItemID == shoppingcartitemid).FirstOrDefault();
                    if (deleteItem == null)
                    {
                        throw new Exception("Part does not exist.");
                    }
                    else
                    {
                        currentCart.UpdatedOn = DateTime.Now;
                        context.ShoppingCartItems.Remove(deleteItem);
                        context.SaveChanges();
                    }
                }
            }
        }

        // UPDATE ITEM

        public void UpdateItem(string username, int shoppingcartitemid, string direction)
        {
            using (var context = new EBContext())
            {
                ShoppingCart currentCart = (from data in context.ShoppingCartItems
                                            where data.ShoppingCart.OnlineCustomer.UserName.Equals(username)
                                            select data.ShoppingCart).FirstOrDefault();
                if (currentCart == null)
                {
                    throw new Exception("Shopping cart was deleted.");
                }
                else
                {
                    ShoppingCartItem currentItem = currentCart.ShoppingCartItems.Where(i => i.ShoppingCartItemID == shoppingcartitemid).FirstOrDefault();
                    if (currentItem == null)
                    {
                        throw new Exception("Part does not exist.");
                    }
                    else
                    {
                        if (direction.Equals("Add"))
                        {
                            currentItem.Quantity += 1;
                        }
                        else if (direction.Equals("Subtract"))
                        {
                            currentItem.Quantity -= 1;
                            if (currentItem.Quantity <= 0)
                            {
                                context.ShoppingCartItems.Remove(currentItem);
                            }
                        }
                        context.SaveChanges();
                    }
                }
            }
        }

        // COUPON STUFF

        public decimal GetCoupon(string couponValueID)
        {
            using (var context = new EBContext())
            {
                int coupon = (from data in context.Coupons
                              where data.CouponIDValue == couponValueID
                              select data.CouponDiscount).FirstOrDefault();
                decimal couponPercent = coupon / Convert.ToDecimal(100.00);
                return couponPercent;
            }
        }


        // CREATE ORDER

        public void CreateOrder(string username, decimal total, string paymentType)
        {
            using (var context = new EBContext())
            {
                var exists = (from x in context.ShoppingCarts
                              where x.OnlineCustomer.UserName.Equals(username)
                              select x).FirstOrDefault();
                if (exists == null)
                {
                    throw new Exception("Cart does not exist.");
                }
                else
                {
                    var itemsExist = (from x in exists.ShoppingCartItems
                                      select x).ToList();
                    if (itemsExist == null)
                    {
                        throw new Exception("Shopping cart is empty.");
                    }
                    else
                    {
                        Sale newSale = new Sale();
                        newSale.SaleDate = DateTime.Now;
                        newSale.UserName = username;
                        newSale.EmployeeID = 10;
                        newSale.TaxAmount = 0;
                        newSale.SubTotal = total;
                        newSale.PaymentType = paymentType;
                        newSale.PaymentToken = null;

                        newSale = context.Sales.Add(newSale);

                        foreach (ShoppingCartItem item in itemsExist)
                        {
                            SaleDetail newSaleItem = new SaleDetail();
                            newSaleItem.PartID = item.PartID;
                            newSaleItem.Quantity = item.Quantity;

                            int partQty = (from x in context.Parts
                                           where x.PartID == item.PartID
                                           select x.QuantityOnHand).FirstOrDefault();
                            if (item.Quantity > partQty)
                            {
                                newSaleItem.Backordered = true;
                                newSaleItem.ShippedDate = null;
                            }
                            else
                            {
                                newSaleItem.Backordered = false;
                                newSaleItem.ShippedDate = DateTime.Now;

                                Part currentPart = context.Parts.Find(item.PartID);
                                currentPart.QuantityOnHand -= item.Quantity;

                                context.Parts.Attach(currentPart);

                                context.Entry(currentPart).State = EntityState.Modified;
                            }

                            newSale.SaleDetails.Add(newSaleItem);
                        }
                        context.SaveChanges();

                    }
                }
            }
        }

    }
}
