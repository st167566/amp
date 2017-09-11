using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Text;
using System.IO;
public partial class ArticleTag_Add : System.Web.UI.Page
{

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["RoleID"] == null || Session["UserID"] == null)
            {
                Util.ShowMessage("用户登录超时，请重新登录！", "Login2.aspx");
            }
            else {
                if (Convert.ToInt16(Session["RoleID"]) > 4)
                {
                    Util.ShowMessage("对不起，你无权访问该页面！", "User_Center.aspx");
                }
                else
                {
                    TagName.Focus();
                }
            }

            

        }
    }
  protected void Button1_Click(object sender, EventArgs e)
    {
     
        ErrorLabel.Text = Check();
        if(ErrorLabel.Text == ""){
        MyDataBind();
        }
    }

    private string Check()
    {
        int i = 0;
        string[] s = new string[6];
        s[0] = "";
        s[1] = "标签名不能为空！";
        s[4] = "标签名已经存在，请输入另外一个标签名！";

        string TagNameStr = TagName.Text;
        string TagDescriptionStr = TagDescription.Text;
        if (!String.IsNullOrEmpty(TagNameStr))
        {          
                if (AlreadyExisted(TagNameStr.Trim()))
                {
                    i = 4;//第五种情况，用户名已经存在
                }
                else
                {
                    DataBind();
                    
                }
          
        }
        else
        {
            i = 1;//第二种情况，用户名密码为空
        }
        return s[i];
    }

    private void MyDataBind()
    {
        int i = 0;
        string UserID = Convert.ToString(Session["UserID"]);
        string username = Convert.ToString(Session["UserName"]);
        using (SqlConnection conn = new DB().GetConnection())
        {

            StringBuilder sb = new StringBuilder("insert into ArticleTags(TagName,Description,Articles,UserID,UserName )");
            sb.Append(" values ( @TagName,@Description,@Articles,@UserID,@UserName ) ");
            SqlCommand cmd = new SqlCommand(sb.ToString(), conn);
            cmd.Parameters.AddWithValue("@TagName", TagName.Text);
            cmd.Parameters.AddWithValue("@Description", TagDescription.Text);
            cmd.Parameters.AddWithValue("@UserID", UserID);
            cmd.Parameters.AddWithValue("@Articles", 0);
            cmd.Parameters.AddWithValue("@UserName", username);
            conn.Open();
            i = cmd.ExecuteNonQuery();
            conn.Close();
            Util.ShowMessage("操作成功！", "ArticleTag_Man.aspx");
           
        }
       
    }

    private bool AlreadyExisted(string param)
    {
        bool a = false;

        using (SqlConnection conn = new DB().GetConnection())
        {
            string sql = "select id from [ArticleTags] where TagName = @TagName";
            SqlCommand cmd = new SqlCommand(sql, conn);
            cmd.Parameters.AddWithValue("@TagName", param);
            conn.Open();
            SqlDataReader rd = cmd.ExecuteReader();
            if (rd.Read())
            {
                a = true;
            }
            rd.Close();
        }

        return a;
    }
  


}
