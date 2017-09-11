using System;
using System.Data;
using System.Data.Common;
using System.Text.RegularExpressions;


public struct ArctilesDetails
{
    public int ID;
    public string Title;
    public string Summary;
    public string Author;
    public string ViewTimes;
    public string CDT;

}

public struct CatMenuDetails
{
    public int ID;
    public string CatMenuName;

}
/// <summary>
/// Search_Access 的摘要说明
/// </summary>
public class Search_Access
{
	public Search_Access()
	{
		//
		// TODO: 在此处添加构造函数逻辑
		//
	}
    public static CatMenuDetails GetCatMenuDetails(string ID) 
    {
        // get a configured DbCommand object
        DbCommand comm = GenericDataAccess.CreateCommand();
        // set the stored procedure name
        comm.CommandText = "GetCatMenuDetails";
        // create a new parameter
        DbParameter param = comm.CreateParameter();
        param.ParameterName = "@ID";
        param.Value = ID;
        param.DbType = DbType.Int32;
        comm.Parameters.Add(param);

        // execute the stored procedure
        DataTable table = GenericDataAccess.ExecuteSelectCommand(comm);
        // wrap retrieved data into a ProductDetails object
        CatMenuDetails details = new CatMenuDetails();
        if (table.Rows.Count > 0)
        {
            // get the first table row
            DataRow dr = table.Rows[0];
            // get product details
            details.ID = int.Parse(ID);
            details.CatMenuName = dr["CatMenuName"].ToString();

        }
        // return department details
        return details;
    }
    // Get product details
    public static ArctilesDetails GetArticleDetails(string ID)
    {
        // get a configured DbCommand object
        DbCommand comm = GenericDataAccess.CreateCommand();
        // set the stored procedure name
        comm.CommandText = "GetArticleDetails";
        // create a new parameter
        DbParameter param = comm.CreateParameter();
        param.ParameterName = "@ID";
        param.Value = ID;
        param.DbType = DbType.Int32;
        comm.Parameters.Add(param);

        // execute the stored procedure
        DataTable table = GenericDataAccess.ExecuteSelectCommand(comm);
        // wrap retrieved data into a ProductDetails object
        ArctilesDetails details = new ArctilesDetails();
        if (table.Rows.Count > 0)
        {
            // get the first table row
            DataRow dr = table.Rows[0];
            // get product details
            details.ID = int.Parse(ID);
            details.Title = dr["Title"].ToString();
            details.Summary = dr["Summary"].ToString();
            details.Author = dr["Author"].ToString();
            details.ViewTimes = dr["ViewTimes"].ToString();
            details.CDT = dr["CDT"].ToString();
           
        }
        // return department details
        return details;
    }

    //// Retrieve the list of products on catalog promotion
    //public static DataTable GetProductsOnFrontPromo(string pageNumber, out int howManyPages)
    //{
    //    // get a configured DbCommand object
    //    DbCommand comm = GenericDataAccess.CreateCommand();
    //    // set the stored procedure name
    //    comm.CommandText = "CatalogGetProductsOnFrontPromo";
    //    // create a new parameter
    //    DbParameter param = comm.CreateParameter();
    //    param.ParameterName = "@SummaryLength";
    //    param.Value = SearchConfiguration.ArticleSummaryLength;
    //    param.DbType = DbType.Int32;
    //    comm.Parameters.Add(param);
    //    // create a new parameter
    //    param = comm.CreateParameter();
    //    param.ParameterName = "@PageNumber";
    //    param.Value = pageNumber;
    //    param.DbType = DbType.Int32;
    //    comm.Parameters.Add(param);
    //    // create a new parameter
    //    param = comm.CreateParameter();
    //    param.ParameterName = "@ProductsPerPage";
    //    param.Value = SearchConfiguration.ProductsPerPage;
    //    param.DbType = DbType.Int32;
    //    comm.Parameters.Add(param);
    //    // create a new parameter
    //    param = comm.CreateParameter();
    //    param.ParameterName = "@HowManyProducts";
    //    param.Direction = ParameterDirection.Output;
    //    param.DbType = DbType.Int32;
    //    comm.Parameters.Add(param);

    //    // execute the stored procedure and save the results in a DataTable
    //    DataTable table = GenericDataAccess.ExecuteSelectCommand(comm);
    //    // calculate how many pages of products and set the out parameter
    //    int howManyProducts = Int32.Parse(comm.Parameters["@HowManyProducts"].Value.ToString());
    //    howManyPages = (int)Math.Ceiling((double)howManyProducts / (double)SearchConfiguration.ProductsPerPage);
    //    // return the page of products
    //    return table;
    //}


