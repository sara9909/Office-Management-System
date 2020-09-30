<%@ Page Language="C#" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">

    protected void btnLogin_Click(object sender, EventArgs e)
    {
        SqlConnection con = new SqlConnection ( Database.ConnectionString);
        try
        {
            con.Open();
            SqlCommand cmd = new SqlCommand("select fullname from users where uname = @uname and pwd = @pwd", con);
            cmd.Parameters.Add("@uname", SqlDbType.VarChar, 10).Value = txtUname.Text;
            cmd.Parameters.Add("@pwd", SqlDbType.VarChar, 10).Value = txtPwd.Text;
            Object name = cmd.ExecuteScalar();
            if (name == null)
                lblMsg.Text = "Invalid Login. Try again!";
            else
            {
                Session.Add("uname", txtUname.Text);
                Session.Add("fullname", name);
                FormsAuthentication.RedirectFromLoginPage(txtUname.Text, false);
            }
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

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
</head>
<body>
        <center>
    <form id="form1" runat="server">
         <h1>
            Srikanth Technologies</h1>

        <h3>
            Login</h3>
        
            <table>
                <tr>
                    <td>
                        Enter
                        User Name</td>
                    <td>
                        <asp:TextBox ID="txtUname" runat="server" Width="150px"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtUname"
                            Display="None" ErrorMessage="Username is missing!"></asp:RequiredFieldValidator></td>
                </tr>
                <tr>
                    <td>
                        Enter
                        Password
                    </td>
                    <td>
                        <asp:TextBox ID="txtPwd" runat="server" TextMode="Password" Width="150px"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtPwd"
                            Display="None" ErrorMessage="Password is missing!"></asp:RequiredFieldValidator></td>
                </tr>
            </table>
        <p>
            <asp:Button ID="btnLogin" runat="server" Text="Login" OnClick="btnLogin_Click" />&nbsp;</p>
        <p>
            <asp:Label ID="lblMsg" runat="server" Font-Bold="True"></asp:Label>&nbsp;</p>
        <p>
            <asp:ValidationSummary ID="ValidationSummary1" runat="server" />
            &nbsp;</p>
    
    </form>
    </center> 
</body>
</html>
