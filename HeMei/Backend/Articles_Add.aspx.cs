using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Text;
using System.IO;
using System.Data;
using System.Text.RegularExpressions;
using System.Net;

public partial class Articles_Add2 : System.Web.UI.Page
{
    public string RandomIDCD = Guid.NewGuid().ToString();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {

            string web = Util.ReturnWeb(Convert.ToInt32(Session["WebID"].ToString()));
            if (Session["RoleID"].ToString() != "1")
            {
                //Webs.Visible = false;
            }

            if (Session["RoleID"] == null || Session["UserID"] == null)
            {
                Util.ShowMessage("用户登录超时，请重新登录！", "/" + web + "/Login.aspx");
            }
            else
            {   
            }
            Session["returnfileurl"] = "";
            SaveCookie("returnfileurl", "132", 1);
            Session["returnfilename"] = "";
            SaveCookie("returnfilename", "", 1);
            //Response.Cookies["returnfileurl"].Value = "1";
        };
        if (Request.QueryString["ID"] != null && !String.IsNullOrEmpty(Request.QueryString["ID"].ToString()))
        {
            /*修改文章*/
            if ((Convert.ToInt16(Session["RoleID"]) < 5))
            {
                Session["ArticleID"] = Request.QueryString["ID"];
                SaveCookie("handle", "doupdata", 1);
                MyInitForUpdate();//调用函数
            }
            else { Response.Write("<script language='javascript'> alert('你无法访问该篇文章' );window.location ='User_Center.aspx';</script>"); }
        }
        else
        {
            /*新增文章*/
            SaveCookie("handle", "doinsert", 1);
        };
    }
    private void MyInitForUpdate()
    {
        ClientScript.RegisterStartupScript(ClientScript.GetType(), "Myinit", " <script type=text/javascript >Myinit(" + Request.QueryString["ID"].ToString() + ");</script>");

    }





    public static void SaveCookie(string CookieName, string CookieValue, double CookieTime)
    {
        HttpCookie myCookie = new HttpCookie(CookieName);
        DateTime now = DateTime.Now;
        myCookie.Value = HttpUtility.UrlEncode(CookieValue);//编码写入转换，防止中文乱码
        if (CookieTime != 0)
        {
            myCookie.Expires = now.AddDays(CookieTime);
            if (HttpContext.Current.Response.Cookies[CookieName] != null)
                HttpContext.Current.Response.Cookies.Remove(CookieName);
            HttpContext.Current.Response.Cookies.Add(myCookie);
        }
        else
        {
            if (HttpContext.Current.Response.Cookies[CookieName] != null)
                HttpContext.Current.Response.Cookies.Remove(CookieName);
            HttpContext.Current.Response.Cookies.Add(myCookie);
        }
    }
    public static string GetCookie(string CookieName)
    {
        HttpCookie myCookie = new HttpCookie(CookieName);
        myCookie = HttpContext.Current.Request.Cookies[CookieName];
        if (myCookie != null)
            return HttpUtility.UrlDecode(myCookie.Value);//返回解码后的Cookie值
        else
            return null;
    }

}