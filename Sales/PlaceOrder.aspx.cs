using eBikes.BLL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Sales_PlaceOrder : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Request.IsAuthenticated)
        {
            Response.Redirect("~/Account/Login.aspx");
        }
        else
        {
            string username = User.Identity.Name.ToString();
            currentUser.Text = username;
            ShoppingCartTotal();
            DisplayCurrentCartQty();
            //if (!CheckForItemsInCart())
            //{
            //    checkoutButton.HRef = "~/Sales/ProductCatalog.aspx";
            //}
        }
    }

    protected void ShoppingCartTotal()
    {
        string username = User.Identity.Name.ToString();
        SalesController sysmgr = new SalesController();
        decimal total = sysmgr.GetShoppingCartTotal(username);
        CurrentCartTotal.Text = string.Format("{0:C2}", total);
    }

    protected void DisplayCurrentCartQty()
    {
        string username = User.Identity.Name.ToString();
        SalesController sysmgr = new SalesController();
        string currentCount = sysmgr.ShowCartQuantity(username);
        CurrentItemsInCart.Text = currentCount;
    }

    protected bool CheckForItemsInCart()
    {
        SalesController sysmgr = new SalesController();
        bool check = sysmgr.CheckForShoppingCartItems(User.Identity.Name);
        return check;
    }

    protected void PlaceOrderButton_Click(object sender, EventArgs e)
    {
        string username = User.Identity.Name;

        SalesController sysmgr = new SalesController();
        decimal total = sysmgr.GetShoppingCartTotal(username);
        string paymentType = PaymentList.SelectedValue.ToUpper();

        MessageUserControl.TryRun(() =>
        {
            SalesController salemgr = new SalesController();
            sysmgr.CreateOrder(username, total, paymentType);
        }, "Order Successful", "Your order has been placed.");
    }


    protected void DiscountButton_Click(object sender, EventArgs e)
    {

        MessageUserControl.TryRun(() =>
        {
            SalesController couponmgr = new SalesController();
            decimal discountPercent = couponmgr.GetCoupon(DiscountTextBox.Text);
        }, "Valid Coupon", "Discount has been applied to your total.");
    }


}