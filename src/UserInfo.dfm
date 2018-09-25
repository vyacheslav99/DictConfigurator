object FUserInfo: TFUserInfo
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1054' '#1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1077
  ClientHeight = 318
  ClientWidth = 449
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnKeyPress = FormKeyPress
  DesignSize = (
    449
    318)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 76
    Top = 16
    Width = 12
    Height = 13
    Caption = 'PK'
  end
  object Label2: TLabel
    Left = 238
    Top = 16
    Width = 30
    Height = 13
    Caption = #1051#1086#1075#1080#1085
  end
  object Label3: TLabel
    Left = 65
    Top = 43
    Width = 23
    Height = 13
    Caption = #1060#1048#1054
  end
  object Label4: TLabel
    Left = 64
    Top = 232
    Width = 24
    Height = 13
    Caption = 'email'
  end
  object Label5: TLabel
    Left = 317
    Top = 232
    Width = 36
    Height = 13
    Caption = #1050#1086#1076' 1'#1057
  end
  object Label6: TLabel
    Left = 50
    Top = 70
    Width = 38
    Height = 13
    Caption = #1060#1080#1083#1080#1072#1083
  end
  object Label7: TLabel
    Left = 20
    Top = 124
    Width = 68
    Height = 13
    Caption = #1044#1077#1087#1072#1088#1090#1072#1084#1077#1085#1090
  end
  object Label8: TLabel
    Left = 294
    Top = 70
    Width = 24
    Height = 13
    Caption = #1056#1086#1083#1100
  end
  object Label9: TLabel
    Left = 31
    Top = 97
    Width = 57
    Height = 13
    Caption = #1044#1086#1083#1078#1085#1086#1089#1090#1100
  end
  object Label10: TLabel
    Left = 49
    Top = 151
    Width = 39
    Height = 13
    Caption = #1057#1083#1091#1078#1073#1072
  end
  object Label11: TLabel
    Left = 55
    Top = 178
    Width = 33
    Height = 13
    Caption = #1054#1090#1076#1077#1083
  end
  object Label12: TLabel
    Left = 51
    Top = 205
    Width = 37
    Height = 13
    Caption = #1057#1077#1082#1090#1086#1088
  end
  object edPk: TEdit
    Left = 94
    Top = 13
    Width = 70
    Height = 21
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 1
    Text = '956899999'
    OnKeyPress = FormKeyPress
  end
  object edLogin: TEdit
    Left = 274
    Top = 13
    Width = 155
    Height = 21
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 2
    Text = 'username'
    OnKeyPress = FormKeyPress
  end
  object edName: TEdit
    Left = 94
    Top = 40
    Width = 335
    Height = 21
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 3
    Text = #1055#1091#1087#1082#1080#1085#1072' '#1060#1105#1082#1083#1072' '#1055#1077#1090#1088#1086#1074#1085#1072
    OnKeyPress = FormKeyPress
  end
  object edEmail: TEdit
    Left = 94
    Top = 229
    Width = 170
    Height = 21
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 11
    Text = 'username@magnit.ru'
    OnKeyPress = FormKeyPress
  end
  object chbDeveloper: TCheckBox
    Left = 20
    Top = 259
    Width = 86
    Height = 17
    TabStop = False
    Caption = #1056#1072#1079#1088#1072#1073#1086#1090#1095#1080#1082
    TabOrder = 13
    OnClick = chbDeveloperClick
    OnKeyPress = FormKeyPress
  end
  object chbModerator: TCheckBox
    Left = 144
    Top = 259
    Width = 77
    Height = 17
    TabStop = False
    Caption = #1052#1086#1076#1077#1088#1072#1090#1086#1088
    TabOrder = 14
    OnClick = chbDeveloperClick
    OnKeyPress = FormKeyPress
  end
  object chbIsActive: TCheckBox
    Left = 262
    Top = 259
    Width = 63
    Height = 17
    TabStop = False
    Caption = #1040#1082#1090#1080#1074#1077#1085
    TabOrder = 15
    OnClick = chbDeveloperClick
    OnKeyPress = FormKeyPress
  end
  object chbHoliday: TCheckBox
    Left = 362
    Top = 259
    Width = 67
    Height = 17
    TabStop = False
    Caption = #1042' '#1086#1090#1087#1091#1089#1082#1077
    TabOrder = 16
    OnClick = chbDeveloperClick
    OnKeyPress = FormKeyPress
  end
  object edCode1C: TEdit
    Left = 359
    Top = 229
    Width = 70
    Height = 21
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 12
    Text = 'ABC000133'
    OnKeyPress = FormKeyPress
  end
  object edBranch: TEdit
    Left = 94
    Top = 67
    Width = 170
    Height = 21
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 4
    Text = #1050#1088#1072#1089#1085#1086#1076#1072#1088
    OnKeyPress = FormKeyPress
  end
  object edDepartment: TEdit
    Left = 94
    Top = 121
    Width = 335
    Height = 21
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 7
    Text = #1044#1077#1087#1072#1088#1090#1072#1084#1077#1085#1090' '#1056#1040#1056
    OnKeyPress = FormKeyPress
  end
  object edRole: TEdit
    Left = 324
    Top = 67
    Width = 105
    Height = 21
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 5
    Text = 'developer'
    OnKeyPress = FormKeyPress
  end
  object btnClose: TButton
    Left = 366
    Top = 285
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = #1047#1072#1082#1088#1099#1090#1100
    TabOrder = 0
    OnClick = btnCloseClick
    OnKeyPress = FormKeyPress
    ExplicitLeft = 331
    ExplicitTop = 175
  end
  object edUnit: TEdit
    Left = 94
    Top = 94
    Width = 335
    Height = 21
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 6
    Text = #1055#1086#1076#1073#1080#1088#1072#1083#1100#1097#1080#1082' '#1096#1082#1072#1088#1083#1091#1087#1086#1082
    OnKeyPress = FormKeyPress
  end
  object edOffice: TEdit
    Left = 94
    Top = 148
    Width = 335
    Height = 21
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 8
    Text = #1050#1086#1085#1090#1088#1086#1083#1100#1085#1086'-'#1088#1077#1074#1080#1079#1080#1086#1085#1085#1072#1103' '#1089#1083#1091#1078#1073#1072' '#1043#1052
    OnKeyPress = FormKeyPress
  end
  object edChapter: TEdit
    Left = 94
    Top = 175
    Width = 335
    Height = 21
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 9
    Text = #1054#1040#1056#1058
    OnKeyPress = FormKeyPress
  end
  object edSector: TEdit
    Left = 94
    Top = 202
    Width = 335
    Height = 21
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 10
    Text = #1057#1077#1082#1090#1086#1088' '#1088#1072#1079#1074#1080#1090#1080#1103' '#1043#1050
    OnKeyPress = FormKeyPress
  end
end
