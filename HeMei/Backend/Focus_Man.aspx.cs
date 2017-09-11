using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Text;
using System.Data;

public partial class Focus_Man : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string web = Util.ReturnWeb(Convert.ToInt32(Session["WebID"].ToString()));
            web_id.Value = Convert.ToString(Session["WebID"]);
            role_id.Value = Convert.ToString(Session["RoleID"]);
            int RoleID = Convert.ToInt16(Session["RoleID"].ToString());
                if (RoleID > 4)
                {
                    Util.ShowMessage("您没有访问该页面的权限！", "/" + web + "/Login.aspx");

                }
              
        }

    }

   
}
