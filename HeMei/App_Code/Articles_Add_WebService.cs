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
/// Articles_Add_WebService 的摘要说明
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// 若要允许使用 ASP.NET AJAX 从脚本中调用此 Web 服务，请取消注释以下行。 
[System.Web.Script.Services.ScriptService]
public class Articles_Add_WebService : System.Web.Services.WebService {
    public Articles_Add_WebService () {

        //如果使用设计的组件，请取消注释以下行 
        //InitializeComponent(); 
    }
    [WebMethod]
    public string HelloWorld() {
        return "Hello World";
    }
    /*用于初始化Cat下拉框*/
    [WebMethod(EnableSession = true)]
    public string LoadCat() {
        using (SqlConnection conn = new DB().GetConnection())
        {
            StringBuilder sb = new StringBuilder("select * from Cats where WebID=" + Session["WebID"].ToString());
            SqlCommand cmd = new SqlCommand(sb.ToString(), conn);
            conn.Open();
            SqlDataAdapter da = new SqlDataAdapter(cmd.CommandText, conn);
            DataSet ds = new DataSet();
            da.Fill(ds);
            conn.Close();
            return Dtb2Json(ds.Tables[0]);
        }

    }
    /*用于初始化Sub下拉框*/
    [WebMethod]
    public string LoadSub(string CID)
    {
        using (SqlConnection conn = new DB().GetConnection())
        {
            StringBuilder sb = new StringBuilder("select * from Subs where CatID="+"'"+CID+"'");
            SqlCommand cmd = new SqlCommand(sb.ToString(), conn);
            conn.Open();
            SqlDataAdapter da = new SqlDataAdapter(cmd.CommandText, conn);
            DataSet ds = new DataSet();
            da.Fill(ds);
            conn.Close();
            return Dtb2Json(ds.Tables[0]);
        }
    }

