using eBikes.BLL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Sales_ViewCart : System.Web.UI.Page
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
            CurrentUser.Text = username;
            ShoppingCartTotal();
            DisplayCurrentCartQty();
            if (!CheckForItemsInCart())
            {
                checkoutButton.HRef = "~/Sales/ProductCatalog.aspx";
            }
        }
    }


    protected void CheckForException(object sender, ObjectDataSourceStatusEventArgs e)
    {
        MessageUserControl.HandleDataBoundException(e);
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

    protected void DeleteItemBtn_Click(object sender, EventArgs e)
    {
        LinkButton cmdBtn = (LinkButton)sender;
        int shoppingcartitemid = int.Parse(cmdBtn.CommandArgument);
        MessageUserControl.TryRun(() =>
        {
            SalesController sysmgr = new SalesController();
            sysmgr.DeleteItem(User.Identity.Name, shoppingcartitemid);
            ShoppingCartListView.DataBind();
            ShoppingCartTotal();
            DisplayCurrentCartQty();
            if (!CheckForItemsInCart())
            {
                checkoutButton.HRef = "~/Sales/PartsCatalog.aspx";
            }
        }, "Removal Successful", "Item has been removed from your cart.");
    }

    protected void UpdateQty_Click(object sender, EventArgs e)
    {
        LinkButton cmdBtn = (LinkButton)sender;
        string direction = cmdBtn.CommandArgument.ToString();
        int partid = int.Parse((cmdBtn.Parent.FindControl("ProductIdLabel") as Label).Text);
        MessageUserControl.TryRun(() =>
        {
            SalesController sysmgr = new SalesController();
            sysmgr.UpdateItem(User.Identity.Name, partid, direction);
            ShoppingCartListView.DataBind();
            ShoppingCartTotal();
            DisplayCurrentCartQty();
            if (!CheckForItemsInCart())
            {
                checkoutButton.HRef = "~/Sales/PartsCatalog.aspx";
            }
        }, "Quantity Updated", "Part Quantity has been updated");
    }

}