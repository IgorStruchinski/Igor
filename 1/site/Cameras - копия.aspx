<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Cameras - копия.aspx.cs" Inherits="Cameras" %>

<html>
<head runat="server">
<meta http-equiv="REFRESH" content="30;"/>
    <title>Камеры</title>
    <link href="~/Content/Main.css" rel="stylesheet" type="text/css" />   
    <style type="text/css">
        .MsoNormal
        {
            vertical-align: middle;
        }
        .style2
        {
            font-weight: bold;
        }
        .newStyle1 {
            clip: rect(0px, 0px, 0px, 0px);
        }
        .auto-style1 {
            width: 294px;
        }
        .auto-style2 {
            text-align: center;
        }
        </style>
</head>
<body style="background-color: teal">
    <form id="form1" runat="server">
    <table border="0" 
        
        style="border-style: ridge; border-color: gray; width: 96%; position: absolute; background-color: white;
        height: 96%; vertical-align: top; bottom: 2%; right: 2%; top: 2%; left: 2%;">
        <tr>
            <td style="vertical-align: top; text-align: center; height: 652px;">
                <table border="0" style="background-color: white; border-right: teal groove; border-top: teal groove; left: 1px; border-left: teal groove; width: 100%; border-bottom: teal groove; top: -9px;">
        <tr>
            <td colspan="7" style="text-align: center">
                <span style="color: #07519a">
                <span style="font-weight: normal;
                    font-size: 20pt; color: teal; vertical-align: middle; text-align: center;">
                Система видеонаблюдения</span></span></td>
        </tr>
        <tr>
            <td style="width: 10px; height: 10px; font-size: 10pt;">
            </td>
            <td class="CapCell" colspan="5" style="height: 10px; text-align: center; background-color: teal; font-size: 10pt;">
                &nbsp;<asp:HyperLink ID="HyperLink7"
                    runat="server" CssClass="Lnk" Font-Size="10pt" Font-Underline="False" NavigateUrl="http://10.182.76.11/" style="color: white; font-size: 10pt;">ЛТС</asp:HyperLink><strong>
                        &nbsp;</strong><span style="color: #000000; background-color: #008080;">&gt;&gt;</span><span
                            style="color: #ffffff"> </span>
                <asp:HyperLink ID="HyperLink1" runat="server" CssClass="Lnk" Font-Size="10pt" Font-Underline="False"
                    NavigateUrl="~/Default.aspx" style="font-size: 10pt;">АСУ ТП</asp:HyperLink><span
                        style="color: #ffffff">&nbsp; <span style="color: #000000">&gt;&gt; </span>&nbsp;</span><span style="color: #000000"><asp:HyperLink 
                    ID="HyperLink8" runat="server" CssClass="Lnk" Font-Size="10pt" 
                    Font-Underline="False" style="font-size: 10pt;"><span 
                    style="color: #FFFFFF">Система видеонаблюдения</span></asp:HyperLink>&nbsp;</span></td>
            <td style="font-size: 10pt; width: 10px; height: 10px; color: #000000;">
            </td>
        </tr>
    </table>
                <asp:Label ID="Label1" runat="server" BackColor="Red" BorderColor="#990033" BorderStyle="Solid" BorderWidth="2px" ForeColor="White" Visible="False"></asp:Label>
                <asp:Label ID="Label2" runat="server" BackColor="White" Font-Bold="True" Font-Underline="False" ForeColor="Red" Text="Извините, но у Вас нет прав для просмотра этой страницы." Visible="False" BorderColor="Red" BorderStyle="Double" Font-Size="Large"></asp:Label>
                <asp:Panel ID="Panel1" runat="server" style="position: relative; height: 80%; width: 100%; top: 0px; left: 0px;">
                    
                    
                    <table border="0" style="border-style: ridge; border-color: gray; width: 100%; position: relative; background-color: white;">
                        <tr>
                            <td class="auto-style1" style="width: 33%; text-align: center;">
                                <center>
                                <asp:Label ID="Label_CamsLTS0" runat="server" Text="Камеры ЛТС" Font-Bold="True" Font-Size="Large" Font-Underline="True"></asp:Label>
                                <asp:GridView ID="CamsLTS" runat="server" Width ="90%"></asp:GridView>
                                </center>
                            </td>
                            
                            <td class="auto-style1" style="width: 33%; text-align: center; vertical-align: text-top;" >
                                <center>
                                <asp:Label ID="Label3" runat="server" Text="Камеры ЭК" Font-Bold="True" Font-Size="Large" Font-Underline="True"></asp:Label>
                                <asp:GridView ID="CamsEK" runat="server"  Width ="90%"></asp:GridView>
                                    <br />
                                    <br />
                                <asp:Label ID="Label6" runat="server" Font-Bold="True" Font-Size="Large" Font-Underline="True" Text="Камеры СМиТ"></asp:Label>
                                <asp:GridView ID="CamsSMiT" runat="server"  Width ="90%"></asp:GridView>
                                </center>
                            </td>
                            
                            <td class="auto-style1" style="width: 34%; text-align: center; vertical-align: text-top;" >
                                <center>
                                <asp:Label ID="Label5" runat="server" Text="Камеры Ёдки" Font-Bold="True" Font-Size="Large" Font-Underline="True"></asp:Label>
                                <asp:GridView ID="CamsEdki" runat="server" Width ="90%"></asp:GridView>
                                <br />
                                    <br />
                                <br />
                                <asp:Label ID="Label4" runat="server" Font-Bold="True" Font-Size="Large" Font-Underline="True" Text="Камеры КЦ 'Сморгонь'"></asp:Label>
                                <asp:GridView ID="CamsSmorg" runat="server" Width ="90%"></asp:GridView>
                                </center>
                            </td>
                        </tr>
                    </table>
                    
                </asp:Panel>
                <br />
                <br />
                </td>
        </tr>
        </table>
    </form>
</body>
</html>