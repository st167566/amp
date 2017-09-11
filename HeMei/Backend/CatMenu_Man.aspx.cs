using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Text;

public partial class CatMenu_Man : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
       
             MyDataBind();

      

    }

    private void MyDataBind()
    {

        string sql = "";
        sql = "select ID,CatMenuName,Valid from CatMenu where WebID=@WebID order by Orders asc";
        

       
       
        using (SqlConnection conn = (SqlConnection)new DB().GetConnection())
        {
            SqlCommand cmd = conn.CreateCommand();
            cmd.Parameters.AddWithValue("@WebID", Convert.ToInt32(Session["WebID"].ToString()));
           
            cmd.CommandText = sql;
            conn.Open();
            SqlDataReader rd = cmd.ExecuteReader();
            Repeater1.DataSource = rd;
            Repeater1.DataBind();
            rd.Close();

    
        }
    }
   
    protected void Button4_Click(object sender, EventArgs e)
    {
        Response.Redirect("SubMenu_Add.aspx");
    }

    protected void OrderByWeb_SelectedIndexChanged(object sender, EventArgs e)
    {
        MyDataBind();
    }

    

    protected void Button3_Click(object sender, EventArgs e)
    {
        Response.Redirect("CatMenu_Add.aspx");
    }
}