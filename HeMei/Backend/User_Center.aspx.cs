using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Text;

public partial class User_Center : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string web = Util.ReturnWeb(Convert.ToInt32(Session["WebID"].ToString()));
            BackToIndex.NavigateUrl = "/" + web + "/Index.aspx";
            if (Session["RoleID"] == null || Session["UserID"] == null)
            {

                Util.ShowMessage("用户登录超时，请重新登录！", "/" + web + "/Login.aspx");
            }
            else
            {
                string username = Convert.ToString(Session["UserName"]);
                string userid = Convert.ToString(Session["UserID"]);
                int roleID = Util.UpdateAvatar(username);
                if (roleID == 1)
                {
                    WaitForAuditPanel.Visible = true;
                    WaitForAuditExceptAdminPanel.Visible = false;
                    ForPassPanel.Visible = true;
                    ForPassExceptAdminPanel.Visible = false;
                    UserNumsPanel.Visible = true;
                    UserTagNumsPanel.Visible = true;
                    ALLArctileNumsPanel.Visible = true;
                    ArctileNumsPanel.Visible = true;
                    Repeater1Panel.Visible = true;
                    UserMamPanel.Visible = true;
                    MorePanel.Visible = true;
                    NewAddRecent7.Visible = true;
                    NewAddRecent7ExceptAdmin.Visible = false;
                    PassArticle7.Visible = true;
                    PassArticle7ExceptAdmin.Visible = false;
                    NotPassArticle7.Visible = true;
                    NotPassArticle7ExceptAdmin.Visible = false;
                    MixedPanel.Visible = true;
                }
                else if (roleID == 2)
                {
                    WaitForAuditPanel.Visible = true;
                    WaitForAuditExceptAdminPanel.Visible = false;
                    ForPassPanel.Visible = true;
                    ForPassExceptAdminPanel.Visible = false;
                    UserNumsPanel.Visible = false;
                    UserTagNumsPanel.Visible = false;
                    ALLArctileNumsPanel.Visible = true;
                    ArctileNumsPanel.Visible = false;
                    Repeater1Panel.Visible = true;
                    UserMamPanel.Visible = false;
                    MorePanel.Visible = false;
                    NewAddRecent7.Visible = true;
                    NewAddRecent7ExceptAdmin.Visible = false;
                    PassArticle7.Visible = true;
                    PassArticle7ExceptAdmin.Visible = false;
                    NotPassArticle7.Visible = true;
                    NotPassArticle7ExceptAdmin.Visible = false;
                    MixedPanel.Visible = false;
                }
                else if (roleID == 3)
                {
                    WaitForAuditPanel.Visible = false;
                    WaitForAuditExceptAdminPanel.Visible = true;
                    ForPassPanel.Visible = false;
                    ForPassExceptAdminPanel.Visible = true;
                    UserNumsPanel.Visible = false;
                    UserTagNumsPanel.Visible = false;
                    ALLArctileNumsPanel.Visible = false;
                    ArctileNumsPanel.Visible = true;
                    //Repeater1Panel.Visible = false;
                    UserMamPanel.Visible = false;
                    MorePanel.Visible = false;
                    NewAddRecent7.Visible = false;
                    NewAddRecent7ExceptAdmin.Visible = true;
                    PassArticle7.Visible = false;
                    PassArticle7ExceptAdmin.Visible = true;
                    NotPassArticle7.Visible = false;
                    NotPassArticle7ExceptAdmin.Visible = true;
                    MixedPanel.Visible = false;
                }
                else if (roleID == 4)
                {
                    WaitForAuditPanel.Visible = false;
                    WaitForAuditExceptAdminPanel.Visible = true;
                    ForPassPanel.Visible = false;
                    ForPassExceptAdminPanel.Visible = true;
                    UserNumsPanel.Visible = false;
                    UserTagNumsPanel.Visible = false;
                    ALLArctileNumsPanel.Visible = false;
                    ArctileNumsPanel.Visible = true;
                    //Repeater1Panel.Visible = false;
                    UserMamPanel.Visible = false;
                    MorePanel.Visible = false;
                    NewAddRecent7.Visible = false;
                    NewAddRecent7ExceptAdmin.Visible = true;
                    PassArticle7.Visible = false;
                    PassArticle7ExceptAdmin.Visible = true;
                    NotPassArticle7.Visible = false;
                    NotPassArticle7ExceptAdmin.Visible = true;
                    MixedPanel.Visible = false;
                }
                else
                {
                    WaitForAuditPanel.Visible = false;
                    WaitForAuditExceptAdminPanel.Visible = true;
                    ForPassPanel.Visible = false;
                    ForPassExceptAdminPanel.Visible = true;
                    UserNumsPanel.Visible = false;
                    UserTagNumsPanel.Visible = false;
                    ALLArctileNumsPanel.Visible = false;
                    ArctileNumsPanel.Visible = true;
                    //Repeater1Panel.Visible = false;
                    UserMamPanel.Visible = false;
                    MorePanel.Visible = false;
                    NewAddRecent7.Visible = false;
                    NewAddRecent7ExceptAdmin.Visible = true;
                    PassArticle7.Visible = false;
                    PassArticle7ExceptAdmin.Visible = true;
                    NotPassArticle7.Visible = false;
                    NotPassArticle7ExceptAdmin.Visible = true;
                    MixedPanel.Visible = false;


                }
                string roleid = Session["RoleID"].ToString();
                using (SqlConnection conn = new DB().GetConnection())
                {

                    SqlCommand cmd = conn.CreateCommand();
                    cmd.CommandText = "select count(*) as maxrow from [Articles] ";
                    conn.Open();
                    SqlDataReader rd = cmd.ExecuteReader();
                    if (rd.Read())
                    {
                        ALLArctileNums.Text = rd["maxrow"].ToString();
                    }
                    rd.Close();


                    cmd.CommandText = "select count(*) as maxrow from [Users]"; ;
                    rd = cmd.ExecuteReader();
                    if (rd.Read())
                    {
                        UserNums.Text = rd["maxrow"].ToString();
                    }
                    rd.Close();

                    cmd.CommandText = "select count(*) as maxrow from [Resources]"; ;
                    rd = cmd.ExecuteReader();
                    if (rd.Read())
                    {
                        FileNums.Text = rd["maxrow"].ToString();
                    }
                    rd.Close();

                    cmd.CommandText = "select top 6 ID,Title,ViewTimes from Articles  where CDT <= GETDATE() and  CDT >=GETDATE()-30 order by ViewTimes desc";
                    rd = cmd.ExecuteReader();
                    Repeater1.DataSource = rd;
                    Repeater1.DataBind();
                    rd.Close();

                    cmd.CommandText = "select count(*) as maxrow from [UserTags]"; ;
                    rd = cmd.ExecuteReader();
                    if (rd.Read())
                    {
                        UserTagNums.Text = rd["maxrow"].ToString();
                    }
                    rd.Close();

                    cmd.CommandText = "select * from Roles order by ID asc";
                    rd = cmd.ExecuteReader();
                    RoleName.DataSource = rd;
                    RoleName.DataValueField = "ID";
                    RoleName.DataTextField = "RoleName";
                    RoleName.DataBind();
                    rd.Close();

                    cmd.CommandText = "select * from Roles order by ID asc;select * from Roles  where ID = @ID";
                    cmd.Parameters.AddWithValue("@ID", Convert.ToInt16(roleid));
                    rd = cmd.ExecuteReader();
                    rd.NextResult();
                    if (rd.Read())
                    {
                        string RoleID = rd["ID"].ToString();
                        if (RoleName.Items.FindByValue(RoleID) != null)
                        {
                            RoleName.ClearSelection();
                            RoleName.Items.FindByValue(RoleID).Selected = true;
                        }
                    }
                    rd.Close();

                    cmd.CommandText = "select count(*) as maxrow from [Articles] where  IsFinished = 1 and Valid=1"; ;
                    rd = cmd.ExecuteReader();
                    if (rd.Read())
                    {
                        WaitForAudit.Text = rd["maxrow"].ToString();
                    }
                    rd.Close();

                    cmd.CommandText = "select count(*) as maxrow from [Articles] where IsFinished = 1 and Valid=1 and  AuthorID = @AuthorID3 ";
                    cmd.Parameters.AddWithValue("@AuthorID3", userid);
                    rd = cmd.ExecuteReader();
                    if (rd.Read())
                    {
                        WaitForAuditExceptAdmin.Text = rd["maxrow"].ToString();
                    }
                    rd.Close();

                    cmd.CommandText = "select count(*) as maxrow from [Articles] where IsFinished = 0 and AuthorID=@AuthorID4"; ;
                    cmd.Parameters.AddWithValue("@AuthorID4", userid);
                    rd = cmd.ExecuteReader();
                    if (rd.Read())
                    {
                        Draft.Text = rd["maxrow"].ToString();
                    }
                    rd.Close();

                    cmd.CommandText = "select count(*) as maxrow from [Articles] where Valid = 0 ";
                    rd = cmd.ExecuteReader();
                    if (rd.Read())
                    {
                        ForPass.Text = rd["maxrow"].ToString();
                    }
                    rd.Close();

                    cmd.CommandText = "select count(*) as maxrow from [Articles] where Valid = 0 and AuthorID = @AuthorID2";
                    cmd.Parameters.AddWithValue("@AuthorID2", userid);
                    rd = cmd.ExecuteReader();
                    if (rd.Read())
                    {
                        ForPassExceptAdmin.Text = rd["maxrow"].ToString();
                    }
                    rd.Close();

                    cmd.CommandText = "select count(*) as maxrow from [Articles] where CDT <= GETDATE() and  CDT >=GETDATE()-7 ";
                    rd = cmd.ExecuteReader();
                    if (rd.Read())
                    {
                        NewAddRecent7Text.Text = rd["maxrow"].ToString();
                    }
                    rd.Close();

                    cmd.CommandText = "select count(*) as maxrow from [Articles] where CDT <= GETDATE() and  CDT >=GETDATE()-7 and AuthorID = @AuthorID5";
                    cmd.Parameters.AddWithValue("@AuthorID5", userid);
                    rd = cmd.ExecuteReader();
                    if (rd.Read())
                    {
                        NewAddRecent7ExceptAdminText.Text = rd["maxrow"].ToString();
                    }
                    rd.Close();

                    cmd.CommandText = "select count(*) as maxrow from [Articles] where CDT <= GETDATE() and  CDT >=GETDATE()-7";
                    rd = cmd.ExecuteReader();
                    if (rd.Read())
                    {
                        PassArticle7Text.Text = rd["maxrow"].ToString();
                    }
                    rd.Close();


                    cmd.CommandText = "select count(*) as maxrow from [Articles] where CDT <= GETDATE() and  CDT >=GETDATE()-7 and AuthorID = @AuthorID6";
                    cmd.Parameters.AddWithValue("@AuthorID6", userid);
                    rd = cmd.ExecuteReader();
                    if (rd.Read())
                    {
                        PassArticle7ExceptAdminText.Text = rd["maxrow"].ToString();
                    }
                    rd.Close();

                    cmd.CommandText = "select count(*) as maxrow from [Articles] where CDT <= GETDATE() and  CDT >=GETDATE()-7  ";
                    rd = cmd.ExecuteReader();
                    if (rd.Read())
                    {
                        NotPassArticle7Text.Text = rd["maxrow"].ToString();
                    }
                    rd.Close();

                    cmd.CommandText = "select count(*) as maxrow from [Articles] where CDT <= GETDATE() and  CDT >=GETDATE()-7 and AuthorID = @AuthorID7";
                    cmd.Parameters.AddWithValue("@AuthorID7", userid);
                    rd = cmd.ExecuteReader();
                    if (rd.Read())
                    {
                        NotPassArticle7ExceptAdminText.Text = rd["maxrow"].ToString();
                    }
                    rd.Close();

                    cmd.CommandText = "select count(*) as maxrow from [Users] where RegisterDateTime <= GETDATE() and  RegisterDateTime >=GETDATE()-7 ";
                    rd = cmd.ExecuteReader();
                    if (rd.Read())
                    {
                        NewUsers.Text = rd["maxrow"].ToString();
                    }
                    rd.Close();

                    cmd.CommandText = "select count(*) as maxrow from [Resources] where CDT <= GETDATE() and  CDT >=GETDATE()-7 ";
                    rd = cmd.ExecuteReader();
                    if (rd.Read())
                    {
                        NewFiles.Text = rd["maxrow"].ToString();
                    }
                    rd.Close();
                }

            }
        }
    }

    private void DoUpdate(int finished)
    {
        int i = 0;
        string UserID = Session["UserID"].ToString();
        using (SqlConnection conn = new DB().GetConnection())
        {
            StringBuilder sb = new StringBuilder("Update [Users] set RoleID = @RoleID, RoleName = @RoleName where ID=@UserID ");
            SqlCommand cmd = new SqlCommand(sb.ToString(), conn);
            cmd.Parameters.AddWithValue("@UserID", UserID);
            cmd.Parameters.AddWithValue("@RoleID", RoleName.SelectedValue);
            cmd.Parameters.AddWithValue("@RoleName", RoleName.SelectedItem.Text);
            conn.Open();
            i = cmd.ExecuteNonQuery();
            if (i == 1)
            {
                Response.Write("<script language='javascript'> alert('操作成功')</script>");
            }
            else
            {
                Response.Write("<script language='javascript'> alert('操作失败，请重试！')</script>");
            }
        }
    }

    protected void OrderDDL_SelectedIndexChanged(object sender, EventArgs e)
    {

        DoUpdate(1);
    }
}