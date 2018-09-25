object DBFindDialog: TDBFindDialog
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1055#1086#1080#1089#1082
  ClientHeight = 225
  ClientWidth = 394
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 12
    Top = 9
    Width = 31
    Height = 13
    Caption = #1053#1072#1081#1090#1080
  end
  object Label2: TLabel
    Left = 12
    Top = 53
    Width = 81
    Height = 13
    Caption = #1057#1090#1086#1083#1073#1077#1094' '#1087#1086#1080#1089#1082#1072
  end
  object cbFindText: TComboBox
    Left = 12
    Top = 26
    Width = 368
    Height = 21
    Hint = #1055#1086#1080#1089#1082' '#1074#1099#1087#1086#1083#1085#1103#1077#1090#1089#1103' '#1087#1086' PK, '#1044#1077#1089#1082#1088#1080#1087#1090#1086#1088#1091' '#1080' '#1053#1072#1079#1074#1072#1085#1080#1102
    ItemHeight = 13
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    OnKeyUp = cbFindTextKeyUp
  end
  object GroupBox1: TGroupBox
    Left = 12
    Top = 99
    Width = 368
    Height = 83
    Caption = ' '#1054#1087#1094#1080#1080' '#1087#1086#1080#1089#1082#1072' '
    TabOrder = 2
    object chbMatchCase: TCheckBox
      Left = 14
      Top = 18
      Width = 131
      Height = 17
      Caption = #1059#1095#1080#1090#1099#1074#1072#1090#1100' '#1088#1077#1075#1080#1089#1090#1088
      TabOrder = 0
    end
    object chbToExistence: TCheckBox
      Left = 14
      Top = 38
      Width = 93
      Height = 17
      Hint = #1042#1093#1086#1078#1076#1077#1085#1080#1077' '#1080#1089#1082#1086#1084#1086#1081' '#1089#1090#1088#1086#1082#1080' '#1080#1083#1080' '#1087#1086#1083#1085#1086#1077' '#1077#1105' '#1089#1086#1074#1087#1072#1076#1077#1085#1080#1077
      Caption = #1055#1086' '#1074#1093#1086#1078#1076#1077#1085#1080#1102
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = chbToExistenceClick
    end
    object Panel1: TPanel
      Left = 21
      Top = 57
      Width = 279
      Height = 20
      BevelOuter = bvNone
      TabOrder = 2
      object rbAnyWord: TRadioButton
        Left = 96
        Top = 1
        Width = 95
        Height = 17
        Hint = #1057#1086#1074#1087#1072#1076#1077#1085#1080#1077' '#1083#1102#1073#1086#1075#1086' '#1080#1079' '#1089#1083#1086#1074' '#1089#1090#1088#1086#1082#1080' '#1087#1086#1080#1089#1082#1072', '#1088#1072#1079#1076#1077#1083#1077#1085#1085#1099#1093' '#1087#1088#1086#1073#1077#1083#1086#1084
        Caption = #1051#1102#1073#1086#1075#1086' '#1080#1079' '#1089#1083#1086#1074
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
      end
      object rbAllWords: TRadioButton
        Left = 200
        Top = 1
        Width = 66
        Height = 17
        Hint = 
          #1057#1086#1074#1087#1072#1076#1077#1085#1080#1077' '#1074#1089#1077#1093' '#1089#1083#1086#1074' '#1089#1090#1088#1086#1082#1080' '#1087#1086#1080#1089#1082#1072' ('#1074' '#1083#1102#1073#1086#1084' '#1087#1086#1088#1103#1076#1082#1077'), '#1088#1072#1079#1076#1077#1083#1077#1085#1085#1099 +
          #1093' '#1087#1088#1086#1073#1077#1083#1086#1084
        Caption = #1042#1089#1077#1093' '#1089#1083#1086#1074
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
      end
      object rbWholeString: TRadioButton
        Left = 10
        Top = 1
        Width = 78
        Height = 17
        Hint = #1042#1093#1086#1078#1076#1077#1085#1080#1077' '#1080#1089#1082#1086#1084#1086#1081' '#1089#1090#1088#1086#1082#1080
        Caption = #1042#1089#1077#1081' '#1089#1090#1088#1086#1082#1080
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
      end
    end
  end
  object btnOK: TBitBtn
    Left = 222
    Top = 188
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 3
    OnClick = btnOKClick
  end
  object btnCancel: TBitBtn
    Left = 305
    Top = 188
    Width = 75
    Height = 25
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 4
    OnClick = btnCancelClick
  end
  object cbColumnName: TComboBox
    Left = 12
    Top = 70
    Width = 368
    Height = 21
    Hint = #1042' '#1082#1072#1082#1086#1084' '#1089#1090#1086#1083#1073#1094#1077' '#1080#1089#1082#1072#1090#1100
    Style = csDropDownList
    ItemHeight = 13
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    OnKeyUp = cbFindTextKeyUp
  end
end
