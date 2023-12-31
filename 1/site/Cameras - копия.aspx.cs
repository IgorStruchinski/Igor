using System;
using System.Data;
using System.Drawing;
using System.Web.UI.WebControls;
using System.IO;

public partial class Cameras : System.Web.UI.Page
{
    //public DataTable DT = new DataTable();
    public DataRow dtr;
    public StreamReader f;
    public DateTime MaxTime;
    public string[] Cams;
    public string PathToCamsFiles = "D:\\1\\site\\";
    string[] ipMas = {
        "192.168.100.20",
        "192.168.100.21"
    };
    protected void Page_Load(object sender, EventArgs e)
    {
        /*
        string userIP;
        userIP = Request.UserHostAddress;
        if (Array.IndexOf(ipMas, userIP) < 0)
        {
            Response.Redirect("http://localhost/AccessDenied.aspx");
        }
        else
        {
        
            MainSVNProc(CamsEK, "CamsEK");
        }
        */
        MainSVNProc(CamsEK, "CamsEK");
    }

    protected void MainSVNProc(GridView GV, string CamsFileName)
    {
        Cams = null;
        Cams = File.ReadAllLines(PathToCamsFiles + CamsFileName, System.Text.Encoding.Default);
        DataTable DT = new DataTable();

        DT.Columns.Add("�");
        DT.Columns.Add("��� ������");
        DT.Columns.Add("IP-�����");
        DT.Columns.Add("����");
        DT.Columns.Add("�����");
        DT.Columns.Add("state");

        string num = "", tag = "", cam_date = "", cam_time = "", cam_ip = "", cam_name = "", cam_state = "";
        for (int i = 0; i < Cams.Length; i++)
        {
            num = Cams[i].Substring(0, Cams[i].IndexOf("#"));
            tag = Cams[i].Substring(Cams[i].IndexOf("#") + 1);
            f = new StreamReader("D:\\CAM_" + tag, System.Text.Encoding.Default);
            cam_date = f.ReadLine();
            cam_time = f.ReadLine();
            cam_ip = f.ReadLine();
            cam_name = f.ReadLine();
            cam_state = f.ReadLine();
            f.Close();

            dtr = DT.NewRow();
            dtr["�"] = num;
            dtr["��� ������"] = cam_name;
            dtr["IP-�����"] = cam_ip;
            dtr["����"] = cam_date;
            dtr["�����"] = cam_time;
            dtr["state"] = cam_state;

            DT.Rows.Add(dtr);
        }
        GV.DataSource = DT;
        GV.DataBind();

        for (int r = 0; r < GV.Rows.Count; r++)
        {
            if (GV.Rows[r].Cells[5].Text == "good")
            {
                GV.Rows[r].BackColor = Color.FromArgb(102, 255, 153);
                GV.Rows[r].ForeColor = Color.Black;
            }
            if (GV.Rows[r].Cells[5].Text == "bad")
            {
                if (GV.Rows[r].Cells[1].Text.Contains("��������� �����"))
                {
                    GV.Rows[r].BackColor = Color.FromArgb(255, 216, 0);
                    GV.Rows[r].ForeColor = Color.Black;
                }
                else
                {
                    GV.Rows[r].BackColor = Color.FromArgb(255, 102, 102);
                    GV.Rows[r].ForeColor = Color.White;
                }
                    
            }
            if (GV.Rows[r].Cells[5].Text == "lost")
            {
                GV.Rows[r].BackColor = Color.Gray;
                GV.Rows[r].ForeColor = Color.Black;
            }
            GV.Rows[r].Cells[5].Visible = false;
        }
        GV.HeaderRow.Cells[5].Visible = false;
        GV.HeaderRow.BackColor = Color.FromArgb(102, 204, 255);
    }


    protected void ReadCams(string CamsFileName)
    {
        Cams = null;
        Cams = File.ReadAllLines(PathToCamsFiles + CamsFileName, System.Text.Encoding.Default);
    }
    protected void FormatTable()
    {
        for (int r = 0; r < CamsLTS.Rows.Count; r++)
        {
            if (CamsLTS.Rows[r].Cells[5].Text == "good")
            {
                CamsLTS.Rows[r].BackColor = Color.FromArgb(102, 255, 153);
                CamsLTS.Rows[r].ForeColor = Color.Black;
            }
            if (CamsLTS.Rows[r].Cells[5].Text == "bad")
            {
                CamsLTS.Rows[r].BackColor = Color.FromArgb(255, 102, 102);
                CamsLTS.Rows[r].ForeColor = Color.White;
            }
            if (CamsLTS.Rows[r].Cells[5].Text == "lost")
            {
                CamsLTS.Rows[r].BackColor = Color.Gray;
                CamsLTS.Rows[r].ForeColor = Color.Black;
            }
            CamsLTS.Rows[r].Cells[5].Visible = false;
        }
        CamsLTS.HeaderRow.Cells[5].Visible = false;
    }
}
