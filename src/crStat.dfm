object FCrStat: TFCrStat
  Left = 0
  Top = 0
  Caption = 'FCrStat'
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
    00000100200000000000000400000000000000000000000000000000000058B4
    E6105DB9EB705FB9E9BF529ECADF4683AAFF39678ADF32597ABF33658B703570
    9C100000000000000000000000000000000000000000000000000000000055B0
    E2EF5EBBECFF7ECFF1FF5BBEF1FF2D96D4FF0F6293FF15618EFF2C6E9BFF3576
    A5EF439EDBBF3174ABCF2B5D89FF234970CF2C5275BF33658B7035709C1055B0
    E2FF74D3FEFFC2F1FCFFCDFAFFFFBDF6FFFFB7F4FFFF91CFE3FF44A5D6FF3676
    A6FF47A1DBFF2F83C4FF165C9EFF084172FF125685FF2C6E9BFF3576A5EF53AD
    E0FF93E4FBFF8BDBF6FF74C9EFFF65AFD4FF4683AAFF578AA6FF4D7D9BFF356F
    9BFF6AB6E0FF6AACD0FF5B97BEFF65A3C7FF76B6D3FF44A5D6FF3676A6FF48A2
    D5BF54AFE1FF5EBBECFF7ECFF1FF5BBEF1FF2D96D4FF0F6293FF15618EFF2C6E
    9BFF387AA9FF377CB1FF22517FFF305C82FF437291FF6AAFCCFF397EAEFF58B4
    E61058B4E6FF5EBDEEFF61ADD5FF5890B5FF5384A6FF49799BFF538DB1FF3C9D
    D0FF3676A6FF2F83C4FF165C9EFF084172FF135E8BFF2C6E9BFF3779A8FF55B0
    E2EF5EBBECFF7ECFF1FF5BBEF1FF2D96D4FF0F6293FF15618EFF2C6E9BFF387B
    ABFF397EAEFF6AACD0FF5B97BEFF69A7CAFF91CFE3FF44A5D6FF3676A6FF55B0
    E2FF74D3FEFFC2F1FCFFCDFAFFFFBDF6FFFFB7F4FFFF91CFE3FF44A5D6FF3676
    A6FF439CD3FF377CB1FF2F628EFF3E6D90FF5A8AA3FF6AAFCCFF397EAEFF53AE
    E1FF98E8FCFFA7F3FFFFA7F3FFFFA7F3FFFFA7F3FFFFA7F3FFFFA2EEFFFF397E
    AEFF47A1DBFF2F83C4FF165C9EFF0C5788FF15618EFF2C6E9BFF397EADFF48A2
    D5BF55B0DDFF6FCCEEFF7CDEFBFF7CE1FFFF81E6FFFF8EDCF5FF6CBBE5FF4FAB
    DEFF6DBCE5FF6AACD0FF5B97BEFFB3EFFBFF91CFE3FF44A5D6FF3676A6FF0000
    000048A2D53048A2D58048A2D58048A2D58048A2D5804AA5D88A379ADFFF4DB5
    F1FF449FDAFF3C83B6FF4B87ADFF578AA6FF5A8AA3FF6AAFCCFF397EAEFF0000
    000000000000000000000000000000000000000000000000000045A4E0FF4EAF
    EAFF74C5ECFF5BBEF1FF2D96D4FF0F6293FF15618EFF2C6E9BFF397EADFF0000
    000000000000000000000000000000000000000000000000000055B0E2FF74D3
    FEFFC2F1FCFFCDFAFFFFBDF6FFFFB7F4FFFF91CFE3FF44A5D6FF3676A6FF0000
    000000000000000000000000000000000000000000000000000053AEE1FF98E8
    FCFFA7F3FFFFA7F3FFFFA7F3FFFFA7F3FFFFA7F3FFFFA2EEFFFF397EAEFF0000
    000000000000000000000000000000000000000000000000000048A2D5BF55B0
    DDFF6FCCEEFF7CDEFBFF7CE1FFFF81E6FFFF8EDCF5FF6CBBE5FF48A2D5BF0000
    00000000000000000000000000000000000000000000000000000000000048A2
    D53048A2D58048A2D58048A2D58048A2D58048A2D58048A2D53000000000007F
    0000000000000000000000000000000000000000000000000000000000000000
    00000000000080000000FE000000FE000000FE000000FE000000FF010000}
  OldCreateOrder = False
  Visible = True
  OnActivate = FormActivate
  OnClose = FormClose
  OnDestroy = FormDestroy
  OnDeactivate = FormDeactivate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
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
    TabOrder = 1
    object Label1: TLabel
      Left = 0
      Top = 0
      Width = 63
      Height = 22
      Caption = '  '#1055#1077#1088#1080#1086#1076', '#1089': '
      Layout = tlCenter
    end
    object edDateFrom: TDateTimePicker
      Left = 63
      Top = 0
      Width = 82
      Height = 22
      Date = 42700.513670011580000000
      Time = 42700.513670011580000000
      TabOrder = 0
    end
    object Label2: TLabel
      Left = 145
      Top = 0
      Width = 22
      Height = 22
      Caption = ' '#1087#1086': '
      Layout = tlCenter
    end
    object edDateTo: TDateTimePicker
      Left = 167
      Top = 0
      Width = 82
      Height = 22
      Date = 42700.513725347220000000
      Time = 42700.513725347220000000
      TabOrder = 1
    end
    object ToolButton1: TToolButton
      Left = 249
      Top = 0
      Width = 8
      Caption = 'ToolButton1'
      ImageIndex = 22
      Style = tbsSeparator
    end
    object ToolButton7: TToolButton
      Left = 257
      Top = 0
      Action = ARefresh
    end
  end
  object dbgCrTask: TDBGridEh
    Left = 0
    Top = 22
    Width = 822
    Height = 504
    Align = alClient
    AllowedOperations = []
    AllowedSelections = []
    ColumnDefValues.Title.TitleButton = True
    DataGrouping.GroupLevels = <>
    DataSource = dsoCrTask
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
    EmptyDataInfo.Active = True
    EmptyDataInfo.Text = #1063#1058#1054'-'#1058#1054' '#1053#1045' '#1058#1040#1050'? '#1055#1086#1076#1091#1084#1072#1081'! '#1052#1086#1078#1077#1090' '#1090#1099' '#1087#1086#1076#1082#1083#1102#1095#1077#1085' '#1085#1077' '#1082' '#1090#1086#1081' '#1073#1072#1079#1077' '#1076#1072#1085#1085#1099#1093'?'
    OptionsEh = [dghFixed3D, dghHighlightFocus, dghRowHighlight, dghDblClickOptimizeColWidth, dghColumnResize, dghColumnMove, dghExtendVertLines]
    ParentShowHint = False
    ShowHint = True
    STFilter.InstantApply = True
    STFilter.Location = stflInTitleFilterEh
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnGetCellParams = dbgCrTaskGetCellParams
    Columns = <
      item
        EditButtons = <>
        FieldName = 'NAME'
        Footers = <>
        Title.Caption = #1055#1088#1086#1077#1082#1090
        Title.Hint = #1053#1072#1079#1074#1072#1085#1080#1077' '#1087#1088#1086#1077#1082#1090#1072
        Width = 400
      end
      item
        EditButtons = <>
        FieldName = 'AVG_EVALUATE'
        Footers = <>
        Title.Caption = #1054#1094#1077#1085#1082#1072
        Title.Hint = #1057#1088#1077#1076#1085#1103#1103' '#1086#1094#1077#1085#1082#1072' '#1079#1072' '#1082#1072#1095#1077#1089#1090#1074#1086' '#1074#1099#1087#1086#1083#1085#1077#1085#1080#1103
        Width = 40
      end
      item
        DisplayFormat = ',0.###'
        EditButtons = <>
        FieldName = 'DIFF_PLAN_FACT'
        Footers = <>
        Title.Caption = #1050#1072#1095'-'#1074#1086
        Title.Hint = 
          #1057#1088#1077#1076#1085#1077#1077' '#1082#1072#1095#1077#1089#1090#1074#1086' '#1087#1083#1072#1085#1080#1088#1086#1074#1072#1085#1080#1103' '#1088#1072#1073#1086#1095#1077#1075#1086' '#1074#1088#1077#1084#1077#1085#1080#13#10#1052#1086#1076#1091#1083#1100'('#1063#1072#1089#1099' '#1087#1083#1072#1085 +
          ' / '#1095#1072#1089#1099' '#1092#1072#1082#1090')'
        Width = 40
      end
      item
        EditButtons = <>
        FieldName = 'CNT_REQ'
        Footers = <>
        Title.Caption = #1047#1072#1087#1088#1086#1089#1086#1074
        Title.Hint = #1054#1073#1097#1077#1077' '#1082#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1079#1072#1087#1088#1086#1089#1086#1074
        Width = 50
      end
      item
        EditButtons = <>
        FieldName = 'HOURS'
        Footers = <>
        Title.Caption = #1063#1072#1089#1086#1074
        Title.Hint = #1057#1091#1084#1084#1072' '#1079#1072#1090#1088#1072#1095#1077#1085#1085#1099#1093' '#1095#1072#1089#1086#1074
        Width = 50
      end
      item
        EditButtons = <>
        FieldName = 'CNT_PROJ'
        Footers = <>
        Title.Caption = #1055#1088#1086#1077#1082#1090#1086#1074
        Title.Hint = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1072#1082#1090#1080#1074#1085#1099#1093' '#1087#1088#1086#1077#1082#1090#1086#1074', '#1075#1076#1077' '#1090#1099' '#1074#1077#1076#1091#1097#1080#1081' '#1088#1072#1079#1088#1072#1073#1086#1090#1095#1080#1082
        Width = 52
      end
      item
        EditButtons = <>
        FieldName = 'OVERDUE'
        Footers = <>
        Title.Caption = #1055#1088#1086#1089#1088#1086#1095#1077#1085#1086
        Title.Hint = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1087#1088#1086#1089#1088#1086#1095#1077#1085#1085#1099#1093' '#1079#1072#1087#1088#1086#1089#1086#1074
      end>
    object RowDetailData: TRowDetailPanelControlEh
    end
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
    object ARefresh: TAction
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100
      Hint = #1054#1073#1085#1086#1074#1080#1090#1100
      ImageIndex = 21
      ShortCut = 116
      OnExecute = ARefreshExecute
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
  object dsCrTask: TpFIBDataSet
    SelectSQL.Strings = (
      
        'select NUM, NAME, PROJ_PK, AVG_EVALUATE, DIFF_PLAN_FACT, HOURS, ' +
        'CNT_REQ, CNT_PROJ, OVERDUE from ('
      
        '  select 0 NUM, p.NAME, p.PK PROJ_PK, sum(c.FACTHOURS) HOURS, av' +
        'g(c.EVALUATE) AVG_EVALUATE,'
      
        '    cast(abs(sum(c.FACTHOURS) - sum(c.PLANHOURS)) as double prec' +
        'ision) / sum(c.PLANHOURS) DIFF_PLAN_FACT,'
      '    count(c.PK) CNT_REQ, null CNT_PROJ, null OVERDUE'
      '  from CR c'
      '    left join PROJECTS p on p.PK = c.NEW_PROJECT'
      
        '  where c.STATUS = 3 and c.INTERNALTYPE = '#39'3'#39' and c.EXECUTOR = :' +
        'USER_PK and'
      
        '    ((c.UPDATED between :DateBegin and :DateEnd and c.I_PK is no' +
        't null) or'
      
        '    (c.ADDED between :DateBegin and :DateEnd and c.I_PK is null)' +
        ')'
      '  group by c.EXECUTOR, NAME, PROJ_PK'
      '  union'
      
        '  select 1 NUM, '#39#1042#1089#1077#1075#1086#39' NAME, null PROJ_PK, sum(c.FACTHOURS) HOU' +
        'RS, avg(c.EVALUATE) AVG_EVALUATE,'
      
        '    cast(abs(sum(c.FACTHOURS) - sum(c.PLANHOURS)) as double prec' +
        'ision) / sum(c.PLANHOURS) DIFF_PLAN_FACT,'
      
        '    count(c.PK) CNT_REQ, (select count(PK) from PROJECTS where P' +
        'ROJECT_LEADER = :USER_PK and STATUS = 1) CNT_PROJ,'
      
        '    (select (OPER_OVERDUE + HIGH_OVERDUE + AVERAGE_OVERDUE + LOW' +
        '_OVERDUE) from OART_CR_DELAY where USER_PK = :USER_PK) OVERDUE'
      '  from CR c'
      '    left join PROJECTS p on p.PK = c.NEW_PROJECT'
      
        '  where c.STATUS = 3 and c.INTERNALTYPE = '#39'3'#39' and c.EXECUTOR = :' +
        'USER_PK and'
      
        '    ((c.UPDATED between :DateBegin and :DateEnd and c.I_PK is no' +
        't null) or'
      
        '    (c.ADDED between :DateBegin and :DateEnd and c.I_PK is null)' +
        ')'
      '  union'
      
        '  select 2 NUM, '#39#1053#1091#1078#1085#1086#39' NAME, null PROJ_PK, TOTAL HOURS, 10 AVG_' +
        'EVALUATE, 0.2 DIFF_PLAN_FACT, 72 CNT_REQ, 6 CNT_PROJ, 0 OVERDUE'
      '  from RAO_WORK_TIME'
      
        '  where USER_PK = :USER_PK and MONTH_NUM = extract(month from ca' +
        'st(:DateBegin as timestamp)) - 1 and'
      
        '    YEAR_NUM = extract(year from cast(:DateBegin as timestamp)) ' +
        ')'
      'order by 1, 2')
    Transaction = FMain.Transact
    Database = FMain.Database
    Left = 176
    Top = 82
    oFetchAll = True
    object dsCrTaskNUM: TFIBIntegerField
      FieldName = 'NUM'
    end
    object dsCrTaskNAME: TFIBStringField
      FieldName = 'NAME'
      Size = 255
      EmptyStrToNull = True
    end
    object dsCrTaskAVG_EVALUATE: TFIBBCDField
      FieldName = 'AVG_EVALUATE'
      Size = 0
      RoundByScale = True
    end
    object dsCrTaskDIFF_PLAN_FACT: TFIBFloatField
      FieldName = 'DIFF_PLAN_FACT'
    end
    object dsCrTaskHOURS: TFIBFloatField
      FieldName = 'HOURS'
    end
    object dsCrTaskCNT_REQ: TFIBIntegerField
      FieldName = 'CNT_REQ'
    end
    object dsCrTaskCNT_PROJ: TFIBIntegerField
      FieldName = 'CNT_PROJ'
    end
    object dsCrTaskOVERDUE: TFIBBCDField
      FieldName = 'OVERDUE'
      Size = 0
      RoundByScale = True
    end
    object dsCrTaskPROJ_PK: TFIBIntegerField
      FieldName = 'PROJ_PK'
    end
  end
  object dsoCrTask: TDataSource
    DataSet = mtCrTask
    Left = 208
    Top = 40
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
  object dsWorkTime: TpFIBDataSet
    SelectSQL.Strings = (
      'select TOTAL HOURS'
      'from RAO_WORK_TIME'
      
        'where USER_PK = :USER_PK and MONTH_NUM = extract(month from cast' +
        '(:DateBegin as timestamp)) - 1 and'
      '  YEAR_NUM = extract(year from cast(:DateBegin as timestamp))')
    Transaction = FMain.Transact
    Database = FMain.Database
    Left = 208
    Top = 82
    oFetchAll = True
    object dsWorkTimeHOURS: TFIBFloatField
      FieldName = 'HOURS'
    end
  end
  object mtCrTask: TMemTableEh
    Params = <>
    Left = 176
    Top = 40
    object mtCrTaskNUM: TIntegerField
      FieldName = 'NUM'
    end
    object mtCrTaskNAME: TStringField
      FieldName = 'NAME'
      Size = 255
    end
    object mtCrTaskAVG_EVALUATE: TIntegerField
      FieldName = 'AVG_EVALUATE'
    end
    object mtCrTaskDIFF_PLAN_FACT: TFloatField
      FieldName = 'DIFF_PLAN_FACT'
    end
    object mtCrTaskHOURS: TIntegerField
      FieldName = 'HOURS'
    end
    object mtCrTaskCNT_REQ: TIntegerField
      FieldName = 'CNT_REQ'
    end
    object mtCrTaskCNT_PROJ: TIntegerField
      FieldName = 'CNT_PROJ'
    end
    object mtCrTaskOVERDUE: TIntegerField
      FieldName = 'OVERDUE'
    end
    object mtCrTaskPROJ_PK: TIntegerField
      FieldName = 'PROJ_PK'
    end
  end
  object dsOverdueReq: TpFIBDataSet
    SelectSQL.Strings = (
      'select count(i.PK) CNT, r.PROJECT'
      'from PROJECTS p'
      '  join I_MAIN_REGISTER r on r.PROJECT = p.PK'
      
        '  join I_RQ_WORK i on i.I_PK = r.PK and i.EXECUTOR = p.PROJECT_L' +
        'EADER'
      '  join CR on CR.I_PK = i.PK'
      'where p.PROJECT_LEADER = :USER_PK'
      '  and i.STATUS in (32, 45, 29, 42, 30, 43, 31, 44)'
      
        '  and ((CR.STATUS = 3 and cast(i.DEADLINE as date) < cast(CR.UPD' +
        'ATED as date))'
      
        '  or (cr.STATUS in (0, 1, 2) and cast(i.DEADLINE as date) < curr' +
        'ent_date))'
      'group by r.PROJECT')
    Transaction = FMain.Transact
    Database = FMain.Database
    Left = 240
    Top = 82
    oFetchAll = True
    object dsOverdueReqCNT: TFIBIntegerField
      FieldName = 'CNT'
    end
    object dsOverdueReqPROJECT: TFIBIntegerField
      FieldName = 'PROJECT'
    end
  end
end
