object MainForm: TMainForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Language Changer - Alpha'
  ClientHeight = 143
  ClientWidth = 351
  Color = clWindowFrame
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnMouseEnter = FormMouseEnter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 16
  object UserNameLbl: TLabel
    Left = 8
    Top = 15
    Width = 91
    Height = 24
    Caption = 'UserName:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -20
    Font.Name = 'Calibri Light'
    Font.Style = []
    ParentFont = False
  end
  object LanguageLbl: TLabel
    Left = 8
    Top = 56
    Width = 79
    Height = 24
    Caption = 'Language:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -20
    Font.Name = 'Calibri Light'
    Font.Style = []
    ParentFont = False
  end
  object ApplyBtn: TButton
    Left = 105
    Top = 103
    Width = 231
    Height = 34
    Hint = 'Apply the current selected Language'
    Caption = 'Apply'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    OnClick = ApplyBtnClick
  end
  object AboutBtn: TButton
    Left = 8
    Top = 103
    Width = 91
    Height = 34
    Caption = 'About Us'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    OnClick = AboutBtnClick
  end
  object LanguageCb: TComboBox
    Left = 105
    Top = 57
    Width = 231
    Height = 26
    Style = csDropDownList
    Color = clWindowFrame
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clHighlightText
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
  end
  object UserNameEdit: TEdit
    Left = 105
    Top = 16
    Width = 231
    Height = 26
    Color = clWindowFrame
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
  end
end
