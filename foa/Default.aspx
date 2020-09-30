<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <br />
    <h2>
        Current Batches<br />
    </h2>
    <br />
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="5"
        CellSpacing="1" DataKeyNames="bcode" DataSourceID="SqlDataSource1" Width="100%">
        <Columns>
            <asp:BoundField DataField="bcode" HeaderText="bcode" ReadOnly="True" SortExpression="bcode"
                Visible="False" />
            <asp:BoundField DataField="ccode" HeaderText="ccode" SortExpression="ccode" Visible="False" />
            <asp:BoundField DataField="cname" HeaderText="Course" SortExpression="cname" />
            <asp:BoundField DataField="stdate" HeaderText="St. Date" ReadOnly="True" SortExpression="stdate" />
            <asp:BoundField DataField="timing" HeaderText="Timing" SortExpression="timing" />
            <asp:HyperLinkField DataNavigateUrlFields="bcode" DataNavigateUrlFormatString="addstudent.aspx?bcode={0}"
                Text="Add Student" />
            <asp:HyperLinkField DataNavigateUrlFields="bcode" DataNavigateUrlFormatString="batchinfo.aspx?bcode={0}"
                Text="Details" />
            <asp:HyperLinkField DataNavigateUrlFields="bcode" DataNavigateUrlFormatString="payment.aspx?bcode={0}"
                Text="Payment" />
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
        SelectCommand="select  bcode, b.ccode, cname,  convert(varchar(10),stdate,3)  stdate, timing&#13;&#10;from  courses c,  batches b &#13;&#10;where  c.ccode = b.ccode and enddate is null">
    </asp:SqlDataSource>
    <br />
</asp:Content>

