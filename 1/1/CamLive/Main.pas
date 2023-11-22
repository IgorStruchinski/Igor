unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, IdRawBase, IdRawClient, IdIcmpClient, IdBaseComponent, Menus, IniFiles,
  IdComponent, IdIPWatch, ShellApi, ComCtrls;

type
  TMainForm = class(TForm)
    IdIcmpClient_ping: TIdIcmpClient;
    Button1: TButton;
    MainMenu: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    Edit_ping_timeout: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Edit_files_path: TEdit;
    Label3: TLabel;
    Edit_file_prefix: TEdit;
    RichEditLog: TRichEdit;
    Label4: TLabel;
    Edit_opros: TEdit;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure N2Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    //procedure OnMinimizeProc(Sender:TObject);
    //procedure Ic(n:Integer;Icon:TIcon;xHint:string);
    //procedure ControlWindow(Var Msg:TMessage); message WM_SYSCOMMAND;
    //procedure IconMouse(Var Msg:TMessage); message WM_USER+1;
  end;

type
  TWorkThread = class(TThread)
  private
  protected
    procedure Execute; override;
    //procedure WorkMain();
  end;

procedure SaveToIni();
procedure ReadFromIni();
procedure SaveFile(prefix: string; path: string; camera: string; ip_addr: string; ping_result: string);
function TextFileToString(const FName: TFileName): string;
procedure AddColoredLine(ARichEdit: TRichEdit; AText: string; AColor: TColor);


var
  MainForm: TMainForm;
  WorkThrd: TWorkThread;
  ListIP: TStringList;
  formCloseTag: string;

const
  fl = 'cams.lst';
  fileName = 'CamLive.ini';
//  oprosSec = 30;

implementation

{$R *.dfm}

procedure TMainForm.FormCreate(Sender: TObject);
begin
  ReadFromIni();
  formCloseTag := 'no'; //тэг для запрета закрытия формы
  ListIP := TStringList.Create(); //создаем список айпишников камер
  ListIP.CommaText := TextFileToString(fl);//загружаем пары ip-название из текстового файла cams.lst
  WorkThrd := TWorkThread.Create(False); //запускаем поток
  WorkThrd.Priority:=tpNormal;
end;

procedure TWorkThread.Execute;
var i: integer;
    path: string;
    ipAddr, CamName, pingResult: string;
    clr: TColor;
    sec: integer;
//const scs = 1000;

begin
  While true do
  begin
    MainForm.RichEditLog.Clear;

    //Проверяем на корректность таймаута
    try MainForm.IdIcmpClient_ping.ReceiveTimeout := StrToInt(MainForm.Edit_ping_timeout.Text);
    except AddColoredLine(MainForm.RichEditLog, 'Задан некорректный таймаут', clBlack); MainForm.IdIcmpClient_ping.ReceiveTimeout := 5000; end;

    //Проверка на корректность периода опроса
    try sec := StrToInt(MainForm.Edit_opros.Text);
    except AddColoredLine(MainForm.RichEditLog, 'Задан некорректный периода опроса', clBlack); sec := 300; end;

    //Проверяем на существование папки для файлов
    if DirectoryExists(MainForm.Edit_files_path.Text) then
    begin
      path := MainForm.Edit_files_path.Text;
      //MainForm.RichEditLog.Lines.Add('директория существует');
    end
    else begin path := 'D:/'; MainForm.RichEditLog.Lines.Add('директория не существует - пишем в ' + path);end;

    for i:=0 to ListIP.Count - 1 do
    begin
      try
      ipAddr := ListIP.Names[i];
      CamName := ListIP.Values[ListIP.Names[i]];

      MainForm.IdIcmpClient_ping.Host := ipAddr;
      MainForm.IdIcmpClient_ping.Ping();
      case MainForm.IdIcmpClient_ping.ReplyStatus.BytesReceived of
        72:  begin pingResult := 'good'; clr := clGreen; end;//100% пинг
        0:   begin pingResult := 'bad';  clr := clRed;   end;//нет связи
        else begin pingResult := 'lost'; clr := clGray;  end;//Пинг есть, но с потерями
      end;
      AddColoredLine(MainForm.RichEditLog, pingResult + ' - ' + ipAddr + ' ' + CamName, clr);
      SaveFile(MainForm.Edit_file_prefix.Text, MainForm.Edit_files_path.Text, CamName, ipAddr, pingResult);
      sleep(50);
      except
        MainForm.RichEditLog.Lines.Add('ошибка 1');
      end;
    end;
    SaveFile('', MainForm.Edit_files_path.Text, '', 'Сборщик состояния камер (on 10.182.76.20)', '');
    sleep(sec * 1000);
  end;
