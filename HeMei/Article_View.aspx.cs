using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;

public partial class Article_View : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["ID"] != null && !String.IsNullOrEmpty(Request.QueryString["ID"].ToString()))
        {
            Session["ArticleID"] = Request.QueryString["ID"];
            using (SqlConnection conn = new DB().GetConnection())
            {
                SqlCommand cmd = conn.CreateCommand();
                cmd.CommandText = "select * from Articles where ID =@ID";
                cmd.Parameters.AddWithValue("@ID", Session["ArticleID"]);
                conn.Open();
                SqlDataReader rd = cmd.ExecuteReader();
                if (rd.Read()) {
                    view_title.InnerText = rd["Title"].ToString();
                    view_connent.InnerHtml = rd["Content"].ToString();
                    view_author.InnerText = rd["Author"].ToString();
                    view_CDT.InnerText = rd["CDT"].ToString().Substring(0,10);
                    view_read.InnerText = rd["ViewTimes"].ToString();
                    view_cat.InnerText = rd["CatName"].ToString();
                }
                rd.Close();
            }
        }
    }
}