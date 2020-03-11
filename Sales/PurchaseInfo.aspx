<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="PurchaseInfo.aspx.cs" Inherits="Sales_PurchaseInfo" %>



<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <style>
        .button {
    background-color: #008CBA; /* Green */
    border: none;
    color: white;
    padding: 10px 20px;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    font-size: 16px;
    border-radius: 4px;
}
    </style>

    <h1>Purchase Details</h1>
    <hr />
    <p>Enter your information for shipping and billing here.</p>

    <div class="row">
        <div class="col-md-12">
            <h3>Billing Details</h3>
            <hr />

         
            <div class="col-md-2">
                <asp:Label ID="BillNameLabel" runat="server" Text="Name: " AssociatedControlID="BillName"></asp:Label>
            </div>
            <div class="col-md-10">
                <asp:TextBox ID="BillName" runat="server" CssClass="form-control"></asp:TextBox>
            </div>
    
             <div class="col-md-2">
                <asp:Label ID="BillEmailLabel" runat="server" Text="Email: " AssociatedControlID="BillEmail"></asp:Label>
            </div>
            <div class="col-md-10">
                <asp:TextBox ID="BillEmail" runat="server" CssClass="form-control"></asp:TextBox>
            </div>

             <div class="col-md-2">
                <asp:Label ID="BillAddressLabel" runat="server" Text="Address: " AssociatedControlID="BillAddress"></asp:Label>
            </div>
            <div class="col-md-10">
                <asp:TextBox ID="BillAddress" runat="server" CssClass="form-control"></asp:TextBox>
            </div>

             <div class="col-md-2">
                <asp:Label ID="BillPhoneLabel" runat="server" Text="Phone: " AssociatedControlID="BillPhone"></asp:Label>
            </div>
            <div class="col-md-10">
                <asp:TextBox ID="BillPhone" runat="server" CssClass="form-control"></asp:TextBox>
            </div>

        </div>
     </div>

    <div class="row">
        <div class="col-md-12">
            <h3>Shipping Details</h3>
            <hr />

         
            <div class="col-md-2">
                <asp:Label ID="ShipNameLabel" runat="server" Text="Name: " AssociatedControlID="ShipName"></asp:Label>
            </div>
            <div class="col-md-10">
                <asp:TextBox ID="ShipName" runat="server" CssClass="form-control"></asp:TextBox>
            </div>
    
             <div class="col-md-2">
                <asp:Label ID="ShipEmailLabel" runat="server" Text="Email: " AssociatedControlID="ShipEmail"></asp:Label>
            </div>
            <div class="col-md-10">
                <asp:TextBox ID="ShipEmail" runat="server" CssClass="form-control"></asp:TextBox>
            </div>

             <div class="col-md-2">
                <asp:Label ID="ShipAddressLabel" runat="server" Text="Address: " AssociatedControlID="ShipAddress"></asp:Label>
            </div>
            <div class="col-md-10">
                <asp:TextBox ID="ShipAddress" runat="server" CssClass="form-control"></asp:TextBox>
            </div>

             <div class="col-md-2">
                <asp:Label ID="ShipPhoneLabel" runat="server" Text="Phone: " AssociatedControlID="ShipPhone"></asp:Label>
            </div>
            <div class="col-md-10">
                <asp:TextBox ID="ShipPhone" runat="server" CssClass="form-control"></asp:TextBox>
            </div>

        </div>
     </div>

    <br />
    <a href="ViewCart.aspx" class="button">View Cart</a>
    <a href="PlaceOrder.aspx" class="button">View Order Summary</a>
</asp:Content>

