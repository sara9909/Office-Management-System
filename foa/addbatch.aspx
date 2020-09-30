<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" Title="Untitled Page" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Data" %>

<script runat="server">

    protected void ddlCourse_SelectedIndexChanged(object sender, EventArgs e)
    {
        // get details of selected course
        String ccode = ddlCourse.SelectedValue;
        SqlConnection con = new SqlConnection(Database.ConnectionString);
        try
        {
            con.Open();
            SqlCommand cmd = new SqlCommand("select  fee, duration from courses where ccode = @ccode", con);
            cmd.Parameters.Add("@ccode", SqlDbType.VarChar, 10).Value = ccode;
            SqlDataReader dr = cmd.ExecuteReader();
            dr.Read();
            txtFee.Text = dr["fee"].ToString();
            txtDuration.Text = dr["duration"].ToString();
            dr.Close();
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

    protected void btnAddBatch_Click(object sender, EventArgs e)
    {

        SqlConnection con = new SqlConnection(Database.ConnectionString);
        try
        {
            con.Open();
            SqlCommand cmd = new SqlCommand(" select  isnull (max(bcode),0)  + 1 from batches", con);
            Object bcode = cmd.ExecuteScalar();
            cmd.CommandText = "insert into batches values(@bcode,@ccode,@stdate,null,@timing,@fee,@duration,@remarks)";
            cmd.Parameters.Add("@bcode", SqlDbType.VarChar, 10).Value = bcode.ToString();
            cmd.Parameters.Add("@ccode", SqlDbType.VarChar, 10).Value = ddlCourse.SelectedValue;
            cmd.Parameters.Add("@stdate", SqlDbType.DateTime).Value = txtStdate.Text;
            cmd.Parameters.Add("@timing", SqlDbType.VarChar,10).Value = txtTiming.Text; 
            cmd.Parameters.Add("@fee", SqlDbType.Money).Value = txtFee.Text;
            cmd.Parameters.Add("@duration", SqlDbType.Int).Value = txtDuration.Text;
            cmd.Parameters.Add("@remarks", SqlDbType.VarChar, 200).Value = txtRemarks.Text;
            cmd.ExecuteNonQuery();
            lblMsg.Text = "Batch Added Sucessfully : " + bcode; 
              
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
        Add Batch</h2>
        <p />
    <table>
        <tr>
            <td>
                Select Course</td>
            <td>
                <asp:DropDownList ID="ddlCourse" runat="server" DataSourceID="SqlDataSource1"
                    DataTextField="cname" DataValueField="ccode" Width="295px" AutoPostBack="True" OnSelectedIndexChanged="ddlCourse_SelectedIndexChanged" >
                </asp:DropDownList></td>
        </tr>
        <tr>
            <td>
                Course Fee
            </td>
            <td>
                <asp:TextBox ID="txtFee" runat="server" Width="72px"></asp:TextBox>

        </tr>
        
                <tr>
            <td>
            Duration 
            </td>
            <td>
                  <asp:TextBox ID="txtDuration" runat="server" Width="70px"></asp:TextBox></td>
        </tr>


        <tr>
            <td>
                St. Date
            </td>
            <td>
                <asp:TextBox ID="txtStdate" runat="server" Width="72px"></asp:TextBox> (mm/dd/yy)
             </td>
            </tr>
           <tr>
          <td>      
             Timing
            </td>
           <td>  
                <asp:TextBox ID="txtTiming" runat="server"></asp:TextBox></td>
                </td>
        </tr>
        
                <tr>
            <td>
               Remarks
            </td>
            <td>
                <asp:TextBox ID="txtRemarks" runat="server" Width="284px"></asp:TextBox>

        </tr>

    </table>
    <br />
    <asp:Button ID="btnAddBatch" runat="server" Text="Add Batch" OnClick="btnAddBatch_Click" /><br />
    <br />
    <asp:Label ID="lblMsg" runat="server"></asp:Label><br />
    <br />
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
        SelectCommand="SELECT [ccode], [cname] FROM [courses] ORDER BY [cname]"></asp:SqlDataSource>
    <br />
</asp:Content>

