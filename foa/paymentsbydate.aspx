<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" Title="Untitled Page" %>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            // get sys date
            txtFrom.Text = DateTime.Now.ToShortDateString();
            txtTo.Text = DateTime.Now.ToShortDateString();
        } 
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h2>
        Payments By Date</h2>
    <p>
        Pay Date From
        <asp:TextBox ID="txtFrom" runat="server" Width="72px"></asp:TextBox>
        &nbsp;to &nbsp;<asp:TextBox ID="txtTo" runat="server" Width="79px"></asp:TextBox>&nbsp;
        <asp:Button ID="btnSubmit" runat="server" Text="Submit" /></p>
    <p>
        &nbsp;&nbsp;<asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False"
            DataKeyNames="rcptno" DataSourceID="SqlDataSource1" EmptyDataText="No Payments were made during this period!"
            Width="100%">
            <EmptyDataRowStyle BackColor="Silver" Font-Bold="True" ForeColor="White" />
            <Columns>
                <asp:BoundField DataField="rcptno" HeaderText="rcptno" ReadOnly="True" SortExpression="rcptno" />
                <asp:BoundField DataField="bcode" HeaderText="bcode" SortExpression="bcode" />
                <asp:BoundField DataField="name" HeaderText="name" SortExpression="name" />
                <asp:BoundField DataField="amount" HeaderText="amount" SortExpression="amount" />
                <asp:BoundField DataField="dp" HeaderText="dp" ReadOnly="True" SortExpression="dp" />
                <asp:BoundField DataField="uname" HeaderText="uname" SortExpression="uname" />
            </Columns>
        </asp:GridView>
        &nbsp; &nbsp;<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
            SelectCommand="select  rcptno,  p.bcode, s.name, amount, dp = convert(varchar(10),dp,3),  uname&#13;&#10;from  payments p, students s&#13;&#10;where p.bcode = s.bcode and p.rollno = s.rollno&#13;&#10;  and  dp between @from and @to&#13;&#10;">
            <SelectParameters>
                <asp:ControlParameter ControlID="txtFrom" Name="from" PropertyName="Text" />
                <asp:ControlParameter ControlID="txtTo" Name="to" PropertyName="Text" />
            </SelectParameters>
        </asp:SqlDataSource>
        </p>
</asp:Content>

