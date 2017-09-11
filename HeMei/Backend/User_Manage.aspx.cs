using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Text;

public partial class User_Manage : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {
            string userid = Convert.ToString(Session["UserID"]);
            int RoleID = Convert.ToInt16(Session["RoleID"].ToString());
            web_id.Value = Session["WebID"].ToString();
            role_id.Value = Session["RoleID"].ToString();

            string web = Util.ReturnWeb(Convert.ToInt32(Session["WebID"].ToString()));
            if (Session["RoleID"] == null || Session["UserID"] == null)
            {

                Util.ShowMessage("用户登录超时，请重新登录！", "/" + web + "/Login.aspx");
            }
            else if (RoleID > 3)
            {
                Util.ShowMessage("对不起，你无权访问该页面！", "User_Center.aspx");
            }
            else
            {
                if (RoleID == 1)
                {
               
                }

                else
                {
               
                }

                string username = Convert.ToString(Session["UserName"]);
                int roleID = Util.UpdateAvatar(username);
                using (SqlConnection conn = new DB().GetConnection())
                {
                   

                    //cmd.CommandText = "select * from Roles where ID<> 1  order by ID asc";
                    //rd = cmd.ExecuteReader();
                    //Role.DataSource = rd;
                    //Role.DataTextField = "RoleName";
                    //Role.DataValueField = "ID";
                    //Role.DataBind();
                    //rd.Close();


                
                    //cmd.CommandText = "select distinct WebName as WebName,ID from WebSite";
                    //rd = cmd.ExecuteReader();
                    //Web.DataSource = rd;
                    //Web.DataValueField = "ID";
                    //Web.DataTextField = "WebName";
                    //Web.DataBind();
                    //rd.Close();
                    //Web.Items.Insert(0, new ListItem("网站", ""));
                }

              

            }
         
        }
    }


}