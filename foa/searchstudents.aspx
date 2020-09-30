<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" Title="Untitled Page" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Data" %>

<script runat="server">

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        String cond = " 1 = 1 ";

        if (txtName.Text.Length > 0)
            cond += " and name like '%" + txtName.Text + "%'";

        if (txtFname.Text.Length > 0)
            cond += " and fname like '%" + txtFname.Text + "%'";

        if (txtDJFrom.Text.Length > 0)
            cond += " and  dj >= '" + txtDJFrom.Text + "'";

        if (txtDJTo.Text.Length > 0)
            cond += " and  dj <= '" + txtDJTo.Text + "'";
        
        SqlConnection con = new SqlConnection(Database.ConnectionString);
        SqlDataAdapter da = new SqlDataAdapter("select * from students where " + cond, con);
        DataSet ds = new DataSet();
        da.Fill(ds, "students");
        DataList1.DataSource = ds.Tables[0];
        DataList1.DataBind();

    }
    
    
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h2>
        Search Students</h2>
    <br />
    Name :
    <asp:TextBox ID="txtName" runat="server" Width="111px"></asp:TextBox>
    &nbsp; Father's Name :
    <asp:TextBox ID="txtFname" runat="server" Width="111px"></asp:TextBox><br />
    Date of joining :
    <asp:TextBox ID="txtDJFrom" runat="server" Width="64px"></asp:TextBox>&nbsp; To
    <asp:TextBox ID="txtDJTo" runat="server" Width="67px"></asp:TextBox>
    &nbsp;&nbsp;
    <asp:Button ID="btnSearch" runat="server" OnClick="btnSearch_Click" Text="Search" /><br />
    <br />
    <asp:DataList ID="DataList1" runat="server">
      <ItemTemplate>
       <table>
       <tr>
       <td>
        <table border="1">
         <tr>
         <td>Batch Code</td> 
         <td> <%# Eval("bcode") %></td> 
         </tr>
         <tr>
         <td>Roll Number</td> 
         <td> <%# Eval("rollno") %></td> 
         </tr> 
        
        <tr>
         <td>Student's Name</td> 
         <td> <%# Eval("name") %></td> 
         </tr>  
        
         <tr>
         <td>Father's Name</td> 
         <td> <%# Eval("fname") %></td> 
         </tr>   
        
        <tr>
         <td>Current Occupation</td> 
         <td> <%# Eval("curocup") %></td> 
         </tr>    
        
        <tr>
         <td>Date Of Joining</td> 
         <td> <%# Eval("dj") %></td> 
         </tr>    
        
        <tr>
         <td>Email </td> 
         <td> <%# Eval("email") %></td> 
         </tr>    
        <tr>
         <td>Phone Number </td> 
         <td> <%# Eval("phone") %></td> 
         </tr>     
         </table>
        </td>
        <td>
         <img src=images/<%# Eval("bcode")%>-<%# Eval("rollno")%>.jpg  />
          <p />
         <a href=payments.aspx?bcode=<%# Eval("bcode")%>&rollno=<%# Eval("rollno")%>>Payments</a>
        </td>
        </tr> 
        </table>
      </ItemTemplate>
      
      <SeparatorTemplate>
        <hr size="2" color="red" />
      </SeparatorTemplate>
    </asp:DataList>
</asp:Content>

