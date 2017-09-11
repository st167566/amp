using System;
using System.Web;
using System.Text.RegularExpressions;

/// <summary>
/// Link 的摘要说明
/// </summary>
public class Link
{

	public Link()
	{
		//
		// TODO: 在此处添加构造函数逻辑
		//
	}
    // regular expression that removes characters that aren't a-z, 0-9, dash, 
    // underscore or space
    private static Regex purifyUrlRegex = new Regex("[^\u4e00-\u9fa5$|^1-9$|^A-Za-z ]", RegexOptions.Compiled);

    // regular expression that changes dashes, underscores and spaces to dashes
    private static Regex dashesRegex = new Regex("[-_ ]+", RegexOptions.Compiled);

    // prepares a string to be included in an URL
    private static string PrepareUrlText(string urlText)
    {
        // remove all characters that aren't a-z, 0-9, dash, underscore or space
        urlText = purifyUrlRegex.Replace(urlText, "");

        // remove all leading and trailing spaces
        urlText = urlText.Trim();

        // change all dashes, underscores and spaces to dashes
        urlText = dashesRegex.Replace(urlText, "-");

        // return the modified string    
        return urlText;
    }


    // Builds an absolute URL
    private static string BuildAbsolute(string relativeUri)
    {
        // get current uri
        Uri uri = HttpContext.Current.Request.Url;
        // build absolute path
        string app = HttpContext.Current.Request.ApplicationPath;
        if (!app.EndsWith("/")) app += "/";
        relativeUri = relativeUri.TrimStart('/');
        // return the absolute path
        return HttpUtility.UrlPathEncode(
          String.Format("http://{0}:{1}{2}{3}",
          uri.Host, uri.Port, app, relativeUri));
    }

    public static string ToMenu(string ID, string path, string CatMenuName,string WebID)
    {

        if (path.Contains("List4"))
        {

            CatMenuDetails p = Search_Access.GetCatMenuDetails(ID);
            string prodUrlName = p.CatMenuName;

            return BuildAbsolute(String.Format("List_{0}_{1}_{2}.html", ID, prodUrlName,WebID));
        }
        else if (path.Contains("List3"))
        {
            //string catname = path.Substring(path.IndexOf('=') + 2).Trim();
            return BuildAbsolute(String.Format("List2_{0}_{1}_{2}.html", HttpUtility.UrlEncode(ID), CatMenuName,WebID));

        }
        else if (path.Contains("View"))
        {
            return BuildAbsolute(String.Format("View-{0}-{1}-{2}.html", HttpUtility.UrlEncode(ID), CatMenuName,WebID));
        }
        else
        {
            return path;
        }

    }

    public static string IndexToVideo(string ID, string SubName, string Title,int WebID)
    {
        return BuildAbsolute(String.Format("View-{0}-{1}-{2}-{3}.html", ID, SubName, Title,WebID));
    }

    public static string ListToVideo(string ID, string SubName)
    {
        return BuildAbsolute(String.Format("View-{0}_{1}.html", ID, SubName));
    }

    public static string CrumbToList3(string ID, string CatName, string WebID)
    {
        return BuildAbsolute(String.Format("List2_{0}_{1}_{2}.html", ID, CatName,WebID));
    }

    public static string CrumbToList4(string ID, string SubName,string WebID)
    {
        //   Link.CrumbToList3(ViewState["SubID"].ToString(), rd["CatName"].ToString())
        return BuildAbsolute(String.Format("List_{0}_{1}_{2}.html", ID, SubName, WebID));
    }

    public static string ToArticles(string ID,string WebID)
    {
        // prepare product URL name
        ArctilesDetails p = Search_Access.GetArticleDetails(ID.ToString());
        string prodUrlName = PrepareUrlText(p.Title);

        // build product URL
        return BuildAbsolute(String.Format("Article_View-{0}-{1}-{2}.html", ID,prodUrlName,WebID));
    }

    public static string ToSearch(string searchString, bool allWords, string page)
    {
        if (page == "1")
            return BuildAbsolute(
              String.Format("/Search.aspx?Search={0}&AllWords={1}",
                searchString, allWords.ToString()));
        else
            return BuildAbsolute(
              String.Format("/Search.aspx?Search={0}&AllWords={1}&Page={2}",
                searchString, allWords.ToString(), page));
    }

    public static string ToSearchAboutFront(string searchString, bool allWords, string page,string Web)
    {
       
        foreach (EnumClass.SMSSource item in Enum.GetValues(typeof(EnumClass.SMSSource)))
        {

            if (item.ToString() == Web)
            {
                break;
            }
          
        }
   
        if (page == "1" )
        {
            return BuildAbsolute(
               String.Format("/"+Web+"/SearchAboutFrontPage.aspx?Search={0}&AllWords={1}",
                 searchString, allWords.ToString()));
        }
        else { 
            return BuildAbsolute(
              String.Format("/" + Web + "/SearchAboutFrontPage.aspx?Search={0}&AllWords={1}&Page={2}",
             searchString, allWords.ToString(), page));
        } 

      
    }
}