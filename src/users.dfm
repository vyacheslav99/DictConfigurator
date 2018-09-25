object FUsers: TFUsers
  Left = 0
  Top = 0
  Caption = 'FUsers'
  ClientHeight = 761
  ClientWidth = 1092
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIChild
  Icon.Data = {
    0000010001001010000001002000680400001600000028000000100000002000
    0000010020000000000000040000000000000000000000000000000000002F35
    3EFF040F22FF091324FF182432FF182331FF222B39FF1E2735FF1B2432FF1A23
    31FF162330FF161F2CFF0D1B29FF00091CFF000D1FFF525358FFA89E95FFFFF1
    E1FFEBDED4FF7C7E7EFF060E23FF1E202FFF222936FF232634FF232533FF181F
    2EFF1A2432FF182031FF001124FF9F988FFFFFEFD9FFFFEBD3FFF1E1CAFFE6CC
    AAFFE3C6A4FFF4D4ABFFCDB599FF262C37FF1B2030FF19202FFF131B28FF1516
    25FF030F1DFF061322FFB9A187FFEFCA9AFFD9B78CFFD6B587FFD5B487FFD5B0
    82FFD3AA7BFFD0A678FFE2B382FFA48770FF0E2234FF2A343FFF394251FF5D71
    85FF768FADFFD9B28FFFDAA971FFCBA06FFFCC9C71FFCC9969FFCA9666FFCA96
    6EFFCC9A6DFFCE9B6CFFCD9D71FF2E333DFF162433FF1D2838FF182433FF2430
    43FF465C74FF9EADC2FFD39D67FFC5906AFFC78F65FFC48A63FFC38962FFC491
    6EFFC9966EFFD49E73FF897264FF142434FF182331FF1B2836FF202B3AFF1E2B
    39FF202B3AFF54728FFFA38773FFD19669FFC49267FFC59267FFC58E67FFC18B
    69FFC58F6CFFD9A776FF766457FF0E1E31FF222E3CFF1F2B3AFF1F2B3BFF1F2A
    38FF192634FF293D55FF9D8B81FFD1996CFFCA976CFFCA946AFFC89067FFC18C
    6CFFC58E70FFD8A076FF3A3E47FF142231FF1F2B3AFF202E3DFF1D2A38FF1C29
    37FF1D2735FF26374AFF78848CFFD49F74FFC8926CFFC58F68FFC28A66FFC58D
    69FFD0966DFFC99976FF1C2837FF182433FF1A2533FF182533FF1B2432FF1A20
    30FF15202FFF0F1B2AFF3B424CFFCBA178FFCC9269FFC18C68FFBE8866FFCB93
    6FFF76645CFF000B26FF111A29FF161D2AFF1C222FFF1A1F2EFF1A1C2AFF161A
    28FF181A29FF121625FF0C1425FF000F2BFF8E6651FFCA9367FFC08862FFC48F
    6EFFC5916FFFE0A079FF373B43FF0E1C2AFF19222FFF1A1D2BFF181B29FF181C
    2AFF1A1C2BFF111B29FF453E3FFFDBA171FFCB916AFFC79066FFC48B65FFC591
    6EFFC58E6CFFD29A71FF37373CFF121A2AFF191D2BFF18202EFF1C1E2CFF1A1E
    2EFF1D2230FF151A2AFF3F373AFFC99164FFC08761FFBF8761FFC08761FFC189
    63FFBE8763FFD2956BFF4C4D50FF091427FF1D2030FF252835FF1C202FFF1F23
    31FF222331FF0E1628FF4F4848FFCD946AFFC18A65FFBF8764FFC28B67FFC089
    61FFC28B61FFC78D68FFAA7F61FF091A2BFF0D1A2BFF191E2EFF1F2232FF1D20
    31FF1F2737FF0B1C31FFAF7F5FFFC98F64FFC08D6DFFC59270FFBE8A66FFBF88
    62FFC18B63FFC08961FFCA8F62FFB88665FF5A4D49FF3B3A3EFF3B383DFF4843
    45FF6B564DFFBB8860FFCD946AFFC38C67FFC18A6AFFBE8763FFBB8262FFC187
    63FFC18762FFC38963FFC08762FFC58D67FFD59A70FFDA9E70FFD59A74FFD497
    6FFFCF966FFFC58E6EFFC38D6EFFB8846AFFC18768FFBF8768FFB98064FF0000
    0000000000000000000000000000000000000000000000000000000000000000
    000000000000000000000000000000000000000000000000000000000000}
  OldCreateOrder = False
  Visible = True
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnDeactivate = FormDeactivate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 0
    Top = 417
    Width = 1092
    Height = 5
    Cursor = crVSplit
    Align = alBottom
    ExplicitTop = 533
    ExplicitWidth = 1016
  end
  object Splitter2: TSplitter
    Left = 687
    Top = 22
    Width = 5
    Height = 395
    Align = alRight
    ExplicitLeft = 781
    ExplicitTop = 0
    ExplicitHeight = 411
  end
  object dbgUsers: TDBGridEh
    Left = 0
    Top = 22
    Width = 687
    Height = 395
    Align = alClient
    AllowedOperations = []
    AllowedSelections = []
    ColumnDefValues.Title.TitleButton = True
    DataGrouping.GroupLevels = <>
    DataSource = dsoUsers
    EditActions = [geaCopyEh]
    Flat = False
    FooterColor = clWindow
    FooterFont.Charset = DEFAULT_CHARSET
    FooterFont.Color = clWindowText
    FooterFont.Height = -11
    FooterFont.Name = 'Tahoma'
    FooterFont.Style = []
    IndicatorTitle.DropdownMenu = pmGrid
    IndicatorTitle.ShowDropDownSign = True
    IndicatorTitle.TitleButton = True
    IndicatorTitle.UseGlobalMenu = False
    IndicatorOptions = [gioShowRowIndicatorEh]
    OptionsEh = [dghFixed3D, dghHighlightFocus, dghAutoSortMarking, dghMultiSortMarking, dghPreferIncSearch, dghRowHighlight, dghDblClickOptimizeColWidth, dghColumnResize, dghColumnMove, dghExtendVertLines]
    ParentShowHint = False
    PopupMenu = pmUsers
    ShowHint = True
    STFilter.InstantApply = True
    STFilter.Local = True
    STFilter.Location = stflInTitleFilterEh
    STFilter.Visible = True
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnApplyFilter = DBGridApplyFilter
    OnFillSTFilterListValues = DBGridFillSTFilterListValues
    OnKeyDown = dbgUsersKeyDown
    Columns = <
      item
        EditButtons = <>
        FieldName = 'PK'
        Footers = <>
        Title.Hint = 'PK'
        Width = 50
      end
      item
        EditButtons = <>
        FieldName = 'LOGIN'
        Footers = <>
        Title.Caption = 'Login'
        Title.Hint = 'Login'
        Width = 100
      end
      item
        EditButtons = <>
        FieldName = 'NAME'
        Footers = <>
        Title.Caption = #1060#1048#1054
        Title.Hint = #1060#1048#1054
        Width = 200
      end
      item
        Checkboxes = True
        EditButtons = <>
        FieldName = 'ISACTIVE'
        Footers = <>
        KeyList.Strings = (
          '1'
          '0')
        Title.Caption = #1040#1082#1090#1080#1074#1077#1085
        Title.Hint = #1040#1082#1090#1080#1074#1077#1085
        Width = 30
      end
      item
        EditButtons = <>
        FieldName = 'ROLE_PK'
        Footers = <>
        Title.Caption = 'PK '#1088#1086#1083#1080
        Title.Hint = 'PK '#1088#1086#1083#1080
        Width = 41
      end
      item
        EditButtons = <>
        FieldName = 'ROLE_NAME'
        Footers = <>
        Title.Caption = #1056#1086#1083#1100
        Title.Hint = #1056#1086#1083#1100
        Width = 60
      end
      item
        Checkboxes = True
        EditButtons = <>
        FieldName = 'DEVELOPER'
        Footers = <>
        KeyList.Strings = (
          '1'
          '0')
        Title.Caption = #1056#1072#1079#1088#1072#1073#1086#1090#1095#1080#1082
        Title.Hint = #1056#1072#1079#1088#1072#1073#1086#1090#1095#1080#1082
        Width = 30
      end
      item
        Checkboxes = True
        EditButtons = <>
        FieldName = 'MODERATOR'
        Footers = <>
        KeyList.Strings = (
          '1'
          '0')
        Title.Caption = #1052#1086#1076#1077#1088#1072#1090#1086#1088
        Title.Hint = #1052#1086#1076#1077#1088#1072#1090#1086#1088
        Width = 30
      end
      item
        EditButtons = <>
        FieldName = 'CODE_1C'
        Footers = <>
        Title.Caption = #1050#1086#1076' 1'#1057
        Title.Hint = #1050#1086#1076' 1'#1057
        Width = 65
      end
      item
        EditButtons = <>
        FieldName = 'EMAIL'
        Footers = <>
        Title.Caption = 'e-mail'
        Title.Hint = 'e-mail'
        Width = 180
      end
      item
        EditButtons = <>
        FieldName = 'SHORT_NAME'
        Footers = <>
        Title.Caption = #1048#1085#1080#1094#1080#1072#1083#1099
        Title.Hint = #1048#1085#1080#1094#1080#1072#1083#1099
        Width = 100
      end
      item
        EditButtons = <>
        FieldName = 'LASTDATE'
        Footers = <>
        Title.Caption = #1055#1086#1089#1083#1077#1076#1085#1077#1077' '#1080#1079#1084#1077#1085#1077#1085#1080#1077
        Title.Hint = #1055#1086#1089#1083#1077#1076#1085#1077#1077' '#1080#1079#1084#1077#1085#1077#1085#1080#1077
        Width = 90
      end
      item
        EditButtons = <>
        FieldName = 'ATTR_NAME'
        Footers = <>
        Title.Caption = #1055#1088#1080#1095#1080#1085#1072' '#1080#1079#1084#1077#1085#1077#1085#1080#1103
        Title.Hint = #1055#1088#1080#1095#1080#1085#1072' '#1080#1079#1084#1077#1085#1077#1085#1080#1103
        Width = 160
      end
      item
        Checkboxes = True
        EditButtons = <>
        FieldName = 'HOLIDAY'
        Footers = <>
        KeyList.Strings = (
          '1'
          '0')
        Title.Caption = #1053#1077' '#1086#1073#1085#1086#1074#1083#1103#1090#1100' e-mail '#1080#1079' '#1051#1044#1040#1055
        Title.Hint = #1053#1077' '#1086#1073#1085#1086#1074#1083#1103#1090#1100' e-mail '#1080#1079' '#1051#1044#1040#1055
        Width = 30
      end
      item
        EditButtons = <>
        FieldName = 'MANAGER'
        Footers = <>
        Title.Caption = #1053#1077#1087#1086#1089#1088#1077#1076#1089#1090#1074#1077#1085#1085#1099#1081' '#1088#1091#1082#1086#1074#1086#1076#1080#1090#1077#1083#1100
        Width = 200
      end
      item
        EditButtons = <>
        FieldName = 'BOSS'
        Footers = <>
        Title.Caption = #1056#1091#1082#1086#1074#1086#1076#1080#1090#1077#1083#1100'-'#1084#1086#1076#1077#1088#1072#1090#1086#1088
        Width = 200
      end
      item
        EditButtons = <>
        FieldName = 'DEP_DIRECTOR'
        Footers = <>
        Title.Caption = #1044#1080#1088#1077#1082#1090#1086#1088' '#1076#1077#1087#1072#1088#1090#1072#1084#1077#1085#1090#1072
        Width = 200
      end>
    object RowDetailData: TRowDetailPanelControlEh
    end
  end
  object pInfo: TPanel
    Left = 0
    Top = 422
    Width = 1092
    Height = 320
    Align = alBottom
    TabOrder = 1
    ExplicitTop = 377
    object Splitter3: TSplitter
      Left = 201
      Top = 1
      Width = 5
      Height = 153
      ExplicitLeft = 781
      ExplicitHeight = 248
    end
    object Splitter4: TSplitter
      Left = 1
      Top = 154
      Width = 1090
      Height = 5
      Cursor = crVSplit
      Align = alBottom
      ExplicitTop = 133
      ExplicitWidth = 1014
    end
    object dbgUserGroups: TDBGridEh
      Left = 1
      Top = 1
      Width = 200
      Height = 153
      Align = alLeft
      AllowedOperations = []
      AllowedSelections = []
      ColumnDefValues.Title.TitleButton = True
      DataGrouping.GroupLevels = <>
      DataSource = dsoUserGroups
      EditActions = [geaCopyEh]
      Flat = False
      FooterColor = clWindow
      FooterFont.Charset = DEFAULT_CHARSET
      FooterFont.Color = clWindowText
      FooterFont.Height = -11
      FooterFont.Name = 'Tahoma'
      FooterFont.Style = []
      IndicatorTitle.DropdownMenu = pmGrid
      IndicatorTitle.ShowDropDownSign = True
      IndicatorTitle.TitleButton = True
      IndicatorTitle.UseGlobalMenu = False
      IndicatorOptions = [gioShowRowIndicatorEh]
      OptionsEh = [dghFixed3D, dghHighlightFocus, dghAutoSortMarking, dghMultiSortMarking, dghPreferIncSearch, dghRowHighlight, dghDblClickOptimizeColWidth, dghColumnResize, dghColumnMove, dghExtendVertLines]
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      Columns = <
        item
          EditButtons = <>
          FieldName = 'PK'
          Footers = <>
          Width = 35
        end
        item
          EditButtons = <>
          FieldName = 'NAME'
          Footers = <>
          Title.Caption = #1043#1088#1091#1087#1087#1072
          Width = 147
        end>
      object RowDetailData: TRowDetailPanelControlEh
      end
    end
    object dbgUserRanks: TDBGridEh
      Left = 206
      Top = 1
      Width = 885
      Height = 153
      Align = alClient
      AllowedOperations = []
      AllowedSelections = []
      ColumnDefValues.Title.TitleButton = True
      DataGrouping.GroupLevels = <>
      DataSource = dsoUserRanks
      EditActions = [geaCopyEh]
      Flat = False
      FooterColor = clWindow
      FooterFont.Charset = DEFAULT_CHARSET
      FooterFont.Color = clWindowText
      FooterFont.Height = -11
      FooterFont.Name = 'Tahoma'
      FooterFont.Style = []
      IndicatorTitle.DropdownMenu = pmGrid
      IndicatorTitle.ShowDropDownSign = True
      IndicatorTitle.TitleButton = True
      IndicatorTitle.UseGlobalMenu = False
      IndicatorOptions = [gioShowRowIndicatorEh]
      OptionsEh = [dghFixed3D, dghHighlightFocus, dghAutoSortMarking, dghMultiSortMarking, dghPreferIncSearch, dghRowHighlight, dghDblClickOptimizeColWidth, dghColumnResize, dghColumnMove, dghExtendVertLines]
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      OnKeyDown = dbgUserRanksKeyDown
      Columns = <
        item
          Checkboxes = True
          EditButtons = <>
          FieldName = 'MAIN_ROLE'
          Footers = <>
          KeyList.Strings = (
            '1'
            '0')
          Title.Caption = #1043#1083#1072#1074#1085#1072#1103
          Title.Hint = #1043#1083#1072#1074#1085#1072#1103' '#1076#1086#1083#1078#1085#1086#1089#1090#1100
          Width = 30
        end
        item
          EditButtons = <>
          FieldName = 'PK'
          Footers = <>
          Title.Hint = 'PK'
          Width = 50
        end
        item
          EditButtons = <>
          FieldName = 'NAME'
          Footers = <>
          Title.Caption = #1044#1086#1083#1078#1085#1086#1089#1090#1100
          Title.Hint = #1044#1086#1083#1078#1085#1086#1089#1090#1100
          Width = 280
        end
        item
          EditButtons = <>
          FieldName = 'DEPARTMENT'
          Footers = <>
          Title.Caption = #1044#1077#1087#1072#1088#1090#1072#1084#1077#1085#1090
          Title.Hint = #1044#1077#1087#1072#1088#1090#1072#1084#1077#1085#1090
          Width = 200
        end
        item
          EditButtons = <>
          FieldName = 'OFFICE'
          Footers = <>
          Title.Caption = #1057#1083#1091#1078#1073#1072
          Title.Hint = #1057#1083#1091#1078#1073#1072
          Width = 200
        end
        item
          EditButtons = <>
          FieldName = 'CHAPTER'
          Footers = <>
          Title.Caption = #1054#1090#1076#1077#1083
          Title.Hint = #1054#1090#1076#1077#1083
          Width = 200
        end
        item
          EditButtons = <>
          FieldName = 'SECTOR'
          Footers = <>
          Title.Caption = #1057#1077#1082#1090#1086#1088
          Title.Hint = #1057#1077#1082#1090#1086#1088
          Width = 200
        end
        item
          EditButtons = <>
          FieldName = 'BRANCH_PK'
          Footers = <>
          Title.Hint = 'BRANCH_PK'
          Width = 50
        end
        item
          EditButtons = <>
          FieldName = 'BRANCH_NAME'
          Footers = <>
          Title.Caption = #1055#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1077
          Title.Hint = #1055#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1077
          Width = 85
        end
        item
          EditButtons = <>
          FieldName = 'FULLNAME'
          Footers = <>
          Title.Caption = #1055#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1077' '#1087#1086#1083#1085#1086#1089#1090#1100#1102
          Title.Hint = #1055#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1077' '#1087#1086#1083#1085#1086#1089#1090#1100#1102
          Width = 145
        end
        item
          Checkboxes = True
          EditButtons = <>
          FieldName = 'BOSS'
          Footers = <>
          Title.Caption = #1056#1091#1082#1086#1074#1086#1076#1080#1090#1077#1083#1100
          Title.Hint = #1056#1091#1082#1086#1074#1086#1076#1103#1097#1072#1103' '#1076#1086#1083#1078#1085#1086#1089#1090#1100
          Width = 30
        end
        item
          Checkboxes = True
          EditButtons = <>
          FieldName = 'IS_CHIEF'
          Footers = <>
          KeyList.Strings = (
            '1'
            '0')
          Title.Caption = '1 '#1051#1080#1094#1086
          Title.Hint = #1055#1077#1088#1074#1086#1077' '#1083#1080#1094#1086' '#1076#1077#1087#1072#1088#1090#1072#1084#1077#1085#1090#1072
          Width = 30
        end>
      object RowDetailData: TRowDetailPanelControlEh
      end
    end
    object dbgUserRefGrant: TDBGridEh
      Left = 1
      Top = 159
      Width = 1090
      Height = 160
      Align = alBottom
      AllowedOperations = []
      AllowedSelections = []
      ColumnDefValues.Title.TitleButton = True
      DataGrouping.Active = True
      DataGrouping.GroupLevels = <
        item
          ColumnName = 'Column_0_TYPE_'
        end>
      DataSource = dsoUserRefGrant
      EditActions = [geaCopyEh]
      Flat = False
      FooterColor = clWindow
      FooterFont.Charset = DEFAULT_CHARSET
      FooterFont.Color = clWindowText
      FooterFont.Height = -11
      FooterFont.Name = 'Tahoma'
      FooterFont.Style = []
      IndicatorTitle.DropdownMenu = pmGrid
      IndicatorTitle.ShowDropDownSign = True
      IndicatorTitle.TitleButton = True
      IndicatorTitle.UseGlobalMenu = False
      IndicatorOptions = [gioShowRowIndicatorEh]
      OptionsEh = [dghFixed3D, dghHighlightFocus, dghAutoSortMarking, dghMultiSortMarking, dghPreferIncSearch, dghRowHighlight, dghDblClickOptimizeColWidth, dghColumnResize, dghColumnMove, dghExtendVertLines]
      ParentShowHint = False
      ShowHint = True
      SortLocal = True
      TabOrder = 2
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      OnKeyDown = dbgUserRanksKeyDown
      Columns = <
        item
          Alignment = taLeftJustify
          EditButtons = <>
          FieldName = 'TYPE_'
          Footers = <>
          KeyList.Strings = (
            '0'
            '1'
            '2')
          PickList.Strings = (
            #1044#1086#1083#1078#1085#1086#1089#1090#1100
            #1056#1086#1083#1100
            #1053#1072' '#1082#1086#1085#1092#1080#1075#1091#1088#1072#1094#1080#1102)
          Title.Caption = #1048#1089#1090#1086#1095#1085#1080#1082' '#1087#1088#1072#1074
          Visible = False
          Width = 100
        end
        item
          EditButtons = <>
          FieldName = 'PK'
          Footers = <>
          Title.Hint = 'PK'
          Width = 40
        end
        item
          EditButtons = <>
          FieldName = 'DESCRIPTOR_'
          Footers = <>
          Title.Caption = #1044#1077#1089#1082#1088#1080#1087#1090#1086#1088
          Title.Hint = #1044#1077#1089#1082#1088#1080#1087#1090#1086#1088
          Width = 180
        end
        item
          EditButtons = <>
          FieldName = 'TITLE'
          Footers = <>
          Title.Caption = #1047#1072#1075#1086#1083#1086#1074#1086#1082
          Title.Hint = #1047#1072#1075#1086#1083#1086#1074#1086#1082
          Width = 250
        end
        item
          EditButtons = <>
          FieldName = 'BASE_DESCRIPTOR'
          Footers = <>
          Title.Caption = #1041#1044
          Title.Hint = #1041#1072#1079#1072' '#1076#1072#1085#1085#1099#1093
          Width = 80
        end
        item
          EditButtons = <>
          FieldName = 'FOLDER_PK'
          Footers = <>
          Title.Caption = 'PK '#1087#1072#1087#1082#1080
          Title.Hint = 'PK '#1087#1072#1087#1082#1080
          Width = 40
        end
        item
          EditButtons = <>
          FieldName = 'FOLDER_NAME'
          Footers = <>
          Title.Caption = #1055#1072#1087#1082#1072
          Title.Hint = #1055#1072#1087#1082#1072
          Width = 180
        end
        item
          EditButtons = <>
          FieldName = 'OWNER_USER_PK'
          Footers = <>
          Title.Caption = 'PK '#1074#1083#1072#1076#1077#1083#1100#1094#1072
          Title.Hint = 'PK '#1074#1083#1072#1076#1077#1083#1100#1094#1072
          Width = 40
        end
        item
          EditButtons = <>
          FieldName = 'LOGIN'
          Footers = <>
          Title.Caption = 'Login'
          Title.Hint = 'Login '#1074#1083#1072#1076#1077#1083#1100#1094#1072
          Width = 100
        end
        item
          EditButtons = <>
          FieldName = 'USER_NAME'
          Footers = <>
          Title.Caption = #1060#1048#1054' '#1074#1083#1072#1076#1077#1083#1100#1094#1072
          Title.Hint = #1060#1048#1054' '#1074#1083#1072#1076#1077#1083#1100#1094#1072
          Width = 200
        end
        item
          EditButtons = <>
          FieldName = 'ROLE_PK'
          Footers = <>
          Title.Caption = 'PK '#1044#1086#1083#1078#1085#1086#1089#1090#1080' / '#1056#1086#1083#1080
          Title.Hint = 'PK '#1044#1086#1083#1078#1085#1086#1089#1090#1080' / '#1056#1086#1083#1080
          Width = 40
        end
        item
          EditButtons = <>
          FieldName = 'ROLE_NAME'
          Footers = <>
          Title.Caption = #1044#1086#1083#1078#1085#1086#1089#1090#1100' / '#1056#1086#1083#1100
          Title.Hint = #1044#1086#1083#1078#1085#1086#1089#1090#1100' / '#1056#1086#1083#1100
          Width = 200
        end
        item
          Checkboxes = True
          EditButtons = <>
          FieldName = 'MAIN_ROLE'
          Footers = <>
          KeyList.Strings = (
            '1'
            '0')
          Title.Caption = #1043#1083#1072#1074#1085#1072#1103
          Title.Hint = #1043#1083#1072#1074#1085#1072#1103' '#1076#1086#1083#1078#1085#1086#1089#1090#1100
          Width = 30
        end
        item
          EditButtons = <>
          FieldName = 'VIEW_REF'
          Footers = <>
          Title.Hint = #1055#1088#1086#1089#1084#1086#1090#1088' '#1089#1087#1088#1072#1074#1086#1095#1085#1080#1082#1072
          Width = 60
        end
        item
          Checkboxes = True
          EditButtons = <>
          FieldName = 'VIEW_'
          Footers = <>
          Title.Hint = #1055#1088#1086#1089#1084#1086#1090#1088
          Width = 40
        end
        item
          EditButtons = <>
          FieldName = 'ADD_'
          Footers = <>
          Title.Hint = #1044#1086#1073#1072#1074#1083#1077#1085#1080#1077
          Width = 50
        end
        item
          EditButtons = <>
          FieldName = 'EDIT_'
          Footers = <>
          Title.Hint = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1077
          Width = 50
        end
        item
          EditButtons = <>
          FieldName = 'DEL_'
          Footers = <>
          Title.Hint = #1059#1076#1072#1083#1077#1085#1080#1077
          Width = 50
        end
        item
          Checkboxes = True
          EditButtons = <>
          FieldName = 'CONFIG_'
          Footers = <>
          Title.Hint = #1050#1086#1085#1092#1080#1075#1091#1088#1080#1088#1086#1074#1072#1085#1080#1077
          Width = 50
        end
        item
          Checkboxes = True
          EditButtons = <>
          FieldName = 'EXPORT'
          Footers = <>
          Title.Hint = #1069#1082#1089#1087#1086#1088#1090
          Width = 45
        end
        item
          Checkboxes = True
          EditButtons = <>
          FieldName = 'IMPORT'
          Footers = <>
          Title.Hint = #1048#1084#1087#1086#1088#1090
          Width = 45
        end>
      object RowDetailData: TRowDetailPanelControlEh
      end
    end
  end
  object pFilters: TPanel
    Left = 692
    Top = 22
    Width = 400
    Height = 395
    Align = alRight
    TabOrder = 2
    ExplicitHeight = 350
    DesignSize = (
      400
      395)
    object Label3: TLabel
      Left = 11
      Top = 58
      Width = 68
      Height = 13
      Caption = #1044#1077#1087#1072#1088#1090#1072#1084#1077#1085#1090
    end
    object Label4: TLabel
      Left = 40
      Top = 86
      Width = 39
      Height = 13
      Caption = #1057#1083#1091#1078#1073#1072
    end
    object Label5: TLabel
      Left = 46
      Top = 114
      Width = 33
      Height = 13
      Caption = #1054#1090#1076#1077#1083
    end
    object Label6: TLabel
      Left = 42
      Top = 142
      Width = 37
      Height = 13
      Caption = #1057#1077#1082#1090#1086#1088
    end
    object Label8: TLabel
      Left = 41
      Top = 366
      Width = 105
      Height = 13
      Anchors = [akRight, akBottom]
      Caption = #1057#1086#1077#1076#1080#1085#1103#1090#1100' '#1092#1080#1083#1100#1090#1088#1099
      ExplicitLeft = 141
      ExplicitTop = 382
    end
    object Label1: TLabel
      Left = 22
      Top = 170
      Width = 57
      Height = 13
      Caption = #1044#1086#1083#1078#1085#1086#1089#1090#1100
    end
    object Label2: TLabel
      Left = 43
      Top = 257
      Width = 36
      Height = 13
      Caption = #1043#1088#1091#1087#1087#1072
    end
    object Label7: TLabel
      Left = 55
      Top = 228
      Width = 24
      Height = 13
      Caption = #1056#1086#1083#1100
    end
    object Label9: TLabel
      Left = 18
      Top = 286
      Width = 61
      Height = 13
      Caption = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082
    end
    object Label10: TLabel
      Left = 7
      Top = 199
      Width = 72
      Height = 13
      Caption = 'PK '#1044#1086#1083#1078#1085#1086#1089#1090#1080
    end
    object Label11: TLabel
      Left = 24
      Top = 30
      Width = 55
      Height = 13
      Caption = #1043#1077#1086#1075#1088#1072#1092#1080#1103
    end
    object pCaption: TWDGradientPanel
      Left = 1
      Top = 1
      Width = 398
      Height = 17
      Align = alTop
      Caption = #1044#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1099#1077' '#1092#1080#1083#1100#1090#1088#1099
      Color = clBtnFace
      Color1 = clWhite
      Color2 = clSilver
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 4079166
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      GradientDirection = gdVertical
      ParentFont = False
      TabOrder = 15
    end
    object lcbDepartment: TDBLookupComboboxEh
      Left = 85
      Top = 55
      Width = 308
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      EditButtons = <>
      KeyField = 'NAME'
      ListField = 'NAME'
      ListSource = dsoDepartment
      TabOrder = 1
      Visible = True
    end
    object lcbService: TDBLookupComboboxEh
      Left = 85
      Top = 83
      Width = 308
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      EditButtons = <>
      KeyField = 'NAME'
      ListField = 'NAME'
      ListSource = dsoService
      TabOrder = 2
      Visible = True
    end
    object lcbDivision: TDBLookupComboboxEh
      Left = 85
      Top = 111
      Width = 308
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      EditButtons = <>
      KeyField = 'NAME'
      ListField = 'NAME'
      ListSource = dsoDivision
      TabOrder = 3
      Visible = True
    end
    object lcbSector: TDBLookupComboboxEh
      Left = 85
      Top = 139
      Width = 308
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      EditButtons = <>
      KeyField = 'NAME'
      ListField = 'NAME'
      ListSource = dsoSector
      TabOrder = 4
      Visible = True
    end
    object cbConcatStr: TComboBox
      Left = 152
      Top = 363
      Width = 45
      Height = 21
      Style = csDropDownList
      Anchors = [akRight, akBottom]
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 11
      Text = 'AND'
      Items.Strings = (
        'AND'
        'OR')
      ExplicitTop = 318
    end
    object btnApplyFilter: TBitBtn
      Left = 205
      Top = 361
      Width = 92
      Height = 25
      Hint = #1055#1088#1080#1084#1077#1085#1080#1090#1100' '#1092#1080#1083#1100#1090#1088' (F4)'
      Anchors = [akRight, akBottom]
      Caption = #1055#1088#1080#1084#1077#1085#1080#1090#1100
      ParentShowHint = False
      ShowHint = True
      TabOrder = 12
      OnClick = btnApplyFilterClick
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000FF55FF00FF55
        FF00FF55FF00FF55FF00FF55FF00FF55FF00FF55FF00FF55FF00FF55FF00FF55
        FF00FF55FF00FF55FF00FF55FF00FF55FF00FF55FF00FF55FF00FF55FF00FF55
        FF00FF55FF00FF55FF00FF55FF00FF55FF00FF55FF00FF55FF00FF55FF00FF55
        FF00FF55FF00FF55FF00FF55FF00FF55FF00FF55FF00FF55FF00FF55FF00FF55
        FF00FF55FF00FF55FF00FF55FF00FF55FF00141414FF141414FF141414FF1414
        14FFFF55FF00FF55FF00FF55FF00FF55FF00FF55FF00FF55FF00FF55FF00FF55
        FF00FF55FF00FF55FF00FF55FF00FF55FF00141414FFEAEAEAFFAC5800FF1414
        14FFFF55FF00FF55FF00FF55FF00FF55FF00FF55FF00FF55FF00FF55FF00FF55
        FF00FF55FF00FF55FF00FF55FF00FF55FF00141414FFEAEAEAFFAC5800FF1414
        14FFFF55FF00FF55FF00FF55FF00FF55FF00FF55FF00FF55FF00FF55FF00FF55
        FF00FF55FF00FF55FF00FF55FF00FF55FF00141414FFEAEAEAFFAC5800FF1414
        14FFFF55FF00FF55FF00FF55FF00FF55FF00FF55FF00FF55FF00FF55FF00FF55
        FF00FF55FF00FF55FF00FF55FF00FF55FF00141414FFEAEAEAFFAC5800FF1414
        14FFFF55FF00FF55FF00FF55FF00FF55FF00FF55FF00FF55FF00FF55FF00FF55
        FF00FF55FF00FF55FF00FF55FF00FF55FF00141414FF141414FFAC6B00FF1414
        14FFFF55FF00FF55FF00FF55FF00FF55FF00FF55FF00FF55FF00FF55FF00FF55
        FF00FF55FF00FF55FF00FF55FF00141414FFD69800FFEAEAEAFFAC6B00FFA15B
        00FF141414FFFF55FF00FF55FF00FF55FF00FF55FF00FF55FF00FF55FF00FF55
        FF00FF55FF00FF55FF00141414FFD6B200FFD69800FFEAEAEAFFB76800FFA15B
        00FF964500FF141414FFFF55FF00FF55FF00FF55FF00FF55FF00FF55FF00FF55
        FF00FF55FF00141414FFD6C400FFD6B200FFEAEAEAFFD07500FFB76800FFA15B
        00FF964500FF963000FF141414FFFF55FF00FF55FF00FF55FF00FF55FF00FF55
        FF00141414FFFEFF01FFD6D500FFEAEAEAFFD69400FFD68600FFB76800FFA15B
        00FF964500FF963000FF893200FF141414FFFF55FF00FF55FF00FF55FF001414
        14FFFFFF2FFFFEFF01FFEAEAEAFFD6C300FFD69400FFD68600FFB76800FFAC58
        00FFA14500FF963000FF893200FF893200FF141414FFFF55FF00FF55FF001414
        14FF141414FFEAEAEAFF141414FF141414FF141414FF141414FF141414FF1414
        14FF141414FF141414FF141414FF141414FF141414FFFF55FF00FF55FF00FF55
        FF00FF55FF00FF55FF00FF55FF00FF55FF00FF55FF00FF55FF00FF55FF00FF55
        FF00FF55FF00FF55FF00FF55FF00FF55FF00FF55FF00FF55FF00FF55FF00FF55
        FF00FF55FF00FF55FF00FF55FF00FF55FF00FF55FF00FF55FF00FF55FF00FF55
        FF00FF55FF00FF55FF00FF55FF00FF55FF00FF55FF00FF55FF00}
      ExplicitTop = 316
    end
    object btnClearFilter: TBitBtn
      Left = 301
      Top = 361
      Width = 92
      Height = 25
      Hint = #1057#1085#1103#1090#1100' '#1092#1080#1083#1100#1090#1088' (F5)'
      Anchors = [akRight, akBottom]
      Caption = #1057#1085#1103#1090#1100
      ParentShowHint = False
      ShowHint = True
      TabOrder = 13
      OnClick = btnClearFilterClick
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000FF55FF00FF55
        FF00FF55FF00FF55FF00FF55FF00FF55FF00FF55FF00FF55FF00FF55FF00FF55
        FF00FF55FF00FF55FF00FF55FF00FF55FF00FF55FF00FF55FF00FF55FF00FF55
        FF00FF55FF00FF55FF00FF55FF00FF55FF00FF55FF00FF55FF00FF55FF00FF55
        FF00FF55FF00FF55FF00FF55FF00FF55FF00FF55FF00FF55FF00FF55FF00FF55
        FF00FF55FF00FF55FF00FF55FF00FF55FF00141414FF141414FF141414FF1414
        14FFFF55FF00FF55FF00FF55FF00FF55FF00FF55FF00FF55FF00FF55FF00FF55
        FF00FF55FF00FF55FF00FF55FF00FF55FF00141414FFEAEAEAFFAC5800FF1414
        14FFFF55FF00FF55FF00FF55FF00FF55FF00FF55FF00FF55FF00FF55FF00FF55
        FF00FF55FF00FF55FF00FF55FF000B0AE7FF141414FFEAEAEAFFAC5800FF1414
        14FFFF55FF000808E2FFFF55FF00FF55FF00FF55FF00FF55FF00FF55FF00FF55
        FF00FF55FF00FF55FF001A1AE7FF1214EAFF0F0FE8FFEAEAEAFFAC5800FF1414
        14FF0808E5FF080AE4FF0808E3FFFF55FF00FF55FF00FF55FF00FF55FF00FF55
        FF00FF55FF00FF55FF00FF55FF002424E4FF1C1CE7FF1414E9FFAC5800FF0B0B
        E7FF0A0AE6FF0A0AE5FFFF55FF00FF55FF00FF55FF00FF55FF00FF55FF00FF55
        FF00FF55FF00FF55FF00FF55FF00FF55FF003131E0FF2827E3FF1F1FE6FF1616
        E9FF1111E9FFFF55FF00FF55FF00FF55FF00FF55FF00FF55FF00FF55FF00FF55
        FF00FF55FF00FF55FF00FF55FF00141414FFD69800FF3B3BDDFF3333DFFF2828
        E3FF141414FFFF55FF00FF55FF00FF55FF00FF55FF00FF55FF00FF55FF00FF55
        FF00FF55FF00FF55FF00141414FFD6B200FF5959D6FF5050D8FF4847DAFF3F3F
        DCFF3535DEFF141414FFFF55FF00FF55FF00FF55FF00FF55FF00FF55FF00FF55
        FF00FF55FF00141414FFD6C400FF6C6CDBFF6767D9FF6161D7FFB76800FF5252
        D7FF4A4AD9FF4141DBFF141414FFFF55FF00FF55FF00FF55FF00FF55FF00FF55
        FF00141414FFFEFF01FF8181E0FF7A7ADEFF7474DDFFD68600FFB76800FFA15B
        00FF5D5DD5FF5555D6FF4C4CD8FF141414FFFF55FF00FF55FF00FF55FF001414
        14FFFFFF2FFFFEFF01FFEAEAEAFF8787E2FFD69400FFD68600FFB76800FFAC58
        00FFA14500FF6464D8FF893200FF893200FF141414FFFF55FF00FF55FF001414
        14FF141414FFEAEAEAFF141414FF141414FF141414FF141414FF141414FF1414
        14FF141414FF141414FF141414FF141414FF141414FFFF55FF00FF55FF00FF55
        FF00FF55FF00FF55FF00FF55FF00FF55FF00FF55FF00FF55FF00FF55FF00FF55
        FF00FF55FF00FF55FF00FF55FF00FF55FF00FF55FF00FF55FF00FF55FF00FF55
        FF00FF55FF00FF55FF00FF55FF00FF55FF00FF55FF00FF55FF00FF55FF00FF55
        FF00FF55FF00FF55FF00FF55FF00FF55FF00FF55FF00FF55FF00}
      ExplicitTop = 316
    end
    object chbUserMainRole: TCheckBox
      Left = 85
      Top = 310
      Width = 177
      Height = 17
      Caption = #1058#1086#1083#1100#1082#1086' '#1087#1086' '#1086#1089#1085#1086#1074#1085#1086#1081' '#1076#1086#1083#1078#1085#1086#1089#1090#1080
      TabOrder = 10
    end
    object lcbRank: TDBLookupComboboxEh
      Left = 85
      Top = 167
      Width = 308
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      EditButtons = <>
      KeyField = 'NAME'
      ListField = 'NAME'
      ListSource = dsoRank
      TabOrder = 5
      Visible = True
    end
    object lcbGroup: TDBLookupComboboxEh
      Left = 85
      Top = 254
      Width = 308
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      EditButtons = <>
      KeyField = 'NAME'
      ListField = 'NAME'
      ListSource = dsoGroup
      TabOrder = 8
      Visible = True
    end
    object lcbRole: TDBLookupComboboxEh
      Left = 85
      Top = 225
      Width = 308
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      EditButtons = <>
      KeyField = 'NAME'
      ListField = 'NAME'
      ListSource = dsoRole
      TabOrder = 7
      Visible = True
    end
    object lcbReference: TDBLookupComboboxEh
      Left = 85
      Top = 283
      Width = 308
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      DropDownBox.Columns = <
        item
          FieldName = 'PK'
          Width = 50
        end
        item
          FieldName = 'DESCRIPTOR_'
          Title.Caption = #1044#1077#1089#1082#1088#1080#1087#1090#1086#1088
          Width = 100
        end
        item
          FieldName = 'TITLE'
          Title.Caption = #1047#1072#1075#1086#1083#1086#1074#1086#1082
          Width = 200
        end>
      EditButtons = <>
      KeyField = 'DESCRIPTOR_'
      ListField = 'TITLE'
      ListSource = dsoReference
      TabOrder = 9
      Visible = True
    end
    object btnClearFields: TBitBtn
      Left = 272
      Top = 330
      Width = 121
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = #1054#1095#1080#1089#1090#1080#1090#1100' '#1074#1089#1077' '#1087#1086#1083#1103
      TabOrder = 14
      OnClick = btnClearFieldsClick
      ExplicitTop = 285
    end
    object edRankPk: TDBNumberEditEh
      Left = 85
      Top = 196
      Width = 100
      Height = 21
      DecimalPlaces = 0
      EditButton.Style = ebsAltUpDownEh
      EditButton.Visible = True
      EditButtons = <>
      TabOrder = 6
      Visible = True
    end
    object lcbBranch: TDBLookupComboboxEh
      Left = 85
      Top = 27
      Width = 308
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      DropDownBox.ColumnDefValues.Title.TitleButton = True
      DropDownBox.Columns = <
        item
          AutoFitColWidth = False
          FieldName = 'PK'
        end
        item
          FieldName = 'FULLNAME'
        end>
      DropDownBox.ListSource = dsoBranch
      DropDownBox.Options = [dlgColumnResizeEh, dlgColLinesEh, dlgAutoSortMarkingEh]
      DropDownBox.SortLocal = True
      DropDownBox.ShowTitles = True
      EditButtons = <>
      KeyField = 'PK'
      ListField = 'FULLNAME'
      ListSource = dsoBranch
      TabOrder = 0
      Visible = True
    end
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 742
    Width = 1092
    Height = 19
    Panels = <
      item
        Alignment = taCenter
        Width = 65
      end
      item
        Width = 200
      end>
    ExplicitTop = 697
  end
  object ToolBar: TToolBar
    Left = 0
    Top = 0
    Width = 1092
    Height = 22
    Caption = 'ToolBar'
    DrawingStyle = dsGradient
    Images = FMain.ilMain
    ParentShowHint = False
    ShowHint = True
    TabOrder = 4
    object ToolButton3: TToolButton
      Left = 0
      Top = 0
      Action = AClearFilter
    end
    object ToolButton1: TToolButton
      Left = 23
      Top = 0
      Action = ABaseFilter
    end
    object ToolButton2: TToolButton
      Left = 46
      Top = 0
      Action = AResetBaseFilter
    end
    object ToolButton4: TToolButton
      Left = 69
      Top = 0
      Width = 8
      Caption = 'ToolButton4'
      ImageIndex = 28
      Style = tbsSeparator
    end
    object ToolButton13: TToolButton
      Left = 77
      Top = 0
      Action = AAddUser
    end
    object ToolButton14: TToolButton
      Left = 100
      Top = 0
      Action = AEditUser
    end
    object ToolButton15: TToolButton
      Left = 123
      Top = 0
      Action = ADelUser
    end
    object ToolButton12: TToolButton
      Left = 146
      Top = 0
      Width = 8
      Caption = 'ToolButton12'
      ImageIndex = 33
      Style = tbsSeparator
    end
    object ToolButton9: TToolButton
      Left = 154
      Top = 0
      Action = AAddRank
    end
    object ToolButton10: TToolButton
      Left = 177
      Top = 0
      Action = ADelRank
    end
    object ToolButton5: TToolButton
      Left = 200
      Top = 0
      Action = AAddGroup
    end
    object ToolButton6: TToolButton
      Left = 223
      Top = 0
      Action = ADelGroup
    end
    object ToolButton7: TToolButton
      Left = 246
      Top = 0
      Action = AAddDict
    end
    object ToolButton8: TToolButton
      Left = 269
      Top = 0
      Action = ADelDict
    end
    object ToolButton11: TToolButton
      Left = 292
      Top = 0
      Width = 8
      Caption = 'ToolButton11'
      ImageIndex = 32
      Style = tbsSeparator
    end
    object chbLoadBoss: TCheckBox
      Left = 300
      Top = 0
      Width = 155
      Height = 22
      Hint = 
        #1055#1086#1076#1075#1088#1091#1079#1080#1090' '#1076#1072#1085#1085#1099#1077' '#1082#1086#1083#1086#1085#1086#1082' '#1053#1077#1087#1086#1089#1088#1077#1076#1089#1090#1074#1077#1085#1085#1099#1081' '#1088#1091#1082#1086#1074#1086#1076#1080#1090#1077#1083#1100', '#1056#1091#1082#1086#1074#1086#1076#1080 +
        #1090#1077#1083#1100'-'#1084#1086#1076#1077#1088#1072#1090#1086#1088' '#1080' '#1044#1080#1088#1077#1082#1090#1086#1088' '#1076#1077#1087#1072#1088#1090#1072#1084#1077#1085#1090#1072'.'#13#10#1055#1088#1080' '#1101#1090#1086#1084' '#1073#1091#1076#1091#1090' '#1089#1085#1103#1090#1099' '#1076#1086 +
        #1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1099#1077' '#1092#1080#1083#1100#1090#1088#1099'.'
      Caption = #1047#1072#1075#1088#1091#1078#1072#1090#1100' '#1088#1091#1082#1086#1074#1086#1076#1080#1090#1077#1083#1077#1081
      TabOrder = 0
      OnClick = chbLoadBossClick
    end
  end
  object dsUsers: TpFIBDataSet
    SelectSQL.Strings = (
      
        'select u.PK, u.LOGIN, u.NAME, u.ISACTIVE, u.ROLE_PK, r.NAME ROLE' +
        '_NAME, u.DEVELOPER, u.MODERATOR,'
      
        '  u.CODE_1C, u.EMAIL, u.SHORT_NAME, u.LASTDATE, c.NAME ATTR_NAME' +
        ', u.HOLIDAY, m.NAME MANAGER,'
      '  b.NAME BOSS, du.NAME DEP_DIRECTOR'
      'from USERS u'
      '  left join ROLES r on r.PK = u.ROLE_PK'
      '  left join CR_ATTR c on c.PK = u.ACTIVEREASON'
      '  left join GET_MANAGER(u.PK, null) m on 1=1'
      '  left join ISBOSS(u.PK) b on 1=1'
      '  left join GET_DIRECTOR_DEPARTAMENT(u.PK) d on 1=1'
      '  left join USERS du on du.PK = d.USER_BOSS'
      'order by u.NAME')
    AfterClose = dsUsersAfterClose
    AfterOpen = dsUsersAfterOpen
    Transaction = FMain.Transact
    Database = FMain.Database
    OnEndScroll = dsUsersEndScroll
    Left = 104
    Top = 42
    poAskRecordCount = True
    object dsUsersPK: TFIBIntegerField
      FieldName = 'PK'
    end
    object dsUsersLOGIN: TFIBStringField
      FieldName = 'LOGIN'
      Size = 25
      EmptyStrToNull = True
    end
    object dsUsersNAME: TFIBStringField
      FieldName = 'NAME'
      Size = 100
      EmptyStrToNull = True
    end
    object dsUsersISACTIVE: TFIBStringField
      FieldName = 'ISACTIVE'
      Size = 1
      EmptyStrToNull = True
    end
    object dsUsersROLE_PK: TFIBIntegerField
      FieldName = 'ROLE_PK'
    end
    object dsUsersROLE_NAME: TFIBStringField
      FieldName = 'ROLE_NAME'
      Size = 255
      EmptyStrToNull = True
    end
    object dsUsersDEVELOPER: TFIBStringField
      FieldName = 'DEVELOPER'
      Size = 1
      EmptyStrToNull = True
    end
    object dsUsersMODERATOR: TFIBStringField
      FieldName = 'MODERATOR'
      Size = 1
      EmptyStrToNull = True
    end
    object dsUsersCODE_1C: TFIBStringField
      FieldName = 'CODE_1C'
      Size = 255
      EmptyStrToNull = True
    end
    object dsUsersEMAIL: TFIBStringField
      FieldName = 'EMAIL'
      Size = 100
      EmptyStrToNull = True
    end
    object dsUsersSHORT_NAME: TFIBStringField
      FieldName = 'SHORT_NAME'
      Size = 50
      EmptyStrToNull = True
    end
    object dsUsersLASTDATE: TFIBDateTimeField
      FieldName = 'LASTDATE'
    end
    object dsUsersATTR_NAME: TFIBStringField
      FieldName = 'ATTR_NAME'
      Size = 255
      EmptyStrToNull = True
    end
    object dsUsersHOLIDAY: TFIBStringField
      FieldName = 'HOLIDAY'
      Size = 1
      EmptyStrToNull = True
    end
    object dsUsersMANAGER: TFIBStringField
      FieldName = 'MANAGER'
      Size = 255
      EmptyStrToNull = True
    end
    object dsUsersBOSS: TFIBStringField
      FieldName = 'BOSS'
      Size = 255
      EmptyStrToNull = True
    end
    object dsUsersDEP_DIRECTOR: TFIBStringField
      FieldName = 'DEP_DIRECTOR'
      Size = 100
      EmptyStrToNull = True
    end
  end
  object dsoUsers: TDataSource
    DataSet = dsUsers
    Left = 136
    Top = 42
  end
  object dsUserGroups: TpFIBDataSet
    SelectSQL.Strings = (
      'select g.PK, g.NAME'
      'from USERS_USER_GROUPS uug'
      '  left join USER_GROUPS g on g.PK = uug.GROUP_PK'
      'where uug.USER_PK = :USER_PK')
    Transaction = FMain.Transact
    Database = FMain.Database
    Left = 48
    Top = 442
    poAskRecordCount = True
    object dsUserGroupsPK: TFIBIntegerField
      FieldName = 'PK'
    end
    object dsUserGroupsNAME: TFIBStringField
      FieldName = 'NAME'
      Size = 255
      EmptyStrToNull = True
    end
  end
  object dsoUserGroups: TDataSource
    DataSet = dsUserGroups
    Left = 80
    Top = 442
  end
  object dsUserRanks: TpFIBDataSet
    SelectSQL.Strings = (
      
        'select ur.MAIN_ROLE, us.PK, us.NAME, d.NAME DEPARTMENT, o.NAME O' +
        'FFICE, c.NAME CHAPTER, s.NAME SECTOR,'
      
        '  b.PK BRANCH_PK, b.NAME BRANCH_NAME, b.FULLNAME, us.BOSS, us.IS' +
        '_CHIEF, ur.PK ROLE_PK'
      'from USER_ROLES ur'
      '  join UNIT_STRUCT us on us.PK = ur.ROLE_PK'
      '  left join SELECT_PARENT_UNIT(us.PK) pus on 1=1'
      '  left join UNIT_STRUCT d on d.PK = pus.UNIT_PK'
      '  left join UNIT_STRUCT o on o.PK = pus.OFFICE_PK'
      '  left join UNIT_STRUCT c on c.PK = pus.CHAPTER_PK'
      '  left join UNIT_STRUCT s on s.PK = pus.SECTOR_PK'
      '  left join BRANCH b on b.PK = ur.GEO_PK'
      'where ur.USER_PK = :USER_PK'
      'order by ur.MAIN_ROLE desc, us.NAME')
    Transaction = FMain.Transact
    Database = FMain.Database
    Left = 232
    Top = 442
    poAskRecordCount = True
    object dsUserRanksMAIN_ROLE: TFIBStringField
      FieldName = 'MAIN_ROLE'
      Size = 1
      EmptyStrToNull = True
    end
    object dsUserRanksPK: TFIBIntegerField
      FieldName = 'PK'
    end
    object dsUserRanksNAME: TFIBStringField
      FieldName = 'NAME'
      Size = 255
      EmptyStrToNull = True
    end
    object dsUserRanksDEPARTMENT: TFIBStringField
      FieldName = 'DEPARTMENT'
      Size = 255
      EmptyStrToNull = True
    end
    object dsUserRanksOFFICE: TFIBStringField
      FieldName = 'OFFICE'
      Size = 255
      EmptyStrToNull = True
    end
    object dsUserRanksCHAPTER: TFIBStringField
      FieldName = 'CHAPTER'
      Size = 255
      EmptyStrToNull = True
    end
    object dsUserRanksSECTOR: TFIBStringField
      FieldName = 'SECTOR'
      Size = 255
      EmptyStrToNull = True
    end
    object dsUserRanksBRANCH_PK: TFIBIntegerField
      FieldName = 'BRANCH_PK'
    end
    object dsUserRanksBRANCH_NAME: TFIBStringField
      FieldName = 'BRANCH_NAME'
      Size = 255
      EmptyStrToNull = True
    end
    object dsUserRanksFULLNAME: TFIBStringField
      FieldName = 'FULLNAME'
      Size = 255
      EmptyStrToNull = True
    end
    object dsUserRanksBOSS: TFIBIntegerField
      FieldName = 'BOSS'
    end
    object dsUserRanksIS_CHIEF: TFIBStringField
      FieldName = 'IS_CHIEF'
      Size = 1
      EmptyStrToNull = True
    end
    object dsUserRanksROLE_PK: TFIBIntegerField
      FieldName = 'ROLE_PK'
    end
  end
  object dsoUserRanks: TDataSource
    DataSet = dsUserRanks
    Left = 264
    Top = 442
  end
  object dsUserRefGrant: TpFIBDataSet
    SelectSQL.Strings = (
      
        'select TYPE_, PK, DESCRIPTOR_, TITLE, BASE_DESCRIPTOR, FOLDER_PK' +
        ', FOLDER_NAME,'
      
        '  OWNER_USER_PK, LOGIN, USER_NAME, ROLE_PK, ROLE_NAME, MAIN_ROLE' +
        ','
      
        '  VIEW_REF, VIEW_, ADD_, EDIT_, DEL_, CONFIG_, EXPORT, IMPORT fr' +
        'om ('
      
        '  select 0 TYPE_, ref.PK, ref.DESCRIPTOR_, ref.TITLE, ref.BASE_D' +
        'ESCRIPTOR, ref.FOLDER_PK, f.NAME FOLDER_NAME,'
      
        '    ref.OWNER_USER_PK, o.LOGIN, o.NAME USER_NAME, us.PK ROLE_PK,' +
        ' us.NAME ROLE_NAME, ur.MAIN_ROLE,'
      
        '    pr.VIEW_REF, pr.VIEW_, pr.ADD_, pr.EDIT_, pr.DEL_, pr.CONFIG' +
        '_, pr.EXPORT, pr.IMPORT'
      '  from USER_ROLES ur'
      '    join UNIT_STRUCT us on us.PK = ur.ROLE_PK'
      '    join DYNAMIC_FORM_PERM_RANKS pr on pr.ROLE_PK = us.PK'
      '    join DYNAMIC_FORM_REFERENCE ref on ref.PK = pr.REFERENCE_PK'
      '    left join USERS o on o.PK = ref.OWNER_USER_PK'
      '    left join DYNAMIC_FORM_FOLDER f on f.PK = ref.FOLDER_PK'
      '  where ur.USER_PK = :USER_PK'
      '  union all'
      
        '  select 1 TYPE_, ref.PK, ref.DESCRIPTOR_, ref.TITLE, ref.BASE_D' +
        'ESCRIPTOR, ref.FOLDER_PK, f.NAME FOLDER_NAME,'
      
        '    ref.OWNER_USER_PK, o.LOGIN, o.NAME USER_NAME, u.ROLE_PK, r.N' +
        'AME ROLE_NAME, null MAIN_ROLE,'
      
        '    pr.VIEW_REF, pr.VIEW_, pr.ADD_, pr.EDIT_, pr.DEL_, pr.CONFIG' +
        '_, pr.EXPORT, pr.IMPORT'
      '  from USERS u'
      '    join ROLES r on r.PK = u.ROLE_PK'
      '    join DYNAMIC_FORM_PERMISSIONS pr on pr.ROLE_PK = r.PK'
      '    join DYNAMIC_FORM_REFERENCE ref on ref.PK = pr.REFERENCE_PK'
      '    left join USERS o on o.PK = ref.OWNER_USER_PK'
      '    left join DYNAMIC_FORM_FOLDER f on f.PK = ref.FOLDER_PK'
      '  where u.PK = :USER_PK'
      '  union all'
      
        '  select 2 TYPE_, ref.PK, ref.DESCRIPTOR_, ref.TITLE, ref.BASE_D' +
        'ESCRIPTOR, ref.FOLDER_PK, f.NAME FOLDER_NAME,'
      
        '    ref.OWNER_USER_PK, o.LOGIN, o.NAME USER_NAME, null ROLE_PK, ' +
        'null ROLE_NAME, null MAIN_ROLE,'
      
        '    null VIEW_REF, null VIEW_, null ADD_, null EDIT_, null DEL_,' +
        ' null CONFIG_, null EXPORT, null IMPORT'
      '  from DYNAMIC_FORM_REF_USER ru'
      '    join DYNAMIC_FORM_REFERENCE ref on ref.PK = ru.REF_PK'
      '    left join USERS o on o.PK = ref.OWNER_USER_PK'
      '    left join DYNAMIC_FORM_FOLDER f on f.PK = ref.FOLDER_PK'
      '  where ru.USER_PK = :USER_PK)'
      'order by TYPE_, TITLE')
    Transaction = FMain.Transact
    Database = FMain.Database
    Left = 88
    Top = 578
    poAskRecordCount = True
    object dsUserRefGrantPK: TFIBIntegerField
      FieldName = 'PK'
    end
    object dsUserRefGrantDESCRIPTOR_: TFIBStringField
      FieldName = 'DESCRIPTOR_'
      Size = 255
      EmptyStrToNull = True
    end
    object dsUserRefGrantTITLE: TFIBStringField
      FieldName = 'TITLE'
      Size = 255
      EmptyStrToNull = True
    end
    object dsUserRefGrantBASE_DESCRIPTOR: TFIBStringField
      FieldName = 'BASE_DESCRIPTOR'
      Size = 255
      EmptyStrToNull = True
    end
    object dsUserRefGrantFOLDER_PK: TFIBIntegerField
      FieldName = 'FOLDER_PK'
    end
    object dsUserRefGrantFOLDER_NAME: TFIBStringField
      FieldName = 'FOLDER_NAME'
      Size = 255
      EmptyStrToNull = True
    end
    object dsUserRefGrantOWNER_USER_PK: TFIBIntegerField
      FieldName = 'OWNER_USER_PK'
    end
    object dsUserRefGrantLOGIN: TFIBStringField
      FieldName = 'LOGIN'
      Size = 25
      EmptyStrToNull = True
    end
    object dsUserRefGrantUSER_NAME: TFIBStringField
      FieldName = 'USER_NAME'
      Size = 100
      EmptyStrToNull = True
    end
    object dsUserRefGrantROLE_PK: TFIBIntegerField
      FieldName = 'ROLE_PK'
    end
    object dsUserRefGrantROLE_NAME: TFIBStringField
      FieldName = 'ROLE_NAME'
      Size = 255
      EmptyStrToNull = True
    end
    object dsUserRefGrantMAIN_ROLE: TFIBStringField
      FieldName = 'MAIN_ROLE'
      Size = 1
      EmptyStrToNull = True
    end
    object dsUserRefGrantVIEW_REF: TFIBIntegerField
      FieldName = 'VIEW_REF'
    end
    object dsUserRefGrantVIEW_: TFIBIntegerField
      FieldName = 'VIEW_'
    end
    object dsUserRefGrantADD_: TFIBIntegerField
      FieldName = 'ADD_'
    end
    object dsUserRefGrantEDIT_: TFIBIntegerField
      FieldName = 'EDIT_'
    end
    object dsUserRefGrantDEL_: TFIBIntegerField
      FieldName = 'DEL_'
    end
    object dsUserRefGrantCONFIG_: TFIBIntegerField
      FieldName = 'CONFIG_'
    end
    object dsUserRefGrantEXPORT: TFIBIntegerField
      FieldName = 'EXPORT'
    end
    object dsUserRefGrantIMPORT: TFIBIntegerField
      FieldName = 'IMPORT'
    end
    object dsUserRefGrantTYPE_: TFIBIntegerField
      FieldName = 'TYPE_'
    end
  end
  object dsoUserRefGrant: TDataSource
    DataSet = mtUserRefGrant
    Left = 120
    Top = 578
  end
  object dsDepartment: TpFIBDataSet
    SelectSQL.Strings = (
      
        'select distinct NAME from UNIT_STRUCT where ISUNIT = 1 and STATU' +
        'S in (1, 3)'
      'order by NAME')
    Transaction = FMain.Transact
    Database = FMain.Database
    Left = 856
    Top = 71
    oFetchAll = True
    object dsDepartmentNAME: TFIBStringField
      FieldName = 'NAME'
      Size = 255
      EmptyStrToNull = True
    end
  end
  object dsoDepartment: TDataSource
    DataSet = dsDepartment
    Left = 888
    Top = 71
  end
  object dsService: TpFIBDataSet
    SelectSQL.Strings = (
      
        'select distinct NAME from UNIT_STRUCT where ISUNIT = 2 and STATU' +
        'S in (1, 3)'
      'order by NAME')
    Transaction = FMain.Transact
    Database = FMain.Database
    Left = 920
    Top = 96
    oFetchAll = True
    object dsServiceNAME: TFIBStringField
      FieldName = 'NAME'
      Size = 255
      EmptyStrToNull = True
    end
  end
  object dsoService: TDataSource
    DataSet = dsService
    Left = 952
    Top = 96
  end
  object dsDivision: TpFIBDataSet
    SelectSQL.Strings = (
      
        'select distinct NAME from UNIT_STRUCT where ISUNIT = 3 and STATU' +
        'S in (1, 3)'
      'order by NAME')
    Transaction = FMain.Transact
    Database = FMain.Database
    Left = 856
    Top = 124
    oFetchAll = True
    object dsDivisionNAME: TFIBStringField
      FieldName = 'NAME'
      Size = 255
      EmptyStrToNull = True
    end
  end
  object dsoDivision: TDataSource
    DataSet = dsDivision
    Left = 888
    Top = 124
  end
  object dsSector: TpFIBDataSet
    SelectSQL.Strings = (
      
        'select distinct NAME from UNIT_STRUCT where ISUNIT = 4 and STATU' +
        'S in (1, 3)'
      'order by NAME')
    Transaction = FMain.Transact
    Database = FMain.Database
    Left = 920
    Top = 152
    oFetchAll = True
    object dsSectorNAME: TFIBStringField
      FieldName = 'NAME'
      Size = 255
      EmptyStrToNull = True
    end
  end
  object dsoSector: TDataSource
    DataSet = dsSector
    Left = 952
    Top = 152
  end
  object ActionList: TActionList
    Images = FMain.ilMain
    Left = 64
    Top = 40
    object AFilter: TAction
      Caption = 'AFilter'
      ShortCut = 115
      OnExecute = AFilterExecute
    end
    object AClearFilter: TAction
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100
      Hint = #1054#1073#1085#1086#1074#1080#1090#1100' ('#1057#1085#1080#1084#1072#1077#1090' '#1076#1086#1087'. '#1092#1080#1083#1100#1090#1088')'
      ImageIndex = 21
      ShortCut = 116
      OnExecute = AFilterExecute
    end
    object AClose: TAction
      Caption = 'AClose'
      ShortCut = 16499
      OnExecute = ACloseExecute
    end
    object ABaseFilter: TAction
      Caption = #1054#1089#1085#1086#1074#1085#1086#1081' '#1092#1080#1083#1100#1088
      Hint = #1054#1089#1085#1086#1074#1085#1086#1081' '#1092#1080#1083#1100#1088
      ImageIndex = 26
      ShortCut = 119
      OnExecute = ABaseFilterExecute
    end
    object AResetBaseFilter: TAction
      Caption = #1057#1085#1103#1090#1100' '#1092#1080#1083#1100#1090#1088
      Hint = #1057#1085#1103#1090#1100' '#1086#1089#1085#1086#1074#1085#1086#1081' '#1092#1080#1083#1100#1090#1088
      ImageIndex = 27
      ShortCut = 120
      OnExecute = AResetBaseFilterExecute
      OnUpdate = AResetBaseFilterUpdate
    end
    object AGridOptions: TAction
      Caption = #1053#1072#1089#1090#1088#1086#1080#1090#1100' '#1082#1086#1083#1086#1085#1082#1080
      Hint = #1053#1072#1089#1090#1088#1086#1080#1090#1100' '#1082#1086#1083#1086#1085#1082#1080
      OnExecute = AGridOptionsExecute
    end
    object AAddGroup: TAction
      Caption = #1055#1088#1080#1074#1103#1079#1072#1090#1100' '#1075#1088#1091#1087#1087#1091
      Hint = #1055#1088#1080#1074#1103#1079#1072#1090#1100' '#1075#1088#1091#1087#1087#1091
      ImageIndex = 23
      OnExecute = AAddGroupExecute
      OnUpdate = AAddGroupUpdate
    end
    object ADelGroup: TAction
      Caption = #1054#1090#1074#1103#1079#1072#1090#1100' '#1075#1088#1091#1087#1087#1091
      Hint = #1054#1090#1074#1103#1079#1072#1090#1100' '#1075#1088#1091#1087#1087#1091
      ImageIndex = 24
      OnExecute = ADelGroupExecute
      OnUpdate = ADelGroupUpdate
    end
    object AAddDict: TAction
      Caption = #1042#1099#1076#1072#1090#1100' '#1087#1088#1072#1074#1072' '#1085#1072' '#1082#1086#1085#1092#1080#1075#1091#1088#1072#1094#1080#1102' '#1089#1087#1088#1072#1074#1086#1095#1085#1080#1082#1072
      Hint = #1042#1099#1076#1072#1090#1100' '#1087#1088#1072#1074#1072' '#1085#1072' '#1082#1086#1085#1092#1080#1075#1091#1088#1072#1094#1080#1102' '#1089#1087#1088#1072#1074#1086#1095#1085#1080#1082#1072
      ImageIndex = 32
      OnExecute = AAddDictExecute
      OnUpdate = AAddGroupUpdate
    end
    object ADelDict: TAction
      Caption = #1047#1072#1073#1088#1072#1090#1100' '#1087#1088#1072#1074#1072' '#1085#1072' '#1082#1086#1085#1092#1080#1075#1091#1088#1072#1094#1080#1102' '#1089#1087#1088#1072#1074#1086#1095#1085#1080#1082#1072
      Hint = #1047#1072#1073#1088#1072#1090#1100' '#1087#1088#1072#1074#1072' '#1085#1072' '#1082#1086#1085#1092#1080#1075#1091#1088#1072#1094#1080#1102' '#1089#1087#1088#1072#1074#1086#1095#1085#1080#1082#1072
      ImageIndex = 31
      OnExecute = ADelDictExecute
      OnUpdate = ADelDictUpdate
    end
    object AAddRank: TAction
      Caption = #1055#1088#1080#1074#1103#1079#1072#1090#1100' '#1076#1086#1083#1078#1085#1086#1089#1090#1100
      Hint = #1055#1088#1080#1074#1103#1079#1072#1090#1100' '#1076#1086#1083#1078#1085#1086#1089#1090#1100
      ImageIndex = 34
      OnExecute = AAddRankExecute
      OnUpdate = AAddGroupUpdate
    end
    object ADelRank: TAction
      Caption = #1054#1090#1074#1103#1079#1072#1090#1100' '#1076#1086#1083#1078#1085#1086#1089#1090#1100
      Hint = #1054#1090#1074#1103#1079#1072#1090#1100' '#1076#1086#1083#1078#1085#1086#1089#1090#1100
      ImageIndex = 33
      OnExecute = ADelRankExecute
      OnUpdate = ADelRankUpdate
    end
    object AAddUser: TAction
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103' (Insert)'
      Hint = #1044#1086#1073#1072#1074#1080#1090#1100' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103' (Insert)'
      ImageIndex = 5
      OnExecute = AAddUserExecute
      OnUpdate = AAddUserUpdate
    end
    object AEditUser: TAction
      Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103' (Shift+Enter)'
      Hint = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103' (Shift+Enter)'
      ImageIndex = 6
      OnExecute = AEditUserExecute
      OnUpdate = AEditUserUpdate
    end
    object ADelUser: TAction
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103' (Ctrl+Delete)'
      Hint = #1059#1076#1072#1083#1080#1090#1100' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103' (Ctrl+Delete)'
      ImageIndex = 7
      OnExecute = ADelUserExecute
      OnUpdate = AAddGroupUpdate
    end
    object AExportToExcel: TAction
      Caption = #1069#1082#1089#1087#1086#1088#1090' '#1074' Excel'
      OnExecute = AExportToExcelExecute
    end
    object AExportToCsv: TAction
      Caption = #1069#1082#1089#1087#1086#1088#1090' '#1074' '#1090#1077#1082#1089#1090' (csv)'
      OnExecute = AExportToCsvExecute
    end
  end
  object dsRank: TpFIBDataSet
    SelectSQL.Strings = (
      
        'select distinct NAME from UNIT_STRUCT where ISUNIT = 0 and STATU' +
        'S in (1, 3)'
      'order by NAME')
    Transaction = FMain.Transact
    Database = FMain.Database
    Left = 848
    Top = 197
    oFetchAll = True
    object dsRankNAME: TFIBStringField
      FieldName = 'NAME'
      Size = 255
      EmptyStrToNull = True
    end
  end
  object dsoRank: TDataSource
    DataSet = dsRank
    Left = 880
    Top = 197
  end
  object dsGroup: TpFIBDataSet
    SelectSQL.Strings = (
      'select NAME from USER_GROUPS order by NAME')
    Transaction = FMain.Transact
    Database = FMain.Database
    Left = 920
    Top = 275
    oFetchAll = True
    object dsGroupNAME: TFIBStringField
      FieldName = 'NAME'
      Size = 255
      EmptyStrToNull = True
    end
  end
  object dsoGroup: TDataSource
    DataSet = dsGroup
    Left = 952
    Top = 275
  end
  object dsRole: TpFIBDataSet
    SelectSQL.Strings = (
      'select NAME from ROLES order by NAME')
    Transaction = FMain.Transact
    Database = FMain.Database
    Left = 855
    Top = 253
    oFetchAll = True
    object dsRoleNAME: TFIBStringField
      FieldName = 'NAME'
      Size = 255
      EmptyStrToNull = True
    end
  end
  object dsoRole: TDataSource
    DataSet = dsRole
    Left = 887
    Top = 253
  end
  object dsReference: TpFIBDataSet
    SelectSQL.Strings = (
      'select PK, DESCRIPTOR_, TITLE from DYNAMIC_FORM_REFERENCE'
      'order by TITLE')
    Transaction = FMain.Transact
    Database = FMain.Database
    Left = 913
    Top = 309
    oFetchAll = True
    object dsReferencePK: TFIBIntegerField
      FieldName = 'PK'
    end
    object dsReferenceDESCRIPTOR_: TFIBStringField
      FieldName = 'DESCRIPTOR_'
      Size = 255
      EmptyStrToNull = True
    end
    object dsReferenceTITLE: TFIBStringField
      FieldName = 'TITLE'
      Size = 255
      EmptyStrToNull = True
    end
  end
  object dsoReference: TDataSource
    DataSet = dsReference
    Left = 945
    Top = 309
  end
  object pmUsers: TPopupMenu
    Images = FMain.ilMain
    Left = 216
    Top = 88
    object N1: TMenuItem
      Action = ABaseFilter
    end
    object N2: TMenuItem
      Action = AResetBaseFilter
    end
    object N3: TMenuItem
      Caption = '-'
    end
    object Insert1: TMenuItem
      Action = AAddUser
    end
    object ShiftEnter1: TMenuItem
      Action = AEditUser
    end
    object CtrlDelete1: TMenuItem
      Action = ADelUser
    end
    object N4: TMenuItem
      Caption = '-'
    end
    object N5: TMenuItem
      Action = AAddRank
    end
    object N7: TMenuItem
      Action = ADelRank
    end
    object N6: TMenuItem
      Action = AAddGroup
    end
    object N8: TMenuItem
      Action = ADelGroup
    end
    object N9: TMenuItem
      Action = AAddDict
    end
    object N10: TMenuItem
      Action = ADelDict
    end
  end
  object pmGrid: TPopupMenu
    Left = 64
    Top = 80
    object MenuItem1: TMenuItem
      Action = AGridOptions
    end
    object Excel1: TMenuItem
      Action = AExportToExcel
    end
    object csv1: TMenuItem
      Action = AExportToCsv
    end
  end
  object mtUserRefGrant: TMemTableEh
    FieldDefs = <>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 56
    Top = 578
    object mtUserRefGrantPK: TIntegerField
      FieldName = 'PK'
    end
    object mtUserRefGrantDESCRIPTOR_: TStringField
      FieldName = 'DESCRIPTOR_'
      Size = 255
    end
    object mtUserRefGrantTITLE: TStringField
      FieldName = 'TITLE'
      Size = 255
    end
    object mtUserRefGrantBASE_DESCRIPTOR: TStringField
      FieldName = 'BASE_DESCRIPTOR'
      Size = 255
    end
    object mtUserRefGrantFOLDER_PK: TIntegerField
      FieldName = 'FOLDER_PK'
    end
    object mtUserRefGrantFOLDER_NAME: TStringField
      FieldName = 'FOLDER_NAME'
      Size = 255
    end
    object mtUserRefGrantOWNER_USER_PK: TIntegerField
      FieldName = 'OWNER_USER_PK'
    end
    object mtUserRefGrantLOGIN: TStringField
      FieldName = 'LOGIN'
      Size = 25
    end
    object mtUserRefGrantUSER_NAME: TStringField
      FieldName = 'USER_NAME'
      Size = 100
    end
    object mtUserRefGrantROLE_PK: TIntegerField
      FieldName = 'ROLE_PK'
    end
    object mtUserRefGrantROLE_NAME: TStringField
      FieldName = 'ROLE_NAME'
      Size = 255
    end
    object mtUserRefGrantMAIN_ROLE: TStringField
      FieldName = 'MAIN_ROLE'
      Size = 1
    end
    object mtUserRefGrantVIEW_REF: TIntegerField
      FieldName = 'VIEW_REF'
    end
    object mtUserRefGrantVIEW_: TIntegerField
      FieldName = 'VIEW_'
    end
    object mtUserRefGrantADD_: TIntegerField
      FieldName = 'ADD_'
    end
    object mtUserRefGrantEDIT_: TIntegerField
      FieldName = 'EDIT_'
    end
    object mtUserRefGrantDEL_: TIntegerField
      FieldName = 'DEL_'
    end
    object mtUserRefGrantCONFIG_: TIntegerField
      FieldName = 'CONFIG_'
    end
    object mtUserRefGrantEXPORT: TIntegerField
      FieldName = 'EXPORT'
    end
    object mtUserRefGrantIMPORT: TIntegerField
      FieldName = 'IMPORT'
    end
    object mtUserRefGrantTYPE_: TIntegerField
      FieldName = 'TYPE_'
    end
  end
  object dsBranch: TpFIBDataSet
    SelectSQL.Strings = (
      'select PK, FULLNAME from BRANCH order by FULLNAME')
    Transaction = FMain.Transact
    Database = FMain.Database
    Left = 920
    Top = 47
    oFetchAll = True
    object dsBranchPK: TFIBIntegerField
      FieldName = 'PK'
    end
    object dsBranchFULLNAME: TFIBStringField
      FieldName = 'FULLNAME'
      Size = 255
      EmptyStrToNull = True
    end
  end
  object dsoBranch: TDataSource
    DataSet = dsBranch
    Left = 952
    Top = 47
  end
end
