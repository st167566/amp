using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Text;
using System.Web.Caching;

public partial class Login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Session["WebID"] = "3";
            U_Label.Text = Request.QueryString["u"];
            if (U_Label.Text != "0")
            {
                Cache.Remove(Session.SessionID);
                Session["UserID"] = null;
                Session["UserName"] = null;
                Session["WebID"] = 3;
            }
            else if (U_Label.Text == "0" && Session["UserID"] != null)
            {
                Util.ShowMessage("你已经成功登录！", "/Backend/User_Center.aspx");
            }
        }
    }

    protected void SureRegisting_Click(object sender, EventArgs e) 
    {
        //执行用户登录
        int roleID = Util.DoLogin(UserName.Text.Trim(), Password.Text.Trim(), (int)EnumClass.SMSSource.HEMEI);
        if (roleID == -1)
        {
            ErrorLable.Text = "用户名或密码错误！";
        }
        else 
        {
            //单点登录判断
            if (Cache != null)
            {
                IDictionaryEnumerator CacheIDE = Cache.GetEnumerator();
                string strKey = "";
                while (CacheIDE.MoveNext())
                {
                    if (CacheIDE.Value != null && CacheIDE.Value.ToString().Equals(UserName.Text))
                    {
                        //已经登录
                        strKey = CacheIDE.Key.ToString();
                        Cache[strKey] = "XXXXXX";
                        break;
                    }
                }
            }
            TimeSpan SessTimeOut = new TimeSpan(0, 0, HttpContext.Current.Session.Timeout, 0, 0);
            HttpContext.Current.Cache.Insert(Session.SessionID, UserName.Text, null, DateTime.MaxValue, SessTimeOut, CacheItemPriority.NotRemovable, null);
            Util.ShowMessage("用户登录成功", "/Backend/User_Center.aspx");
        }
    }
}