    // Search the product catalog
    public static DataTable Search(string searchString, string allWords, string pageNumber,int web,out int howManyPages)
    {
        
        // get a configured DbCommand object
        DbCommand comm = GenericDataAccess.CreateCommand();
        // set the stored procedure name
        comm.CommandText = "SearchArticles";
        // create a new parameter
        DbParameter param = comm.CreateParameter();
        param.ParameterName = "@SummaryLength";
        param.Value = SearchConfiguration.ArticleSummaryLength;
        param.DbType = DbType.Int32;
        comm.Parameters.Add(param);
        // create a new parameter
        param = comm.CreateParameter();
        param.ParameterName = "@AllWords";
        param.Value = allWords.ToUpper() == "TRUE" ? "1" : "0";
        param.DbType = DbType.Byte;
        comm.Parameters.Add(param);
       
        
        // create a new parameter
        param = comm.CreateParameter();
        param.ParameterName = "@PageNumber";
        param.Value = pageNumber;
        param.DbType = DbType.Int32;
        comm.Parameters.Add(param);
        // create a new parameter
        param = comm.CreateParameter();
        param.ParameterName = "@Web";
        param.Value = web;
        param.DbType = DbType.Int32;
        comm.Parameters.Add(param);
        // create a new parameter
        param = comm.CreateParameter();
        param.ParameterName = "@ProductsPerPage";
        param.Value = SearchConfiguration.ProductsPerPage;
        param.DbType = DbType.Int32;
        comm.Parameters.Add(param);
        // create a new parameter
        param = comm.CreateParameter();
        param.ParameterName = "@HowManyResults";
        param.Direction = ParameterDirection.Output;
        param.DbType = DbType.Int32;
        comm.Parameters.Add(param);

        // define the maximum number of words
        int howManyWords = 5;
        // transform search string into array of words
        string[] words = Regex.Split(searchString, "[^\u4e00-\u9fa5$|^1-9$|^A-Za-z]+");

        // add the words as stored procedure parameters
        int index = 1;
        for (int i = 0; i <= words.GetUpperBound(0) && index <= howManyWords; i++)
            // ignore short words
            if (words[i].Length > 0)
            {
                // create the @Word parameters
                param = comm.CreateParameter();
                param.ParameterName = "@Word" + index.ToString();
                param.Value = words[i];
                param.DbType = DbType.String;
                comm.Parameters.Add(param);
                index++;
            }
          


        // execute the stored procedure and save the results in a DataTable
        DataTable table = GenericDataAccess.ExecuteSelectCommand(comm);
        // calculate how many pages of products and set the out parameter
        int howManyProducts =
      Int32.Parse(comm.Parameters["@HowManyResults"].Value.ToString());
        howManyPages = (int)Math.Ceiling((double)howManyProducts /
                       (double)SearchConfiguration.ProductsPerPage);
        // return the page of products
        return table;
    }



    // Search the product catalog
    public static DataTable SearchOrderByViewtimes(string searchString, string allWords, string pageNumber, out int howManyPages)
    {
        // get a configured DbCommand object
        DbCommand comm = GenericDataAccess.CreateCommand();
        // set the stored procedure name
        comm.CommandText = "SearchArticlesOrderByViewtimes";
        // create a new parameter
        DbParameter param = comm.CreateParameter();
        param.ParameterName = "@SummaryLength";
        param.Value = SearchConfiguration.ArticleSummaryLength;
        param.DbType = DbType.Int32;
        comm.Parameters.Add(param);
        // create a new parameter
        param = comm.CreateParameter();
        param.ParameterName = "@AllWords";
        param.Value = allWords.ToUpper() == "TRUE" ? "1" : "0";
        param.DbType = DbType.Byte;
        comm.Parameters.Add(param);

        // create a new parameter
        param = comm.CreateParameter();
        param.ParameterName = "@PageNumber";
        param.Value = pageNumber;
        param.DbType = DbType.Int32;
        comm.Parameters.Add(param);
        // create a new parameter
        param = comm.CreateParameter();
        param.ParameterName = "@ProductsPerPage";
        param.Value = SearchConfiguration.ProductsPerPage;
        param.DbType = DbType.Int32;
        comm.Parameters.Add(param);
        // create a new parameter
        param = comm.CreateParameter();
        param.ParameterName = "@HowManyResults";
        param.Direction = ParameterDirection.Output;
        param.DbType = DbType.Int32;
        comm.Parameters.Add(param);

        // define the maximum number of words
        int howManyWords = 5;
        // transform search string into array of words
        string[] words = Regex.Split(searchString, "[^\u4e00-\u9fa5$|^1-9$|^A-Za-z]+");

        // add the words as stored procedure parameters
        int index = 1;
        for (int i = 0; i <= words.GetUpperBound(0) && index <= howManyWords; i++)
            // ignore short words
            if (words[i].Length > 0)
            {
                // create the @Word parameters
                param = comm.CreateParameter();
                param.ParameterName = "@Word" + index.ToString();
                param.Value = words[i];
                param.DbType = DbType.String;
                comm.Parameters.Add(param);
                index++;
            }

        // execute the stored procedure and save the results in a DataTable
        DataTable table = GenericDataAccess.ExecuteSelectCommand(comm);
        // calculate how many pages of products and set the out parameter
        int howManyProducts =
      Int32.Parse(comm.Parameters["@HowManyResults"].Value.ToString());
        howManyPages = (int)Math.Ceiling((double)howManyProducts /
                       (double)SearchConfiguration.ProductsPerPage);
        // return the page of products
        return table;
    }

