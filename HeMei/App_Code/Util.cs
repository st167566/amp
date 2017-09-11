using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.Text;
using System.IO;
using System.Configuration;
using System.Web.Script.Serialization;

/// <summary>
///Util 的摘要说明
/// </summary>
public class Util
{
    public static string strSuccess = "操作成功！";
    public static string strFail = "操作失败，请重试！";

    public static string strFile = "";
    public static void SetFileName(string FileName)
    {
        strFile += FileName;
    }
    public static string GetFileName()
    {
        return strFile;
    }
    public static void CleanFileName()
    {
        strFile = "";
    }

	public Util()
	{
		//
		//TODO: 在此处添加构造函数逻辑
		//
	}

    /*用于DataSet转化为Json字符串返回*/
    public static string Dtb2Json(DataTable dtb)
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

    public static string GetFileType(string FileExtension)
    {
        int i = 0;
        string s = "";
        //{Image,Video,Audio,Flash}
        String[] ss = { ".jpg,.gif,.png,.bmp", ".flv,.mp4,.mpeg,.avi,.wav", ".mp3", ".swf" };
        for (i = 0; i < ss.Length;i++ )
        {
            if (itemExist(ss[i], FileExtension))
            {   
                break;
            }
        }

        switch (i)
        {
            case 0: s = "Images"; break;
            case 1: s = "Video"; break;
            case 2: s = "Audio"; break;
            case 3: s = "Flash"; break;
            default: s = "";break ;
        }
        return s;
    }

    //s1="1,2,3,123,23";s2="3"; 判断s2,是否在s1中,
    public static bool itemExist(string s1, string s2)
    {
        bool r = false;
        if (!String.IsNullOrEmpty(s1))
        {
            string[] ss = s1.Split(',');
            for (int i = 0; i < ss.Length; i++)
            {
                if (!String.IsNullOrEmpty(ss[i]) && s2 == ss[i].Trim())
                {
                    r = true;
                    break;
                }
            }
        }
        return r;
    }

    public static string GetHash(string password)
    {
        byte[] b = System.Text.ASCIIEncoding.ASCII.GetBytes(password);
        byte[] b2 = new SHA1Managed().ComputeHash(b);
        return Convert.ToBase64String(b2, 0, b2.Length);
    }

    public static bool Qualified(string purview)
    {
        bool result = false;
        if (System.Web.HttpContext.Current.Session["Purview"] == null)
        {
            result = false;
        }
        else
        {
            if( System.Web.HttpContext.Current.Session["Purview"].ToString().Equals("超级管理员") )
            {
                result = true;
            }
            else
            {
                string[] s = purview.Split(',');
                for (int i = 0; i < s.Length; i++)
                {
                    if (System.Web.HttpContext.Current.Session["Purview"].ToString().Equals(s[i]))
                    {
                        result = true;
                        break;
                    }
                }
            }
        }
        return result;
    }

    public static void ShowMessage(string words, string location)
    {
        System.Web.HttpContext.Current.Response.Write("<script>alert('" + words + "');</script>");
        System.Web.HttpContext.Current.Response.Write("<script>location.href='" + location + "';</script>");

    }

    //记录用户操作历史
    public static void UserUtil_Notes(string utilwords,int i,string entitywords,string UserName,string VisitPage,string UserIP,int webID) 
    {
         string datetime = DateTime.Now.ToString();
        StringBuilder MyStringBuilder = new StringBuilder();
        MyStringBuilder.Append(utilwords);
        MyStringBuilder.Append(i);
        MyStringBuilder.Append(entitywords);
        string finalwords = MyStringBuilder.ToString();
        using (SqlConnection conn = new DB().GetConnection())
        {
            StringBuilder sb = new StringBuilder("insert into [UserUtil_Notes]( Util,UserName,VisitPage,VisitDatetime,UserIP,WebID)");
            sb.Append(" values ( @Util,@UserName,@VisitPage,@VisitDatetime,@UserIP,@webID) ");
            SqlCommand cmd = new SqlCommand(sb.ToString(), conn);
            cmd.Parameters.AddWithValue("@Util", finalwords);
            cmd.Parameters.AddWithValue("@UserName", UserName);
            cmd.Parameters.AddWithValue("@VisitPage", VisitPage);
            cmd.Parameters.AddWithValue("@VisitDatetime", datetime);
            cmd.Parameters.AddWithValue("@UserIP", UserIP);
            cmd.Parameters.AddWithValue("@webID", webID);
            conn.Open();
            i = cmd.ExecuteNonQuery();
            cmd.Dispose();

        }
    }

