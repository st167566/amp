using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Data;
using System.Data.SqlClient;
using System.Web.Script.Serialization;
using System.Collections;
using System.Text;

/// <summary>
/// File_Man_WebService 的摘要说明
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// 若要允许使用 ASP.NET AJAX 从脚本中调用此 Web 服务，请取消注释以下行。 
// [System.Web.Script.Services.ScriptService]
public class File_Man_WebService : System.Web.Services.WebService {

    public File_Man_WebService () {

        //如果使用设计的组件，请取消注释以下行 
        //InitializeComponent(); 
    }

    [WebMethod(EnableSession = true)]
    public string InitFileMan()
    {
        DataSet ds;
        using (SqlConnection conn = new DB().GetConnection())
        {
            StringBuilder sb = new StringBuilder("select * from [Resources] where Valid=1 and status is not null and WebID=" + Session["WebID"].ToString() + " order by id desc");
            SqlCommand cmd = new SqlCommand(sb.ToString(), conn);
            conn.Open();
            SqlDataAdapter da = new SqlDataAdapter(cmd.CommandText, conn);
            ds = new DataSet();
            da.Fill(ds);
            conn.Close();
        }
        return Dtb2Json(ds.Tables[0]);
    }


    [WebMethod(EnableSession = true)]
    public string InitCat()
    {
        DataSet ds;
        using (SqlConnection conn = new DB().GetConnection())
        {
            StringBuilder sb = new StringBuilder("select * from [ResourceFolders] where ParentID=0 and WebID=" + Session["WebID"].ToString());
            SqlCommand cmd = new SqlCommand(sb.ToString(), conn);
            conn.Open();
            SqlDataAdapter da = new SqlDataAdapter(cmd.CommandText, conn);
            ds = new DataSet();
            da.Fill(ds);
            conn.Close();
        }
        return Dtb2Json(ds.Tables[0]);
    }

    [WebMethod(EnableSession = true)]
    public string InitSub(string catid)
    {
        DataSet ds;
        using (SqlConnection conn = new DB().GetConnection())
        {
            StringBuilder sb = new StringBuilder("select * from [ResourceFolders] where ParentID="+catid+" and WebID=" + Session["WebID"].ToString());
            SqlCommand cmd = new SqlCommand(sb.ToString(), conn);
            conn.Open();
            SqlDataAdapter da = new SqlDataAdapter(cmd.CommandText, conn);
            ds = new DataSet();
            da.Fill(ds);
            conn.Close();
        }
        return Dtb2Json(ds.Tables[0]);
    }


    /*用于DataSet转化为Json字符串返回*/
    private string Dtb2Json(DataTable dtb)
    {
        JavaScriptSerializer jss = new JavaScriptSerializer();
        System.Collections.ArrayList dic = new System.Collections.ArrayList();
        foreach (DataRow dr in dtb.Rows)
        {
            System.Collections.Generic.Dictionary<string, object> drow = new System.Collections.Generic.Dictionary<string, object>();
            foreach (DataColumn dc in dtb.Columns)
            {
                drow.Add(dc.ColumnName, dr[dc.ColumnName]);
            }
            dic.Add(drow);
        }
        return jss.Serialize(dic);
    }
}
