<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" Title="Untitled Page" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Data" %>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            // get sys date
            txtDJ.Text = DateTime.Now.Month + "/" + DateTime.Now.Day + "/" + DateTime.Now.Year;
            txtBcode.Text = Request.QueryString["bcode"];
            hlinkBatch.NavigateUrl = "batchinfo.aspx?bcode=" + txtBcode.Text;
        }

    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        SqlConnection con = new SqlConnection(Database.ConnectionString);
        try
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = "AddStudent";
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;
            cmd.Parameters.Add("@bcode", SqlDbType.VarChar, 10).Value = txtBcode.Text;
            cmd.Parameters.Add("@name", SqlDbType.VarChar, 30).Value = txtName.Text;
            cmd.Parameters.Add("@fname", SqlDbType.VarChar, 30).Value = txtFname.Text;
            cmd.Parameters.Add("@curocup", SqlDbType.VarChar, 30).Value = txtCurOcup.Text;
            cmd.Parameters.Add("@email", SqlDbType.VarChar, 50).Value = txtEmail.Text;
            cmd.Parameters.Add("@phone", SqlDbType.VarChar, 20).Value = txtPhone.Text;
            cmd.Parameters.Add("@dj", SqlDbType.DateTime).Value = txtDJ.Text;
            cmd.Parameters.Add("@amount", SqlDbType.Money).Value = txtAmount.Text;
            cmd.Parameters.Add("@uname", SqlDbType.VarChar, 10).Value = Session["uname"];
            cmd.ExecuteNonQuery();
            lblMsg.Text = "Student Has Been Added Successfully!";
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
        Add&nbsp; Student</h2>
        <br />
        <table>
            <tr>
                <td>
                    Batch Code</td>
                <td>
                    <asp:TextBox ID="txtBcode" runat="server" ReadOnly="True" Width="104px"></asp:TextBox>
                    &nbsp; &nbsp;<asp:HyperLink ID="hlinkBatch" runat="server">Details</asp:HyperLink>
                    &nbsp; &nbsp;
                </td>
            </tr>
            <tr>
                <td>
                    Student Name</td>
                <td>
                    <asp:TextBox ID="txtName" runat="server" Width="262px"></asp:TextBox></td>
            </tr>
            <tr>
                <td>
                    Father's Name</td>
                <td >
                    <asp:TextBox ID="txtFname" runat="server" Width="262px"></asp:TextBox></td>
            </tr>
            <tr>
                <td >
                    Current Occupation</td>
                <td>
                    <asp:TextBox ID="txtCurOcup" runat="server" Width="262px"></asp:TextBox></td>
            </tr>
            <tr>
                <td >
                    Email Address</td>
                <td >
                    <asp:TextBox ID="txtEmail" runat="server" Width="262px"></asp:TextBox></td>
            </tr>
            <tr>
                <td >
                    Phone Number(s)</td>
                <td >
                    <asp:TextBox ID="txtPhone" runat="server" Width="262px"></asp:TextBox></td>
            </tr>
            <tr>
                <td >
                    Date Of Joining
                </td>
                <td >
                    <asp:TextBox ID="txtDJ" runat="server" Width="102px"></asp:TextBox>
                    (mm/dd//yy)</td>
            </tr>
            <tr>
                <td >
                    Amount Paid&nbsp;
                </td>
                <td >
                    <asp:TextBox ID="txtAmount" runat="server" Width="102px"></asp:TextBox></td>
            </tr>
        </table>
    <br />
    <asp:Button ID="btnAdd" runat="server" Text="Add Student" OnClick="btnAdd_Click" /><br />
    <br />
    <asp:Label ID="lblMsg" runat="server"></asp:Label>
</asp:Content>

