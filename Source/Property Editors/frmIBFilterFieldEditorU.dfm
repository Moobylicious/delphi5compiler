object frmIBFilterFieldEditor: TfrmIBFilterFieldEditor
  Left = 241
  Top = 111
  BorderStyle = bsDialog
  Caption = 'Filter Field Editor'
  ClientHeight = 256
  ClientWidth = 237
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 64
    Top = 4
    Width = 27
    Height = 13
    Caption = 'Fields'
  end
  object Label2: TLabel
    Left = 60
    Top = 216
    Width = 22
    Height = 13
    Caption = 'Alias'
  end
  object lstFieldList: TListBox
    Left = 0
    Top = 20
    Width = 153
    Height = 193
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ItemHeight = 13
    MultiSelect = True
    ParentFont = False
    TabOrder = 0
    OnClick = lstFieldListClick
  end
  object edtAlias: TEdit
    Left = 4
    Top = 232
    Width = 149
    Height = 21
    Enabled = False
    TabOrder = 1
    OnChange = edtAliasChange
  end
  object btnAdd: TButton
    Left = 160
    Top = 24
    Width = 75
    Height = 25
    Caption = 'Add Fields'
    TabOrder = 2
    OnClick = btnAddClick
  end
  object btnRemove: TButton
    Left = 160
    Top = 56
    Width = 75
    Height = 25
    Caption = 'Remove Fields'
    TabOrder = 3
    OnClick = btnRemoveClick
  end
  object BitBtn1: TBitBtn
    Left = 160
    Top = 224
    Width = 75
    Height = 25
    TabOrder = 4
    Kind = bkCancel
  end
  object BitBtn2: TBitBtn
    Left = 160
    Top = 192
    Width = 75
    Height = 25
    TabOrder = 5
    Kind = bkOK
  end
end
