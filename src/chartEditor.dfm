object FChartEditor: TFChartEditor
  Left = 0
  Top = 0
  Caption = 'FChartEditor'
  ClientHeight = 466
  ClientWidth = 682
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIChild
  Icon.Data = {
    0000010001001010000001002000680400001600000028000000100000002000
    0000010020000000000000040000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000007777
    77FF777777FFC8C8C8FF777777FF777777FF0000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    000000000000777777FF00000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    000000000000777777FF00000000000000000000000000000000000000007171
    7196717171FF717171FF717171FF717171FF717171FF717171FF717171FF7171
    71FF717171FF777777FF717171FF717171FF717171FF717171FF717171967777
    77FFF4F4F4FFF0F0F0FFF0F0F0FFF0F0F0FFF0F0F0FFF0F0F0FFF0F0F0FFF0F0
    F0FFF0F0F0FF777777FFF0F0F0FFF0F0F0FFF0F0F0FFF4F4F4FF777777FF7F7F
    7FFFF4F4F4FFC8793AFFC9793BFFC9793AFFC9793AFFC9793AFFC9793BFFC879
    3BFFE8E8E8FF777777FFE8E8E8FFE8E8E8FFE8E8E8FFF4F4F4FF7F7F7FFF8787
    87FFF4F4F4FFD38B4FFFD28A4FFFD28B4FFFD38B4FFFD28A4EFFD38B4EFFD28B
    4EFFE8E8E8FF777777FFE8E8E8FFE8E8E8FFE8E8E8FFF4F4F4FF878787FF8F8F
    8FFFF4F4F4FFDD9C62FFDC9C62FFDD9C63FFDC9C63FFDC9C63FFDD9C62FFDC9C
    62FFE8E8E8FF777777FFE8E8E8FFE8E8E8FFE8E8E8FFF4F4F4FF8F8F8FFF9696
    96FFF7F7F7FFE3A870FFE3A870FFE3A870FFE3A870FFE3A870FFE3A870FFE3A8
    70FFEEEEEEFF777777FFEEEEEEFFEEEEEEFFEEEEEEFFF7F7F7FF969696FF9C9C
    9CFFFCFCFCFFFBFBFBFFFBFBFBFFFBFBFBFFFBFBFBFFFBFBFBFFFBFBFBFFFBFB
    FBFFFBFBFBFF777777FFFBFBFBFFFBFBFBFFFBFBFBFFFCFCFCFF9C9C9CFFA1A1
    A196A1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1
    A1FFA1A1A1FF777777FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1A1960000
    0000000000000000000000000000000000000000000000000000000000000000
    000000000000777777FF00000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    000000000000777777FF00000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000007777
    77FF777777FFC8C8C8FF777777FF777777FF0000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    000000000000000000000000000000000000000000000000000000000000FFFF
    0000FF070000FFDF0000FFDF0000000000000000000000000000000000000000
    0000000000000000000000000000FFDF0000FFDF0000FF070000FFFF0000}
  OldCreateOrder = False
  Visible = True
  OnActivate = FormActivate
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnDeactivate = FormDeactivate
  DesignSize = (
    682
    466)
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 6
    Top = 7
    Width = 670
    Height = 417
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 0
    DesignSize = (
      670
      417)
    object Label2: TLabel
      Left = 15
      Top = 18
      Width = 14
      Height = 13
      Caption = 'PK'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Bevel1: TBevel
      Left = 15
      Top = 80
      Width = 642
      Height = 8
      Anchors = [akLeft, akTop, akRight]
      Shape = bsTopLine
      ExplicitWidth = 643
    end
    object Label3: TLabel
      Left = 15
      Top = 96
      Width = 92
      Height = 13
      Caption = #1055#1086#1083#1077' '#1072#1073#1094#1080#1089#1089' (X)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label8: TLabel
      Left = 15
      Top = 300
      Width = 260
      Height = 13
      Caption = #1042#1099#1088#1072#1078#1077#1085#1080#1077' '#1076#1083#1103' '#1087#1086#1076#1087#1080#1089#1080' '#1082#1083#1102#1095#1077#1074#1099#1093' '#1090#1086#1095#1077#1082' '#1075#1088#1072#1092#1080#1082#1072
    end
    object Bevel2: TBevel
      Left = 15
      Top = 190
      Width = 642
      Height = 8
      Anchors = [akLeft, akTop, akRight]
      Shape = bsTopLine
      ExplicitWidth = 643
    end
    object Label10: TLabel
      Left = 122
      Top = 18
      Width = 119
      Height = 13
      Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1075#1088#1072#1092#1080#1082#1072
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label11: TLabel
      Left = 440
      Top = 208
      Width = 122
      Height = 13
      Caption = #1056#1072#1079#1074#1086#1088#1086#1090' '#1087#1086#1076#1087#1080#1089#1077#1081' '#1087#1086' X'
    end
    object Label14: TLabel
      Left = 15
      Top = 49
      Width = 18
      Height = 13
      Caption = #1058#1080#1087
    end
    object Label1: TLabel
      Left = 15
      Top = 127
      Width = 102
      Height = 13
      Caption = #1055#1086#1083#1077' '#1086#1088#1076#1080#1085#1072#1090' (Y)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label4: TLabel
      Left = 14
      Top = 159
      Width = 93
      Height = 13
      Caption = #1055#1086#1083#1077' '#1075#1088#1091#1087#1087#1080#1088#1086#1074#1082#1080
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 15
      Top = 207
      Width = 112
      Height = 13
      Caption = #1060#1091#1085#1082#1094#1080#1103' '#1075#1088#1091#1087#1087#1080#1088#1086#1074#1082#1080
    end
    object Label6: TLabel
      Left = 14
      Top = 237
      Width = 120
      Height = 13
      Caption = #1042#1099#1088#1072#1078#1077#1085#1080#1077' '#1089#1086#1088#1090#1080#1088#1086#1074#1082#1080
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label7: TLabel
      Left = 14
      Top = 268
      Width = 72
      Height = 13
      Caption = #1055#1086#1076#1087#1080#1089#1100' '#1086#1089#1080' Y'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label9: TLabel
      Left = 375
      Top = 300
      Width = 187
      Height = 13
      Caption = #1056#1072#1079#1074#1086#1088#1086#1090' '#1087#1086#1076#1087#1080#1089#1077#1081' '#1082#1083#1102#1095#1077#1074#1099#1093' '#1090#1086#1095#1077#1082
    end
    object Label12: TLabel
      Left = 205
      Top = 49
      Width = 36
      Height = 13
      Caption = #1043#1088#1091#1087#1087#1072
    end
    object Label13: TLabel
      Left = 443
      Top = 49
      Width = 120
      Height = 13
      Caption = #1056#1072#1089#1087#1086#1083#1086#1078#1077#1085#1080#1077' '#1074' '#1075#1088#1091#1087#1087#1077
    end
    object edPk: TEdit
      Left = 39
      Top = 15
      Width = 65
      Height = 21
      TabStop = False
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 0
    end
    object lcbXField: TDBLookupComboboxEh
      Left = 140
      Top = 93
      Width = 517
      Height = 21
      Hint = #1055#1086#1083#1077', '#1087#1086' '#1082#1086#1090#1086#1088#1086#1084#1091' '#1073#1077#1088#1091#1090#1089#1103' '#1079#1085#1072#1095#1077#1085#1080#1103' '#1076#1083#1103' '#1086#1089#1080' '#1061' ('#1072#1073#1094#1080#1089#1089')'
      Anchors = [akLeft, akTop, akRight]
      EmptyDataInfo.Text = '< '#1085#1077#1090' >'
      EditButtons = <>
      KeyField = 'PK'
      ListField = 'FIELD_NAME'
      ListSource = dsoFields
      ParentShowHint = False
      ShowHint = True
      TabOrder = 5
      Visible = True
    end
    object edTitle: TEdit
      Left = 247
      Top = 15
      Width = 410
      Height = 21
      Hint = 
        #1053#1072#1079#1074#1072#1085#1080#1077', '#1082#1086#1090#1086#1088#1086#1077' '#1073#1091#1076#1077#1090' '#1086#1090#1086#1073#1088#1072#1078#1072#1090#1100#1089#1103' '#1074' '#1089#1087#1080#1089#1082#1077' '#1075#1088#1072#1092#1080#1082#1086#1074' '#1087#1088#1080' '#1074#1099#1073#1086#1088 +
        #1077' '#1075#1088#1072#1092#1080#1082#1072
      Anchors = [akLeft, akTop, akRight]
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
    end
    object cbChartType: TComboBox
      Left = 39
      Top = 46
      Width = 65
      Height = 21
      Hint = #1042#1085#1077#1096#1085#1080#1081' '#1074#1080#1076' '#1075#1088#1072#1092#1080#1082#1072':'#13#10'bars - '#1089#1090#1086#1083#1073#1080#1082#1080#13#10'lines - '#1074' '#1074#1080#1076#1077' '#1074#1086#1083#1085#1099
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 0
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      Text = 'bars'
      Items.Strings = (
        'bars'
        'lines')
    end
    object edXAxisRotate: TDBNumberEditEh
      Left = 567
      Top = 205
      Width = 90
      Height = 21
      Hint = 
        #1059#1075#1086#1083' '#1088#1072#1079#1074#1086#1088#1086#1090#1072' '#1087#1086#1076#1087#1080#1089#1077#1081' '#1086#1089#1080' X '#1085#1072' '#1075#1088#1072#1092#1080#1082#1077'.'#13#10#1054#1090' -180 '#1076#1086' 180 '#1075#1088#1072#1076#1091#1089 +
        #1086#1074'. 0 - '#1087#1086#1076#1087#1080#1089#1080' '#1088#1072#1089#1087#1086#1083#1086#1078#1077#1085#1099' '#1075#1086#1088#1080#1079#1086#1085#1090#1072#1083#1100#1085#1086'.'#13#10#1045#1089#1083#1080' '#1079#1085#1072#1095#1077#1085#1080#1077' '#1086#1090#1088#1080#1094#1072 +
        #1090#1077#1083#1100#1085#1086#1077' - '#1087#1086#1076#1087#1080#1089#1100' '#1088#1072#1079#1074#1086#1088#1072#1095#1080#1074#1072#1077#1090#1089#1103' '#1086#1090' '#1075#1086#1088#1080#1079#1086#1085#1090#1072' '#1087#1088#1072#1074#1099#1084' '#1082#1088#1072#1077#1084' '#1074#1085#1080#1079 +
        '.'#13#10#1045#1089#1083#1080' '#1087#1086#1083#1086#1078#1080#1090#1077#1083#1100#1085#1086#1077' - '#1074#1074#1077#1088#1093'.'
      DecimalPlaces = 0
      DisplayFormat = '#'
      EmptyDataInfo.Text = '<'#1085#1077' '#1079#1072#1076#1072#1085'>'
      EditButton.Style = ebsAltUpDownEh
      EditButton.Visible = True
      EditButtons = <>
      MaxValue = 180.000000000000000000
      MinValue = -180.000000000000000000
      ParentShowHint = False
      ShowHint = True
      TabOrder = 9
      Visible = True
    end
    object lcbYField: TDBLookupComboboxEh
      Left = 140
      Top = 124
      Width = 517
      Height = 21
      Hint = #1055#1086#1083#1077', '#1087#1086' '#1082#1086#1090#1086#1088#1086#1084#1091' '#1073#1077#1088#1091#1090#1089#1103' '#1079#1085#1072#1095#1077#1085#1080#1103' '#1076#1083#1103' '#1086#1089#1080' Y ('#1086#1088#1076#1080#1085#1072#1090')'
      Anchors = [akLeft, akTop, akRight]
      EmptyDataInfo.Text = '< '#1085#1077#1090' >'
      EditButtons = <>
      KeyField = 'PK'
      ListField = 'FIELD_NAME'
      ListSource = dsoFields
      ParentShowHint = False
      ShowHint = True
      TabOrder = 6
      Visible = True
    end
    object lcbSDField: TDBLookupComboboxEh
      Left = 140
      Top = 156
      Width = 517
      Height = 21
      Hint = 
        #1055#1086#1083#1077', '#1087#1086' '#1082#1086#1090#1086#1088#1086#1084#1091' '#1073#1091#1076#1077#1090' '#1087#1088#1086#1080#1079#1074#1077#1076#1077#1085#1072' '#1075#1088#1091#1087#1087#1080#1088#1086#1074#1072#1082#1072' '#1089#1090#1088#1086#1082' '#1084#1072#1089#1089#1080#1074#1072' '#1076 +
        #1072#1085#1085#1099#1093
      Anchors = [akLeft, akTop, akRight]
      EmptyDataInfo.Text = '< '#1085#1077#1090' >'
      EditButtons = <>
      KeyField = 'PK'
      ListField = 'FIELD_NAME'
      ListSource = dsoFields
      ParentShowHint = False
      ShowHint = True
      TabOrder = 7
      Visible = True
    end
    object cbGroupFunction: TComboBox
      Left = 140
      Top = 204
      Width = 180
      Height = 21
      Hint = #1060#1091#1085#1082#1094#1080#1103' '#1075#1088#1091#1087#1087#1080#1088#1086#1074#1082#1080' '#1084#1072#1089#1089#1080#1074#1072', '#1087#1088#1080#1084#1077#1085#1103#1077#1090#1089#1103' '#1082' '#1087#1086#1083#1102' '#1075#1088#1091#1087#1087#1080#1088#1086#1074#1082#1080
      Style = csDropDownList
      ItemHeight = 13
      ParentShowHint = False
      ShowHint = True
      TabOrder = 8
      Items.Strings = (
        #1057#1091#1084#1084#1072
        #1057#1088#1077#1076#1085#1077#1077
        #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086
        #1052#1072#1082#1089#1080#1084#1091#1084
        #1052#1080#1085#1080#1084#1091#1084)
    end
    object edOrder: TEdit
      Left = 140
      Top = 235
      Width = 517
      Height = 21
      Hint = 
        'SQL-'#1074#1099#1088#1072#1078#1077#1085#1080#1077' '#1073#1083#1086#1082#1072' ORDER BY '#1041#1045#1047' '#1089#1083#1086#1074' order by, '#1090#1086#1083#1100#1082#1086' '#1089#1087#1080#1089#1086#1082' '#1087#1086 +
        #1083#1077#1081' '#1080' '#1085#1072#1087#1088#1072#1074#1083#1077#1085#1080#1103' '#1089#1086#1088#1090#1080#1088#1086#1074#1082#1080'.'
      Anchors = [akLeft, akTop, akRight]
      ParentShowHint = False
      ShowHint = True
      TabOrder = 10
    end
    object edYTitle: TEdit
      Left = 140
      Top = 266
      Width = 517
      Height = 21
      Hint = #1055#1086#1076#1087#1080#1089#1100' '#1085#1072' '#1075#1088#1072#1092#1080#1082#1077' '#1076#1083#1103' '#1086#1089#1080' Y'
      Anchors = [akLeft, akTop, akRight]
      ParentShowHint = False
      ShowHint = True
      TabOrder = 11
    end
    object edAdditionalFieldRotate: TDBNumberEditEh
      Left = 567
      Top = 297
      Width = 90
      Height = 21
      Hint = 
        #1059#1075#1086#1083' '#1088#1072#1079#1074#1086#1088#1086#1090#1072' '#1087#1086#1076#1087#1080#1089#1077#1081' '#1085#1072#1076' '#1082#1083#1102#1095#1077#1074#1099#1084#1080' '#1090#1086#1095#1082#1072#1084#1080' '#1085#1072' '#1075#1088#1072#1092#1080#1082#1077'.'#13#10#1054#1090' -1' +
        '80 '#1076#1086' 180 '#1075#1088#1072#1076#1091#1089#1086#1074'. 0 - '#1087#1086#1076#1087#1080#1089#1080' '#1088#1072#1089#1087#1086#1083#1086#1078#1077#1085#1099' '#1075#1086#1088#1080#1079#1086#1085#1090#1072#1083#1100#1085#1086'.'#13#10#1045#1089#1083#1080 +
        ' '#1079#1085#1072#1095#1077#1085#1080#1077' '#1086#1090#1088#1080#1094#1072#1090#1077#1083#1100#1085#1086#1077' - '#1087#1086#1076#1087#1080#1089#1100' '#1088#1072#1079#1074#1086#1088#1072#1095#1080#1074#1072#1077#1090#1089#1103' '#1086#1090' '#1075#1086#1088#1080#1079#1086#1085#1090#1072' '#1087 +
        #1088#1072#1074#1099#1084' '#1082#1088#1072#1077#1084' '#1074#1085#1080#1079'.'#13#10#1045#1089#1083#1080' '#1087#1086#1083#1086#1078#1080#1090#1077#1083#1100#1085#1086#1077' - '#1074#1074#1077#1088#1093'.'
      DecimalPlaces = 0
      DisplayFormat = '#'
      EmptyDataInfo.Text = '<'#1085#1077' '#1079#1072#1076#1072#1085'>'
      EditButton.Style = ebsAltUpDownEh
      EditButton.Visible = True
      EditButtons = <>
      MaxValue = 180.000000000000000000
      MinValue = -180.000000000000000000
      ParentShowHint = False
      ShowHint = True
      TabOrder = 12
      Visible = True
    end
    object lcbGroup: TDBLookupComboboxEh
      Left = 247
      Top = 46
      Width = 150
      Height = 21
      Hint = 
        #1043#1088#1091#1087#1087#1072', '#1074' '#1082#1086#1090#1086#1088#1086#1081' '#1073#1091#1076#1077#1090' '#1088#1072#1089#1087#1086#1083#1086#1078#1077#1085' '#1075#1088#1072#1092#1080#1082'. '#1042#1089#1077' '#1075#1088#1072#1092#1080#1082#1080' '#1074' '#1075#1088#1091#1087#1087#1077' ' +
        #1086#1090#1086#1073#1088#1072#1078#1072#1102#1090#1089#1103#13#10#1074#1084#1077#1089#1090#1077' '#1085#1072' '#1086#1076#1085#1086#1081' '#1087#1072#1085#1077#1083#1080' '#1080' '#1088#1072#1089#1089#1095#1080#1090#1099#1074#1072#1102#1090#1089#1103' '#1085#1072' '#1086#1089#1085#1086#1074#1077' ' +
        #1086#1076#1085#1080#1093' '#1080' '#1090#1077#1093' '#1078#1077' '#1087#1072#1088#1072#1084#1077#1090#1088#1086#1074'.'#13#10#1045#1089#1083#1080' '#1075#1088#1072#1092#1080#1082' '#1087#1088#1080#1074#1103#1079#1072#1085' '#1082' '#1075#1088#1091#1087#1087#1077', '#1090#1086' '#1077#1075 +
        #1086' '#1085#1077' '#1073#1091#1076#1077#1090' '#1074#1080#1076#1085#1086' '#1074' '#1089#1087#1080#1089#1082#1077' '#1075#1088#1072#1092#1080#1082#1086#1074' '#1074' '#1086#1082#1085#1077#13#10#1074#1099#1073#1086#1088#1072' '#1075#1088#1072#1092#1080#1082#1072', '#1074#1084#1077#1089#1090 +
        #1086' '#1085#1077#1075#1086' '#1073#1091#1076#1077#1090' '#1075#1088#1091#1087#1087#1072'.'
      DropDownBox.AutoFitColWidths = False
      DropDownBox.Columns = <
        item
          FieldName = 'TITLE'
          Title.Caption = #1043#1088#1091#1087#1087#1072
          Width = 150
        end
        item
          FieldName = 'DESCRIPTOR_'
          Title.Caption = #1044#1077#1089#1082#1088#1080#1087#1090#1086#1088
          Width = 120
        end
        item
          FieldName = 'REF_TITLE'
          Title.Caption = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082
          Width = 300
        end>
      DropDownBox.ListSource = dsoGroup
      DropDownBox.Options = [dlgColumnResizeEh, dlgColLinesEh]
      DropDownBox.ShowTitles = True
      DropDownBox.Sizable = True
      EmptyDataInfo.Text = '< '#1085#1077#1090' >'
      EditButtons = <>
      KeyField = 'PK'
      ListField = 'TITLE'
      ListSource = dsoGroup
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      Visible = True
    end
    object edGroupOrder: TDBNumberEditEh
      Left = 567
      Top = 46
      Width = 90
      Height = 21
      Hint = 
        #1055#1086#1088#1103#1076#1086#1082' '#1088#1072#1089#1087#1086#1083#1086#1078#1077#1085#1080#1103' '#1075#1088#1072#1092#1080#1082#1086#1074' '#1074' '#1075#1088#1091#1087#1087#1077', '#1089#1074#1077#1088#1093#1091'-'#1074#1085#1080#1079' '#1080#1083#1080' '#1089#1083#1077#1074#1072'-'#1085#1072 +
        #1087#1088#1072#1074#1086' ('#1079#1072#1074#1080#1089#1080#1090' '#1086#1090' '#1085#1072#1089#1090#1088#1086#1077#1082' '#1075#1088#1091#1087#1087#1099')'
      DecimalPlaces = 0
      DisplayFormat = '#'
      EmptyDataInfo.Text = '<'#1085#1077' '#1079#1072#1076#1072#1085#1086'>'
      EditButton.Style = ebsAltUpDownEh
      EditButton.Visible = True
      EditButtons = <>
      MinValue = 1.000000000000000000
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
      Visible = True
    end
    object mAdditionalField: TRichEdit
      Left = 14
      Top = 324
      Width = 643
      Height = 80
      Hint = 
        #1063#1072#1089#1090#1100' SQL-'#1074#1099#1088#1072#1078#1077#1085#1080#1103'. '#1054#1076#1085#1086' '#1080#1079' '#1089#1087#1080#1089#1082#1072' '#1087#1086#1083#1077#1081' select, '#1074#1099#1095#1080#1089#1083#1080#1084#1086#1077' '#1080#1083#1080 +
        ' '#1086#1073#1099#1095#1085#1086#1077
      Anchors = [akLeft, akTop, akRight]
      ParentShowHint = False
      PlainText = True
      ScrollBars = ssBoth
      ShowHint = True
      TabOrder = 13
      WordWrap = False
    end
  end
  object btnSave: TBitBtn
    Left = 488
    Top = 433
    Width = 90
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
    TabOrder = 1
    OnClick = btnSaveClick
    Glyph.Data = {
      36040000424D3604000000000000360000002800000010000000100000000100
      2000000000000004000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000319610FF52A639FF4A9E29FF318E08FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000319E21FF52A642FFC6F7DEFFB5EFC6FF429E21FF3196
      10FF000000000000000000000000000000000000000000000000000000000000
      00000000000039A631FF4AAE42FFADEFCEFF9CFFEFFF9CFFE7FF9CE7ADFF429E
      21FF000000000000000000000000000000000000000000000000000000000000
      000039AE4AFF4AB652FF94EFB5FF8CFFD6FF7BFFCEFF7BFFC6FF8CFFCEFF84DF
      9CFF399E21FF00000000000000000000000000000000000000000000000042BE
      5AFF4ABE5AFF84E7A5FF7BF7BDFF7BF7BDFF7BEFB5FF7BF7BDFF7BF7B5FF84F7
      BDFF73D784FF399E29FF000000000000000000000000000000000000000042BE
      63FF63DF8CFF6BEF9CFF73EFADFF7BE7ADFF4ABE5AFF5AC76BFF84EFB5FF7BEF
      ADFF73EFA5FF5ACF6BFF39A629FF000000000000000000000000000000004AC7
      6BFF52DF7BFF6BE794FF73E79CFF52C76BFF39AE42FF39AE42FF5ACF73FF84EF
      ADFF73E79CFF63DF8CFF42C752FF39A631FF00000000000000000000000042C7
      6BFF4ACF73FF63DF8CFF52CF73FF42B652FF000000000000000039B64AFF63CF
      7BFF84E79CFF6BDF84FF4AD76BFF39BE42FF39A639FF00000000000000000000
      00004AC773FF4ACF73FF42C76BFF0000000000000000000000000000000042B6
      52FF63CF7BFF73DF8CFF52D76BFF31C742FF39AE39FF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000042BE5AFF5ACF73FF5AD76BFF42BE52FF42AE4AFF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000042BE63FF4AC763FF42BE5AFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000}
  end
  object btnClose: TBitBtn
    Left = 584
    Top = 433
    Width = 90
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #1047#1072#1082#1088#1099#1090#1100
    TabOrder = 2
    OnClick = btnCloseClick
    Glyph.Data = {
      36040000424D3604000000000000360000002800000010000000100000000100
      2000000000000004000000000000000000000000000000000000FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF000000B5001821BD000808B500FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF000808B5002129BD000000B500FF00FF00FF00FF00FF00FF00FF00FF000008
      C6003142D6008CADFF005A73E7000008BD00FF00FF00FF00FF00FF00FF000808
      BD005A73E7008CB5FF003142D6000008C600FF00FF00FF00FF00FF00FF002131
      D6007394FF007B9CFF007B9CFF005263EF000818CE00FF00FF000818CE00526B
      EF007B9CFF007B9CFF007B9CFF002931D600FF00FF00FF00FF00FF00FF001021
      DE00425AF700526BFF005263FF005A73FF00425AEF001021DE00425AEF00637B
      FF005263FF005A6BFF004A63F7001021DE00FF00FF00FF00FF00FF00FF00FF00
      FF001021E7003142F7003942FF003142FF003952FF00425AFF004252FF003139
      FF003942FF00314AF7001021E700FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF001829EF002131F7001821FF001818F7001821FF001818F7001821
      FF002131F7001829EF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF001831FF001829FF002121F7002129F7002129F7001821
      F7001831FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF001831FF003142FF004A5AFF005263FF005A6BFF005A6BFF005263
      FF00394AFF001831FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF001831FF00394AFF005263FF006373FF00637BFF006373FF006B7BFF00637B
      FF005A6BFF003952FF001831FF00FF00FF00FF00FF00FF00FF00FF00FF002131
      FF00394AFF005A63FF006373FF00738CFF00526BFF002139FF00526BFF007B94
      FF006B84FF006373FF004252FF002131FF00FF00FF00FF00FF00FF00FF002139
      FF00525AFF006373FF00738CFF00526BFF001831FF00FF00FF001831FF005A73
      FF008494FF007384FF005A6BFF002939FF00FF00FF00FF00FF00FF00FF001831
      FF00314AFF006B7BFF00526BFF001831FF00FF00FF00FF00FF00FF00FF001831
      FF005A73FF00738CFF00394AFF001831FF00FF00FF00FF00FF00FF00FF00FF00
      FF001831FF00314AFF002139FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF002139FF00314AFF001831FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
  end
  object dsoFields: TDataSource
    Left = 336
    Top = 96
  end
  object ActionList: TActionList
    Left = 72
    Top = 24
    object ASave: TAction
      Caption = 'ASave'
      ShortCut = 16397
      OnExecute = ASaveExecute
    end
  end
  object dsoGroup: TDataSource
    Left = 336
    Top = 56
  end
end