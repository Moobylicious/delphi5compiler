object IBConnectionBrokerEditForm: TIBConnectionBrokerEditForm
  Left = 487
  Top = 125
  BorderStyle = bsDialog
  BorderWidth = 5
  Caption = 'Database Component Editor'
  ClientHeight = 306
  ClientWidth = 332
  Color = clBtnFace
  ParentFont = True
  HelpFile = 'ibx.hlp'
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 270
    Width = 332
    Height = 36
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    object OKBtn: TButton
      Left = 8
      Top = 7
      Width = 75
      Height = 24
      Caption = 'OK'
      Default = True
      ModalResult = 1
      TabOrder = 0
    end
    object CancelBtn: TButton
      Left = 89
      Top = 7
      Width = 74
      Height = 24
      Cancel = True
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 1
    end
    object HelpBtn: TButton
      Left = 250
      Top = 7
      Width = 75
      Height = 24
      Caption = '&Help'
      TabOrder = 3
      Visible = False
    end
    object Test: TButton
      Left = 169
      Top = 6
      Width = 75
      Height = 25
      Caption = '&Test'
      TabOrder = 2
      OnClick = TestClick
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 0
    Width = 332
    Height = 97
    Align = alTop
    Caption = 'Connection'
    TabOrder = 0
    object Label1: TLabel
      Left = 24
      Top = 51
      Width = 49
      Height = 13
      Caption = '&Database:'
    end
    object Label7: TLabel
      Left = 24
      Top = 17
      Width = 34
      Height = 13
      Caption = '&Server:'
    end
    object Label8: TLabel
      Left = 225
      Top = 17
      Width = 42
      Height = 13
      Caption = '&Protocol:'
    end
    object ServerName: TEdit
      Left = 24
      Top = 30
      Width = 189
      Height = 21
      TabOrder = 0
    end
    object Protocol: TComboBox
      Left = 224
      Top = 30
      Width = 93
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 1
      Items.Strings = (
        'TCP'
        'NamedPipe'
        'SPX')
    end
    object DatabaseName: TEdit
      Left = 24
      Top = 64
      Width = 294
      Height = 21
      TabOrder = 2
    end
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 97
    Width = 332
    Height = 173
    Align = alClient
    Caption = 'Database Parameters'
    TabOrder = 1
    object Label2: TLabel
      Left = 24
      Top = 18
      Width = 56
      Height = 13
      Caption = '&User Name:'
      FocusControl = UserName
    end
    object Label3: TLabel
      Left = 24
      Top = 53
      Width = 49
      Height = 13
      Caption = 'Pass&word:'
      FocusControl = Password
    end
    object Label4: TLabel
      Left = 24
      Top = 89
      Width = 46
      Height = 13
      Caption = 'S&QLRole:'
      FocusControl = SQLRole
    end
    object Label5: TLabel
      Left = 136
      Top = 19
      Width = 41
      Height = 13
      Caption = 'Se&ttings:'
      FocusControl = DatabaseParams
    end
    object Label6: TLabel
      Left = 24
      Top = 123
      Width = 68
      Height = 13
      Caption = '&Character Set:'
      FocusControl = CharacterSet
    end
    object UserName: TEdit
      Left = 24
      Top = 32
      Width = 94
      Height = 21
      TabOrder = 0
      OnChange = UserNameChange
      OnExit = UserNameChange
    end
    object Password: TEdit
      Left = 24
      Top = 67
      Width = 94
      Height = 21
      TabOrder = 1
      OnChange = PasswordChange
      OnExit = PasswordChange
    end
    object SQLRole: TEdit
      Left = 24
      Top = 102
      Width = 94
      Height = 21
      TabOrder = 2
      OnChange = SQLRoleChange
      OnExit = SQLRoleChange
    end
    object DatabaseParams: TMemo
      Left = 136
      Top = 33
      Width = 183
      Height = 124
      TabOrder = 4
    end
    object CharacterSet: TComboBox
      Left = 24
      Top = 137
      Width = 94
      Height = 21
      ItemHeight = 13
      TabOrder = 3
      Text = 'None'
      OnExit = CharacterSetChange
      Items.Strings = (
        'None'
        'ASCII'
        'BIG_5'
        'CYRL'
        'DOS437'
        'DOS850'
        'DOS852'
        'DOS857'
        'DOS860'
        'DOS861'
        'DOS863'
        'DOS865'
        'EUCJ_0208'
        'GB_2312'
        'ISO8859_1'
        'KSC_5601'
        'NEXT'
        'OCTETS'
        'SJIS_0208'
        'UNICODE_FSS'
        'WIN1250'
        'WIN1251'
        'WIN1252'
        'WIN1253'
        'WIN1254')
    end
  end
end
