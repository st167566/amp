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
/// Articles_draft_WebService 的摘要说明
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// 若要允许使用 ASP.NET AJAX 从脚本中调用此 Web 服务，请取消注释以下行。 
// [System.Web.Script.Services.ScriptService]
public class Articles_draft_WebService : System.Web.Services.WebService {

    public Articles_draft_WebService () {

        //如果使用设计的组件，请取消注释以下行 
        //InitializeComponent(); 
    }

    [WebMethod(EnableSession = true)]
    public string InitArticleMan()
    {
        DataSet ds;
        using (SqlConnection conn = new DB().GetConnection())
        {
            StringBuilder sb = new StringBuilder("select ID,Title,CatName,SubName,WebID,Author,Valid,LDT,ViewTimes from Articles where Valid=1 and IsFinished=0 and WebID=@WebID order by orders desc");
            SqlCommand cmd = new SqlCommand(sb.ToString(), conn);
            cmd.Parameters.AddWithValue("@WebID", Session["WebID"].ToString());
            conn.Open();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            ds = new DataSet();
            da.Fill(ds);
            conn.Close();
        }
        return Dtb2Json(ds.Tables[0]);
    }
    [WebMethod(EnableSession = true)]
    public string InitAuthor()
    {
        DataSet ds;
        using (SqlConnection conn = new DB().GetConnection())
        {
            StringBuilder sb = new StringBuilder("select  distinct authorID,Author from articles where author!='' and authorID is not NULL and WebID=@WebID");
            SqlCommand cmd = new SqlCommand(sb.ToString(), conn);
            cmd.Parameters.AddWithValue("@WebID", Session["WebID"].ToString());
            conn.Open();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            ds = new DataSet();
            da.Fill(ds);
            conn.Close();
        }
        return Dtb2Json(ds.Tables[0]);
    }
    [WebMethod(EnableSession = true)]
    public string InitUserTag()
    {
        DataSet ds;
        using (SqlConnection conn = new DB().GetConnection())
        {
            StringBuilder sb = new StringBuilder("select  distinct UserTagID,UserTagName from articles where usertagid!=0 and WebID=@WebID");
            SqlCommand cmd = new SqlCommand(sb.ToString(), conn);
            cmd.Parameters.AddWithValue("@WebID", Session["WebID"].ToString());
            conn.Open();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            ds = new DataSet();
            da.Fill(ds);
            conn.Close();
        }
        return Dtb2Json(ds.Tables[0]);
    }
    [WebMethod(EnableSession = true)]
    public string SelectArticle(string ids)
    {
        DataSet ds;
        using (SqlConnection conn = new DB().GetConnection())
        {
             StringBuilder sb = new StringBuilder("select ID,Title from Articles where ID in (" + ids + ")" + " order by orders desc");
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
    public string UpdateArticleMan(string cat, string sub, string author, string usertag, string starttime, string endtime)
    {
        string add = "";
        if (cat != "-1") { add += " and CatID='" + cat + "'"; }
        if (sub != "-1") { add += " and subid=" + sub; }
        if (author != "") { add += " and author in (" + author + ")"; }
        if (usertag != "") { add += " and usertagname in (" + usertag + ")"; }
        if (starttime != "" && endtime != "") { add += " and cdt between '" + starttime + "' and '" + endtime + "'"; }
        DataSet ds;
        using (SqlConnection conn = new DB().GetConnection())
        {
            StringBuilder sb = new StringBuilder("select ID,Title,CatName,SubName,WebID,Author,Valid,LDT,ViewTimes from Articles where Valid=1 and IsFinished=0 and WebID=@WebID" + add + " order by orders desc");
            SqlCommand cmd = new SqlCommand(sb.ToString(), conn);
            cmd.Parameters.AddWithValue("@WebID", Session["WebID"].ToString());
            cmd.Parameters.AddWithValue("@CatID", cat);
            cmd.Parameters.AddWithValue("@SubID", sub);
            cmd.Parameters.AddWithValue("@Author", author);
            cmd.Parameters.AddWithValue("@usertag", usertag);
            cmd.Parameters.AddWithValue("@starttime", starttime);
            cmd.Parameters.AddWithValue("@endtime", endtime);
            conn.Open();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
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
            StringBuilder sb = new StringBuilder("select * from Cats where WebID=@WebID");
            SqlCommand cmd = new SqlCommand(sb.ToString(), conn);
            cmd.Parameters.AddWithValue("@WebID", Session["WebID"].ToString());
            conn.Open();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            ds = new DataSet();
            da.Fill(ds);
            conn.Close();
        }
        return Dtb2Json(ds.Tables[0]);
    }
    [WebMethod(EnableSession = true)]
    public string InitSub(string cat)
    {
        DataSet ds;
        using (SqlConnection conn = new DB().GetConnection())
        {
            StringBuilder sb = new StringBuilder("select * from Subs where CatID=@cat");
            SqlCommand cmd = new SqlCommand(sb.ToString(), conn);
            cmd.Parameters.AddWithValue("@cat", cat);
            conn.Open();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            ds = new DataSet();
            da.Fill(ds);
            conn.Close();
        }
        return Dtb2Json(ds.Tables[0]);
    }
    [WebMethod(EnableSession = true)]
    public int DeleteArticle(string ids)
    {
        int i = 0;
        using (SqlConnection conn = new DB().GetConnection())
        {   //新建文章数据
            StringBuilder sb = new StringBuilder("update Articles set Valid=0 where ID in (" + ids + ")");
            SqlCommand cmd = new SqlCommand(sb.ToString(), conn);
            conn.Open();
            i = cmd.ExecuteNonQuery();
            conn.Close();
        }
        return i;
    }
    [WebMethod(EnableSession = true)]
    public int TopArticle(string ids)
    {
        int i = 0;
        using (SqlConnection conn = new DB().GetConnection())
        {   //新建文章数据
            StringBuilder sb = new StringBuilder("update Articles set orders+=1 where ID in (" + ids + ")");
            SqlCommand cmd = new SqlCommand(sb.ToString(), conn);
            conn.Open();
            i = cmd.ExecuteNonQuery();
            conn.Close();
        }
        return i;
    }
    [WebMethod(EnableSession = true)]
    public int MoveArticle(string ids, string catid, string catname, string subid, string subname)
    {
        int i = 0;
        string add = "";
        if (subname != "") add = ",SubID=@SubID,SubName=@SubName";
        else add = ",SubID='',SubName=''";
        using (SqlConnection conn = new DB().GetConnection())
        {   //新建文章数据
            StringBuilder sb = new StringBuilder("update Articles set CatID=@CatID,CatName=@CatName" + add + " where ID in (" + ids + ")");
            SqlCommand cmd = new SqlCommand(sb.ToString(), conn);
            cmd.Parameters.AddWithValue("@CatID", catid);
            cmd.Parameters.AddWithValue("@CatName", catname);
            cmd.Parameters.AddWithValue("@SubID", subid);
            cmd.Parameters.AddWithValue("@SubName", subname);
            conn.Open();
            i = cmd.ExecuteNonQuery();
            conn.Close();
        }
        return i;
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
