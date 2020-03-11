<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="PlaceOrder.aspx.cs" Inherits="Sales_PlaceOrder" %>

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

        td{
            padding-right: 100px;
        }

        table#MainContent_ListView2_itemPlaceholderContainer{
            margin-left: 220px;
        }

        input#MainContent_PaymentList_1{
            margin-left:-20px;
        }

        .credit{
            margin-left: 65px;
        }


    </style>



    <h1>Place Order</h1>

     <asp:Label ID="currentUser" runat="server" Text="" Visible="false"></asp:Label>

              <div style="float:right;">
    <a href="ViewCart.aspx"><img src="../Images/shoppingcart.png" /></a>
<asp:Label ID="CurrentItemsInCart" runat="server" Text=""></asp:Label>
                  </div>
     <br />
    <br />
    <br />
    <div style="float:right;">
        <a href="CheckOutNav.aspx">Checkout</a>
    </div>


    <uc1:MessageUserControl runat="server" ID="MessageUserControl" />

    <br />
    <br />
        <h2>Discount</h2>

    <asp:Label ID="DiscountLabel" runat="server" Text="Coupon Code: "></asp:Label>
    <asp:TextBox ID="DiscountTextBox" runat="server" CssClass="form-control"></asp:TextBox>
    <br />
    <asp:LinkButton ID="DiscountButton" runat="server" CssClass="button">Apply Discount</asp:LinkButton>
    <br />
    <br />
    <br />

    <h2>Order Summary</h2>
    <br />
 
      <asp:Label ID="CurrentCartTotal" runat="server" Text="" Visible="false"></asp:Label>
  

    <asp:ListView ID="ListView1" runat="server" DataSourceID="PlaceOrderDataSource">
      
        <EmptyDataTemplate>
            <table runat="server" style="">
                <tr>
                    <td>No data was returned.</td>
                </tr>
            </table>
        </EmptyDataTemplate>
        
        <ItemTemplate>
            <tr style="">
                <td>
                    <asp:Label Text='<%# Eval("ShoppingCartItemID") %>' runat="server" ID="ShoppingCartItemIDLabel" Visible="false" /></td>
                <td>
                    <asp:Label Text='<%# Eval("Description") %>' runat="server" ID="DescriptionLabel" /></td>
                <td>
                    <asp:Label Text='<%# "$" + Eval("UnitPrice", "{0:0.00}") %>' runat="server" ID="UnitPriceLabel" /></td>
                <td>
                    <asp:Label Text='<%# Eval("Qty") %>' runat="server" ID="QtyLabel" /></td>
                <td>
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
                                <th runat="server">Description</th>
                                <th runat="server">UnitPrice</th>
                                <th runat="server">Qty</th>
                                <th runat="server">ItemTotal</th>
                      
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
    <br />

    <asp:ListView ID="ListView2" runat="server" DataSourceID="ObjectDataSource1">
       
       
        <EmptyDataTemplate>
            <table runat="server" style="">
                <tr>
                    <td>No data was returned.</td>
                </tr>
            </table>
        </EmptyDataTemplate>
       
        <ItemTemplate>
            <tr style="">
                <td>
                    <asp:Label Text='<%# "$" + Eval("SubTotal", "{0:0.00}") %>' runat="server" ID="SubTotalLabel" /></td>
                <td>
                    <asp:Label Text='<%# Eval("Discount") %>' runat="server" ID="DiscountLabel" /></td>
                <td>
                    <asp:Label Text='<%# "$" + Eval("Total", "{0:0.00}") %>' runat="server" ID="TotalLabel" /></td>
                
  
            </tr>
        </ItemTemplate>
        <LayoutTemplate>
            <table runat="server">
                <tr runat="server">
                    <td runat="server">
                        <table runat="server" id="itemPlaceholderContainer" style="" border="0">
                            <tr runat="server" style="">
                                <th runat="server">SubTotal</th>
                                <th runat="server">Discount</th>
                                <th runat="server">Total</th>
        
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
    <br />


    <h2>Payment</h2>
    <asp:RadioButtonList ID="PaymentList" runat="server" RepeatDirection="Horizontal">
        <asp:ListItem Text="Debit" Value="D"></asp:ListItem>
        <asp:ListItem Text="Credit" Value="C"></asp:ListItem>
    </asp:RadioButtonList><img src="../Images/debit.png" />
    <img src="../Images/credit.gif" class="credit"/>
    <br />
    <br />

    <a href="PurchaseInfo.aspx" class="button">Customer Information</a>
    <asp:LinkButton ID="PlaceOrderButton" runat="server" CssClass="button" OnClick="PlaceOrderButton_Click">Place Order</asp:LinkButton>
    


    <%-- OBJECT DATA SOURCE --%>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetCurrentCheckoutInformation" TypeName="eBikes.BLL.SalesController">
        <SelectParameters>
            <asp:ControlParameter ControlID="currentUser" PropertyName="Text" Name="username" Type="String"></asp:ControlParameter>
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="PlaceOrderDataSource" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="ListShoppingCartItems" TypeName="eBikes.BLL.SalesController">
        <SelectParameters>
            <asp:ControlParameter ControlID="currentUser" PropertyName="Text" Name="username" Type="String"/>
        </SelectParameters>
    </asp:ObjectDataSource>

</asp:Content>