    /*用于初始化UserTag下拉框*/
    [WebMethod(EnableSession = true)]
    public string UserTag(string handle)
    {
        if (handle == "doinsert")
        {//新建的话找到该用户的Tags（职位或单位）
            using (SqlConnection conn = new DB().GetConnection())
            {
                StringBuilder sb = new StringBuilder("select UserTags.*,Users_UserTags.* from Users_UserTags inner join UserTags on Users_UserTags.UserTagID=UserTags.ID where Users_UserTags.UserID='" + Context.Session["UserID"] + "'");
                SqlCommand cmd = new SqlCommand(sb.ToString(), conn);
                conn.Open();
                SqlDataAdapter da = new SqlDataAdapter(cmd.CommandText, conn);
                DataSet ds = new DataSet();
                da.Fill(ds);
                conn.Close();
                return Dtb2Json(ds.Tables[0]);
            }
        }
        else 
        { //更新的话找到文章作者的职务
            return ""; 
        }
    }
    /*用于保存/发布按钮*/
    [WebMethod(EnableSession = true)]
    public string SaveArticle(string handle, string title, string content, string summary, string coverurl, string catid, string subid, string usertagid, string enclosure, string articletags, string CDT, string islist, string iscomment, string article_id, string enclosure_name, string finished, string catname, string subname, string author, string tagname, string randomid1)
    {
        string authorid = "";//创建者的ID
        int i = 0;//回发状态
        string randomID = Guid.NewGuid().ToString();
        string nowdate = DateTime.Now.ToString("yyyy-MM-dd");
        if (handle == "doinsert")
        {//新建文章
            using (SqlConnection conn = new DB().GetConnection())
            {   //新建文章数据
                StringBuilder sb = new StringBuilder("Insert into Articles ( Title,Content,Summary,CatID,CatName,SubID,SubName,AuthorID,Author,CDT,IsFinished,Valid,ViewTimes,UserTagID,UserTagName,Comments,Likes,Orders,CoverImageURL,IsList,AllowComment,WebID,RandomID)");
                sb.Append(" values (@Title,@Content,@Summary,@CatID,@CatName,@SubID,@SubName,@AuthorID,@Author,@CDT,@IsFinished,1,0,@TagID,@TagName,0,0,0,@CoverImageURL,@IsList,@IsComment,@WebID,@RandomID)");
                SqlCommand cmd = new SqlCommand(sb.ToString(), conn);
                cmd.Parameters.AddWithValue("@Title", title);
                cmd.Parameters.AddWithValue("@Content", content);
                cmd.Parameters.AddWithValue("@Summary", summary);
                cmd.Parameters.AddWithValue("@CatID", catid);
                cmd.Parameters.AddWithValue("@CatName", catname);
                cmd.Parameters.AddWithValue("@SubID", subid);
                cmd.Parameters.AddWithValue("@SubName", subname);
                cmd.Parameters.AddWithValue("@AuthorID", Session["UserID"]);
                cmd.Parameters.AddWithValue("@Author", author);
                cmd.Parameters.AddWithValue("@CDT", CDT==""?nowdate:CDT);
                cmd.Parameters.AddWithValue("@IsFinished", finished);
                cmd.Parameters.AddWithValue("@TagID", usertagid);
                cmd.Parameters.AddWithValue("@TagName", tagname);
                cmd.Parameters.AddWithValue("@RandomID", randomID);
                cmd.Parameters.AddWithValue("@CoverImageURL", coverurl);
                cmd.Parameters.AddWithValue("@IsList", islist);
                cmd.Parameters.AddWithValue("@IsComment", iscomment);
                cmd.Parameters.AddWithValue("@WebID", Session["WebID"].ToString());
                conn.Open();
                cmd.ExecuteNonQuery();
                cmd.Dispose();
                //查找新增文章的ID
                cmd.CommandText = "select * from Articles where RandomID = @RandomID";
                SqlDataReader rd = cmd.ExecuteReader();
                if (rd.Read())article_id = rd["ID"].ToString();
                cmd.Dispose();
                rd.Close();
                //新增文章与附件关联
                if (enclosure != "")
                {
                    string[] fileurl = enclosure.Split(',');
                    string[] fname = enclosure_name.Split(',');
                    string cmdadd = "";
                    for (int j = 1; j < fileurl.Length; j++) { cmdadd += ",('" + fileurl[j] + "','" + article_id + "','" + fname[j] + "')"; };
                    cmd.CommandText = "Insert into [Article_Resource] (ResourceURL,ArticleID,ResourceName)values (@FileURL,@ArticleID,@FileName)" + cmdadd;
                    cmd.Parameters.AddWithValue("@FileURL", fileurl[0]);
                    cmd.Parameters.AddWithValue("@ArticleID", article_id);
                    cmd.Parameters.AddWithValue("@FileName", fname[0]);
                    cmd.ExecuteNonQuery();
                    cmd.Dispose();
                }
                cmd.CommandText = "update Article_Resource set ArticleID=@ArticleID2 where RandomID='"+randomid1+"'";
                cmd.Parameters.AddWithValue("@ArticleID2", article_id);
                cmd.ExecuteNonQuery();
                cmd.Dispose();
                //新增文章与标签关联
                if (articletags != "")
                {
                    string[] tag = articletags.Split(',');
                    string cmdadd = "";
                    for (int j = 1; j < tag.Length; j++) { cmdadd += ",('" + tag[j] + "','" + article_id + "','"+Session["WebID"]+"','"+Session["UserID"]+"')"; };
                    cmd.CommandText = "Insert into Articles_ArticleTags (ArticleTagName,ArticleID,WebID,UserID)values (@ArticleTagName,@ArticleID1,@WebID,@UserID)" + cmdadd;
                    cmd.Parameters.AddWithValue("@ArticleTagName", tag[0]);
                    cmd.Parameters.AddWithValue("@ArticleID1", article_id);
                    cmd.Parameters.AddWithValue("@UserID", Session["UserID"]);
                    cmd.ExecuteNonQuery();
                    cmd.Dispose();
                }
                conn.Close();
            }
        }
        else if(handle=="doupdata"){
           article_id = Session["ArticleID"].ToString();
            using (SqlConnection conn = new DB().GetConnection())
            {   //新建文章数据
                StringBuilder sb = new StringBuilder("Update Articles set Title=@Title,Content=@Content,CatName=@CatName,SubName=@SubName,UpdateAuthor=@UpdateAuthor,Summary=@Summary,CatID=@CatID,SubID=@SubID,UpdateAuthorID=@UpdateAuthorID,LDT=@LDT,CoverImageURL=@CoverImageURL,IsList=@IsList,AllowComment=@IsComment,IsFinished=@Finished where ID=@ArticleID");
                SqlCommand cmd = new SqlCommand(sb.ToString(), conn);
                cmd.Parameters.AddWithValue("@ArticleID", article_id);
                cmd.Parameters.AddWithValue("@Title", title);
                cmd.Parameters.AddWithValue("@Content", content);
                cmd.Parameters.AddWithValue("@Summary", summary);
                cmd.Parameters.AddWithValue("@CatID", catid);
                cmd.Parameters.AddWithValue("@SubID", subid);
                cmd.Parameters.AddWithValue("@CatName", catname);
                cmd.Parameters.AddWithValue("@SubName", subname);
                cmd.Parameters.AddWithValue("@UpdateAuthor", author);
                cmd.Parameters.AddWithValue("@UpdateAuthorID", Session["UserID"]);
                cmd.Parameters.AddWithValue("@LDT", CDT == "" ? nowdate : CDT);
                cmd.Parameters.AddWithValue("@CoverImageURL", coverurl);
                cmd.Parameters.AddWithValue("@IsList", islist);
                cmd.Parameters.AddWithValue("@IsComment", iscomment);
                cmd.Parameters.AddWithValue("@Finished", finished);
                conn.Open();
                i=cmd.ExecuteNonQuery();
                //删除旧的附件关联
                cmd.CommandText = "Delete from Article_Resource where ArticleID = @ArticleID and (RandomID='' or RandomID is NULL)";
                cmd.ExecuteNonQuery();
                //删除旧的TAG
                cmd.CommandText = "Delete from Articles_ArticleTags where ArticleID = @ArticleID";
                cmd.ExecuteNonQuery();
                cmd.CommandText = "update Article_Resource set ArticleID=@ArticleID where RandomID='" + randomid1 + "'";
                cmd.ExecuteNonQuery();
                cmd.Dispose();
                //新增文章与附件关联
                if (enclosure != "")
                {
                    string[] fileurl = enclosure.Split(',');
                    string[] fname = enclosure_name.Split(',');
                    string cmdadd = "";
                    for (int j = 1; j < fileurl.Length; j++) { cmdadd += ",('" + fileurl[j] + "','" + article_id + "','" + fname[j] + "')"; };
                    cmd.CommandText = "Insert into [Article_Resource] (ResourceURL,ArticleID,ResourceName)values (@FileURL,@ArticleID,@FileName)" + cmdadd;
                    cmd.Parameters.AddWithValue("@FileURL", fileurl[0]);
                    cmd.Parameters.AddWithValue("@FileName", fname[0]);
                    cmd.ExecuteNonQuery();
                    cmd.Dispose();
                }
                //新增文章与标签关联
                if (articletags != "")
                {
                    string[] tag = articletags.Split(',');
                    string cmdadd = "";
                    for (int j = 1; j < tag.Length; j++) { cmdadd += ",('" + tag[j] + "','" + article_id + "','" + Session["WebID"] + "','" + Session["UserID"] + "')"; };
                    cmd.CommandText = "Insert into Articles_ArticleTags (ArticleTagName,ArticleID,WebID,UserID)values (@ArticleTagName,@ArticleID1,@WebID,@UserID)" + cmdadd;
                    cmd.Parameters.AddWithValue("@ArticleTagName", tag[0]);
                    cmd.Parameters.AddWithValue("@ArticleID1", article_id);
                    cmd.Parameters.AddWithValue("@UserID", Session["UserID"]);
                    cmd.Parameters.AddWithValue("@WebID", Session["WebID"].ToString());
                    cmd.ExecuteNonQuery();
                    cmd.Dispose();
                }
                conn.Close();
                
            }
        }
        return article_id;
    }
    /*加载初始化页面,包括Title，Context,Summary,Cat,Sub,IsList,IsComment,CoverPhoto*/
    [WebMethod]
    public DataSet Myinit(string article_id)
    {
        using (SqlConnection conn = new DB().GetConnection())
        {
            StringBuilder sb = new StringBuilder("select * from Articles where ID='" + article_id + "'");
            SqlCommand cmd = new SqlCommand(sb.ToString(), conn);
            conn.Open();
            SqlDataAdapter da = new SqlDataAdapter(cmd.CommandText, conn);
            DataSet ds = new DataSet();
            da.Fill(ds);
            conn.Close();
            return ds;
        }
    }
    /*加载初始化页面,包括TAG*/
    [WebMethod]
    public string Tagsinit(string article_id)
    {
        using (SqlConnection conn = new DB().GetConnection())
        {
            StringBuilder sb = new StringBuilder("select * from [Articles_ArticleTags] where [ArticleID]='" + article_id + "'");
            SqlCommand cmd = new SqlCommand(sb.ToString(), conn);
            conn.Open();
            SqlDataAdapter da = new SqlDataAdapter(cmd.CommandText, conn);
            DataSet ds = new DataSet();
            da.Fill(ds);
            conn.Close();
            return Dtb2Json(ds.Tables[0]);
        }
    }
    /*加载初始化页面,包括TAG*/
    [WebMethod]
    public string Filesinit(string article_id)
    {
        using (SqlConnection conn = new DB().GetConnection())
        {
            StringBuilder sb = new StringBuilder("select * from [Article_Resource] where (RandomID=''or RandomID is NULL) and [ArticleID]='" + article_id + "'");
            SqlCommand cmd = new SqlCommand(sb.ToString(), conn);
            conn.Open();
            SqlDataAdapter da = new SqlDataAdapter(cmd.CommandText, conn);
            DataSet ds = new DataSet();
            da.Fill(ds);
            conn.Close();
            return Dtb2Json(ds.Tables[0]);
        }
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
