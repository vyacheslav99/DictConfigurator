object FGroups: TFGroups
  Left = 0
  Top = 0
  Caption = 'FGroups'
  ClientHeight = 526
  ClientWidth = 822
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
    00000000000000000000000000000000000000000000000000001B198EFF1916
    8DFF19168DFF19168DFF19168DFF19158DFF0000000000000000000000000000
    0000000000000000000000000000000000000000000024258DFFA4B6F8FF9FB3
    F8FF7B7FF8FF6F7AF6FF6D79F6FF6D79F6FF1B178DFF00000000000000000000
    000000000000000000009B651CFF955F1AFF282C98FFBEDDFBFFA7B9F9FFA2B4
    F8FF9FB2F8FF6F7AF7FF6D79F6FF6D79F6FF6D79F6FF19158DFF000000000000
    000000000000A16820FFFFD344FFFFCE45FF272A9EFFC2E0FBFFC0DDFBFFA7BA
    FAFFA5B9FAFFA5B9FAFF6D79F7FF6D79F6FF6D79F6FF19168DFF000000000000
    0000A46B21FFFFF3EAFFFFE6B5FFFDD049FF272AA2FFC7E1FBFFC4E0FBFFC2DB
    FAFFAECAFAFFABC8FBFFAAC8FAFF6D79F7FF6D79F6FF1A178DFF000000000000
    0000A66D21FFFEF6EAFFFFEDB5FFFEE6B2FFD5AA51FF272AA2FFC8E1F8FFC4DE
    F8FFC3DAF9FFBAD2F9FFACCBF9FF6D79F5FF1E1D8EFF00000000000000000000
    0000A66D21FFFEF9EBFFFFEFB5FFFEEBB4FFFCE9B2FFD1A555FF2A2DA2FF3128
    ECFF252697FF222391FF3022EBFF1F1F8FFF0000000000000000000000000000
    000000000000A66D21FFFFF3E9FFFFE9B4FFFEE6B4FFFAE9AFFFC9A555FF282A
    9CFFAABCF7FF6D79F5FF202091FF000000000000000000000000000000000000
    00000000000000000000A66D21FFFFCF1FFFA66D23FFAC6C25FF272AA2FFC1DA
    FAFFAECAFAFFA9BBFAFF6D79F9FF201F92FF0000000000000000000000000000
    0000000000000000000000000000A66D21FFFFD342FFFCCF47FF272A9EFFC3DE
    FBFFBEDBFCFFAECAFBFFAABBFBFF202093FF0000000000000000000000000000
    00000000000000000000A66D21FFFFF5E3FFFFEACBFFFDD449FFD7BF49FF272A
    9EFFC1DFFCFFBDDBFCFF212294FF000000000000000000000000000000000000
    00000000000000000000A66D21FFFEF9E5FFFFF3D0FFFEECCBFFFCD344FF9767
    34FF272A9EFF25279AFF00000000000000000000000000000000000000000000
    0000000000000000000000000000A66D21FFFEF9E5FFFFF5E3FFA46B23FF0000
    0000000000000000000000000000000000000000000000000000000000000000
    000000000000000000000000000000000000A66D21FFA66D21FF000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    000000000000000000000000000000000000000000000000000000000000FFFF
    0000FE070000FC030000E0010000C0010000800100008003000080070000C00F
    0000E0070000F0070000E00F0000E01F0000F0FF0000F9FF0000FFFF0000}
  OldCreateOrder = False
  Visible = True
  OnActivate = FormActivate
  OnClose = FormClose
  OnDeactivate = FormDeactivate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 230
    Top = 22
    Width = 5
    Height = 485
    ExplicitLeft = 215
    ExplicitHeight = 471
  end
  object ToolBar: TToolBar
    Left = 0
    Top = 0
    Width = 822
    Height = 22
    Caption = 'ToolBar'
    DrawingStyle = dsGradient
    Flat = False
    Images = FMain.ilMain
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    object ToolButton7: TToolButton
      Left = 0
      Top = 0
      Action = ARefresh
    end
    object ToolButton8: TToolButton
      Left = 23
      Top = 0
      Width = 8
      Caption = 'ToolButton8'
      ImageIndex = 22
      Style = tbsSeparator
    end
    object ToolButton1: TToolButton
      Left = 31
      Top = 0
      Action = AAddGroup
    end
    object ToolButton3: TToolButton
      Left = 54
      Top = 0
      Action = ADelGroup
    end
    object ToolButton2: TToolButton
      Left = 77
      Top = 0
      Action = ALinkUser
    end
    object ToolButton9: TToolButton
      Left = 100
      Top = 0
      Action = AUnlinkUser
    end
    object ToolButton4: TToolButton
      Left = 123
      Top = 0
      Width = 8
      Caption = 'ToolButton4'
      ImageIndex = 8
      Style = tbsSeparator
    end
    object ToolButton5: TToolButton
      Left = 131
      Top = 0
      Action = ACommitChanges
    end
    object ToolButton6: TToolButton
      Left = 154
      Top = 0
      Action = ARollbackChanges
    end
  end
  object dbgUserGroups: TDBGridEh
    Left = 0
    Top = 22
    Width = 230
    Height = 485
    Align = alLeft
    AllowedSelections = []
    ColumnDefValues.Title.TitleButton = True
    DataGrouping.GroupLevels = <>
    DataSource = dsoGroups
    EditActions = [geaCutEh, geaCopyEh, geaPasteEh, geaDeleteEh, geaSelectAllEh]
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
    OptionsEh = [dghFixed3D, dghHighlightFocus, dghAutoSortMarking, dghMultiSortMarking, dghRowHighlight, dghDblClickOptimizeColWidth, dghDialogFind, dghColumnResize, dghColumnMove, dghExtendVertLines]
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
        Width = 160
      end>
    object RowDetailData: TRowDetailPanelControlEh
    end
  end
  object dbgUsers: TDBGridEh
    Left = 235
    Top = 22
    Width = 587
    Height = 485
    Align = alClient
    AllowedOperations = []
    AllowedSelections = []
    ColumnDefValues.Title.TitleButton = True
    DataGrouping.GroupLevels = <>
    DataSource = dsoGroupUsers
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
    OptionsEh = [dghFixed3D, dghHighlightFocus, dghAutoSortMarking, dghMultiSortMarking, dghPreferIncSearch, dghRowHighlight, dghDblClickOptimizeColWidth, dghDialogFind, dghColumnResize, dghColumnMove, dghExtendVertLines]
    ParentShowHint = False
    ShowHint = True
    STFilter.InstantApply = False
    STFilter.Location = stflInTitleFilterEh
    TabOrder = 1
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
      end>
    object RowDetailData: TRowDetailPanelControlEh
    end
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 507
    Width = 822
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
    object AAddGroup: TAction
      Caption = #1057#1086#1079#1076#1072#1090#1100' '#1075#1088#1091#1087#1087#1091
      Hint = #1057#1086#1079#1076#1072#1090#1100' '#1075#1088#1091#1087#1087#1091' (Ins)'
      ImageIndex = 5
      OnExecute = AAddGroupExecute
      OnUpdate = AAddGroupUpdate
    end
    object ADelGroup: TAction
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1075#1088#1091#1087#1087#1091
      Hint = #1059#1076#1072#1083#1080#1090#1100' '#1075#1088#1091#1087#1087#1091' (Ctrl+Del)'
      ImageIndex = 7
      OnExecute = ADelGroupExecute
      OnUpdate = ADelGroupUpdate
    end
    object ACommitChanges: TAction
      Caption = #1047#1072#1092#1080#1082#1089#1080#1088#1086#1074#1072#1090#1100' '#1090#1088#1072#1085#1079#1072#1082#1094#1080#1102
      Hint = #1047#1072#1092#1080#1082#1089#1080#1088#1086#1074#1072#1090#1100' '#1090#1088#1072#1085#1079#1072#1082#1094#1080#1102
      ImageIndex = 30
      ShortCut = 16397
      OnExecute = ACommitChangesExecute
      OnUpdate = ACommitChangesUpdate
    end
    object ARollbackChanges: TAction
      Caption = #1054#1090#1082#1072#1090#1080#1090#1100' '#1090#1088#1072#1085#1079#1072#1082#1094#1080#1102
      Hint = #1054#1090#1082#1072#1090#1080#1090#1100' '#1090#1088#1072#1085#1079#1072#1082#1094#1080#1102
      ImageIndex = 29
      ShortCut = 49234
      OnExecute = ARollbackChangesExecute
      OnUpdate = ACommitChangesUpdate
    end
    object ARefresh: TAction
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100
      Hint = #1054#1073#1085#1086#1074#1080#1090#1100
      ImageIndex = 21
      ShortCut = 116
      OnExecute = ARefreshExecute
    end
    object ALinkUser: TAction
      Caption = #1055#1088#1080#1074#1103#1079#1072#1090#1100' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103
      Hint = #1055#1088#1080#1074#1103#1079#1072#1090#1100' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103
      ImageIndex = 23
      OnExecute = ALinkUserExecute
      OnUpdate = ADelGroupUpdate
    end
    object AUnlinkUser: TAction
      Caption = #1054#1090#1074#1103#1079#1072#1090#1100' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103
      Hint = #1054#1090#1074#1103#1079#1072#1090#1100' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103
      ImageIndex = 24
      OnExecute = AUnlinkUserExecute
      OnUpdate = AUnlinkUserUpdate
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
  object dsGroups: TpFIBDataSet
    UpdateSQL.Strings = (
      'update USER_GROUPS set NAME = :NAME'
      'where PK = :PK')
    DeleteSQL.Strings = (
      'delete from USER_GROUPS where PK = :PK')
    InsertSQL.Strings = (
      'insert into USER_GROUPS (PK, NAME) values (:PK, :NAME)')
    RefreshSQL.Strings = (
      'select PK, NAME from USER_GROUPS'
      'where PK = :PK')
    SelectSQL.Strings = (
      'select PK, NAME from USER_GROUPS'
      'order by PK')
    AfterClose = dsGroupsAfterClose
    Transaction = FMain.Transact
    Database = FMain.Database
    OnEndScroll = dsGroupsEndScroll
    Left = 128
    Top = 42
    oFetchAll = True
    object dsGroupsPK: TFIBIntegerField
      FieldName = 'PK'
    end
    object dsGroupsNAME: TFIBStringField
      FieldName = 'NAME'
      Size = 255
      EmptyStrToNull = True
    end
  end
  object dsoGroups: TDataSource
    DataSet = dsGroups
    Left = 160
    Top = 42
  end
  object dsGroupUsers: TpFIBDataSet
    SelectSQL.Strings = (
      
        'select u.PK, u.LOGIN, u.NAME, u.ISACTIVE, u.ROLE_PK, r.NAME ROLE' +
        '_NAME, u.DEVELOPER, u.MODERATOR,'
      '  g.PK GROUP_PK'
      'from USER_GROUPS g'
      '  join USERS_USER_GROUPS uug on uug.GROUP_PK = g.PK'
      '  join USERS u on u.PK = uug.USER_PK'
      '  left join ROLES r on r.PK = u.ROLE_PK'
      'where g.PK = :PK'
      'order by u.NAME')
    Transaction = FMain.Transact
    Database = FMain.Database
    Left = 128
    Top = 82
    poAskRecordCount = True
    object dsGroupUsersPK: TFIBIntegerField
      FieldName = 'PK'
    end
    object dsGroupUsersLOGIN: TFIBStringField
      FieldName = 'LOGIN'
      Size = 25
      EmptyStrToNull = True
    end
    object dsGroupUsersNAME: TFIBStringField
      FieldName = 'NAME'
      Size = 100
      EmptyStrToNull = True
    end
    object dsGroupUsersISACTIVE: TFIBStringField
      FieldName = 'ISACTIVE'
      Size = 1
      EmptyStrToNull = True
    end
    object dsGroupUsersROLE_PK: TFIBIntegerField
      FieldName = 'ROLE_PK'
    end
    object dsGroupUsersROLE_NAME: TFIBStringField
      FieldName = 'ROLE_NAME'
      Size = 255
      EmptyStrToNull = True
    end
    object dsGroupUsersDEVELOPER: TFIBStringField
      FieldName = 'DEVELOPER'
      Size = 1
      EmptyStrToNull = True
    end
    object dsGroupUsersMODERATOR: TFIBStringField
      FieldName = 'MODERATOR'
      Size = 1
      EmptyStrToNull = True
    end
    object dsGroupUsersGROUP_PK: TFIBIntegerField
      FieldName = 'GROUP_PK'
    end
  end
  object dsoGroupUsers: TDataSource
    DataSet = dsGroupUsers
    Left = 160
    Top = 82
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
end
