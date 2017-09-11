using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Text;

public partial class Tags_Man : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack) 
        {
            int RoleID = Convert.ToInt16(Session["RoleID"].ToString());
            web_id.Value = Convert.ToString(Session["WebID"]);
            role_id.Value = Convert.ToString(Session["RoleID"]);
            string web = Util.ReturnWeb(Convert.ToInt32(Session["WebID"].ToString()));
            if (Session["RoleID"] == null || Session["UserID"] == null)
            {
                Util.ShowMessage("用户登录超时，请重新登录！", "/" + web + "/Login.aspx");
            }
            else if (RoleID > 3)
            {
                Util.ShowMessage("您没有访问该页面的权限！", "/" + web + "/Login.aspx");
            }
            else 
            {
                if (RoleID == 1)
                {
                   
                }
                else 
                {
                  
                }
                using (SqlConnection conn = new DB().GetConnection())
                {
                   

                
                }
             
            }
        }
    }

 
   

  

}