using System.Configuration;

/// <summary>
/// SearchConfiguration 的摘要说明
/// </summary>
public class SearchConfiguration
{
    // Caches the connection string
    private static string dbConnectionString;
    // Caches the data provider name 
    private static string dbProviderName;
    // Store the number of products per page
    private readonly static int productsPerPage;
    // Store the product description length for Articles lists
    private readonly static int articleSummaryLength;
    // Store the name of your shop
    private readonly static string siteName;

    static SearchConfiguration()
    {
        dbConnectionString = ConfigurationManager.ConnectionStrings["SETCConnectionString"].ConnectionString;
        dbProviderName = ConfigurationManager.ConnectionStrings["SETCConnectionString"].ProviderName;
        productsPerPage = System.Int32.Parse(ConfigurationManager.AppSettings["ProductsPerPage"]);
        articleSummaryLength = System.Int32.Parse(ConfigurationManager.AppSettings["ArticleSummaryLength"]);
        siteName = ConfigurationManager.AppSettings["SiteName"];
      
    }
    // Returns the connection string for the BalloonShop database
    public static string DbConnectionString
    {
        get
        {
            return dbConnectionString;
        }
    }

    // Returns the data provider name
    public static string DbProviderName
    {
        get
        {
            return dbProviderName;
        }
    }

    // Returns the maximum number of products to be displayed on a page
    public static int ProductsPerPage
    {
        get
        {
            return productsPerPage;
        }
    }

    // Returns the length of product descriptions in products lists
    public static int ArticleSummaryLength
    {
        get
        {
            return articleSummaryLength;
        }
    }

    // Returns the length of product descriptions in products lists
    public static string SiteName
    {
        get
        {
            return siteName;
        }
    }

	public SearchConfiguration()
	{
		//
		// TODO: 在此处添加构造函数逻辑
		//
	}

   
}