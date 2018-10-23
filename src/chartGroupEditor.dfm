object FChartGroupEditor: TFChartGroupEditor
  Left = 0
  Top = 0
  Caption = 'FChartGroupEditor'
  ClientHeight = 186
  ClientWidth = 392
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
    392
    186)
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 6
    Top = 7
    Width = 380
    Height = 137
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 0
    DesignSize = (
      380
      137)
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
    object Label10: TLabel
      Left = 15
      Top = 60
      Width = 53
      Height = 13
      Caption = #1047#1072#1075#1086#1083#1086#1074#1086#1082
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 15
      Top = 104
      Width = 73
      Height = 13
      Caption = #1056#1072#1089#1087#1086#1083#1086#1078#1077#1085#1080#1077
    end
    object edPk: TEdit
      Left = 94
      Top = 15
      Width = 70
      Height = 21
      TabStop = False
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 0
    end
    object edTitle: TEdit
      Left = 94
      Top = 57
      Width = 273
      Height = 21
      Hint = 
        #1053#1072#1079#1074#1072#1085#1080#1077' '#1075#1088#1091#1087#1087#1099', '#1082#1086#1090#1086#1088#1086#1077' '#1073#1091#1076#1077#1090' '#1074#1080#1076#1085#1086' '#1074' '#1089#1087#1080#1089#1082#1077' '#1075#1088#1072#1092#1080#1082#1086#1074' '#1087#1088#1080' '#1074#1099#1073#1086#1088 +
        #1077' '#1075#1088#1072#1092#1080#1082#1072
      Anchors = [akLeft, akTop, akRight]
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
    end
    object cbOrientation: TComboBox
      Left = 94
      Top = 101
      Width = 145
      Height = 21
      Hint = 
        #1056#1072#1089#1087#1086#1083#1086#1078#1077#1085#1080#1077' '#1075#1088#1072#1092#1080#1082#1086#1074' '#1074' '#1075#1088#1091#1087#1087#1077' - '#1075#1086#1088#1080#1079#1086#1085#1090#1072#1083#1100#1085#1086#1077' '#1080#1083#1080' '#1074#1077#1088#1090#1080#1082#1072#1083#1100#1085#1086#1077 +
        '.'#13#10#1055#1086#1082#1072' '#1076#1072#1085#1085#1099#1081' '#1087#1072#1088#1072#1084#1077#1090#1088' '#1085#1077' '#1088#1072#1073#1086#1090#1072#1077#1090' '#1080' '#1075#1088#1072#1092#1080#1082#1080' '#1074#1089#1077#1075#1076#1072' '#1088#1072#1089#1087#1086#1083#1072#1075#1072#1102#1090 +
        #1089#1103' '#1074#1077#1088#1090#1080#1082#1072#1083#1100#1085#1086' ('#1089#1074#1077#1088#1093#1091'-'#1074#1085#1080#1079')'
      Style = csDropDownList
      ItemHeight = 13
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      Items.Strings = (
        #1043#1086#1088#1080#1079#1086#1085#1090#1072#1083#1100#1085#1086
        #1042#1077#1088#1090#1080#1082#1072#1083#1100#1085#1086)
    end
  end
  object btnSave: TBitBtn
    Left = 198
    Top = 153
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
    Left = 294
    Top = 153
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
  object ActionList: TActionList
    Left = 152
    Top = 16
    object ASave: TAction
      Caption = 'ASave'
      ShortCut = 16397
      OnExecute = ASaveExecute
    end
  end
end