    // 用户登录，失败返回-1，成功返回RoleID
    public static int  DoLogin(string username, string password,int webid)
    {
        int roleID = -1;
        string UserID = "1";
        using (SqlConnection conn = new DB().GetConnection())
        {
            SqlCommand cmd = conn.CreateCommand();
            cmd.CommandText = "select * from [Users] where [WebID] = @WebID and [UserName] = @UserName and [Password] = @Password ";
            cmd.Parameters.AddWithValue("@UserName", username);
            cmd.Parameters.AddWithValue("@Password", Util.GetHash(password));
            cmd.Parameters.AddWithValue("@WebID", webid);
            conn.Open();
            SqlDataReader rd = cmd.ExecuteReader();
            if (rd.Read())
            {
                roleID = Convert.ToInt16(rd["RoleID"]);
                System.Web.HttpContext.Current.Session["RoleID"] = roleID;
                System.Web.HttpContext.Current.Session["RoleName"] = rd["RoleName"].ToString();
                System.Web.HttpContext.Current.Session["Email"] = rd["Email"].ToString();
                System.Web.HttpContext.Current.Session["UserName"] = username;
                System.Web.HttpContext.Current.Session["Avatar"] = rd["avatar"].ToString();
                UserID = rd["ID"].ToString();
                System.Web.HttpContext.Current.Session["UserID"] = UserID;
                System.Web.HttpContext.Current.Session["WebID"] = rd["WebID"].ToString();
            }
            cmd.Dispose();
            rd.Close();
        }
        return roleID;
    }

    public static bool AreadyExist(string table, string column, string value,int WebID)
    {
        bool result = false;
        using (IDbConnection conn = new DB().GetConnection())
        {
            IDbCommand cmd = conn.CreateCommand();
            cmd.CommandText = "select count(*) from " + table + " where " + column + " = '" + value + "'" +"and WebID = '" + WebID + "'";
            conn.Open();
            if ((int)cmd.ExecuteScalar() > 0)
            {
                result = true;
            }
        }
        return result;
    }

    public static bool AreadyExistd(string table, string column, string[] value)
    {
        bool result = false;
        using (IDbConnection conn = new DB().GetConnection())
        {
            IDbCommand cmd = conn.CreateCommand();
            cmd.CommandText = "select count(*) from " + table + " where " + column + " = '" + value + "'";
            conn.Open();
            if ((int)cmd.ExecuteScalar() > 0)
            {
                result = true;
            }
        }
        return result;
    }

    public static bool SessionOut(string [] key)
    {
        bool result = false;
        for (int i = 0; i < key.Length; i++)
        {
            if (System.Web.HttpContext.Current.Session[key[i]] == null)
            {
                result = true;
                break;
            }
        }
        return result;
    }

    public void Operate()
    {
        //System.Web.HttpContext.Current.
    }

    public static int permission(string ArticleID )
    {
        int authorID = -1;
        using (SqlConnection conn = new DB().GetConnection())
        {
            SqlCommand cmd = conn.CreateCommand();
            cmd.CommandText = "select * from [Articles] where [ID] = @ArticleID ";
            cmd.Parameters.AddWithValue("@ArticleID", ArticleID);
            conn.Open();
            SqlDataReader rd = cmd.ExecuteReader();
            if (rd.Read())
            {
                authorID = Convert.ToInt16(rd["AuthorID"]);
                System.Web.HttpContext.Current.Session["AuthorID"] = authorID;

            }
            cmd.Dispose();
            rd.Close();
        }

        return authorID;
    }

    //更新母版头像和用户完善页头像
    public static int UpdateAvatar(string username)
    {
        int roleID = -1;
        using (SqlConnection conn = new DB().GetConnection())
        {
            SqlCommand cmd = conn.CreateCommand();
            cmd.CommandText = "select * from [Users] where [UserName] = @UserName ";
            cmd.Parameters.AddWithValue("@UserName", username);
            conn.Open();
            SqlDataReader rd = cmd.ExecuteReader();
            if (rd.Read())
            {
                roleID = Convert.ToInt16(rd["RoleID"]);
                System.Web.HttpContext.Current.Session["RoleID"] = roleID;
                System.Web.HttpContext.Current.Session["RoleName"] = rd["RoleName"].ToString();
                System.Web.HttpContext.Current.Session["Avatar"] = rd["Avatar"].ToString();
          

            }
            cmd.Dispose();
            rd.Close();
        }

        return roleID;
    }

    //返回所在网站前台
    public static string ReturnWeb(int webid) 
    {
        string web = "";
        if (webid == (int)EnumClass.SMSSource.GZY)
        {
            web = EnumClass.SMSSource.GZY.ToString();
        }
        else if (webid == (int)EnumClass.SMSSource.SEST)
        {
            web = EnumClass.SMSSource.SEST.ToString();
        }
        else if (webid == (int)EnumClass.SMSSource.DMC)
        {
            web = EnumClass.SMSSource.DMC.ToString();
        }
        else 
        {
            web = EnumClass.SMSSource.GSSE.ToString();
        }
        return web;
    }
}
