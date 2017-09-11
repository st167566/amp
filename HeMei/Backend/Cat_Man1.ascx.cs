using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;

public partial class Cat_Man1 : System.Web.UI.UserControl
{
    public string CatID {set; get; }  
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            MyInit();
    
        }
     
    }

    private void MyInit()
    {
        string sql = "select ID,SubName,Valid from Subs where CatID = " + CatID + " Order by ID Desc";
        using (SqlConnection conn = (SqlConnection)new DB().GetConnection())
        {
            SqlCommand cmd = new SqlCommand(sql, conn);
            conn.Open();
            SqlDataReader rd = cmd.ExecuteReader();
            SubRepeater.DataSource = rd;
            SubRepeater.DataBind();
            rd.Close();
        }

    }
    
    
}
