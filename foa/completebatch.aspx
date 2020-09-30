<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" Title="Untitled Page" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Data" %>

<script runat="server">

    protected void btnUpdate_Click(object sender, EventArgs e)
    {

        SqlConnection con = new SqlConnection(Database.ConnectionString);
        try
        {
            con.Open();
            SqlCommand cmd = new SqlCommand("update batches set enddate = @enddate where bcode  = @bcode", con);
            cmd.Parameters.Add("@bcode", SqlDbType.VarChar, 10).Value = ddlBcode.SelectedValue;
            cmd.Parameters.Add("@enddate", SqlDbType.VarChar, 10).Value = txtEnddate.Text;
            if (cmd.ExecuteNonQuery() == 1)
                lblMsg.Text = "Batch Details Updated Successfully!";  
            else
                lblMsg.Text = "Sorry! Could not update batch details";   
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
        Complete Batch</h2>
    <p>
        <table>
            <tr>
                <td style="width: 148px">
                    Select Batch
                </td>
                <td style="width: 100px">
                    <asp:DropDownList ID="ddlBcode" runat="server" DataSourceID="SqlDataSource1"
                        DataTextField="bname" DataValueField="bcode" Width="281px">
                    </asp:DropDownList></td>
            </tr>
            <tr>
                <td style="width: 148px">
                    Completion Date
                </td>
                <td style="width: 100px">
                    <asp:TextBox ID="txtEnddate" runat="server"></asp:TextBox>
                    (mm/dd/yy)</td>
            </tr>
        </table>
    </p>
    <p>
        <asp:Button ID="btnUpdate" runat="server" OnClick="btnUpdate_Click" Text="Update Batch" />&nbsp;</p>
    <p>
        <asp:Label ID="lblMsg" runat="server"></asp:Label>&nbsp;</p>
    <p>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
            SelectCommand="select  bcode , bname = bcode + ' - ' +   convert(varchar(10), stdate,3) +  ' - ' + timing&#13;&#10;from  batches where enddate is null">
        </asp:SqlDataSource>
        &nbsp;</p>
</asp:Content>

