<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AccessDenied - копия.aspx.cs" Inherits="AccessDenied" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body style="vertical-align:central;">
    <form id="form1" runat="server">
    <div style="text-align: center; vertical-align: central; width: 100%; height: 100%">
        <br />
        <br />
        <br />
        <br />
        <asp:Label ID="Label1" runat="server" Text="Извините, но у Вас нет прав для просмотра этой страницы." BorderColor="Red" BorderStyle="Double" Font-Size="X-Large" ForeColor="Black"></asp:Label>
    
        <br />
        <br />
        <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/Default.aspx">На главную</asp:HyperLink>
    
    </div>
    </form>
</body>
</html>
