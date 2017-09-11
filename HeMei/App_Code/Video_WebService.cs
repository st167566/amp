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
/// Video_WebService 的摘要说明
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// 若要允许使用 ASP.NET AJAX 从脚本中调用此 Web 服务，请取消注释以下行。 
[System.Web.Script.Services.ScriptService]
public class Video_WebService : System.Web.Services.WebService
{

    public Video_WebService()
    {

        //如果使用设计的组件，请取消注释以下行 
        //InitializeComponent(); 
    }

    [WebMethod]
    public string HelloWorld()
    {
        return "Hello World";
    }

    [WebMethod(EnableSession = true)]
    public string SaveComment(string ArticleID, string ArticleTitle, string SubName, string Comment, string PublisherAvatar, string IsAnonymous, string ShowName, string WebID)
    {
        using (SqlConnection conn = new DB().GetConnection())
        {
            SqlCommand cmd = conn.CreateCommand();
            conn.Open();
            StringBuilder sb = new StringBuilder("Insert into ArticleView_Comment (ArticleID,ArticleTitle,SubName,PublisherID,[Comment],PublishTime,IsAnonymous,ShowName,Visible,PublisherName,PublisherAvatar,WebID)");
            sb.Append(" values(@ArticleID,@ArticleTitle,@SubName,@PublisherID,@Comment,@PublishTime,@IsAnonymous,@ShowName,@Visible,@PublisherName,@PublisherAvatar,@WebID)");
            cmd = new SqlCommand(sb.ToString(), conn);
            cmd.Parameters.AddWithValue("@ArticleID", ArticleID);
            cmd.Parameters.AddWithValue("@ArticleTitle", ArticleTitle);
            cmd.Parameters.AddWithValue("@SubName", SubName);
            cmd.Parameters.AddWithValue("@PublisherID", Session["UserID"].ToString());
            cmd.Parameters.AddWithValue("@Comment", Comment);
            cmd.Parameters.AddWithValue("@PublisherName", Session["UserName"].ToString());
            cmd.Parameters.AddWithValue("@PublisherAvatar", PublisherAvatar);
            cmd.Parameters.AddWithValue("@PublishTime", DateTime.Now.ToString());
            cmd.Parameters.AddWithValue("@IsAnonymous", IsAnonymous);
            cmd.Parameters.AddWithValue("@ShowName", ShowName);
            cmd.Parameters.AddWithValue("@Visible", 1);
            cmd.Parameters.AddWithValue("@WebID", WebID);
            cmd.ExecuteNonQuery();   //插入成功
            cmd.Dispose();

            cmd.CommandText = "update Articles set ReviewTimes = ReviewTimes +1 where ID =@ArticleID";
            cmd.ExecuteNonQuery();
            conn.Close();
        }
        return "0";
    }

    /*用于初始化相关推荐模块,已弃用*/
    //[WebMethod(EnableSession = true)]
    //public string LoadRelateRecomend(string handle,string ListID,string SubID)
    //{
    //    if (handle == "doGetData")
    //    {
    //        using (SqlConnection conn = new DB().GetConnection())
    //        {
    //            SqlCommand cmd = conn.CreateCommand();
    //            conn.Open();
    //            if (!String.IsNullOrEmpty(ListID)) 
    //            {
    //                cmd.CommandText = "select top 5* from Cats where ID <>'" + ListID + "'AND WebID = 6 order by ID Desc";
    //            }
    //            if (!String.IsNullOrEmpty(SubID)) 
    //            {
    //                cmd.CommandText = "select top 5* from Subs where ID <>'" + SubID + "'AND WebID = 6 order by ID Desc";
    //            }

    //            SqlDataAdapter da = new SqlDataAdapter(cmd.CommandText, conn);
    //            DataSet ds = new DataSet();
    //            da.Fill(ds);
    //            conn.Close();
    //            return Dtb2Json(ds.Tables[0]);
    //        }
    //    }
    //    else
    //    {
    //        return "";
    //    }
    //}

    [WebMethod(EnableSession = true)]
    public string LoadHotClick(string handle)
    {
        if (handle == "doGetData")
        {
            using (SqlConnection conn = new DB().GetConnection())
            {
                StringBuilder sb = new StringBuilder("select top 5* from Articles where  WebID = 6 order by ViewTimes Desc");
                SqlCommand cmd = new SqlCommand(sb.ToString(), conn);
                conn.Open();
                SqlDataAdapter da = new SqlDataAdapter(cmd.CommandText, conn);
                DataSet ds = new DataSet();
                da.Fill(ds);
                conn.Close();
                return Util.Dtb2Json(ds.Tables[0]);
            }
        }
        else
        {
            return "";
        }
    }

    //Index页面
    [WebMethod]
    public string getHotClick()
    {

        using (SqlConnection conn = new DB().GetConnection())
        {
            StringBuilder sb = new StringBuilder("select top 6* from Articles where  WebID = 6 order by ViewTimes Desc");
            SqlCommand cmd = new SqlCommand(sb.ToString(), conn);
            conn.Open();
            SqlDataAdapter da = new SqlDataAdapter(cmd.CommandText, conn);
            DataSet ds = new DataSet();
            da.Fill(ds);
            conn.Close();
            return Util.Dtb2Json(ds.Tables[0]);
        }
    }

    [WebMethod]
    public string getVideo(string ArticleID)
    {
        using (SqlConnection conn = new DB().GetConnection())
        {
            SqlCommand cmd = conn.CreateCommand();
            conn.Open();
            cmd.CommandText = "select * from [Articles] where [ID] = '" + ArticleID + "' and [IsFinished] = 1 and [Valid] = 1";
            SqlDataAdapter da = new SqlDataAdapter(cmd.CommandText, conn);
            DataSet ds = new DataSet();
            da.Fill(ds);
            conn.Close();
            return Util.Dtb2Json(ds.Tables[0]);
        }


    }



    [WebMethod]
    public string getBRData(string SubID)
    {
        using (SqlConnection conn = new DB().GetConnection())
        {
            //精品推荐子栏目作品
            string sql = "select top 4 * from Articles where CatID = 30 and SubID = @SubID AND Status =1 and Finished = 1 and Valid = 1 and WebID =6 Order by Orders Desc,CDT Desc,ID Desc";
            SqlCommand cmd = new SqlCommand(sql, conn);
            if (String.IsNullOrEmpty(SubID))
            {
                cmd.Parameters.AddWithValue("@SubID", 93);
            }
            else
            {
                cmd.Parameters.AddWithValue("@SubID", SubID);
            }
            conn.Open();
            SqlDataAdapter da = new SqlDataAdapter(cmd.CommandText, conn);
            DataSet ds = new DataSet();
            da.Fill(ds);
            conn.Close();
            return Util.Dtb2Json(ds.Tables[0]);

        }
    }

    [WebMethod]
    public string LoadRelateArticle(string ArticleID)
    {
        using (SqlConnection conn = new DB().GetConnection())
        {
            SqlCommand cmd = conn.CreateCommand();
            conn.Open();
            cmd.CommandText = "select * from [Articles] where [ID] <> '" + ArticleID + "'And [Status] =1 and [IsFinished] = 1 and [Valid] = 1 and [CatID] = 32 order by ID desc";
            SqlDataAdapter da = new SqlDataAdapter(cmd.CommandText, conn);
            DataSet ds = new DataSet();
            da.Fill(ds);
            conn.Close();
            return Util.Dtb2Json(ds.Tables[0]);
        }
    }



}
