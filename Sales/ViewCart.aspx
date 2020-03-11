<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="ViewCart.aspx.cs" Inherits="Sales_ViewCart" %>

<%@ Register Src="~/UserControls/MessageUserControl.ascx" TagPrefix="uc1" TagName="MessageUserControl" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">

    <style>


        .button {
    background-color: #008CBA; 
    border: none;
    color: white;
    padding: 10px 20px;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    font-size: 16px;
    border-radius: 4px;
}

        .delete{
             
                 background-color: #e2220d; 
    border: none;
    color: white;
    padding: 5px 10px;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    font-size: 16px;
    border-radius: 4px;
    margin: 10px 5px;
        
        }

        .descriptioncart{
            padding: 10px;
            width: 300px;
        }

        .pricecart{
            padding: 20px;
            text-align: right;
            width: 50px;
        }

        .quantitycart{
            padding: 20px;
            text-align: center;
            width: 150px;
        }

        .totalcart{
            padding: 20px;
            text-align:right;
            width: 150px;
        }

        .carttotal{
     
            text-align:right;
            margin-left:100px;
     
        }

        .descriptionheader{
            padding:10px;
        }
        
        .quantityheader{
            padding-left:25px;
        }

        .totalheader{
            padding-left:70px;
        }
      

    </style>







<h1>Shopping Cart <asp:Label ID="CurrentUser" runat="server" Text="" Visible="false"></asp:Label></h1>
    <asp:Label ID="CurrentItemsInCart" runat="server" Text="" Visible="false"></asp:Label>

<uc1:MessageUserControl runat="server" ID="MessageUserControl" />

    <div class="row">
        <div class="col-md-6">
            <asp:ListView ID="ShoppingCartListView" runat="server" DataSourceID="ShoppingCartDataSource">
                
                <EmptyDataTemplate>
                    <table runat="server" style="">
                        <tr>
                            <td>Shopping cart is empty! <a runat="server" href="ProductCatalog.aspx">Continue Shopping</a></td>
                        </tr>
                    </table>
                </EmptyDataTemplate>
                <ItemTemplate>
                    <tr style="margin-top:20px;">
                        <td>
                            <asp:Label Text='<%# Eval("ShoppingCartItemID") %>' runat="server" ID="ProductIdLabel" Visible="false"/>
                            <asp:LinkButton ID="DeleteItemBtn" runat="server" CommandArgument='<%# Eval("ShoppingCartItemId") %>' OnClick="DeleteItemBtn_Click" CssClass="delete">
                          Delete
                            </asp:LinkButton>
                        </td>
                        <td class="descriptioncart">
                            <asp:Label Text='<%# Eval("Description") %>' runat="server" ID="DescriptionLabel" /></td>
                        <td class="pricecart">
                            <asp:Label Text='<%# "$" + Eval("UnitPrice", "{0:0.00}") %>' runat="server" ID="UnitPriceLabel" /></td>
                        <td class="quantitycart">
                            <asp:LinkButton ID="SubtractQtyFromItem" runat="server" CommandArgument="Subtract" OnClick="UpdateQty_Click">-</asp:LinkButton>
                            <asp:Label Text='<%# Eval("Qty") %>' runat="server" ID="QtyLabel" />
                        <asp:LinkButton ID="AddQtyToItem" runat="server" CommandArgument="Add" OnClick="UpdateQty_Click">+</asp:LinkButton></td>
                        <td class="totalcart">
                            <asp:Label Text='<%# "$" + Eval("ItemTotal", "{0:0.00}") %>' runat="server" ID="ItemTotalLabel" /></td>
                     
                    </tr>
                </ItemTemplate>
                <LayoutTemplate>
                    <table runat="server">
                        <tr runat="server">
                            <td runat="server">
                                <table runat="server" id="itemPlaceholderContainer" style="" border="0">
                                    <tr runat="server" style="">
                                        <th runat="server"></th>
                                        <th runat="server" class="descriptionheader">Description</th>
                                        <th runat="server" class="priceheader">Unit Price</th>
                                        <th runat="server" class="quantityheader">Quantity</th>
                                        <th runat="server" class="totalheader">Total</th>
                                 
                                    </tr>
                                    <tr runat="server" id="itemPlaceholder"></tr>
                                </table>
                            </td>
                        </tr>
                        <tr runat="server">
                            <td runat="server" style=""></td>
                        </tr>
                    </table>
                </LayoutTemplate>
               
            </asp:ListView>

            <br />
    <div class="carttotal">
    <p><b>Cart Total:</b></p>
    <asp:Label ID="CurrentCartTotal" runat="server" Text="" ></asp:Label>
        </div>

        </div>
    </div>

    <br />


    <br />
    <br />
    <a href="ProductCatalog.aspx" class="button">Back to Catalog</a>
    <a runat="server" href="PurchaseInfo.aspx" class="button" id="checkoutButton">Customer Information</a>





    <%-- DATA SOURCE FOR SHOPPING CART --%>
    <asp:ObjectDataSource ID="ShoppingCartDataSource" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="ListShoppingCartItems" TypeName="eBikes.BLL.SalesController">
        <SelectParameters>
             <asp:ControlParameter ControlID="CurrentUser" PropertyName="Text" Name="username" Type="String"></asp:ControlParameter>
        </SelectParameters>
    </asp:ObjectDataSource>


</asp:Content>

