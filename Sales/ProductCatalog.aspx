<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="ProductCatalog.aspx.cs" Inherits="Sales_Sales" %>

<%@ Register Src="~/UserControls/MessageUserControl.ascx" TagPrefix="uc1" TagName="MessageUserControl" %>

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

        .add{
                 background-color: #43c13a; /* Green */
    border: none;
    color: white;
    padding: 5px 10px;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    font-size: 16px;
    border-radius: 4px;
    margin: 0px 5px;
        }

        .col-md-6.category{
            margin-top: 60px;
        }

        h1{
            margin-top: 50px;
            font-size: 60px;
        }

        .quantitylist{
            width: 70px;
            padding:5px;
        }

        .descriptionlist{
            padding: 5px;
        }

        .pricelist{
            padding:5px;
            text-align:right;
        }

        .stocklist{
            padding: 5px;
            text-align:right;
        }
        
    </style>




		<h1 class="pctitle">Product Catalog</h1>

          <div style="float:right;">
    <a href="ViewCart.aspx"><img src="../Images/shoppingcart.png" /></a>
    <asp:Label ID="CurretyItemsQtyCart" runat="server" Text="" CssClass="current-number-in-cart-label"></asp:Label>
              
    <asp:Label runat="server" ID="CurrentCategoryId" Text="0" Visible="false"></asp:Label>
    <asp:Label runat="server" ID="CurrentLoggedInUser" Text="" Visible="false"></asp:Label>
        </div>
    <br />
    <br />
    <br />
    <div style="float:right;">
        <a href="CheckOutNav.aspx">Checkout</a>
    </div>




  

    <uc1:MessageUserControl runat="server" ID="MessageUserControl" />

    <%-- SEARCH BY CATEGORY --%>

    <div class="row">
        <div class="col-md-6 category">
            <h2>Search by Category</h2>
            <asp:ListView ID="AllProductsListView" runat="server" DataSourceID="AllCategoriesCountDataSource">

                <EmptyDataTemplate>
                    <table runat="server" style="">
                        <tr>
                            <td>No data was returned.</td>
                        </tr>
                    </table>
                </EmptyDataTemplate>

                <ItemTemplate>
                    <span style="">

                            <asp:Label Text='<%# Eval("CategoryID") %>' runat="server" ID="CategoryIDLabel" Visible="false"  AssociatedControlID="FilterResults1"  />
                        <asp:LinkButton ID="FilterResults1" runat="server" OnClick="FilterResults_Click" CommandArgument='<%# Eval("CategoryID") %>' EnableViewState="true">
                            <asp:Label Text='<%# Eval("Description") %>' runat="server" ID="DescriptionLabel" style="margin-right:5px;"/>

                            <asp:Label Text='<%# Eval("Count") %>' runat="server" ID="CountLabel" />
                        </asp:LinkButton>
                    </span>
                </ItemTemplate>
                <LayoutTemplate>
                    <table runat="server">
                        <tr runat="server">
                            <td runat="server">
                                <table runat="server" id="itemPlaceholderContainer" style="" border="0">
                                    <tr runat="server" style="">
                                
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

            <asp:ListView ID="CategoriesListView" runat="server" DataSourceID="ProductCategoriesDataSource">
               
                <EmptyDataTemplate>
                    <table runat="server" style="">
                        <tr>
                            <td>No data was returned.</td>
                        </tr>
                    </table>
                </EmptyDataTemplate>
                
                <ItemTemplate>
                    <span style="">

                            <asp:Label Text='<%# Eval("CategoryID") %>' runat="server" ID="CategoryIDLabel" Visible="false"/>
                                <asp:LinkButton ID="FilterResults2" runat="server" OnClick="FilterResults_Click" CommandArgument='<%# Eval("CategoryID") %>' EnableViewState="true">
                            <asp:Label Text='<%# Eval("Description") %>' runat="server" ID="DescriptionLabel" style="margin-right: 5px;"/>
      
                            <asp:Label Text='<%# Eval("Count") %>' runat="server" ID="CountLabel"/>
                        </asp:LinkButton><br />

                    </span>
                </ItemTemplate>
                <LayoutTemplate>
                    <div runat="server" id="itemPlaceholderContainer" style=""><span runat="server" id="itemPlaceholder" /></div>
                    <div style="">
                    </div>
                </LayoutTemplate>
            </asp:ListView>
        </div>


    <%-- PRODUCT LIST --%>

 
        <div class="col-md-6">
            <h2><asp:Label runat="server" ID="catFilterType" Text="All Categories"></asp:Label></h2>
            <asp:LoginView runat="server" ID="ProductsLoggedIn">
                <AnonymousTemplate>
                    <asp:GridView ID="ProductsListGridView" runat="server" AutoGenerateColumns="False" DataSourceID="ProductListDataSource" AllowPaging="True">
                        <Columns>
                            <asp:TemplateField SortExpression="PartId">
                                <ItemTemplate>
                                    <div>
                                        <asp:Label runat="server" Text='<%# Bind("PartId") %>' ID="PartIdLabel" Visible="false"></asp:Label>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField SortExpression="CartQty">
                                <ItemTemplate>

                                    <div class="quantitylist">
                                        <a runat="server" href="~/Account/Login" class="add">Add</a>
                                        <asp:Label runat="server" Text='<%# Bind("CartQuantity") %>' ID="CartQuantityLabel" Visible="false" CssClass="add"></asp:Label>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField SortExpression="PartName">
                                <ItemTemplate>
                                    <div class="descriptionlist">
                                        <asp:Label runat="server" Text='<%# Bind("PartName") %>' ID="PartNameLabel"></asp:Label>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField SortExpression="UnitPrice">
                                <ItemTemplate>
                                    <div class="pricelist">
                                        <asp:Label runat="server" Text='<%# "$" + Eval("UnitPrice", "{0:0.00}") %>' ID="UnitPriceLabel"></asp:Label>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField SortExpression="QtyInStock">
                                <ItemTemplate>
                                    <div class="stocklist">
                                        <asp:Label runat="server" ID="QtyInStockLabel"><span class="stock-span">Stock:</span> <%# Eval("QtyInStock") %></asp:Label>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </AnonymousTemplate>

                <LoggedInTemplate>
                    <asp:GridView ID="ProductsListViewLoggedIn" runat="server" AutoGenerateColumns="False" DataSourceID="ProductListDataSource" AllowPaging="True">
                        <Columns>
                             <asp:TemplateField SortExpression="PartId">
                                <ItemTemplate>
                                    <div>
                                        <asp:Label runat="server" Text='<%# Bind("PartId") %>' ID="PartIdLabel" Visible="false"></asp:Label>
                                        <asp:LinkButton ID="AddToCartBtn" runat="server" CommandName="addToCart" CommandArgument='<%# Eval("PartId") %>' CssClass="add" OnClick="AddToCartBtn_Click">Add</asp:LinkButton>
                                         
                                            <asp:Label runat="server" Text='<%# Bind("CartQuantity") %>' ID="CartQuantityLabel" CssClass="addQty-Amount"></asp:Label>
                                        
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField SortExpression="AddQty">
                                <ItemTemplate>
                                    <div class="quantitylist">
                                        <asp:Label runat="server" Text="" ID="AddQtyLbl" Visible="false"></asp:Label>
                                        <asp:TextBox runat="server" ID="AddQtyValue" text="1" CssClass="form-control"></asp:TextBox>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField SortExpression="PartName">
                                <ItemTemplate>
                                    <div class="descriptionlist">
                                        <asp:Label runat="server" Text='<%# Bind("PartName") %>' ID="PartNameLabel"></asp:Label>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField SortExpression="UnitPrice">
                                <ItemTemplate>
                                    <div class="pricelist">
                                        <asp:Label runat="server" Text='<%# "$" + Eval("UnitPrice", "{0:0.00}") %>' ID="UnitPriceLabel"></asp:Label>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField SortExpression="QtyInStock">
                                <ItemTemplate>
                                    <div class="stocklist">
                                        <asp:Label runat="server" ID="QtyInStockLabel"><span class="stock-span">Stock:</span> <%# Eval("QtyInStock") %></asp:Label>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </LoggedInTemplate>

            </asp:LoginView>
        </div>
    </div>

    <br />
    <a href="ViewCart.aspx" class="button">View Cart</a>



<%-- OBJECT DATA SOURCE TO LIST CATEGORIES --%>

    <asp:ObjectDataSource ID="ProductCategoriesDataSource" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="ListProductCategories" TypeName="eBikes.BLL.SalesController"></asp:ObjectDataSource>

    <asp:ObjectDataSource ID="AllCategoriesCountDataSource" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="AllCategoriesCount" TypeName="eBikes.BLL.SalesController"></asp:ObjectDataSource>


<%-- DATA SOURCE FOR PRODUCT LIST BY CATEGORY --%>
    <asp:ObjectDataSource ID="ProductListDataSource" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="PartsByCategory" TypeName="eBikes.BLL.SalesController">
        <SelectParameters>
            <asp:ControlParameter ControlID="CurrentCategoryId" PropertyName="Text" Name="catId" Type="Int32"></asp:ControlParameter>
            <asp:ControlParameter ControlID="CurrentLoggedInUser" PropertyName="Text" Name="username" Type="String"></asp:ControlParameter>
        </SelectParameters>
    </asp:ObjectDataSource>

</asp:Content>

