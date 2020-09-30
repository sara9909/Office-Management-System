<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" Title="Untitled Page" %>

<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Data" %>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {

        if (!Page.IsPostBack)
        {
            txtDp.Text = DateTime.Now.ToShortDateString();
            txtBcode.Text = Request.QueryString["bcode"];
        }
    }

    protected void btnPayment_Click(object sender, EventArgs e)
    {

        SqlConnection con = new SqlConnection(Database.ConnectionString);
        try
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = "payment";
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;
            cmd.Parameters.Add("@bcode", SqlDbType.VarChar, 10).Value = txtBcode.Text;
            cmd.Parameters.Add("@rollno", SqlDbType.Int).Value = ddlRollno.SelectedValue;
            cmd.Parameters.Add("@amount", SqlDbType.Int).Value = txtAmount.Text;
            cmd.Parameters.Add("@dp", SqlDbType.DateTime).Value = txtDp.Text;
            cmd.Parameters.Add("@remarks", SqlDbType.VarChar, 100).Value = txtRemarks.Text;
            cmd.Parameters.Add("@uname", SqlDbType.VarChar, 10).Value = Session["uname"];
            cmd.ExecuteNonQuery();
            lblMsg.Text = "Payment has been processed successfully!";
            txtAmount.Text = "";
            txtRemarks.Text = ""; 
        } // end of try
        catch (Exception ex)
        {
            lblMsg.Text = "Error -->" + ex.Message;
        }
        finally
        {
            con.Close();
        }

    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h2>
        Payment</h2>
    <br />
    <table>
        <tr>
            <td style="width: 100px">
                Batch Code
            </td>
            <td style="width: 282px">
                <asp:TextBox ID="txtBcode" runat="server" ReadOnly="True" Width="75px"></asp:TextBox></td>
        </tr>
        <tr>
            <td style="width: 100px">
                Student
            </td>
            <td style="width: 282px">
                <asp:DropDownList ID="ddlRollno" runat="server" DataSourceID="SqlDataSource1"
                    DataTextField="name" DataValueField="rollno" Width="247px">
                </asp:DropDownList></td>
        </tr>
        <tr>
            <td style="width: 100px">
                Amount
            </td>
            <td style="width: 282px">
                <asp:TextBox ID="txtAmount" runat="server" Width="78px"></asp:TextBox>
                Paid On :
                <asp:TextBox ID="txtDp" runat="server" Width="78px"></asp:TextBox></td>
        </tr>
        <tr>
            <td style="width: 100px">
                Remarks</td>
            <td style="width: 282px">
                <asp:TextBox ID="txtRemarks" runat="server" Width="239px"></asp:TextBox></td>
        </tr>
    </table>
    <br />
    <asp:Button ID="btnPayment" runat="server" Text="Submit" OnClick="btnPayment_Click" /><br />
    <br />
    <asp:Label ID="lblMsg" runat="server"></asp:Label>
    <br />
    <br />
    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtAmount"
        ErrorMessage="Amount being paid must be entered"></asp:RequiredFieldValidator><br />
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
        SelectCommand="SELECT [rollno], [name] FROM [students] WHERE ([bcode] = @bcode) ORDER BY [name]">
        <SelectParameters>
            <asp:QueryStringParameter Name="bcode" QueryStringField="bcode" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

