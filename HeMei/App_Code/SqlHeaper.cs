using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;

/// <summary>
///SqlHeaper 的摘要说明
/// </summary>
public class SqlHeaper
{
		//连接字符串
        private static readonly string constr = ConfigurationManager.ConnectionStrings["mysql"].ConnectionString;

        
        //封装常用方法

        //1.执行insert/delete/update的方法
        public static int ExecuteNonQuery(String sql, CommandType cmdType,params SqlParameter[] pms) 
        {
            //连接对象
            using (SqlConnection con = new SqlConnection(constr)) 
            {
                //执行命令
                using (SqlCommand cmd=new SqlCommand (sql ,con ))
                {
                    cmd.CommandType = cmdType;
                    if (pms !=null )
                    {
                        cmd.Parameters.AddRange(pms);
                    }
                    con.Open();
                    return cmd.ExecuteNonQuery();
                }
            }
        }


        //返回单个值的方法
        public static object ExecuteScalar(String sql, CommandType cmdType, params SqlParameter[] pms) 
        {
            //连接对象
            using (SqlConnection con = new SqlConnection(constr))
            {
                //执行命令
                using (SqlCommand cmd = new SqlCommand(sql, con))
                {
                    cmd.CommandType = cmdType;
                    if (pms != null)
                    {
                        cmd.Parameters.AddRange(pms);
                    }
                    con.Open();
                    return cmd.ExecuteScalar();
                }
            }
        }


        //返回SqlDataReader的方法
        public static SqlDataReader ExecuteReader(String sql, CommandType cmdType, params SqlParameter[] pms) 
        {
            //连接对象
            SqlConnection con = new SqlConnection(constr);
                //执行命令
                using (SqlCommand cmd = new SqlCommand(sql, con))
                {
                    cmd.CommandType = cmdType;
                    if (pms != null)
                    {
                        cmd.Parameters.AddRange(pms);
                    }
                    try
                    {
                        con.Open();
                        // sqldata关掉不能用
                        return cmd.ExecuteReader(CommandBehavior.CloseConnection);
                    }
                    catch 
                    {
                        //关闭连接
                        con.Close();
                        //释放连接
                        con.Dispose();
                        throw;
                    }
                }
        }


        //返回DataTable的方法
        public static DataTable ExecuteDataTable(String sql, CommandType cmdType, params SqlParameter[] pms) 
        {
            DataTable dt = new DataTable();
            using (SqlDataAdapter adapter = new SqlDataAdapter(sql ,constr)) 
            {
                adapter.SelectCommand.CommandType = cmdType;
                if (pms != null)
                {
                    adapter.SelectCommand.Parameters.AddRange(pms );
                }
                //内部帮我们打开数据库
                adapter.Fill(dt );
                return dt;
            }
        }
	
}
