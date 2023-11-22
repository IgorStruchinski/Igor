object MainForm: TMainForm
  Left = 192
  Top = 107
  BorderStyle = bsToolWindow
  Caption = 'Cam Live Watcher'
  ClientHeight = 629
  ClientWidth = 339
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 7
    Top = 8
    Width = 78
    Height = 13
    Caption = #1058#1072#1081#1084#1072#1091#1090' '#1087#1080#1085#1075#1072':'
  end
  object Label2: TLabel
    Left = 8
    Top = 56
    Width = 89
    Height = 13
    Caption = #1055#1091#1090#1100' '#1076#1083#1103' '#1092#1072#1081#1083#1086#1074':'
  end
  object Label3: TLabel
    Left = 8
    Top = 80
    Width = 90
    Height = 13
    Caption = #1055#1088#1077#1092#1080#1082#1089' '#1092#1072#1081#1083#1086#1074':'
  end
  object Label4: TLabel
    Left = 7
    Top = 32
    Width = 80
    Height = 13
    Caption = #1055#1077#1088#1080#1086#1076' '#1086#1087#1088#1086#1089#1072':'
  end
  object Button1: TButton
    Left = 8
    Top = 104
    Width = 97
    Height = 33
    Caption = #1055#1077#1088#1077#1079#1072#1075#1088#1091#1079#1080#1090#1100' '#1089#1087#1080#1089#1086#1082' '#1082#1072#1084#1077#1088
    TabOrder = 0
    WordWrap = True
    OnClick = Button1Click
  end
  object Edit_ping_timeout: TEdit
    Left = 104
    Top = 5
    Width = 97
    Height = 21
    Enabled = False
    TabOrder = 1
    Text = '5000'
  end
  object Edit_files_path: TEdit
    Left = 104
    Top = 53
    Width = 225
    Height = 21
    Enabled = False
    TabOrder = 2
    Text = 'D:/'
  end
  object Edit_file_prefix: TEdit
    Left = 104
    Top = 77
    Width = 121
    Height = 21
    Enabled = False
    TabOrder = 3
    Text = 'CAM'
  end
  object RichEditLog: TRichEdit
    Left = 0
    Top = 144
    Width = 339
    Height = 485
    Align = alBottom
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Lines.Strings = (
      'RichEditLog')
    ParentFont = False
    TabOrder = 4
    Zoom = 100
  end
  object Edit_opros: TEdit
    Left = 104
    Top = 29
    Width = 97
    Height = 21
    Enabled = False
    TabOrder = 5
    Text = '300'
  end
  object IdIcmpClient_ping: TIdIcmpClient
    Protocol = 1
    ProtocolIPv6 = 58
    IPVersion = Id_IPv4
    Left = 224
    Top = 560
  end
  object MainMenu: TMainMenu
    Left = 256
    Top = 560
    object N1: TMenuItem
      Caption = #1060#1072#1081#1083
      object N2: TMenuItem
        Caption = #1042#1099#1093#1086#1076
        OnClick = N2Click
      end
    end
    object N3: TMenuItem
      Caption = #1055#1086#1084#1086#1097#1100
      object N4: TMenuItem
        Caption = #1054' '#1087#1088#1086#1075#1088#1072#1084#1084#1077'...'
        OnClick = N4Click
      end
    end
  end
end
