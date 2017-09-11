using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;

public partial class User : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string web = Util.ReturnWeb(Convert.ToInt32(Session["WebID"].ToString()));
            HyperLink.NavigateUrl = "/" + web + "/Login.aspx";
            BackToIndex.NavigateUrl = "/" + web + "/Index.aspx";
            if (Session["RoleID"] == null || Session["UserID"] == null)
            {

                Util.ShowMessage("用户登录超时，请重新登录！", "/" + web + "/Login.aspx");
            }
            else
            {
                using (SqlConnection conn = new DB().GetConnection())
                {
                    SqlCommand cmd = conn.CreateCommand();
                    cmd.CommandText = "select distinct WebName as WebName,ID from WebSite";
                    conn.Open();
                    SqlDataReader rd = cmd.ExecuteReader();
                    Webs.DataSource = rd;
                    Webs.DataValueField = "ID";
                    Webs.DataTextField = "WebName";
                    Webs.DataBind();
                    rd.Close();
                    Webs.Items.Insert(0, new ListItem("选择网站", ""));
                    conn.Close();

                }
                    // load search box controls' values
                    string allWords = Request.QueryString["AllWords"];
                string searchString = Request.QueryString["Search"];
                if (allWords != null)
                    allWordsCheckBox.Checked = (allWords.ToUpper() == "TRUE");
                if (searchString != null)
                    searchTextBox.Text = searchString;

                string username = Convert.ToString(Session["UserName"]);
                int roleID = Util.UpdateAvatar(username);
                AvatarImage.ImageUrl = Session["Avatar"].ToString();
                AvatarImage1.ImageUrl = Session["Avatar"].ToString();
                if (roleID == 1)//ROOT
                {
                    Web.Visible = true;
                    Article.Visible = false;
                    Files.Visible = false;
                    WebSetting.Visible = true;
                    FocusPanel.Visible = false;
             

                }
                else if (roleID == 2)//Super
                {

                    Web.Visible = true;
                    Article.Visible = false;
                    Files.Visible = false;
                    WebSetting.Visible = true;
                    FocusPanel.Visible = false;
        
                
                }
                else if (roleID == 3)//Owner
                {
                    Web.Visible = false;
                    FilePanel.Visible = true;
                    WebSetting.Visible = true;
                    FocusPanel.Visible = true;
              
               
                }
                else if (roleID == 4)//Admin
                {
                    Web.Visible = false;
                    FilePanel.Visible = true;
                    WebSetting.Visible = true;
                    FocusPanel.Visible = true;
                
           
                }
                else if (roleID == 5)//Editor
                {
                    Web.Visible = false;
                    FilePanel.Visible = true;
                    WebSetting.Visible = false;
                    FocusPanel.Visible = false;
                  
               
                }
                else
                {
                    Web.Visible = false;
                    FilePanel.Visible = false;
                    WebSetting.Visible = false;
                    FocusPanel.Visible = false;
          
                    Article.Visible = true;
                    Files.Visible = false;

                }
                if (HasPossess())
                {
                  
                }
              
            }
        }
       
        
    }

    protected void goButton_Click(object sender, EventArgs e)
    {
        ExecuteSearch();
    }

    // Redirect to the search results page
    private void ExecuteSearch()
    {
        string searchText = searchTextBox.Text;
        bool allWords = allWordsCheckBox.Checked;
        if (searchTextBox.Text.Trim() != "")
            Response.Redirect(Link.ToSearch(searchText, allWords, "1"));
    }

    override protected void OnInit(EventArgs e)
    {
        if (Cache != null)
        {
            IDictionaryEnumerator idE = Cache.GetEnumerator();
            while (idE.MoveNext())
            {
                if (idE.Key != null && idE.Key.ToString().Equals(Session.SessionID))
                {
                    string web = Util.ReturnWeb(Convert.ToInt32(Session["WebID"].ToString()));
                    //已经登录
                    if (idE.Value != null && "XXXXXX".Equals(idE.Value.ToString()))
                    {
                        Cache.Remove(Session.SessionID);
                        Session["UserID"] = null;
                        Session["UserName"] = null;
                        Util.ShowMessage("用户登录超时，请重新登录！", "/" + web + "/Login.aspx");
                        Response.End();
                    }
                    break;
                }
            }
        }

    }

    private bool HasPossess()
    {
        bool r = false;
        using (SqlConnection conn = new DB().GetConnection())
        {
            string sql = "select * from profile1 where UserID=@UserIDProfile";
            SqlCommand cmd = new SqlCommand(sql, conn);
            cmd.Parameters.AddWithValue("@UserIDProfile",Session["UserID"].ToString());
            conn.Open();
            SqlDataReader rd = cmd.ExecuteReader();
            if (rd.Read())
            {
                r = true;
            }
            else
            {
                r = false;
            }
            rd.Close();
        }
        return r;
    }

    private void DoUpdate(int finished)
    {
     
        Session["WebID"] = Webs.SelectedValue;
        Response.Redirect(Request.Url.ToString());

    }

    protected void Webs_SelectedIndexChanged(object sender, EventArgs e)
    {

        DoUpdate(1);
    }
}
  

