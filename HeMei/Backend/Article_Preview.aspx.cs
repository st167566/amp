using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Article_View : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        ArticleTitle.InnerText = GetCookie("title");
       // Summary.Text = GetCookie("summary");
        ArticleContent.InnerHtml = GetCookie("content");
        CDT.InnerHtml = GetCookie("CDT") == "" ? DateTime.Now.ToString().Substring(0, 9) : GetCookie("CDT");
        Username1.InnerHtml = GetCookie("uname");
        catname.InnerHtml = GetCookie("catname");
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