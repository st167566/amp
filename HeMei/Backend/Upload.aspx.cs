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
using System.Configuration;
using System.Drawing;

public partial class Upload : System.Web.UI.Page
{
    string UserID = "0";
    //存储允许上传的资源的后缀名，key=Extension，value=TypeName
    Dictionary<string, string> ResourceTypes = new Dictionary<string, string>();
    protected void Page_Load(object sender, EventArgs e)
    {
        UserID = Session["UserID"].ToString();
        string _targDir = DateTime.Now.ToString("yyyyMM");
        string basePath = Server.MapPath("~/Backend/upload/" + _targDir);
        string FileNames = "";
        HttpFileCollection files = System.Web.HttpContext.Current.Request.Files;
        string allowExtension = ConfigurationManager.AppSettings["PhotoExtension"].ToString();

        //产生随机四位数
        //Random rdm = new Random();
        //int a = rdm.Next(1000, 9999);

        //如果目录不存在，则创建目录
        if (files != null)
        {
            if (!Directory.Exists(basePath))
            {
                //创建文件夹
                Directory.CreateDirectory(basePath);
            }

            for (int i = 0; i < files.Count; i++)
            {

                //文件原名称
                string OldFileName = files[i].FileName;
                //文件大小（字节为单位）
                int Size = files[i].ContentLength;
                string size;
                if (Size > 1024)
                {
                    Size /= 1024;
                    size = Size.ToString();
                }
                else
                {
                    size = "0";
                }
                string fileSize = size;
                //文件后缀名
                string Extentsion = Path.GetExtension(files[i].FileName).ToLower();
                //自动命名文件名称
                string fileName = UserID + "_" + DateTime.Now.ToString("yyyyMMddHHmmss") + "_" + new Random().Next(1000, 10000).ToString() + Extentsion;
                FileNames += "," + fileName;
                string FT = Extentsion.Substring(1);
                //文件上传保存物理路径
                string filePath = "/"+"Backend"+ "/" +"upload" + "/" + _targDir + "/" + fileName;
                //文件类型  FileType

                using (SqlConnection conn = new DB().GetConnection())
                {

                    SqlCommand cmd = conn.CreateCommand();
                    conn.Open();
                    cmd.CommandText = "select * from ResourceTypes where Extension=@Extension";
                    cmd.Parameters.AddWithValue("@Extension", FT);
                    SqlDataReader rd = cmd.ExecuteReader();
                    if (rd.Read())
                    {
                        Label1.Text = rd["TypeName"].ToString();
                    }

                    rd.Close();
                    conn.Close();
                }
                String fileType = Label1.Text;


                //写入文件
                files[i].SaveAs(basePath + "/" + fileName);
                string fileXltPath = "";
                string fileXltPath3 = "";

                if (allowExtension.Contains(Extentsion))
                {

                    System.IO.Stream oStream = files[i].InputStream;
                    System.Drawing.Image oImage = System.Drawing.Image.FromStream(oStream);
                    int oWidth = oImage.Width; //原图宽度   
                    int oHeight = oImage.Height; //原图高度
                    int tWidth = 600; //设置缩略图初始宽度   
                    int t2Height = 150;
                    int t2Width = 200;
                    int tHeight = 300; //设置缩略图初始高度 
                    //按比例计算出缩略图的宽度和高度   
                    if (oWidth >= oHeight)
                    {
                        tHeight = (int)Math.Floor(Convert.ToDouble(oHeight) * (Convert.ToDouble(tWidth) / Convert.ToDouble(oWidth)));
                        t2Height = (int)Math.Floor(Convert.ToDouble(oHeight) * (Convert.ToDouble(t2Width) / Convert.ToDouble(oWidth)));
                    }
                    else
                    {
                        tWidth = (int)Math.Floor(Convert.ToDouble(oWidth) * (Convert.ToDouble(tHeight) / Convert.ToDouble(oHeight)));
                        t2Width = (int)Math.Floor(Convert.ToDouble(oWidth) * (Convert.ToDouble(t2Height) / Convert.ToDouble(oHeight)));
                    }

                    if (oWidth >= 600)
                    {
                        //生成缩略原图   
                        Bitmap tImage = new Bitmap(tWidth, tHeight);
                        Graphics g = Graphics.FromImage(tImage);
                        g.InterpolationMode = System.Drawing.Drawing2D.InterpolationMode.High; //设置高质量插值法   
                        g.SmoothingMode = System.Drawing.Drawing2D.SmoothingMode.HighQuality;//设置高质量,低速度呈现平滑程度 
                        g.Clear(Color.Transparent); //清空画布并以透明背景色填充   
                        g.DrawImage(oImage, new Rectangle(0, 0, tWidth, tHeight), new Rectangle(0, 0, oWidth, oHeight), GraphicsUnit.Pixel);
                        fileXltPath = basePath + fileName.Replace(Extentsion, "m" + Extentsion);
                        string fileXltPath2 = basePath + "\\" + fileName.Replace(Extentsion, "m" + Extentsion);
                        tImage.Save(fileXltPath2, System.Drawing.Imaging.ImageFormat.Jpeg);


                    }
                    Bitmap tImage2 = new Bitmap(t2Width, t2Height);

                    Graphics g2 = Graphics.FromImage(tImage2);

                    g2.InterpolationMode = System.Drawing.Drawing2D.InterpolationMode.High;

                    g2.SmoothingMode = System.Drawing.Drawing2D.SmoothingMode.HighQuality;

                    g2.Clear(Color.Transparent);

                    g2.DrawImage(oImage, new Rectangle(0, 0, t2Width, t2Height), new Rectangle(0, 0, oWidth, oHeight), GraphicsUnit.Pixel);
                    //创建一个图像对象取得上传图片对象
                    //缩略图的保存路径

                    fileXltPath3 = basePath + fileName.Replace(Extentsion, "s" + Extentsion);
                    string fileXltPath4 = basePath + "\\" + fileName.Replace(Extentsion, "s" + Extentsion);
                    //保存缩略图

                    tImage2.Save(fileXltPath4, System.Drawing.Imaging.ImageFormat.Jpeg);

                    using (SqlConnection conn = new DB().GetConnection())
                    {
                        //向resources插入一条记录操作
                        StringBuilder sb = new StringBuilder("Insert into Resources (ResourceName,FileName,FilePath,FileSizeInKB,FileType,Extentsion,FolderID,FolderName,UserID,CDT,Status,UserName,Valid,Thumbnail,Thumbnail2,WebID)");
                        sb.Append(" values(@ResourceName,@FileName,@FilePath,@FileSize,@FileType,@Extentsion,@FolderID,@FolderName,@UserID,@CDT,@Status,@UserName,@Valid,@Thumbnail,@Thumbnail2,@WebID)");
                        SqlCommand cmd = new SqlCommand(sb.ToString(), conn);
                        cmd.Parameters.AddWithValue("@ResourceName", OldFileName);
                        cmd.Parameters.AddWithValue("@FileName", fileName);
                        cmd.Parameters.AddWithValue("@FilePath", filePath);
                        cmd.Parameters.AddWithValue("@FileSize", fileSize);
                        cmd.Parameters.AddWithValue("@FileType", fileType);
                        cmd.Parameters.AddWithValue("@Extentsion", Extentsion);
                        cmd.Parameters.AddWithValue("@FolderID", 96);
                        cmd.Parameters.AddWithValue("@FolderName", "默认文件夹");
                        cmd.Parameters.AddWithValue("@UserID", Session["UserID"].ToString());
                        cmd.Parameters.AddWithValue("@UserName", Session["UserName"].ToString());
                        cmd.Parameters.AddWithValue("@CDT", DateTime.Now);
                        cmd.Parameters.AddWithValue("@Status", 0);
                        cmd.Parameters.AddWithValue("@Valid", 1);
                        if (oWidth >= 600)
                        {
                            cmd.Parameters.AddWithValue("@Thumbnail", fileXltPath);
                        }
                        else
                        {
                            cmd.Parameters.AddWithValue("@Thumbnail", filePath);
                        }
                        cmd.Parameters.AddWithValue("@Thumbnail2", fileXltPath3);
                        cmd.Parameters.AddWithValue("@WebID", Session["WebID"].ToString());
                        conn.Open();
                        cmd.ExecuteNonQuery();
                        conn.Close();
                        conn.Open();
                        cmd.CommandText = "SELECT count(*) from Resources where FolderID =@FolderID";
                        int count = int.Parse(Convert.ToString(cmd.ExecuteScalar()));
                        cmd.CommandText = "Update ResourceFolders set Counts = " + count.ToString() + " where ID = 96";
                        //cmd.Parameters.AddWithValue("@ID", FolderDDL.SelectedItem.Value);
                        cmd.ExecuteNonQuery();
                        cmd.Dispose();
                        //插入成功
                    }

                }


                else
                {
                    using (SqlConnection conn = new DB().GetConnection())
                    {
                        //向resources插入一条记录操作
                        StringBuilder sb = new StringBuilder("Insert into Resources (ResourceName,FileName,FilePath,FileSizeInKB,FileType,Extentsion,FolderID,FolderName,UserID,CDT,Status,UserName,Valid,Thumbnail,Thumbnail2,WebID)");
                        sb.Append(" values(@ResourceName,@FileName,@FilePath,@FileSize,@FileType,@Extentsion,@FolderID,@FolderName,@UserID,@CDT,@Status,@UserName,@Valid,@Thumbnail,@Thumbnail2,@WebID)");
                        SqlCommand cmd = new SqlCommand(sb.ToString(), conn);
                        cmd.Parameters.AddWithValue("@ResourceName", OldFileName);
                        cmd.Parameters.AddWithValue("@FileName", fileName);
                        cmd.Parameters.AddWithValue("@FilePath", filePath);
                        cmd.Parameters.AddWithValue("@FileSize", fileSize);
                        cmd.Parameters.AddWithValue("@FileType", fileType);
                        cmd.Parameters.AddWithValue("@Extentsion", Extentsion);
                        cmd.Parameters.AddWithValue("@FolderID", 96);
                        cmd.Parameters.AddWithValue("@FolderName", "默认文件夹");
                        cmd.Parameters.AddWithValue("@UserID", Session["UserID"].ToString());
                        cmd.Parameters.AddWithValue("@UserName", Session["UserName"].ToString());
                        cmd.Parameters.AddWithValue("@CDT", DateTime.Now);
                        cmd.Parameters.AddWithValue("@Status", 0);
                        cmd.Parameters.AddWithValue("@Valid", 1);
                        cmd.Parameters.AddWithValue("@Thumbnail", fileXltPath);
                        cmd.Parameters.AddWithValue("@Thumbnail2", fileXltPath3);
                        cmd.Parameters.AddWithValue("@WebID", Session["WebID"].ToString());
                        conn.Open();
                        cmd.ExecuteNonQuery();
                        conn.Close();
                        conn.Open();
                        cmd.CommandText = "SELECT count(*) from Resources where FolderID =@FolderID";
                        int count = int.Parse(Convert.ToString(cmd.ExecuteScalar()));
                        cmd.CommandText = "Update ResourceFolders set Counts = " + count.ToString() + " where ID = 96";
                        //cmd.Parameters.AddWithValue("@ID", FolderDDL.SelectedItem.Value);
                        cmd.ExecuteNonQuery();
                        cmd.Dispose();
                        //插入成功
                    }
                }

            }
            Util.SetFileName(FileNames);
        }
    }
}