using System;
using System.Collections.Generic;
using System.Web;
using System.IO;
using System.Net;
using System.Text;
using System.Text.RegularExpressions;

/// <summary>
///PageOperate 的摘要说明
/// </summary>
public class PageOperate
{
    public PageOperate()
    {
        //下载于51aspx.com
        //TODO: 在此处添加构造函数逻辑
        //
    }

    /// <summary>
    /// 将字符串转换成int型，若字符串为空，返回0
    /// </summary>
    /// <param name="str">要转换的字符串</param>
    /// <returns>转后的int值</returns>
    public static int GetIntValue(object o)
    {
        try
        {
            if (o == null)
                return 0;
            if ((o.ToString()).Length == 0)
                return 0;
            else
            {
                if (Int32.Parse(o.ToString()) == 0)
                    return 0;
                else
                    return Int32.Parse(o.ToString());
            }
        }
        catch
        {
            return 0;
        }
    }

    /// <summary>
    /// 是null就返回空，否则返回原字符串
    /// </summary>
    /// <param name="str">需要处理的字符串</param>
    /// <returns>转换后的值</returns>
    public static string GetNullToString(object o)
    {
        try
        {
            if (o == null)
                return "";
            else
                return o.ToString();
        }
        catch
        {
            return "";
        }
    }

    /// <summary>
    /// 弹出JavaScript小窗口,并转向指定的页面
    /// </summary>
    /// <param name="msg">弹出信息</param>
    /// <param name="toURL">专转向的网页</param>
    public static void AlertAndRedirect(string msg, string toURL)
    {
        string js = "<script language=javascript>alert('{0}');window.location.replace('{1}')</script>";
        HttpContext.Current.Response.Write(string.Format(js, msg, toURL));
    }
}