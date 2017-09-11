using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;

public partial class Cat_Man : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {
            string web = Util.ReturnWeb(Convert.ToInt32(Session["WebID"].ToString()));
            web_id.Value = Convert.ToString(Session["WebID"]);
            if (Session["RoleID"] == null || Session["UserID"] == null)
            {
                Util.ShowMessage("用户登录超时，请重新登录！", "/" + web + "/Login.aspx");
            }
            else
            {
                int RoleID = Convert.ToInt16(Session["RoleID"].ToString());
                if (RoleID > 3)
                {
                    Util.ShowMessage("对不起，你无权访问该页面！", "User_Center.aspx");

                }
                else
                {
                    //if (Convert.ToInt16(Session["RoleID"].ToString()) != 1)
                    //{
                    //    OrderByWeb.Visible = false;
                    //}
                    //using (SqlConnection conn = (SqlConnection)new DB().GetConnection())
                    //{
                    //    SqlCommand cmd = conn.CreateCommand();
                    //    cmd.CommandText = "select distinct WebName as WebName,ID from WebSite";
                    //    conn.Open();
                    //    SqlDataReader rd = cmd.ExecuteReader();
                    //    OrderByWeb.DataSource = rd;
                    //    OrderByWeb.DataValueField = "ID";
                    //    OrderByWeb.DataTextField = "WebName";
                    //    OrderByWeb.DataBind();
                    //    rd.Close();
                    //    OrderByWeb.Items.Insert(0, new ListItem("网站", ""));
                    //    conn.Close();
                      
                    //}

                    MyDataBind();
                }
            }

        }

    }

    private void MyDataBind()
    {
        string sql = "";
        sql = "select ID,CatName,Valid from Cats where WebID=@WebID order by Orders asc";
       


        //if (OrderByWeb.SelectedIndex > 0)
        //{
        //    sql = "select ID,CatName,Valid from Cats where WebID = @WebID order by Orders asc";
        //}

        using (SqlConnection conn = (SqlConnection)new DB().GetConnection())
        {
            SqlCommand cmd = conn.CreateCommand();
            if (Convert.ToInt16(Session["RoleID"].ToString()) != 0)
            {
                cmd.Parameters.AddWithValue("WebID", Convert.ToInt32(Session["WebID"].ToString()));
            }
            //if (OrderByWeb.SelectedIndex > 0)
            //{
            //    cmd.Parameters.AddWithValue("WebID", OrderByWeb.SelectedValue);
            //}

            cmd.CommandText = sql;
            conn.Open();
            SqlDataReader rd = cmd.ExecuteReader();
            Repeater1.DataSource = rd;
            Repeater1.DataBind();
            rd.Close();


        }
    
       
    }


    protected void OrderByWeb_SelectedIndexChanged(object sender, EventArgs e)
    {
        MyDataBind();
    }

}