    // Search the product catalog
    public static DataTable SearchArticlesOrderByViewtimesAsc(string searchString, string allWords, string pageNumber, out int howManyPages)
    {
        // get a configured DbCommand object
        DbCommand comm = GenericDataAccess.CreateCommand();
        // set the stored procedure name
        comm.CommandText = "SearchArticlesOrderByViewtimesAsc";
        // create a new parameter
        DbParameter param = comm.CreateParameter();
        param.ParameterName = "@SummaryLength";
        param.Value = SearchConfiguration.ArticleSummaryLength;
        param.DbType = DbType.Int32;
        comm.Parameters.Add(param);
        // create a new parameter
        param = comm.CreateParameter();
        param.ParameterName = "@AllWords";
        param.Value = allWords.ToUpper() == "TRUE" ? "1" : "0";
        param.DbType = DbType.Byte;
        comm.Parameters.Add(param);

        // create a new parameter
        param = comm.CreateParameter();
        param.ParameterName = "@PageNumber";
        param.Value = pageNumber;
        param.DbType = DbType.Int32;
        comm.Parameters.Add(param);
        // create a new parameter
        param = comm.CreateParameter();
        param.ParameterName = "@ProductsPerPage";
        param.Value = SearchConfiguration.ProductsPerPage;
        param.DbType = DbType.Int32;
        comm.Parameters.Add(param);
        // create a new parameter
        param = comm.CreateParameter();
        param.ParameterName = "@HowManyResults";
        param.Direction = ParameterDirection.Output;
        param.DbType = DbType.Int32;
        comm.Parameters.Add(param);

        // define the maximum number of words
        int howManyWords = 5;
        // transform search string into array of words
        string[] words = Regex.Split(searchString, "[^\u4e00-\u9fa5$|^1-9$|^A-Za-z]+");

        // add the words as stored procedure parameters
        int index = 1;
        for (int i = 0; i <= words.GetUpperBound(0) && index <= howManyWords; i++)
            // ignore short words
            if (words[i].Length > 0)
            {
                // create the @Word parameters
                param = comm.CreateParameter();
                param.ParameterName = "@Word" + index.ToString();
                param.Value = words[i];
                param.DbType = DbType.String;
                comm.Parameters.Add(param);
                index++;
            }

        // execute the stored procedure and save the results in a DataTable
        DataTable table = GenericDataAccess.ExecuteSelectCommand(comm);
        // calculate how many pages of products and set the out parameter
        int howManyProducts =
      Int32.Parse(comm.Parameters["@HowManyResults"].Value.ToString());
        howManyPages = (int)Math.Ceiling((double)howManyProducts /
                       (double)SearchConfiguration.ProductsPerPage);
        // return the page of products
        return table;
    }

