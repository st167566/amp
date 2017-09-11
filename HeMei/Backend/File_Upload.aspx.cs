using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.Sql;
using System.Data.SqlClient;
using CuteWebUI;
using System.IO;
using System.Text;
using System.Data;
using System.Web.UI.HtmlControls;

public partial class File_Upload : System.Web.UI.Page
{
    //存储允许上传的资源的后缀名，key=Extension，value=TypeName
    Dictionary<string, string> ResourceTypes = new Dictionary<string, string>();

    //设置默认的RoleID    
    string RoleID = "5";
    string UserID = "0";
    //chenxilian:定义一个guid变量，来接收系统生成的唯一GUID值
    string guid = "0";
    //获得上传图片的路劲
    public string ImgData = null;


    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string web = Util.ReturnWeb(Convert.ToInt32(Session["WebID"].ToString()));
           
            if (Session["RoleID"] == null || Session["UserID"] == null)
            {
                Util.ShowMessage("用户登录超时，请重新登录！", "/" + web + "/Login.aspx");
            }
            else
            {
                    UserID = Session["UserID"].ToString();
                 

                    using (SqlConnection conn = new DB().GetConnection())
                    {
                        SqlDataReader rd;
                        SqlCommand cmd = conn.CreateCommand();
                        cmd.CommandText = "Select * from ResourceFolders where ParentID = '0' order by ID asc";
                        conn.Open();
                        rd = cmd.ExecuteReader();
                        FolderDDL.DataSource = rd;
                        FolderDDL.DataValueField = "ID";
                        FolderDDL.DataTextField = "FolderName";
                        FolderDDL.DataBind();
                        rd.Close();
                        FolderDDL.Items.Insert(0, new ListItem("--文件夹目录--", "-1"));
                        FolderDDL.SelectedIndex = 1;
                        conn.Close();
                    }
               
            }
        }
    }

    // 判断fileextension是否合法
    protected bool CheckExtension(string extension)
    {
        bool result = false;
        // 如果Dictionary的键值数<1，即没有元素，则先读取数据表
        if (ResourceTypes.Keys.Count < 1)
        {
            using (SqlConnection conn = new DB().GetConnection())
            {
                SqlDataReader rd;
                SqlCommand cmd = conn.CreateCommand();
                cmd.CommandText = "select * from ResourceTypes";
                conn.Open();
                rd = cmd.ExecuteReader();
                while (rd.Read())
                {
                    ResourceTypes.Add(rd["Extension"].ToString(), rd["TypeName"].ToString());
                }
                rd.Close();
                conn.Close();
            }

        }
        // 判断是否含有指定的后缀名
        if (ResourceTypes.ContainsKey(extension))
        {
            result = true;
            ResourceTypeLabel.Text = ResourceTypes[extension];
        }
        return result;
    }


    // 资源上传完毕时，不回传页面
    /*
     * Justin 2015-8-18
     * Step:
     * 1 判断文件后缀名是否合法，文件大小是否超标，从FileUpload数据表中读取基本数据
     * 2 对文件重命名 userid_yyyyMMddhhmmss_random_o.jpg，o表示原始资源
     * 3 把文件另存（移动到）用户的文件夹下，例如 users/101/201508/,按月新建文件夹即可
     * 4 对图片生成web图、缩略图和移动图，对视频鼓励用户上传移动版的视频（或者在线转录），用一个图片表示视频封面
     *   缩略图，在后台资源管理中用，移动版的图片在手机访问的时候使用，平板则直接使用web版的图片
     *   userid_yyyyMMddhhmmss_random_o.jpg，userid_yyyyMMddhhmmss_random_w.jpg，userid_yyyyMMddhhmmss_random_p.jpg，userid_yyyyMMddhhmmss_random_s.jpg
     *   同步IO，再进化到异步IO
     * 5 在File数据表中，插入一条数据，记录相关信息
     * 
     * 6 用户点击“插入资源”按钮，再把相应的资源插入到文章中，关闭本窗口
     * 
     * 
     */
    protected void Uploader_FileUploaded(object sender, UploaderEventArgs args)
    {
        //TestLabel.Text = "Uploader1_UploadCompleted";
        //资源的重命名
        TextBox1.Text = args.FileName.Substring(0, args.FileName.LastIndexOf('.'));

        //InsertMsg("File uploaded! " + args.FileName + ", " + args.FileSize + " bytes.");

        string fileExtension = args.FileName.Substring(args.FileName.LastIndexOf('.') + 1).ToLower();

        //如果后缀名不空，且后缀名合法
        if ((!String.IsNullOrEmpty(fileExtension)) && CheckExtension(fileExtension))
        {
            //判断文件大小，暂缓
            string fileSize = args.FileSize / 1024 + "";


            //chenxilian:判断资源类型，给ResourceTypeLabel.Text赋值上传的资源类型
            ResourceTypeLabel.Text = ResourceTypes[fileExtension];
            //重命名文件  userid_yyyyMMddHHmmss_random4_o.jpg           
            string fileName = Session["UserID"].ToString() + "_" + DateTime.Now.ToString("yyyyMMddHHmmss") + "_" + new Random().Next(1000, 10000).ToString() + "." + fileExtension;

            ////文件实际存储路径，Users/userid/yyyyMM/  采用相对路径，方便js访问图片
            //string filePath = "Users/" + Session["UserID"].ToString() + "/" + DateTime.Now.ToString("yyyyMM");

            //文件实际存储路径，upload/yyyyMM/  采用相对路径，方便js访问图片
            string filePath = "upload" + "/" + DateTime.Now.ToString("yyyyMM");

            string serverPath = Server.MapPath(filePath);
            if (!Directory.Exists(serverPath))
            {
                Directory.CreateDirectory(serverPath);
            }
            //移动文件到指定目录
            args.MoveTo(serverPath + "/" + fileName);
            //filePath存储的是文件的相对路径，包括文件名
            filePath = "/" + filePath + "/" + fileName;


            FET.Text = fileExtension;
            FS.Text = fileSize;
            FN.Text = fileName;
            FP.Text = filePath;

            //bool i=InsertDataBase();
            //bool i = InsertDataBase();
            //if (i == true)
            //{
            //    Response.Redirect(Server.HtmlEncode("File_Man.aspx"));
            //}

        }
    }

    //在数据表Resources插入一条记录操作
    protected bool InsertDataBase()
    {
        bool result = false;

        using (SqlConnection conn = new DB().GetConnection())
        {
            //向resources插入一条记录操作
            StringBuilder sb = new StringBuilder("Insert into Resources (ResourceName,FileName,FilePath,FileSizeInKB,FileType,Extentsion,FolderID,FolderName,UserID,CDT,Status,UserName,Valid,WebID)");
            sb.Append(" values(@ResourceName,@FileName,@FilePath,@FileSize,@FileType,@Extentsion,@FolderID,@FolderName,@UserID,@CDT,@Status,@UserName,@Valid,@WebID)");
            SqlCommand cmd = new SqlCommand(sb.ToString(), conn);
            cmd.Parameters.AddWithValue("@ResourceName", TextBox1.Text);
            cmd.Parameters.AddWithValue("@FileName", FN.Text);
            cmd.Parameters.AddWithValue("@FilePath", FP.Text);
            cmd.Parameters.AddWithValue("@FileSize", FS.Text);
            cmd.Parameters.AddWithValue("@FileType", ResourceTypeLabel.Text);
            cmd.Parameters.AddWithValue("@Extentsion", FET.Text);
            cmd.Parameters.AddWithValue("@FolderID", FolderDDL.SelectedItem.Value);
            cmd.Parameters.AddWithValue("@FolderName", FolderDDL.SelectedItem.Text);
            cmd.Parameters.AddWithValue("@UserID", Session["UserID"].ToString());
            cmd.Parameters.AddWithValue("@UserName", Session["UserName"].ToString());
            cmd.Parameters.AddWithValue("@CDT", DateTime.Now);
            cmd.Parameters.AddWithValue("@Status", 0);
            cmd.Parameters.AddWithValue("@Valid", 1);
            cmd.Parameters.AddWithValue("@WebID", Convert.ToInt32(Session["WebID"].ToString()));
            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();
            conn.Open();
            cmd.CommandText = "SELECT count(*) from Resources where FolderID =@FolderID";
            int count = int.Parse(Convert.ToString(cmd.ExecuteScalar()));
            cmd.CommandText = "Update ResourceFolders set Counts = " + count.ToString() + " where ID = @ID";
            cmd.Parameters.AddWithValue("@ID", FolderDDL.SelectedItem.Value);
            cmd.ExecuteNonQuery();
            cmd.Dispose();
            //插入成功
            result = true;
        }
        return result;
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        string FNText=Util.GetFileName();
        string[] array = FNText.Split(',');
        int k = array.Length;
        int s = k - 1;
        int i = 0;
        string sql = "";
        using (SqlConnection conn = new DB().GetConnection())
        {
            conn.Open();
            SqlCommand cmd=conn.CreateCommand();
            for (int num = 0; num < k; num++)
            {
                sql = "Update [Resources] set FolderID=@FolderID,FolderName=@FolderName where FileName = @FileName";
                cmd = new SqlCommand(sql.ToString(), conn);
                cmd.Parameters.AddWithValue("@FileName", array[num]);
                cmd.Parameters.AddWithValue("@FolderID", FolderDDL.SelectedItem.Value);
                cmd.Parameters.AddWithValue("@FolderName", FolderDDL.SelectedItem.Text);
                cmd.ExecuteNonQuery();
            }
            Util.CleanFileName();
            conn.Close();
            conn.Open();
            cmd.CommandText = "Update ResourceFolders set Counts = Counts - " + s.ToString() + " where ID = 96;Update ResourceFolders set Counts = Counts + " + s.ToString() + " where ID = @ID";
            cmd.Parameters.AddWithValue("@ID", FolderDDL.SelectedItem.Value);
            cmd.ExecuteNonQuery();
            cmd.Dispose();
            //插入成功
            i=1;

        }
        if (i == 1)
        {
            Response.Redirect(Server.HtmlEncode("File_Man.aspx"));
        }
    }

    protected void FolderDDL_SelectedIndexChanged(object sender, EventArgs e)
    {
        StringBuilder whereStr = new StringBuilder(" where 1= 1 ");
        if (FolderDDL.SelectedIndex > 0)
        {
            whereStr.Append(" and FolderID = '").Append(FolderDDL.SelectedValue).Append("'");
        }
    }
}