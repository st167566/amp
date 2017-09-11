<%@ WebHandler Language="C#" Class="UpLoadFile" %>

using System;
using System.Web;
using System.IO;
using System.Web.SessionState;
using System.Data.SqlClient;
using System.Text;
using System.Drawing;

public class UpLoadFile : IHttpHandler, IRequiresSessionState
{

    public void ProcessRequest (HttpContext context) {
        HttpFileCollection files = context.Request.Files;
        string project_id = "";//用于项目封面图上传
        string _targDir = DateTime.Now.ToString("yyyyMM");
        string basePath = System.Web.HttpContext.Current.Server.MapPath("~/Backend/Upload/" + _targDir);
        string allowExtension = "";//上传的格式限制
        string returnurl = "";
        if (!Directory.Exists(basePath))
        {
            //创建文件夹
            Directory.CreateDirectory(basePath);
        }
        if (context.Request["UploadType"] == "ProjectCoverPhoto")
        {
            //用于项目封面图上传
            allowExtension = ".jpg,.png,.gif";
            project_id = context.Request["project_id"];
        }
        if (context.Request["UploadType"] == "FocuPhoto")
        {
            //用于网站群焦点图上传
            allowExtension = ".jpg,.png,.gif";
            project_id = context.Request["project_id"];
        }
        else if (context.Request["UploadType"] == "LinkFile")
        {
            //用于任务关联上传文件
            allowExtension = ".jpg,.png,.gif";
        }
        for (int iFile = 0; iFile < files.Count; iFile++)
        {
            string number = String.Format("{0:0000}", new Random().Next(1000));//生产****四位数的字符串;
            ///'检查文件扩展名字
            HttpPostedFile postedFile = files[iFile];
             
            //文件大小（字节为单位）
            int Size = postedFile.ContentLength;
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
            string fileName = System.IO.Path.GetFileName(postedFile.FileName);
            string extension = System.IO.Path.GetExtension(fileName).ToLower();
            
            if (allowExtension.Contains(extension))
            {
                string now = DateTime.Now.ToString("yyyyMMdd_HHmmss");
                string physicalName = "/Backend/Upload/" + _targDir + "/" + context.Session["UserID"] + "_" + now + "_" + number + extension;
                returnurl = physicalName;
                postedFile.SaveAs(context.Server.MapPath(physicalName));
                using (SqlConnection conn = new DB().GetConnection())//上传文件更新数据库
                {
                    StringBuilder sb = new StringBuilder("Insert into Resources(ResourceName,FilePath,FileSizeInKB,FileType,Extentsion,UserID,CDT,Status,Valid,WebID)");
                    sb.Append(" values(@ResourceName,@FilePath,@FileSizeInKB,@FileType,@Extentsion,@UserID,@CDT,@Status,@Valid,@WebID)");
                    SqlCommand cmd = new SqlCommand(sb.ToString(), conn);
                    cmd.Parameters.AddWithValue("FileName", fileName);
                    cmd.Parameters.AddWithValue("@ResourceName", files[iFile].FileName);
                    cmd.Parameters.AddWithValue("@FilePath", physicalName);
                    cmd.Parameters.AddWithValue("@FileSizeInKB", fileSize);
                    cmd.Parameters.AddWithValue("@FileType", JudgeType(allowExtension));
                    cmd.Parameters.AddWithValue("@Extentsion", extension);
                    cmd.Parameters.AddWithValue("@UserID", context.Session["UserID"]);
                    cmd.Parameters.AddWithValue("@CDT", DateTime.Now);
                    cmd.Parameters.AddWithValue("@Status", 0);
                    cmd.Parameters.AddWithValue("@Valid", 1);
                    cmd.Parameters.AddWithValue("@WebID",context.Session["WebID"]);
                    conn.Open();
                    cmd.ExecuteNonQuery();
                    cmd.Dispose();
                    conn.Close();
                    //插入成功

                }
                if (context.Request["UploadType"] == "FocuPhoto")
                {
                    string uploadpath = context.Server.MapPath(@"~\Backend/Upload/"+ _targDir) + "\\";
                    Byte[] oFileByte = new byte[postedFile.ContentLength];
                    System.IO.Stream oStream = postedFile.InputStream;
                    System.Drawing.Image oImage = System.Drawing.Image.FromStream(oStream);
                         int oWidth = oImage.Width; //原图宽度   
                    int oHeight = oImage.Height; //原图高度
                    int tWidth = 600; //设置缩略图初始宽度   
                    int tHeight = 180; //设置缩略图初始高度  
                    //按比例计算出缩略图的宽度和高度   
                    if (oWidth >= oHeight)
                    {
                        tHeight = (int)Math.Floor(Convert.ToDouble(oHeight) * (Convert.ToDouble(tWidth) / Convert.ToDouble(oWidth)));
                    }
                    else
                    {
                        tWidth = (int)Math.Floor(Convert.ToDouble(oWidth) * (Convert.ToDouble(tHeight) / Convert.ToDouble(oHeight)));
                    }
                    //生成缩略原图   
                    Bitmap tImage = new Bitmap(600, tHeight);
                    Graphics g = Graphics.FromImage(tImage);
                    g.InterpolationMode = System.Drawing.Drawing2D.InterpolationMode.High; //设置高质量插值法   
                    g.SmoothingMode = System.Drawing.Drawing2D.SmoothingMode.HighQuality;//设置高质量,低速度呈现平滑程度   
                    g.Clear(Color.Transparent); //清空画布并以透明背景色填充   
                    g.DrawImage(oImage, new Rectangle(0, 0, tWidth, tHeight), new Rectangle(0, 0, oWidth, oHeight), GraphicsUnit.Pixel);
                    //创建一个图像对象取得上传图片对象
                    //缩略图的保存路径
                    string fileXltPath = uploadpath + "\\" + fileName.Replace(extension , "x" + extension );
                    string fileXltPath2 = "/Backend/upload/"+  _targDir + "/"+fileName.Replace(extension , "x" + extension );
                    //保存缩略图
                    tImage.Save(fileXltPath, System.Drawing.Imaging.ImageFormat.Jpeg);
                    using (SqlConnection conn = new DB().GetConnection())//上传文件更新数据库
                {
                    StringBuilder sb = new StringBuilder("insert into Focuses( PhotoSrc,UserID,UserName,Thumbnail,WebID ) values( @PhotoSrc,@UserID,@UserName,@Thumbnail,@WebID )");
                    SqlCommand cmd = new SqlCommand(sb.ToString(), conn);
                    cmd.Parameters.AddWithValue("@PhotoSrc", physicalName);
                    cmd.Parameters.AddWithValue("@UserID",  context.Session["UserID"]);
                    cmd.Parameters.AddWithValue("@UserName", context.Session["UserName"]);
                    cmd.Parameters.AddWithValue("@Thumbnail",fileXltPath2);
                    cmd.Parameters.AddWithValue("@WebID", context.Session["WebID"]);
                    conn.Open();
                    cmd.ExecuteNonQuery();
                    cmd.Dispose();
                    conn.Close();
                    //插入成功

                }
                }

            }
         
        }
        context.Response.Write(returnurl);
        context.Response.End();
    }
    public string JudgeType(string allowExtension)
    {
        if (allowExtension == ".jpg,.png,.gif") return "图片";
        else if (allowExtension == ".mp3") return "音频";
        else if (allowExtension == ".bmp,.mp4,.flv,.mpeg,.swf,.avi") return "视频";
        else return "文档";

    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}