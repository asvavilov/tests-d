object frmTest: TfrmTest
  Left = 213
  Top = 106
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1058#1077#1089#1090#1080#1088#1086#1074#1072#1085#1080#1077
  ClientHeight = 453
  ClientWidth = 632
  Color = clSkyBlue
  Constraints.MinHeight = 480
  Constraints.MinWidth = 640
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Courier New'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 18
  object lcurQ: TLabel
    Left = 320
    Top = 0
    Width = 305
    Height = 17
    AutoSize = False
    Caption = #1058#1077#1082#1091#1097#1080#1081' '#1074#1086#1087#1088#1086#1089
  end
  object pic: TImage
    Left = 320
    Top = 88
    Width = 305
    Height = 305
    Center = True
    Proportional = True
    Stretch = True
    Transparent = True
  end
  object Panel1: TPanel
    Left = 0
    Top = 412
    Width = 632
    Height = 41
    Align = alBottom
    BevelInner = bvLowered
    Color = clGray
    TabOrder = 1
    object splitter: TShape
      Left = 312
      Top = 0
      Width = 9
      Height = 41
    end
    object okey: TBitBtn
      Left = 8
      Top = 8
      Width = 137
      Height = 25
      Caption = #1043#1086#1090#1086#1074#1086
      Default = True
      TabOrder = 0
      OnClick = okeyClick
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333330000333333333333333333333333F33333333333
        00003333344333333333333333388F3333333333000033334224333333333333
        338338F3333333330000333422224333333333333833338F3333333300003342
        222224333333333383333338F3333333000034222A22224333333338F338F333
        8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
        33333338F83338F338F33333000033A33333A222433333338333338F338F3333
        0000333333333A222433333333333338F338F33300003333333333A222433333
        333333338F338F33000033333333333A222433333333333338F338F300003333
        33333333A222433333333333338F338F00003333333333333A22433333333333
        3338F38F000033333333333333A223333333333333338F830000333333333333
        333A333333333333333338330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
    end
    object nextQ: TBitBtn
      Left = 160
      Top = 8
      Width = 137
      Height = 25
      Caption = #1055#1088#1086#1087#1091#1089#1090#1080#1090#1100
      TabOrder = 1
      OnClick = nextQClick
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00344446333334
        44433333FFFF333333FFFF33000033AAA43333332A4333338833F33333883F33
        00003332A46333332A4333333383F33333383F3300003332A2433336A6633333
        33833F333383F33300003333AA463362A433333333383F333833F33300003333
        6AA4462A46333333333833FF833F33330000333332AA22246333333333338333
        33F3333300003333336AAA22646333333333383333F8FF33000033444466AA43
        6A43333338FFF8833F383F330000336AA246A2436A43333338833F833F383F33
        000033336A24AA442A433333333833F33FF83F330000333333A2AA2AA4333333
        333383333333F3330000333333322AAA4333333333333833333F333300003333
        333322A4333333333333338333F333330000333333344A433333333333333338
        3F333333000033333336A24333333333333333833F333333000033333336AA43
        33333333333333833F3333330000333333336663333333333333333888333333
        0000}
      NumGlyphs = 2
    end
  end
  object pVariants: TPanel
    Left = 8
    Top = 0
    Width = 305
    Height = 393
    BevelInner = bvLowered
    BorderStyle = bsSingle
    Color = clWhite
    ParentBackground = False
    TabOrder = 0
  end
  object query: TMemo
    Left = 320
    Top = 16
    Width = 305
    Height = 65
    BevelInner = bvNone
    BevelOuter = bvNone
    Color = clCream
    ReadOnly = True
    TabOrder = 2
  end
  object toEnd: TTimer
    Enabled = False
    OnTimer = toEndTimer
  end
end
