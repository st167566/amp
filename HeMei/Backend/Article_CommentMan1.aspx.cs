using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Text;

public partial class Article_CommentMan1 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string web = Util.ReturnWeb(Convert.ToInt32(Session["WebID"].ToString()));
            if (Session["RoleID"] == null || Session["UserID"] == null)
            {

                Util.ShowMessage("用户登录超时，请重新登录！", "/" + web + "/Login.aspx");
            }
            else
            {

                if (Convert.ToInt16(Session["RoleID"].ToString()) != 1)
                {
                    OrderByWeb.Visible = false;
                }
                else 
                {
                    using (SqlConnection conn = (SqlConnection)new DB().GetConnection())
                    {
                        SqlCommand cmd = conn.CreateCommand();
                        cmd.CommandText = "select distinct WebName as WebName,ID from WebSite";
                        conn.Open();
                        SqlDataReader rd = cmd.ExecuteReader();
                        OrderByWeb.DataSource = rd;
                        OrderByWeb.DataValueField = "ID";
                        OrderByWeb.DataTextField = "WebName";
                        OrderByWeb.DataBind();
                        rd.Close();
                        OrderByWeb.Items.Insert(0, new ListItem("网站", ""));
                        conn.Close();

                    }

                }


                if (Request.QueryString["IDS"] != null)
                {
                    IDSLabel.Text = Request.QueryString["IDS"].ToString();
                    MyInit1();
                }
                else MyInit();

            }
        }
    }
    private void MyInit()
    {
        string sql = "";
        if (Convert.ToInt16(Session["RoleID"].ToString()) != 1)
        {
            sql = "select * from ArticleView_Comment where  Visible=1  and WebID=@WebID order by Orders asc";
        }
        else
        {

            sql = "select * from ArticleView_Comment left join WebSite on  ArticleView_Comment.WebID =WebSite .ID where  WebSite.IsMainSite='True'";
        }


        if (OrderByWeb.SelectedIndex > 0)
        {
            sql = "select * from ArticleView_Comment where WebID = @WebID order by PublishTime desc";
        }
        using (SqlConnection conn = new DB().GetConnection())
        {
            SqlCommand cmd = conn.CreateCommand();
            if (Convert.ToInt16(Session["RoleID"].ToString()) != 1)
            {
                cmd.Parameters.AddWithValue("WebID", Convert.ToInt32(Session["WebID"].ToString()));
            }
            if (OrderByWeb.SelectedIndex > 0)
            {
                cmd.Parameters.AddWithValue("WebID", OrderByWeb.SelectedValue);
            }

            cmd.CommandText = sql;
            conn.Open();
            SqlDataReader rd = cmd.ExecuteReader();
            GridView1.DataSource = rd;
            GridView1.DataBind();
            rd.Close();
            conn.Close();
        }
    }
    private void MyInit1()
    {
        using (SqlConnection conn = new DB().GetConnection())
        {
            SqlCommand cmd = conn.CreateCommand();
            cmd.CommandText = "select * from ArticleView_Comment where ArticleID in (" + IDSLabel.Text + ") and Visible=1  order by PublishTime desc";
            conn.Open();
            SqlDataReader rd = cmd.ExecuteReader();
            GridView1.DataSource = rd;
            GridView1.DataBind();
            rd.Close();
            conn.Close();
        }
    }
    protected void Button1_Click1(object sender, EventArgs e)
    {
        int i = 0;
        string ids = "";
        for (int i1 = 0; i1 <= GridView1.Rows.Count - 1; i1++)
        {
            CheckBox checkBox = (CheckBox)GridView1.Rows[i1].FindControl("ChechBox1");
            if (checkBox.Checked == true)
            {
                ids += "," + GridView1.DataKeys[i1].Value;
            }
        }
        if (ids != "")
        {
            ids = ids.Substring(1);
            using (SqlConnection conn = new DB().GetConnection())
            {
                SqlCommand cmd = conn.CreateCommand();
                cmd.CommandText = "update ArticleView_Comment set Visible=0 where ID in (" + ids + ") ";
                conn.Open();
                i = cmd.ExecuteNonQuery();
                cmd.Dispose();

            }
            if (i > 0)
            {
                ResultLabel.Text = "成功删除" + i + "条留言！";
                ResultLabel.ForeColor = System.Drawing.Color.Green;
            }
            else
            {
                ResultLabel.Text = "操作失败，请重试！";
                ResultLabel.ForeColor = System.Drawing.Color.Red;
            }
        }
        else {
            ResultLabel.Text = "请择至少一条留言进行操作！";
            ResultLabel.ForeColor = System.Drawing.Color.Red;
        }
        MyInit();
    }
    protected void Button2_Click(object sender, EventArgs e)
    {
        Response.Redirect(Server.HtmlEncode("Article_Man.aspx"));
    }

    
    protected void OrderByWeb_SelectedIndexChanged(object sender, EventArgs e)
    {
        MyInit();
    }

}