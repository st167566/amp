using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Text;

public partial class Focus_Edit : System.Web.UI.Page
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

                int RoleID = Convert.ToInt16(Session["RoleID"].ToString());
                if (RoleID > 3)
                {
                    Util.ShowMessage("对不起，你无权访问该页面！", "User_Center.aspx");

                }
                else
                {
                    ID_Label.Text = Request.QueryString["ID"];

                    using (SqlConnection conn = new DB().GetConnection())
                    {
                        string sql = "select * from Focuses where ID = @ID";
                        SqlCommand cmd = new SqlCommand(sql, conn);
                        cmd.Parameters.AddWithValue("@ID", ID_Label.Text);
                        conn.Open();
                        SqlDataReader rd = cmd.ExecuteReader();
                        if (rd.Read())
                        {
                            Image1.ImageUrl = rd["PhotoSrc"].ToString();
                            LinkURLTextBox.Text = rd["LinkURL"].ToString();
                            OrdersTextBox.Text = rd["Orders"].ToString();
                            ValidCheckBox.Checked = Convert.ToBoolean(rd["Valid"]);
                        }
                        rd.Close();
                        conn.Close();
                    }

                }
            }
        }
    }
    protected void Button2_Click(object sender, EventArgs e)
    {

        if (!String.IsNullOrEmpty(ID_Label.Text))
        {
            using (SqlConnection conn = new DB().GetConnection())
            {
                int orders = Convert.ToInt16(OrdersTextBox.Text);
                string sql = "update focuses set LinkURL = @LinkURL,Orders = @Orders,Valid=@Valid where ID = @ID";
                SqlCommand cmd = new SqlCommand(sql, conn);
                conn.Open();
                cmd.Parameters.AddWithValue("@LinkURL", LinkURLTextBox.Text);
                cmd.Parameters.AddWithValue("@Orders", OrdersTextBox.Text);
                cmd.Parameters.AddWithValue("@Valid", ValidCheckBox.Checked);
                cmd.Parameters.AddWithValue("@ID", ID_Label.Text);
                cmd.ExecuteNonQuery();
            }

            Response.Redirect(Server.HtmlEncode("Focus_Man.aspx"));
        }
    }
}