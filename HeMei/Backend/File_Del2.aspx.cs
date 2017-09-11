using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;

public partial class File_Del2 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["RoleID"] == null || Session["UserID"] == null)
            {
                Util.ShowMessage("用户登录超时，请重新登录！", "Login2.aspx");
            }
            else
            {
                int RoleID = Convert.ToInt16(Session["RoleID"].ToString());
                if (RoleID > 4)
                {
                    Util.ShowMessage("对不起，你无权访问该页面！", "User_Center.aspx");

                }
                else
                {
                    if (Request.QueryString["IDS"] != null)
                    {
                        IDSLabel.Text = Request.QueryString["IDS"].ToString();
                 
                        MyInit();
                    }
                }
            }
        }
    }
    private void MyInit()
    {
        using (SqlConnection conn = new DB().GetConnection())
        {
            SqlCommand cmd = conn.CreateCommand();
            cmd.CommandText = "select * from Resources where ID in (" + IDSLabel.Text + ") and Valid=1 order by ID desc";
            conn.Open();
            SqlDataReader rd = cmd.ExecuteReader();
            GridView1.DataSource = rd;
            GridView1.DataBind();
            rd.Close();



            //计算要删除的有效的资源共多少
            cmd.CommandText = "select count(*) as maxrow from Resources where ID in (" + IDSLabel.Text + ") and Valid=1 ";
            rd = cmd.ExecuteReader();
            if (rd.Read())
            {
                Count.Text = rd["maxrow"].ToString();
            }
            rd.Close();


            //除作者本人和Editor以上的权限可以对已有效的资源（Valid = 1） 进行 删除（Valid=0）操作，其余会报错。

            string s = "";
            int i = Convert.ToInt32(Count.Text);
            string[] AuthorID = new string[i];
            string[] resourceIDS = new string[i];
            cmd.CommandText = "select * from Resources where ID in (" + IDSLabel.Text + ") and Valid=1 order by ID desc";
            SqlDataReader rd2 = cmd.ExecuteReader();
            if (i != 0)
            {
                for (int j = 0; j < i; j++)
                {
                    if (rd2.Read())
                    {
                        AuthorID[j] = rd2["UserID"].ToString();
                        resourceIDS[j] = rd2["ID"].ToString();
                        int RoleID = Convert.ToInt16(Session["RoleID"].ToString());
                        if (RoleID > 2)
                        {
                            if (AuthorID[j] != Session["UserID"].ToString())
                            {
                                Response.Write("<script>alert('以下资源有其他作者上传的文件，你无法进行删除操作');</script>");
                                Button3.Visible = false;
                                j = i;
                            }
                       }
                        for (int k = 0; k < i; k++)
                        {
                            s = string.Join(",", resourceIDS);

                            ResourceIDS.Text = s;
                        } 
                        

                    }
                }
            }
            else
            {
                int s1 = 0;
                ResourceIDS.Text = s1.ToString();
            }

            rd2.Close();
            




            conn.Close();
        }
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        int i = 0;
        int rowNo = 0;
        using (SqlConnection conn = new DB().GetConnection())
        { 
            SqlCommand cmd = conn.CreateCommand();
            cmd.CommandText = "Update Resources set Valid=0 where ID in (" + ResourceIDS.Text + ")";
            conn.Open();
            i = cmd.ExecuteNonQuery();
            cmd.Dispose();

            foreach (GridViewRow row in GridView1.Rows)
            {
                string hidecolum_folderidN = GridView1.DataKeyNames[0];
                int hidecolum_folderidValue = (int)GridView1.DataKeys[rowNo].Value;
                cmd.CommandText = "Update ResourceFolders set Counts = Counts-1 where ID = " + hidecolum_folderidValue.ToString() + "  ";
                cmd.ExecuteNonQuery();
                rowNo++;
            }

            cmd.CommandText = "select * from Resources where  Valid=1 and ID in (" + ResourceIDS.Text + ") order by ID desc";
            SqlDataReader rd = cmd.ExecuteReader();
            GridView1.DataSource = rd;
            GridView1.DataBind();
            rd.Close();
            conn.Close();

        }
        if (i > 0)
        {
            ResultLabel.Text = "成功删除" + i + "个资源！";
            ResultLabel.ForeColor = System.Drawing.Color.Green;
            Response.Redirect("File_Man.aspx");
        }
        else
        {
            ResultLabel.Text = "操作失败，请重试！";
            ResultLabel.ForeColor = System.Drawing.Color.Red;
        }
    }
    protected void Button2_Click(object sender, EventArgs e)
    {
        Response.Redirect("File_Man.aspx");
    }
}