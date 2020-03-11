<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="CheckOutNav.aspx.cs" Inherits="Sales_CheckOutNav" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <h1>Checkout Navigation</h1>
    <br />
    <br />


    <div class="row">
        <div class="col-md-3">
            <img src="../Images/shoppingcart.png" /><a href="ViewCart.aspx">View Cart</a>
            <ul>
                <li>Change Item Quantities</li>
                <li>Remove Items</li>
                <li><a href="ProductCatalog.aspx">Continue Shopping</a></li>
            </ul>
        </div>

        <div class="col-md-3">
            <a href="PurchaseInfo.aspx">Customer Information</a>
            <ul>
               <li>Customer Information</li> 
            </ul>
        </div>

        <div class="col-md-3">
            <a href="PlaceOrder.aspx">Place Order</a>
            <ul>
                <li>Apply a Coupon</li>
                <li>View Totals</li>
                <li>Place Your Order</li>
            </ul>
        </div>


    </div>


</asp:Content>