    // Search the product catalog
    public static DataTable SearchArticlesOrderByCDTAsc(string searchString, string allWords, string pageNumber, out int howManyPages)
    {
        // get a configured DbCommand object
        DbCommand comm = GenericDataAccess.CreateCommand();
        // set the stored procedure name
        comm.CommandText = "SearchArticlesOrderByCDTAsc";
        // create a new parameter
        DbParameter param = comm.CreateParameter();
        param.ParameterName = "@SummaryLength";
        param.Value = SearchConfiguration.ArticleSummaryLength;
        param.DbType = DbType.Int32;
        comm.Parameters.Add(param);
        // create a new parameter
        param = comm.CreateParameter();
        param.ParameterName = "@AllWords";
        param.Value = allWords.ToUpper() == "TRUE" ? "1" : "0";
        param.DbType = DbType.Byte;
        comm.Parameters.Add(param);

        // create a new parameter
        param = comm.CreateParameter();
        param.ParameterName = "@PageNumber";
        param.Value = pageNumber;
        param.DbType = DbType.Int32;
        comm.Parameters.Add(param);
        // create a new parameter
        param = comm.CreateParameter();
        param.ParameterName = "@ProductsPerPage";
        param.Value = SearchConfiguration.ProductsPerPage;
        param.DbType = DbType.Int32;
        comm.Parameters.Add(param);
        // create a new parameter
        param = comm.CreateParameter();
        param.ParameterName = "@HowManyResults";
        param.Direction = ParameterDirection.Output;
        param.DbType = DbType.Int32;
        comm.Parameters.Add(param);

        // define the maximum number of words
        int howManyWords = 5;
        // transform search string into array of words
        string[] words = Regex.Split(searchString, "[^\u4e00-\u9fa5$|^1-9$|^A-Za-z]+");

        // add the words as stored procedure parameters
        int index = 1;
        for (int i = 0; i <= words.GetUpperBound(0) && index <= howManyWords; i++)
            // ignore short words
            if (words[i].Length > 0)
            {
                // create the @Word parameters
                param = comm.CreateParameter();
                param.ParameterName = "@Word" + index.ToString();
                param.Value = words[i];
                param.DbType = DbType.String;
                comm.Parameters.Add(param);
                index++;
            }

        // execute the stored procedure and save the results in a DataTable
        DataTable table = GenericDataAccess.ExecuteSelectCommand(comm);
        // calculate how many pages of products and set the out parameter
        int howManyProducts =
      Int32.Parse(comm.Parameters["@HowManyResults"].Value.ToString());
        howManyPages = (int)Math.Ceiling((double)howManyProducts /
                       (double)SearchConfiguration.ProductsPerPage);
        // return the page of products
        return table;
    }

    // Search the product catalog
    public static DataTable SearchArticlesOrderByCDTDesc(string searchString, string allWords, string pageNumber, out int howManyPages)
    {
        // get a configured DbCommand object
        DbCommand comm = GenericDataAccess.CreateCommand();
        // set the stored procedure name
        comm.CommandText = "SearchArticlesOrderByCDTDesc";
        // create a new parameter
        DbParameter param = comm.CreateParameter();
        param.ParameterName = "@SummaryLength";
        param.Value = SearchConfiguration.ArticleSummaryLength;
        param.DbType = DbType.Int32;
        comm.Parameters.Add(param);
        // create a new parameter
        param = comm.CreateParameter();
        param.ParameterName = "@AllWords";
        param.Value = allWords.ToUpper() == "TRUE" ? "1" : "0";
        param.DbType = DbType.Byte;
        comm.Parameters.Add(param);

        // create a new parameter
        param = comm.CreateParameter();
        param.ParameterName = "@PageNumber";
        param.Value = pageNumber;
        param.DbType = DbType.Int32;
        comm.Parameters.Add(param);
        // create a new parameter
        param = comm.CreateParameter();
        param.ParameterName = "@ProductsPerPage";
        param.Value = SearchConfiguration.ProductsPerPage;
        param.DbType = DbType.Int32;
        comm.Parameters.Add(param);
        // create a new parameter
        param = comm.CreateParameter();
        param.ParameterName = "@HowManyResults";
        param.Direction = ParameterDirection.Output;
        param.DbType = DbType.Int32;
        comm.Parameters.Add(param);

        // define the maximum number of words
        int howManyWords = 5;
        // transform search string into array of words
        string[] words = Regex.Split(searchString, "[^\u4e00-\u9fa5$|^1-9$|^A-Za-z]+");

        // add the words as stored procedure parameters
        int index = 1;
        for (int i = 0; i <= words.GetUpperBound(0) && index <= howManyWords; i++)
            // ignore short words
            if (words[i].Length > 0)
            {
                // create the @Word parameters
                param = comm.CreateParameter();
                param.ParameterName = "@Word" + index.ToString();
                param.Value = words[i];
                param.DbType = DbType.String;
                comm.Parameters.Add(param);
                index++;
            }

        // execute the stored procedure and save the results in a DataTable
        DataTable table = GenericDataAccess.ExecuteSelectCommand(comm);
        // calculate how many pages of products and set the out parameter
        int howManyProducts =
      Int32.Parse(comm.Parameters["@HowManyResults"].Value.ToString());
        howManyPages = (int)Math.Ceiling((double)howManyProducts /
                       (double)SearchConfiguration.ProductsPerPage);
        // return the page of products
        return table;
    }
}