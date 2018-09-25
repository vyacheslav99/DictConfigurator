object FHistory: TFHistory
  Left = 0
  Top = 0
  Caption = 'FHistory'
  ClientHeight = 666
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
    0000010020000000000000040000000000000000000000000000000000000000
    0000525552FF4A514AFF313831FF394139FF393029FF00000000000000000000
    0000000000000000000000000000000000000000000000000000000000008C7D
    73FF7B7573FFCEBAADFFDEBAA5FFBDA294FF5A4D4AFF423C29FF634931FF6349
    31FF5A4531FF634931FF634931FF5A4531FF634931FF634931FF524129FF8C8A
    8CFFC6C3BDFFFFEBDEFFEFD7BDFFE7BEADFFB59A8CFF4A4542FFC6A694FFBD9E
    84FFAD8A73FFC6AE94FFBD9E84FFAD8A73FFC6A28CFFB58E7BFF6B4D31FFA5A6
    A5FFF7EFE7FFEFE7DEFF424942FF524D4AFFD6AA94FF4A4542FFEFDBDEFFF7E3
    DEFFCEA694FFF7DFD6FFF7DFD6FFCEAA8CFFF7D3C6FFCEB6A5FF6B5139FFADA2
    9CFFE7E3E7FFEFEBEFFF6B656BFFD6CFCEFFC6B6A5FF736D63FFEFE3DEFFF7E3
    DEFFC6A69CFFE7D3DEFFE7D3D6FFC6A294FFF7D3C6FFCEB6A5FF6B5139FFBDA6
    9CFFADAAADFFE7E3E7FFDED7D6FFD6C7C6FF84757BFF947963FFD6AA94FFBDA2
    9CFF3151D6FF3155DEFF3155CEFF2145ADFFC6A294FFBD9A84FF6B4D31FFC6B6
    A5FFDEDFDEFFADAEADFF9C9294FF9C9A9CFFC6BEBDFFC6A28CFFF7EBEFFFEFE3
    EFFF5279EFFFDEDBEFFFD6DBEFFF3155CEFFE7D3D6FFCEB6A5FF6B5139FFC6B6
    ADFFF7F3EFFFEFE7E7FFCEAA94FFEFE7DEFFF7EBE7FFD6AE94FFF7EFEFFFEFE7
    F7FF7B92FFFFE7EBFFFFDEDBEFFF3155DEFFE7D3D6FFCEBAB5FF6B5139FFCEB2
    9CFFD6BAA5FFCEAA94FFBD8E73FFD6AE94FFCEAA94FFBD8E73FFD6AE94FFC6AA
    9CFF8496EFFF7B92FFFF5279EFFF3151D6FFC6A69CFFBD9A84FF6B5139FFD6BE
    ADFFF7F3EFFFF7EFEFFFCEAA94FFF7EFEFFFF7EFEFFFCEAA94FFF7EFEFFFF7EF
    EFFFC6AA9CFFEFE7F7FFEFE3EFFFBDA29CFFF7E3DEFFD6CBC6FF6B594AFFD6BE
    A5FFFFF3EFFFFFEFEFFFDEAE94FFFFEFEFFFFFEFEFFFD6AE94FFFFEFEFFFFFEF
    E7FFD6AE94FFFFEBE7FFFFE7E7FFD6AA8CFFFFE7DEFFEFD7CEFF735942FFEFAA
    94FFF7B69CFFF7B694FFEFAE8CFFF7AE94FFF7AE84FFE79E7BFFE79E7BFFE79A
    73FFE78E63FFE78E63FFE78E63FFE77D4AFFE78652FFE77D52FFBD5D31FFF7AE
    94FFFFDBCEFFFFDFD6FFFFDFD6FFFFDFD6FFFFDBCEFFFFD7C6FFFFAE8CFFFFA6
    7BFFEFA27BFFEFA27BFFEF9A7BFFEF9A73FFEF9A73FFEF9263FFD66531FFE7A6
    94FFF7B69CFFE7AA8CFFE7AE94FFDEA284FFE7A684FFDE967BFFE79A73FFDE8A
    63FFE78E63FFCE8252FFD68663FFCE714AFFD67D52FFCE7142FFD67142FF948E
    8CFFDED3D6FF9C9A94FFD6D3CEFF948E8CFFD6CFCEFF948A8CFFD6CFCEFF9C96
    94FFD6CFC6FF948A84FFCECBC6FF7B716BFFCEC7C6FF84797BFFB5B2ADFF0000
    0000293429FF00000000293429FF00000000293429FF00000000394139FF0000
    00004A4D4AFF00000000394139FF00000000394139FF000000004A4D4AFF83FF
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000AAAA0000}
  OldCreateOrder = False
  Visible = True
  OnActivate = FormActivate
  OnClose = FormClose
  OnDestroy = FormDestroy
  OnDeactivate = FormDeactivate
  PixelsPerInch = 96
  TextHeight = 13
  object dbgHistory: TDBGridEh
    Left = 0
    Top = 0
    Width = 1092
    Height = 647
    Align = alClient
    AllowedOperations = []
    AllowedSelections = []
    ColumnDefValues.Title.TitleButton = True
    DataGrouping.GroupLevels = <>
    DataSource = dsoHistory
    EditActions = [geaCopyEh]
    EvenRowColor = clWindow
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
    OptionsEh = [dghFixed3D, dghHighlightFocus, dghAutoSortMarking, dghMultiSortMarking, dghRowHighlight, dghDblClickOptimizeColWidth, dghColumnResize, dghColumnMove, dghExtendVertLines]
    ParentShowHint = False
    ShowHint = True
    SortLocal = True
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
    OnApplyFilter = dbgHistoryApplyFilter
    OnFillSTFilterListValues = dbgHistoryFillSTFilterListValues
    OnKeyDown = dbgHistoryKeyDown
    Columns = <
      item
        DisplayFormat = 'DD.MM.YYYY HH:mm'
        EditButtons = <>
        FieldName = 'DATE_ADD'
        Footers = <>
        TextEditing = False
        Title.Caption = #1044#1072#1090#1072' '#1086#1087#1077#1088#1072#1094#1080#1080
        Title.Hint = #1044#1072#1090#1072' '#1086#1087#1077#1088#1072#1094#1080#1080
        Width = 90
      end
      item
        EditButtons = <>
        FieldName = 'ACTION_'
        Footers = <>
        Title.Caption = #1044#1077#1081#1089#1090#1074#1080#1077
        Width = 80
      end
      item
        EditButtons = <>
        FieldName = 'REF_DESCRIPTOR'
        Footers = <>
        Title.Caption = #1044#1077#1089#1082#1088#1080#1087#1090#1086#1088'/'#1053#1072#1079#1074#1072#1085#1080#1077'/PK '#1086#1073#1098#1077#1082#1090#1072
        Title.Hint = #1044#1077#1089#1082#1088#1080#1087#1090#1086#1088'/'#1053#1072#1079#1074#1072#1085#1080#1077'/PK '#1086#1073#1098#1077#1082#1090#1072
        Width = 180
      end
      item
        EditButtons = <>
        FieldName = 'PK'
        Footers = <>
        Title.Caption = 'PK '#1054#1073#1098#1077#1082#1090#1072
        Title.Hint = 'PK '#1054#1073#1098#1077#1082#1090#1072
        Width = 50
      end
      item
        EditButtons = <>
        FieldName = 'TITLE'
        Footers = <>
        Title.Caption = #1053#1072#1079#1074#1072#1085#1080#1077
        Width = 200
      end
      item
        EditButtons = <>
        FieldName = 'USER_PK'
        Footers = <>
        Title.Caption = 'PK '#1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103
        Title.Hint = 'PK '#1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103
        Width = 50
      end
      item
        EditButtons = <>
        FieldName = 'LOGIN'
        Footers = <>
        Title.Caption = #1051#1086#1075#1080#1085
        Width = 100
      end
      item
        EditButtons = <>
        FieldName = 'NAME'
        Footers = <>
        Title.Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100
        Width = 200
      end
      item
        EditButtons = <>
        FieldName = 'ACTION_DETAIL'
        Footers = <>
        Title.Caption = #1055#1086#1076#1088#1086#1073#1085#1086
        Width = 300
      end>
    object RowDetailData: TRowDetailPanelControlEh
    end
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 647
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
  end
  object ActionList: TActionList
    Images = FMain.ilMain
    Left = 72
    Top = 56
    object AClose: TAction
      Caption = 'AClose'
      ShortCut = 16499
      OnExecute = ACloseExecute
    end
    object AGridOptions: TAction
      Caption = #1053#1072#1089#1090#1088#1086#1080#1090#1100' '#1082#1086#1083#1086#1085#1082#1080
      Hint = #1053#1072#1089#1090#1088#1086#1080#1090#1100' '#1082#1086#1083#1086#1085#1082#1080
      OnExecute = AGridOptionsExecute
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
  object dsoHistory: TDataSource
    DataSet = dsHistory
    Left = 161
    Top = 42
  end
  object pmGrid: TPopupMenu
    Left = 72
    Top = 88
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
  object dsHistory: TpFIBDataSet
    SelectSQL.Strings = (
      'select l.DATE_ADD,'
      
        '  case l.ACTION_ when 0 then '#39#1057#1086#1079#1076#1072#1085#39' when 1 then '#39#1048#1079#1084#1077#1085#1077#1085#39' when' +
        ' 2 then '#39#1053#1072#1082#1072#1090' '#1089#1082#1088#1080#1087#1090#1072' ('#1087#1077#1088#1077#1089#1086#1079#1076#1072#1085')'#39' when 3 then '#39#1059#1076#1072#1083#1077#1085#39' end AC' +
        'TION_,'
      
        '  l.REF_DESCRIPTOR, r.PK, r.TITLE, l.USER_PK, u.LOGIN, u.NAME, l' +
        '.ACTION_DETAIL'
      'from DCFG_REF_LOG l'
      '  left join USERS u on u.PK = l.USER_PK'
      
        '  left join DYNAMIC_FORM_REFERENCE r on r.DESCRIPTOR_ = l.REF_DE' +
        'SCRIPTOR'
      'where l.OBJ_TYPE = :OBJ_TYPE and l.REF_DESCRIPTOR = :DESCRIPTOR'
      'order by l.DATE_ADD desc')
    Transaction = FMain.Transact
    Database = FMain.Database
    Left = 128
    Top = 42
    poAskRecordCount = True
    object dsHistoryDATE_ADD: TFIBDateTimeField
      FieldName = 'DATE_ADD'
    end
    object dsHistoryACTION_: TFIBStringField
      FieldName = 'ACTION_'
      Size = 26
      EmptyStrToNull = True
    end
    object dsHistoryREF_DESCRIPTOR: TFIBStringField
      FieldName = 'REF_DESCRIPTOR'
      Size = 255
      EmptyStrToNull = True
    end
    object dsHistoryPK: TFIBIntegerField
      FieldName = 'PK'
    end
    object dsHistoryTITLE: TFIBStringField
      FieldName = 'TITLE'
      Size = 255
      EmptyStrToNull = True
    end
    object dsHistoryUSER_PK: TFIBIntegerField
      FieldName = 'USER_PK'
    end
    object dsHistoryLOGIN: TFIBStringField
      FieldName = 'LOGIN'
      Size = 25
      EmptyStrToNull = True
    end
    object dsHistoryNAME: TFIBStringField
      FieldName = 'NAME'
      Size = 100
      EmptyStrToNull = True
    end
    object dsHistoryACTION_DETAIL: TFIBStringField
      FieldName = 'ACTION_DETAIL'
      Size = 4096
      EmptyStrToNull = True
    end
  end
end