end;















procedure TMainForm.Button1Click(Sender: TObject);
begin
  ListIP.CommaText := TextFileToString(fl);//загружаем пары ip-название из текстового файла cams.lst
end;

procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if formCloseTag <> 'ok' then
  begin
    Action := caNone;
    //OnMinimizeProc(Sender);
  end
  else
    SaveToIni();
end;












//возвращаем текст из текстового файла
function TextFileToString(const FName: TFileName): string;
var
  St: TStringList;
begin
  St:= TStringList.Create;
  try
    St.LoadFromFile(FName);
    Result:= St.Text;
    Result := StringReplace(Result, #13#10, '', [rfReplaceAll, rfIgnoreCase])
  finally
    St.Free
  end
end;

//Добавление строки в ричэдит с цветны текстом
procedure AddColoredLine(ARichEdit: TRichEdit; AText: string; AColor: TColor);
begin
  with ARichEdit do
  begin
    SelStart := Length(Text);
    SelAttributes.Color := AColor;
    Lines.Add(AText);
  end;
end;

//сохраняем результат пинга камеры в файл
procedure SaveFile(prefix: string; path: string; camera: string; ip_addr: string; ping_result: string);
var f: TextFile;
    fname, str: string;
begin
  str := '';
  fname := StringReplace(ip_addr, '.', '', [rfReplaceAll, rfIgnoreCase]);
  fname := prefix + '_' + fname;
  if Length(prefix) = 0 then
    fname := 'COpros_Cams_good';

  AssignFile(f, path + fname);

  //если в файле уже есть запись 'bad' то не изменяем файл, чтобы знать время когда камера отвалилась
  if FileExists(path + fname) then
    if ping_result = 'bad' then
    begin
      Reset(f);
      While not EOF(f) do
      begin
        Readln(f, str);
        if Pos('bad', str) > 0 then begin CloseFile(f); exit; end;
      end;
      CloseFile(f);
    end;
  ////////////////////////////

  Rewrite(f);
  Writeln(f, FormatDateTime('dd.mm.yyyy', Now));
  Writeln(f, FormatDateTime('hh:MM:ss', Now));
  Writeln(f, ip_addr);
  Writeln(f, StringReplace(camera, '_', ' ', [rfReplaceAll, rfIgnoreCase]));
  Writeln(f, ping_result);
  CloseFile(f);
end;



///////////////////////////////   INI   ///////////////////////////////////////////////////////////////
procedure SaveToIni();
var iniFile: TIniFile;
    i: integer;
begin
  iniFile := TIniFile.Create(extractfilepath(paramstr(0)) + fileName);
  iniFile.WriteString('Settings', 'Ping timeout', MainForm.Edit_ping_timeout.Text);
  iniFile.WriteString('Settings', 'Opros', MainForm.Edit_opros.Text);
  iniFile.WriteString('Settings', 'Files path', MainForm.Edit_files_path.Text);
  iniFile.WriteString('Settings', 'File prefix', MainForm.Edit_file_prefix.Text);
  iniFile.Free;
end;

procedure ReadFromIni();
var iniFile: TIniFile;
    i: integer;
begin
  iniFile := TIniFile.Create(extractfilepath(paramstr(0)) + fileName);
  MainForm.Edit_ping_timeout.Text := iniFile.ReadString('Settings', 'Ping timeout', '5000');
  MainForm.Edit_opros.Text := iniFile.ReadString('Settings', 'Opros', '300');
  MainForm.Edit_files_path.Text := iniFile.ReadString('Settings', 'Files path', 'D:/');
  MainForm.Edit_file_prefix.Text := iniFile.ReadString('Settings', 'File prefix', 'CAM');
  iniFile.Free;
end;
//////////////////////////////////////////////////////////////////////////////////////////////////////


procedure TMainForm.N2Click(Sender: TObject);
begin
  formCloseTag := 'ok';
  MainForm.Close;
end;

procedure TMainForm.N4Click(Sender: TObject);
begin
  ShowMessage('Cam Live Watcher версия 1.0.8.19' + #10 + #13 +
            'Программа для контроля работы системы видеонаблюдения.' + #10 + #13 +
            'Автор: Стручинский Игорь (zebra346256@gmail.com)' + #10 + #13 +
            'Программа бесплатная, но Вы можете поддержать' + #10 + #13 +
            'автора материально.');
end;


end.
