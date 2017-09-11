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
/// User_WebService 的摘要说明
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// 若要允许使用 ASP.NET AJAX 从脚本中调用此 Web 服务，请取消注释以下行。 
[System.Web.Script.Services.ScriptService]
public class User_WebService : System.Web.Services.WebService
{

    public User_WebService()
    {

        //如果使用设计的组件，请取消注释以下行 
        //InitializeComponent(); 
    }

    [WebMethod]
    public string HelloWorld()
    {
        return "Hello World";
    }

   
    //用户模块
    [WebMethod(EnableSession = true)]
    public string InitManUser()
    {
        DataSet ds;
        using (SqlConnection conn = new DB().GetConnection())
        {
          
            StringBuilder sb = new StringBuilder("");
            //if (Convert.ToInt32(Session["RoleID"]) > 2)
            //{
                sb.Append(@"select a.*,b.UserID,b.RoleID,b.Valid
FROM Webs_Users AS b 
LEFT JOIN
Users as a
ON b.UserID = a.ID
where b.WebID = '" + Convert.ToInt32(Session["WebID"].ToString()) + "'");
            //}
            //else
            //{
            //    sb.Append("select * from Users");
            //}
            SqlCommand cmd = new SqlCommand(sb.ToString(), conn);
            conn.Open();
            SqlDataAdapter da = new SqlDataAdapter(cmd.CommandText, conn);
            ds = new DataSet();
            da.Fill(ds);
            conn.Close();
            return Util.Dtb2Json(ds.Tables[0]);
  
        }
    }

    [WebMethod(EnableSession = true)]
    public string addUserIntoWeb(string UserID, string WebID, string RoleID)
    {
        int i = 0;
        string[] array = WebID.Split(',');
        int len = array.Length;
        using (SqlConnection conn = new DB().GetConnection())
        {
            conn.Open();
            for (int j = 0; j < len; j++)
            {
                StringBuilder sb = new StringBuilder("insert into Webs_Users(WebID,UserID,RoleID,CDT,CreatorID) ");
                sb.Append("values (@WebID,@UserID,@RoleID,@CDT,@CreatorID)");
                SqlCommand cmd = new SqlCommand(sb.ToString(), conn);
                cmd.Parameters.AddWithValue("@WebID", array[j]);
                cmd.Parameters.AddWithValue("@UserID", UserID);
                cmd.Parameters.AddWithValue("@RoleID", RoleID);
                cmd.Parameters.AddWithValue("@CDT", DateTime.Now);
                cmd.Parameters.AddWithValue("@CreatorID", Session["UserID"].ToString());
                i = cmd.ExecuteNonQuery();

            }
            conn.Close();
        }
        if (i == 1)
        {
            return "Success";
        }
        else
        {
            return "Fail";
        }
    }

    [WebMethod(EnableSession = true)]
    public int forbiddenUser(string ids) 
    {
        int i = 0;
        using (SqlConnection conn = new DB().GetConnection())
        {  
            StringBuilder sb = new StringBuilder("update Webs_Users set Valid=0 where UserID in (" + ids + ") and WebID = "+Session["WebID"].ToString());
            SqlCommand cmd = new SqlCommand(sb.ToString(), conn);
            conn.Open();
            i = cmd.ExecuteNonQuery();
            conn.Close();
        }
        return i;
    }

    [WebMethod(EnableSession = true)]
    public int ensureUser(string ids)
    {
        int i = 0;
        using (SqlConnection conn = new DB().GetConnection())
        { 
            StringBuilder sb = new StringBuilder("update Webs_Users set Valid=1 where UserID in (" + ids + ") and WebID = " + Session["WebID"].ToString());
            SqlCommand cmd = new SqlCommand(sb.ToString(), conn);
            conn.Open();
            i = cmd.ExecuteNonQuery();
            conn.Close();
        }
        return i;
    }

    [WebMethod(EnableSession = true)]
    public int delAllUser(string ids)
    {
        int i = 0;
        using (SqlConnection conn = new DB().GetConnection())
        {
            StringBuilder sb = new StringBuilder("delete from Webs_Users  where UserID in (" + ids + ") and WebID = " + Session["WebID"].ToString());
            SqlCommand cmd = new SqlCommand(sb.ToString(), conn);
            conn.Open();
            i = cmd.ExecuteNonQuery();
            conn.Close();
        }
        return i;
    }


    [WebMethod(EnableSession = true)]
    public string showWeb(string UserID)
    {
        using (SqlConnection conn = new DB().GetConnection())
        {
            DataSet ds;
            StringBuilder sb = new StringBuilder("");
            if (Convert.ToInt32(Session["RoleID"]) > 2)
            {
                sb.Append("select * from Users where WebID = '" + Convert.ToInt32(Session["WebID"].ToString()) + "'");
            }
            else
            {
                sb.Append(@"SELECT a.WebID,b.WebName 
                            FROM  Webs_Users AS a
                            inner join
                            WebSite as b
                            on  a.WebID = b.ID
                            where a.UserID = "+ UserID);
            }
            SqlCommand cmd = new SqlCommand(sb.ToString(), conn);
            conn.Open();
            SqlDataAdapter da = new SqlDataAdapter(cmd.CommandText, conn);
            ds = new DataSet();
            da.Fill(ds);
            conn.Close();
            return Util.Dtb2Json(ds.Tables[0]);

        }
    }

    [WebMethod(EnableSession = true)]
    public string getRoles()
    {
        using (SqlConnection conn = new DB().GetConnection())
        {
            DataSet ds;
            StringBuilder sb = new StringBuilder("");
            //if (Convert.ToInt32(Session["RoleID"]) > 2)
            //{
                sb.Append("select * from Roles where ID > 2 ");
            //}
            //else
            //{
            //    sb.Append("select * from Roles where ID > 1");
            //}
            SqlCommand cmd = new SqlCommand(sb.ToString(), conn);
            conn.Open();
            SqlDataAdapter da = new SqlDataAdapter(cmd.CommandText, conn);
            ds = new DataSet();
            da.Fill(ds);
            conn.Close();
            return Util.Dtb2Json(ds.Tables[0]);

        }
    }

    [WebMethod(EnableSession = true)]
    public string SaveUserInfo(DateTime BirthDate, string Phone, string Status)
    {
        int i;
        using (SqlConnection conn = new DB().GetConnection())
        {

            StringBuilder sb = new StringBuilder("Update [Users] set TelePhone=@Phone,Status=@Signature,Birthdate=@Birthdate where ID=@UserID");
            SqlCommand cmd = new SqlCommand(sb.ToString(), conn);
            cmd.Parameters.AddWithValue("@Phone", Phone);
            cmd.Parameters.AddWithValue("@Signature", Status);
            cmd.Parameters.AddWithValue("@Birthdate", BirthDate);
            cmd.Parameters.AddWithValue("@UserID", Session["UserID"].ToString());
            conn.Open();
            i = cmd.ExecuteNonQuery();
            conn.Close();
        }
        return "Success";
    }

    [WebMethod(EnableSession = true)]
    public DataSet getValidAndRole(string WebID)
    {
        using (SqlConnection conn = new DB().GetConnection())
        {
            StringBuilder sb = new StringBuilder("Select RoleID from [Webs_Users] where UserID = '" + Session["UserID"].ToString() + "'" + "and WebID='" + WebID + "'");
            SqlCommand cmd = new SqlCommand(sb.ToString(), conn);
            conn.Open();
            SqlDataAdapter da = new SqlDataAdapter(cmd.CommandText, conn);
            DataSet ds = new DataSet();
            da.Fill(ds);
            conn.Close();
            return ds;

        }

    }

    [WebMethod(EnableSession = true)]
    public string insertWebsUsers(string WebID, string RoleID)
    {
        int i;
        using (SqlConnection conn = new DB().GetConnection())
        {
            StringBuilder sb = new StringBuilder("Insert into Webs_Users(WebID,UserID,RoleID,CDT,CreatorID)");
            sb.Append(" values (@WebID,@UserID,@RoleID,@CDT,@CreatorID)");
            SqlCommand cmd = new SqlCommand(sb.ToString(), conn);
            cmd.Parameters.AddWithValue("@WebID", WebID);
            cmd.Parameters.AddWithValue("@UserID", Session["UserID"].ToString());
            cmd.Parameters.AddWithValue("@RoleID", RoleID);
            cmd.Parameters.AddWithValue("@CDT", DateTime.Now);
            cmd.Parameters.AddWithValue("@CreatorID", Session["UserID"].ToString());
            conn.Open();
            i = cmd.ExecuteNonQuery();
            cmd.Dispose();

        }
        if (i == 1)
        {
            return "Success";
        }
        else
        {
            return "Fail";
        }
    }

    [WebMethod]

    public string getUsersByWeb(string WebID)
    {
        DataSet ds;
        string sql = "select * from Users  where WebID=" + WebID;
        using (SqlConnection conn = new DB().GetConnection())
        {
            SqlCommand cmd = conn.CreateCommand();
            cmd.CommandText = sql;
            conn.Open();
            SqlDataAdapter da = new SqlDataAdapter(cmd.CommandText, conn);
            ds = new DataSet();
            da.Fill(ds);
            conn.Close();
        }
        return Util.Dtb2Json(ds.Tables[0]);
    }

    [WebMethod]
    public string getUsersByRole(string RoleID)
    {
        DataSet ds;
        string sql = "select * from Users  where RoleID=" + RoleID;
        using (SqlConnection conn = new DB().GetConnection())
        {
            SqlCommand cmd = conn.CreateCommand();
            cmd.CommandText = sql;
            conn.Open();
            SqlDataAdapter da = new SqlDataAdapter(cmd.CommandText, conn);
            ds = new DataSet();
            da.Fill(ds);
            conn.Close();
        }
        return Util.Dtb2Json(ds.Tables[0]);
    }


    [WebMethod(EnableSession = true)]
    public string addUser(string UserName, string TrueName, string Password, string Email, string RoleID)
    {
        int i = 0;

        StringBuilder sqlInserUser = new StringBuilder("insert into [Users]( UserName,TrueName,Password,Email,RoleID,RegisterDateTime,WebID )");
        sqlInserUser.Append(" values ( @UserName,@TrueName,@Password,@Email,@RoleID,@RegisterDateTime,@WebID) SELECT @NewUserId=@@Identity ");

        StringBuilder sqlInserWebUser = new StringBuilder("insert into [Webs_Users](WebID,UserID,RoleID,CDT,CreatorID )");
        sqlInserWebUser.Append(" values ( @WebID,@UserID,@RoleID,@CDT,@CreatorID  ) ");

        using (SqlConnection conn = new DB().GetConnection())
        {
            conn.Open();
            // 显示开启事务
            SqlTransaction trans = conn.BeginTransaction();
            SqlCommand cmd = conn.CreateCommand();
            // 关联事务
            cmd.Transaction = trans;

            try
            {
                cmd.CommandText = sqlInserUser.ToString();
                cmd.Parameters.AddWithValue("@UserName", UserName);
                cmd.Parameters.AddWithValue("@TrueName", TrueName);
                cmd.Parameters.AddWithValue("@Password", Util.GetHash(Password));//密码加密
                cmd.Parameters.AddWithValue("@Email", Email);
                cmd.Parameters.AddWithValue("@RoleID", RoleID);
                cmd.Parameters.AddWithValue("@RegisterDateTime", DateTime.Now);
                cmd.Parameters.AddWithValue("@WebID", Session["WebID"].ToString());
                // 此输出参数返回新插入 UserId
                cmd.Parameters.Add("NewUserId", SqlDbType.Int).Direction = ParameterDirection.Output;
                // 插入 User
                cmd.ExecuteNonQuery();

                int newUserId = (int)cmd.Parameters["NewUserId"].Value;

                cmd.CommandText = sqlInserWebUser.ToString();
                cmd.Parameters.Clear();
                cmd.Parameters.AddWithValue("@WebID", Session["WebID"].ToString());
                cmd.Parameters.AddWithValue("@UserID", SqlDbType.Int);
                cmd.Parameters.AddWithValue("@RoleID", RoleID);
                cmd.Parameters.AddWithValue("@CDT", DateTime.Now);
                cmd.Parameters.AddWithValue("@CreatorID", Session["UserID"].ToString());
                cmd.Parameters[1].Value = newUserId;
                i = cmd.ExecuteNonQuery();



                // 提交事务
                trans.Commit();
                return String.Format("用户 '{0}' 创建成功。事务已提交。", UserName);
            }

            catch (Exception inner)
            {
                // 发生错误，回滚事务
                if (trans != null) trans.Rollback();
                return String.Format("用户 '{0}' 创建失败。/n事务已回滚。/n详细信息：{1}", UserName, inner.Message);
                //throw new Exception("创建用户失败。事务已回滚。", inner);
            }
        }

    }

    [WebMethod(EnableSession = true)]
    public string DelUser(string ID)
    {
        int i;
        using (SqlConnection conn = new DB().GetConnection())
        {
            StringBuilder sqlDelUser = new StringBuilder("delete from Webs_Users where WebID =@WebID AND UserID = @UserID");
            conn.Open();
            SqlCommand cmd = new SqlCommand(sqlDelUser.ToString(), conn);
            cmd.Parameters.AddWithValue("@WebID", Session["WebID"].ToString());
            cmd.Parameters.AddWithValue("@UserID", ID);
            i = cmd.ExecuteNonQuery();
            conn.Close();
        }
        if (i == 1)
        {
            return "Success";
        }
        else
        {
            return "Error";
        }

    }

    [WebMethod(EnableSession = true)]
    public string updateUserInfo(string UserID,string UserName, string TrueName, string Password, string Email, string RoleID)
    {
        int i;
        using (SqlConnection conn = new DB().GetConnection())
        {
            StringBuilder sqlUpdateUser = new StringBuilder(
                @"update [Users] set UserName = @UserName,
                 TrueName = @TrueName,
                 Password = @Password,
                 Email = @Email,
                 RoleID = @RoleID,
                 where ID = @ID");
            conn.Open();
            SqlCommand cmd = new SqlCommand(sqlUpdateUser.ToString(), conn);
            cmd.Parameters.AddWithValue("@UserName", UserName);
            cmd.Parameters.AddWithValue("@TrueName", TrueName);
            cmd.Parameters.AddWithValue("@Password", Util.GetHash(Password));//密码加密
            cmd.Parameters.AddWithValue("@Email", Email);
            cmd.Parameters.AddWithValue("@RoleID", RoleID);
            cmd.Parameters.AddWithValue("@ID", UserID);
            i = cmd.ExecuteNonQuery();
            conn.Close();
        }
        if (i == 1)
        {
            return "Success";
        }
        else
        {
            return "Error";
        }
    }


    [WebMethod]
    public string delWebUser(string UserID, string WebID)
    {
        int i = 0;
        string[] array = WebID.Split(',');
        int len = array.Length;
      
        using (SqlConnection conn = new DB().GetConnection())
        {
            StringBuilder sb = new StringBuilder("delete from Webs_Users where UserID=@UserID and WebID in (" + WebID + ")");
            SqlCommand cmd = new SqlCommand(sb.ToString(), conn);
            cmd.Parameters.AddWithValue("@UserID", UserID);
            conn.Open();
            cmd.ExecuteNonQuery();
            cmd.Dispose();
            conn.Close();

        }
        if (i == 1)
        {
            return "Success";
        }
        else
        {
            return "Fail";
        }
    }


    //检查用户是否唯一
    [WebMethod(EnableSession = true)]
    public int checkUser(string UserName)
    {
        Boolean check = Util.AreadyExist("Users", "UserName", UserName, Convert.ToInt32(Session["WebID"].ToString()));
        if (check)
        {
            return 1;
        }
        else
        {
            return -1;
        }
    }

  
    //网站模块
    [WebMethod(EnableSession = true)]
    public string getWebData()
    {
        using (SqlConnection conn = new DB().GetConnection())
        {

            StringBuilder sb = new StringBuilder("select distinct WebName as WebName,ID from WebSite");
            SqlCommand cmd = new SqlCommand(sb.ToString(), conn);
            conn.Open();
            SqlDataAdapter da = new SqlDataAdapter(cmd.CommandText, conn);
            DataSet ds = new DataSet();
            da.Fill(ds);
            conn.Close();
            return Util.Dtb2Json(ds.Tables[0]);
        }
      
    }

    [WebMethod(EnableSession = true)]
    public int delAllWeb(string ids)
    {
        int i = 0;
        using (SqlConnection conn = new DB().GetConnection())
        {
            StringBuilder sb = new StringBuilder("delete from WebSite  where ID in (" + ids + ") ");
            SqlCommand cmd = new SqlCommand(sb.ToString(), conn);
            conn.Open();
            i = cmd.ExecuteNonQuery();
            conn.Close();
        }
        return i;
    }



    //用户标签模块
    [WebMethod(EnableSession = true)]
    public string InitUserTagMan()
    {
        DataSet ds;
        using (SqlConnection conn = new DB().GetConnection())
        {
            StringBuilder sb = new StringBuilder("");
            if (Convert.ToInt32(Session["RoleID"]) == 1)
            {
                sb.Append("select * from UserTags ");
            }
            else
            {
                sb.Append("select * from UserTags where WebID = "+Session["WebID"].ToString());
            }
            SqlCommand cmd = new SqlCommand(sb.ToString(), conn);
            conn.Open();
            SqlDataAdapter da = new SqlDataAdapter(cmd.CommandText, conn);
            ds = new DataSet();
            da.Fill(ds);
            conn.Close();
            return Util.Dtb2Json(ds.Tables[0]);
        }
        }

    [WebMethod(EnableSession = true)]
    public string InitWebUser()
    {
        DataSet ds;
        using (SqlConnection conn = new DB().GetConnection())
        {
            StringBuilder sb = new StringBuilder("select ID,UserName,Avatar from Users where WebID = '"+ Convert.ToInt32(Session["WebID"].ToString()) + "'");
            SqlCommand cmd = new SqlCommand(sb.ToString(), conn);
            conn.Open();
            SqlDataAdapter da = new SqlDataAdapter(cmd.CommandText, conn);
            ds = new DataSet();
            da.Fill(ds);
            conn.Close();
            return Util.Dtb2Json(ds.Tables[0]);
        }
    }

    [WebMethod]
    public string updateTag(string ID,string TagName,string Description)
    {
        int i;
        using (SqlConnection conn = new DB().GetConnection())
        {
            StringBuilder sb = new StringBuilder("update UserTags set TagName=@TagName,Description=@Description where ID=@ID");
            SqlCommand cmd = new SqlCommand(sb.ToString(), conn);
            cmd.Parameters.AddWithValue("@TagName", TagName);
            cmd.Parameters.AddWithValue("@Description", Description);
            cmd.Parameters.AddWithValue("@ID", ID);
            conn.Open();
            i = cmd.ExecuteNonQuery();
            conn.Close();
        }
        if (i == 1)
        {
            return "Success";
        }
        else
        {
            return "Error";
        }
    }

    [WebMethod(EnableSession = true)]
    public string addTag(string TagName, string TagDescription)
    {
        int i;
        using (SqlConnection conn = new DB().GetConnection())
        {
            StringBuilder sb = new StringBuilder("insert into UserTags(TagName,Description,UserID,UserName,WebID )");
            sb.Append(" values ( @TagName,@Description,@UserID,@UserName,@WebID ) ");
            SqlCommand cmd = new SqlCommand(sb.ToString(), conn);
            cmd.Parameters.AddWithValue("@TagName", TagName);
            cmd.Parameters.AddWithValue("@Description", TagDescription);
            cmd.Parameters.AddWithValue("@UserID", Session["UserID"].ToString());
            cmd.Parameters.AddWithValue("@UserName", "可删除");
            cmd.Parameters.AddWithValue("@WebID", Convert.ToInt32(Session["WebID"].ToString()));
            conn.Open();
            i = cmd.ExecuteNonQuery();
            conn.Close();
        }
        if (i == 1)
        {
            return "Success";
        }
        else
        {
            return "Error";
        }
    }

    [WebMethod(EnableSession = true)]
    public int checkTag(string TagName)
    {
        Boolean check = Util.AreadyExist("UserTags", "TagName", TagName, Convert.ToInt32(Session["WebID"].ToString()));
        if (check)
        {
            return 1;
        }
        else
        {
            return -1;
        }
    }

    [WebMethod]
    public string DelTag(string ID)
    {
        int i;
        using (SqlConnection conn = new DB().GetConnection())
        {
            StringBuilder sb = new StringBuilder("delete  from UserTags where ID = @ID");
            SqlCommand cmd = new SqlCommand(sb.ToString(), conn);
            cmd.Parameters.AddWithValue("@ID", ID);
            conn.Open();
            i = cmd.ExecuteNonQuery();
            conn.Close();
        }
        if (i == 1)
        {
            return "Success";
        }
        else
        {
            return "Error";
        }
    }

    [WebMethod]
    public string getTagUser(string TagID)
    {
        DataSet ds;
        using (SqlConnection conn = new DB().GetConnection())
        {
            StringBuilder sb = new StringBuilder(
                @"select  distinct a.Avatar,a.UserName,a.ID,b.UserTagID from Users as a
                  inner join Users_UserTags as b
                  on a.ID = b.UserID
                  right join UserTags as c
                  on b.UserTagID = "+ TagID);
            SqlCommand cmd = new SqlCommand(sb.ToString(), conn);
            conn.Open();
            SqlDataAdapter da = new SqlDataAdapter(cmd.CommandText, conn);
            ds = new DataSet();
            da.Fill(ds);
            conn.Close();
            return Util.Dtb2Json(ds.Tables[0]);
        }
     
    }

    [WebMethod]
    public string delTagUser(string TagID, string UserID)
    {
        int i = 0;
        string[] array = UserID.Split(',');
        int len = array.Length;
        Util.ShowMessage(len.ToString(),"");
        using (SqlConnection conn = new DB().GetConnection())
        {
            StringBuilder sb = new StringBuilder("delete from Users_UserTags where UserTagID=@TagID and UserID in (" + UserID + ")");
            SqlCommand cmd = new SqlCommand(sb.ToString(), conn);
            cmd.Parameters.AddWithValue("@TagID", TagID);
            conn.Open();
            cmd.ExecuteNonQuery();
            cmd.Dispose();

            cmd.CommandText = "update UserTags set Users= Users - @Users where ID=@TagID";
            cmd.Parameters.AddWithValue("@Users", len);
            i = cmd.ExecuteNonQuery();
            conn.Close();

        }
        if (i == 1)
        {
            return "Success";
        }
        else
        {
            return "Fail";
        }
    }

    [WebMethod]
    public string addWebUser(string TagID, string UserID)
    {
        int i = 0;
        string[] array = UserID.Split(',');
        int len = array.Length;
        using (SqlConnection conn = new DB().GetConnection())
        {
            conn.Open();
            for (int j = 0; j < len; j++)
            {
                StringBuilder sb = new StringBuilder("insert into Users_UserTags(UserID,UserTagID) ");
                sb.Append("values (@UserID,@UserTagID)");
                SqlCommand cmd = new SqlCommand(sb.ToString(), conn);
                cmd.Parameters.AddWithValue("@UserID", array[j]);
                cmd.Parameters.AddWithValue("@UserTagID", TagID);
                i = cmd.ExecuteNonQuery();
              
            }

            StringBuilder sb2 = new StringBuilder("update UserTags set Users= Users + @Users where ID=@UserTagID");
            SqlCommand cmd2 = new SqlCommand(sb2.ToString(), conn);
            cmd2.Parameters.AddWithValue("@Users", len);
            cmd2.Parameters.AddWithValue("@UserTagID", TagID);
            cmd2.ExecuteNonQuery();
           
            conn.Close();
        }
        if (i == 1)
        {
            return "Success";
        }
        else
        {
            return "Fail";
        }
    }

    [WebMethod]

    public string getUserTagsByWeb(string WebID)
    {
        DataSet ds;
        string sql = "select * from UserTags  where WebID=" + WebID + " order by id desc";
        using (SqlConnection conn = new DB().GetConnection())
        {
            SqlCommand cmd = conn.CreateCommand();
            cmd.CommandText = sql;
            conn.Open();
            SqlDataAdapter da = new SqlDataAdapter(cmd.CommandText, conn);
            ds = new DataSet();
            da.Fill(ds);
            conn.Close();
        }
        return Util.Dtb2Json(ds.Tables[0]);
    }


    //栏目菜单模块
    [WebMethod(EnableSession = true)]
    public string addCat(string CatName, string Href, string CatDescription,string Valid,string IsShow)
    {
        int i;
        using (SqlConnection conn = new DB().GetConnection())
        {
            StringBuilder sb = new StringBuilder("insert into Cats(CatName,Href,Description,Valid,IsShow,WebID )");
            sb.Append(" values ( @CatName,@Href,@Description,@Valid,@IsShow,@WebID ) ");
            SqlCommand cmd = new SqlCommand(sb.ToString(), conn);
            cmd.Parameters.AddWithValue("@CatName", CatName);
            cmd.Parameters.AddWithValue("@Href", Href);
            cmd.Parameters.AddWithValue("@Description", CatDescription);
            cmd.Parameters.AddWithValue("@Valid", Valid);
            cmd.Parameters.AddWithValue("@IsShow", IsShow);
            cmd.Parameters.AddWithValue("@WebID", Convert.ToInt32(Session["WebID"].ToString()));
            conn.Open();
            i = cmd.ExecuteNonQuery();
            conn.Close();
        }
        if (i == 1)
        {
            return "Success";
        }
        else
        {
            return "Error";
        }
    }

    [WebMethod(EnableSession = true)]
    public string addCatMenu(string CatMenuName, string Href, string Orders, string Valid)
    {
        int i;
        using (SqlConnection conn = new DB().GetConnection())
        {
            StringBuilder sb = new StringBuilder("insert into CatMenu(CatMenuName,Href,Orders,Valid,WebID )");
            sb.Append(" values ( @CatMenuName,@Href,@Orders,@Valid,@WebID ) ");
            SqlCommand cmd = new SqlCommand(sb.ToString(), conn);
            cmd.Parameters.AddWithValue("@CatMenuName", CatMenuName);
            cmd.Parameters.AddWithValue("@Href", Href);
            cmd.Parameters.AddWithValue("@Orders", Orders);
            cmd.Parameters.AddWithValue("@Valid", Valid);
            cmd.Parameters.AddWithValue("@WebID", Convert.ToInt32(Session["WebID"].ToString()));
            conn.Open();
            i = cmd.ExecuteNonQuery();
            conn.Close();
        }
        if (i == 1)
        {
            return "Success";
        }
        else
        {
            return "Error";
        }
    }

    [WebMethod(EnableSession = true)]
    public string editCat(string CatID,string CatName, string Href, string CatDescription, string Valid, string IsShow)
    {
        int i;
        using (SqlConnection conn = new DB().GetConnection())
        {
            StringBuilder sb = new StringBuilder(@"Update [Cats] set CatName = @CatName,Href = @Href,Description = @Description,Valid=@Valid,
                                                IsShow=@IsShow where ID=@CatID");
            SqlCommand cmd = new SqlCommand(sb.ToString(), conn);
            cmd.Parameters.AddWithValue("@CatName", CatName);
            cmd.Parameters.AddWithValue("@Href", Href);
            cmd.Parameters.AddWithValue("@Description", CatDescription);
            cmd.Parameters.AddWithValue("@Valid", Valid);
            cmd.Parameters.AddWithValue("@IsShow", IsShow);
            cmd.Parameters.AddWithValue("@CatID", CatID);
            conn.Open();
            i = cmd.ExecuteNonQuery();
            conn.Close();
        }
        if (i == 1)
        {
            return "Success";
        }
        else
        {
            return "Error";
        }
    }

    [WebMethod(EnableSession = true)]
    public string editCatMenu(string CatMenuID, string CatMenuName, string Href, string Orders, string Valid)
    {
        int i;
        using (SqlConnection conn = new DB().GetConnection())
        {
            StringBuilder sb = new StringBuilder(@"Update [CatMenu] set CatMenuName = @CatMenuName,Href = @Href,Orders = @Orders,Valid=@Valid
                                                 where ID=@CatMenuID");
            SqlCommand cmd = new SqlCommand(sb.ToString(), conn);
            cmd.Parameters.AddWithValue("@CatMenuName", CatMenuName);
            cmd.Parameters.AddWithValue("@Href", Href);
            cmd.Parameters.AddWithValue("@Orders", Orders);
            cmd.Parameters.AddWithValue("@Valid", Valid);
            cmd.Parameters.AddWithValue("@CatMenuID", CatMenuID);
            conn.Open();
            i = cmd.ExecuteNonQuery();
            conn.Close();
        }
        if (i == 1)
        {
            return "Success";
        }
        else
        {
            return "Error";
        }
    }

    [WebMethod(EnableSession = true)]
    public string editSub(string SubID,string CatID, string SubName, string Href, string SubDescription, string Valid)
    {
        int i;
        using (SqlConnection conn = new DB().GetConnection())
        {
            StringBuilder sb = new StringBuilder(@"Update [Subs] set SubName = @SubName,Href = @Href,Description = @Description,Valid=@Valid,
                                                CatID=@CatID where ID=@SubID");
            SqlCommand cmd = new SqlCommand(sb.ToString(), conn);
            cmd.Parameters.AddWithValue("@SubName", SubName);
            cmd.Parameters.AddWithValue("@Href", Href);
            cmd.Parameters.AddWithValue("@Description", SubDescription);
            cmd.Parameters.AddWithValue("@Valid", Valid);
            cmd.Parameters.AddWithValue("@CatID", CatID);
            cmd.Parameters.AddWithValue("@SubID", SubID);
            conn.Open();
            i = cmd.ExecuteNonQuery();
            conn.Close();
        }
        if (i == 1)
        {
            return "Success";
        }
        else
        {
            return "Error";
        }
    }

    [WebMethod(EnableSession = true)]
    public string editSubMenu(string SubMenuID, string CatMenuID, string SubMenuName, string Href, string SubOrders, string Valid)
    {
        int i;
        using (SqlConnection conn = new DB().GetConnection())
        {
            StringBuilder sb = new StringBuilder(@"Update [SubMenu] set SubMenuName = @SubMenuName,Href = @Href,Orders = @SubOrders,Valid=@Valid,
                                                CatMenuID=@CatMenuID where ID=@SubMenuID");
            SqlCommand cmd = new SqlCommand(sb.ToString(), conn);
            cmd.Parameters.AddWithValue("@SubMenuName", SubMenuName);
            cmd.Parameters.AddWithValue("@Href", Href);
            cmd.Parameters.AddWithValue("@SubOrders", SubOrders);
            cmd.Parameters.AddWithValue("@Valid", Valid);
            cmd.Parameters.AddWithValue("@CatMenuID", CatMenuID);
            cmd.Parameters.AddWithValue("@SubMenuID", SubMenuID);
            conn.Open();
            i = cmd.ExecuteNonQuery();
            conn.Close();
        }
        if (i == 1)
        {
            return "Success";
        }
        else
        {
            return "Error";
        }
    }


    [WebMethod]
    public void delCat(string CatID)
    {
        using (SqlConnection conn = new DB().GetConnection())
        {
            SqlCommand cmd = conn.CreateCommand();
            cmd.CommandText = "Delete from Cats where ID = " + CatID;
            conn.Open();
            cmd.ExecuteNonQuery();
            cmd.Dispose();

            cmd.CommandText = "Delete from Subs where CatID = " + CatID;
            cmd.ExecuteNonQuery();
            cmd.Dispose();
            conn.Close();

        }
    }

    [WebMethod]
    public void delCatMenu(string CatMenuID)
    {
        using (SqlConnection conn = new DB().GetConnection())
        {
            SqlCommand cmd = conn.CreateCommand();
            cmd.CommandText = "Delete from CatMenu where ID = " + CatMenuID;
            conn.Open();
            cmd.ExecuteNonQuery();
            cmd.Dispose();

            cmd.CommandText = "Delete from SubMenu where CatMenuID = " + CatMenuID;
            cmd.ExecuteNonQuery();
            cmd.Dispose();
            conn.Close();

        }
    }

    [WebMethod]
    public void delSub(string SubID)
    {
        using (SqlConnection conn = new DB().GetConnection())
        {
            SqlCommand cmd = conn.CreateCommand();
            cmd.CommandText = "Delete from Subs where ID = " + SubID;
            conn.Open();
            cmd.ExecuteNonQuery();
            cmd.Dispose();
            conn.Close();

        }
    }

    [WebMethod]
    public void delSubMenu(string SubMenuID)
    {
        using (SqlConnection conn = new DB().GetConnection())
        {
            SqlCommand cmd = conn.CreateCommand();
            cmd.CommandText = "Delete from SubMenu where ID = " + SubMenuID;
            conn.Open();
            cmd.ExecuteNonQuery();
            cmd.Dispose();
            conn.Close();

        }
    }

    [WebMethod(EnableSession = true)]
    public string addSub(string SubName, string SubHref, string SubDescription, string Valid, string CatID)
    {
        int i;
        using (SqlConnection conn = new DB().GetConnection())
        {
            StringBuilder sb = new StringBuilder("insert into Subs(SubName,Href,Description,Valid,CatID,WebID )");
            sb.Append(" values ( @SubName,@Href,@Description,@Valid,@CatID,@WebID ) ");
            SqlCommand cmd = new SqlCommand(sb.ToString(), conn);
            cmd.Parameters.AddWithValue("@SubName", SubName);
            cmd.Parameters.AddWithValue("@Href", SubHref);
            cmd.Parameters.AddWithValue("@Description", SubDescription);
            cmd.Parameters.AddWithValue("@Valid", Valid);
            cmd.Parameters.AddWithValue("@CatID", CatID);
            cmd.Parameters.AddWithValue("@WebID", Convert.ToInt32(Session["WebID"].ToString()));
            conn.Open();
            i = cmd.ExecuteNonQuery();
            conn.Close();
        }
        if (i == 1)
        {
            return "Success";
        }
        else
        {
            return "Error";
        }
    }

    [WebMethod(EnableSession = true)]
    public string addSubMenu(string SubMenuName, string SubHref, string SubOrders, string Valid, string CatMenuID)
    {
        int i;
        using (SqlConnection conn = new DB().GetConnection())
        {
            StringBuilder sb = new StringBuilder("insert into SubMenu(SubMenuName,Href,Orders,Valid,CatMenuID,WebID )");
            sb.Append(" values ( @SubName,@Href,@Orders,@Valid,@CatMenuID,@WebID ) ");
            SqlCommand cmd = new SqlCommand(sb.ToString(), conn);
            cmd.Parameters.AddWithValue("@SubName", SubMenuName);
            cmd.Parameters.AddWithValue("@Href", SubHref);
            cmd.Parameters.AddWithValue("@Orders", SubOrders);
            cmd.Parameters.AddWithValue("@Valid", Valid);
            cmd.Parameters.AddWithValue("@CatMenuID", CatMenuID);
            cmd.Parameters.AddWithValue("@WebID", Convert.ToInt32(Session["WebID"].ToString()));
            conn.Open();
            i = cmd.ExecuteNonQuery();
            conn.Close();
        }
        if (i == 1)
        {
            return "Success";
        }
        else
        {
            return "Error";
        }
    }


    [WebMethod(EnableSession = true)]
    public string loadCatMenu(string handle)
    {
        using (SqlConnection conn = new DB().GetConnection())
        {

            StringBuilder sb = new StringBuilder("");
            if (handle == "GetMenu")
            {
                sb.Append("select CatMenuName,ID from CatMenu where WebID = '" + Session["WebID"].ToString() + "'" );
            }
            else
            {
                sb.Append("select CatName,ID from Cats where WebID = '" + Session["WebID"].ToString() + "'");
            }
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
    public DataSet showCatInfo(string CatID)
    {
        DataSet ds;
        using (SqlConnection conn = new DB().GetConnection())
        {

            StringBuilder sb = new StringBuilder("select * from Cats where ID = " + CatID);
            SqlCommand cmd = new SqlCommand(sb.ToString(), conn);
            conn.Open();
            SqlDataAdapter da = new SqlDataAdapter(cmd.CommandText, conn);
            ds = new DataSet();
            da.Fill(ds);
            conn.Close();
            return ds;
        }
    }

    [WebMethod]
    public DataSet showCatMenuInfo(string CatMenuID)
    {
        DataSet ds;
        using (SqlConnection conn = new DB().GetConnection())
        {

            StringBuilder sb = new StringBuilder("select * from CatMenu where ID = " + CatMenuID);
            SqlCommand cmd = new SqlCommand(sb.ToString(), conn);
            conn.Open();
            SqlDataAdapter da = new SqlDataAdapter(cmd.CommandText, conn);
            ds = new DataSet();
            da.Fill(ds);
            conn.Close();
            return ds;
        }
    }

    [WebMethod]
    public DataSet showSubInfo(string SubID)
    {
        DataSet ds;
        using (SqlConnection conn = new DB().GetConnection())
        {

            StringBuilder sb = new StringBuilder("select * from Subs where ID = " + SubID);
            SqlCommand cmd = new SqlCommand(sb.ToString(), conn);
            conn.Open();
            SqlDataAdapter da = new SqlDataAdapter(cmd.CommandText, conn);
            ds = new DataSet();
            da.Fill(ds);
            conn.Close();
            return ds;
        }
    }

    [WebMethod]
    public DataSet showSubMenuInfo(string SubMenuID)
    {
        DataSet ds;
        using (SqlConnection conn = new DB().GetConnection())
        {

            StringBuilder sb = new StringBuilder("select * from SubMenu where ID = " + SubMenuID);
            SqlCommand cmd = new SqlCommand(sb.ToString(), conn);
            conn.Open();
            SqlDataAdapter da = new SqlDataAdapter(cmd.CommandText, conn);
            ds = new DataSet();
            da.Fill(ds);
            conn.Close();
            return ds;
        }
    }

    [WebMethod(EnableSession = true)]

    public string InitCatMan()
   {
        DataSet ds;
        using (SqlConnection conn = new DB().GetConnection())
      {

            StringBuilder sb = new StringBuilder("select ID,CatName,Valid from Cats   where WebID  = '" + Session["WebID"].ToString() + "'");
            SqlCommand cmd = new SqlCommand(sb.ToString(), conn);
            conn.Open();
            SqlDataAdapter da = new SqlDataAdapter(cmd.CommandText, conn);
            ds = new DataSet();
            da.Fill(ds);
            conn.Close();
            return Util.Dtb2Json(ds.Tables[0]);
     }

  }

    [WebMethod(EnableSession = true)]

    public string InitSubMan(String CatID)
    {
        DataSet ds;
        using (SqlConnection conn = new DB().GetConnection())
        {

            StringBuilder sb = new StringBuilder("select ID,SubName,Valid from Subs where CatID = " + CatID + " Order by ID Desc");
            SqlCommand cmd = new SqlCommand(sb.ToString(), conn);
            conn.Open();
            SqlDataAdapter da = new SqlDataAdapter(cmd.CommandText, conn);
            ds = new DataSet();
            da.Fill(ds);
            conn.Close();
            return Util.Dtb2Json(ds.Tables[0]);
        }



    }


    [WebMethod]

    public string InitWebMan()
    {
        DataSet ds;
        using (SqlConnection conn = new DB().GetConnection())
        {

            StringBuilder sb = new StringBuilder("select * from WebSite");
            SqlCommand cmd = new SqlCommand(sb.ToString(), conn);
            conn.Open();
            SqlDataAdapter da = new SqlDataAdapter(cmd.CommandText, conn);
            ds = new DataSet();
            da.Fill(ds);
            conn.Close();
         
        }
        return Util.Dtb2Json(ds.Tables[0]);
    }

    [WebMethod]

    public string EditWeb(string ID,string WebName,string Description,string IsMainSite)
    {
        int i;
        using (SqlConnection conn = new DB().GetConnection())
        {
            StringBuilder sb = new StringBuilder("update Website set WebName=@WebName,Description=@Description,IsMainSite=@IsMainSite where ID=@ID");
            SqlCommand cmd = new SqlCommand(sb.ToString(), conn);
            cmd.Parameters.AddWithValue("@WebName", WebName);
            cmd.Parameters.AddWithValue("@Description", Description);
            cmd.Parameters.AddWithValue("@IsMainSite", IsMainSite);
            cmd.Parameters.AddWithValue("@ID", ID);
            conn.Open();
            i = cmd.ExecuteNonQuery();
            conn.Close();
        }
        if (i == 1)
        {
            return "Success";
        }
        else
        {
            return "Error";
        }
    }

    [WebMethod]
    public string InsertWeb(string WebName, string Description, string IsMainSite)
    {
        int i;
        using (SqlConnection conn = new DB().GetConnection())
        {
            StringBuilder sb = new StringBuilder("insert into Website (WebName,Description,IsMainSite,CDT) values(@WebName,@Description,@IsMainSite,@CDT)");
            SqlCommand cmd = new SqlCommand(sb.ToString(), conn);
            cmd.Parameters.AddWithValue("@WebName", WebName);
            cmd.Parameters.AddWithValue("@Description", Description);
            cmd.Parameters.AddWithValue("@IsMainSite", IsMainSite);
            cmd.Parameters.AddWithValue("@CDT", DateTime.Now);
            conn.Open();
            i = cmd.ExecuteNonQuery();
            conn.Close();
        }
        if (i == 1)
        {
            return "Success";
        }
        else
        {
            return "Error";
        }
    }

    [WebMethod]
    public string DelWeb(string ID)
    {
        int i;
        using (SqlConnection conn = new DB().GetConnection())
        {
            StringBuilder sb = new StringBuilder("delete  from WebSite where ID = @ID");
            SqlCommand cmd = new SqlCommand(sb.ToString(), conn);
            cmd.Parameters.AddWithValue("@ID", ID);
            conn.Open();
            i = cmd.ExecuteNonQuery();
            conn.Close();
        }
        if (i == 1)
        {
            return "Success";
        }
        else
        {
            return "Error";
        }
    }


    //焦点图模块

    [WebMethod(EnableSession = true)]

    public string InitFocuses()
    {
        DataSet ds;
        string sql = "";
        //if (Convert.ToInt16(Session["RoleID"].ToString()) > 2 )
        //{
            sql = "select * from Focuses where WebID=" + Convert.ToInt32(Session["WebID"].ToString()) + " and Valid=1 order by valid desc,orders desc,id desc";
        //}
        //else
        //{

        //    sql = "select  Focuses.ID,PhotoTitle,PhotoSrc,LinkURL,Orders,Thumbnail,Valid from Focuses left join WebSite on   Focuses.WebID =WebSite .ID where  WebSite.IsMainSite='True' order by valid desc,orders desc,id desc";
        //}

        using (SqlConnection conn = new DB().GetConnection())
        {

            SqlCommand cmd = conn.CreateCommand();
            cmd.CommandText = sql;
            conn.Open();
            SqlDataAdapter da = new SqlDataAdapter(cmd.CommandText, conn);
            ds = new DataSet();
            da.Fill(ds);
            conn.Close();
        }
        return Util.Dtb2Json(ds.Tables[0]);
    }


    [WebMethod]

    public string getFocusByWeb(string WebID)
    {
        DataSet ds;
        string sql = "select * from Focuses  where WebID=" + WebID + " order by valid desc,orders desc,id desc";
        using (SqlConnection conn = new DB().GetConnection())
        {
            SqlCommand cmd = conn.CreateCommand();
            cmd.CommandText = sql;
            conn.Open();
            SqlDataAdapter da = new SqlDataAdapter(cmd.CommandText, conn);
            ds = new DataSet();
            da.Fill(ds);
            conn.Close();
        }
        return Util.Dtb2Json(ds.Tables[0]);
    }

    [WebMethod]

    public string updateFocus(string ID, string LinkURL, string Orders, string Valid)
    {
        int i;
        using (SqlConnection conn = new DB().GetConnection())
        {
            StringBuilder sb = new StringBuilder("update Focuses set LinkURL = @LinkURL, Orders = @Orders, Valid = @Valid where ID = @ID");
            SqlCommand cmd = new SqlCommand(sb.ToString(), conn);
            cmd.Parameters.AddWithValue("@LinkURL", LinkURL);
            cmd.Parameters.AddWithValue("@Orders", Orders);
            cmd.Parameters.AddWithValue("@Valid", Valid);
            cmd.Parameters.AddWithValue("@ID", ID);
            conn.Open();
            i = cmd.ExecuteNonQuery();
            conn.Close();
        }
        if (i == 1)
        {
            return "Success";
        }
        else
        {
            return "Error";
        }
    }

    [WebMethod]
    public string DelFocuses(string ID)
    {
        int i;
        string sqlCon = "";
        using (SqlConnection conn = new DB().GetConnection())
        {
            SqlCommand cmd = conn.CreateCommand();
            // 删除物理路径下的文件
            {
                sqlCon = "Select * from Focuses where ID = @ID";
                cmd.CommandText = sqlCon;
                cmd.Parameters.AddWithValue("@ID", ID);
                conn.Open();
                SqlDataAdapter sda = new SqlDataAdapter();
                sda.SelectCommand = cmd;
                DataSet ds = new DataSet();
                sda.Fill(ds, "PhotoTitle");
                foreach (DataRow drow in ds.Tables["PhotoTitle"].Rows)
                {
                    string FilePath = drow["PhotoSrc"].ToString();
                    // 删除物理路径下的文件
                    System.IO.File.Delete(Server.MapPath(FilePath));
                }
                conn.Close();
            }
            {
                string sql = "delete from Focuses where ID = @ID";
                cmd = new SqlCommand(sql, conn);
                cmd.Parameters.AddWithValue("@ID", ID);
                conn.Open();
                i = cmd.ExecuteNonQuery();
                conn.Close();
            }
        }
        if (i == 1)
        {
            return "Success";
        }
        else
        {
            return "Error";
        }
    }

    [WebMethod]
    public string updateFocusOrder(string IDs,string Orders)
    {
        string[] IDarray = IDs.Split(',');
        string[] Orderarray = Orders.Split(',');
        int len = Orderarray.Length;

        int i = 0;
        using (SqlConnection conn = new DB().GetConnection())
        {
            SqlCommand cmd = conn.CreateCommand();
            conn.Open();
            for (int j = 0; j < len; j++)
            {
                cmd.CommandText = "update Focuses set  Orders ="+ Orderarray[j] + " where ID = "+ IDarray[j];
                i = cmd.ExecuteNonQuery(); 
                cmd.Dispose();
            }
            conn.Close();
        }
        if (i == 1)
        {
            return "Success";
        }
        else
        {
            return "Error";
        }
    }

}
