object frmIBAvailableFields: TfrmIBAvailableFields
  Left = 485
  Top = 111
  BorderStyle = bsDialog
  Caption = 'Available Fields'
  ClientHeight = 273
  ClientWidth = 204
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 185
    Height = 225
    Caption = 'Fields'
    TabOrder = 0
    object lstFields: TListBox
      Left = 8
      Top = 20
      Width = 169
      Height = 197
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ItemHeight = 13
      MultiSelect = True
      ParentFont = False
      TabOrder = 0
    end
  end
  object BitBtn1: TBitBtn
    Left = 22
    Top = 240
    Width = 75
    Height = 25
    TabOrder = 1
    Kind = bkOK
  end
  object BitBtn2: TBitBtn
    Left = 106
    Top = 240
    Width = 75
    Height = 25
    TabOrder = 2
    Kind = bkCancel
  end
end
