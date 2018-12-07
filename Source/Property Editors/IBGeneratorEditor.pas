{*************************************************************}
{                                                             }
{       Borland Delphi Visual Component Library               }
{       InterBase Express core components                     }
{                                                             }
{       Copyright (c) 1998-2002 Borland Software Corporation  }
{                                                             }
{    Additional code created by Jeff Overcash and used        }
{    with permission.                                         }
{*************************************************************}

unit IBGeneratorEditor;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  TfrmGeneratorEditor = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    OKBtn: TButton;
    CancelBtn: TButton;
    cbxGenerators: TComboBox;
    cbxFields: TComboBox;
    grpApplyEvent: TRadioGroup;
    HelpBtn: TButton;
    Label3: TLabel;
    edtIncrement: TEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmGeneratorEditor: TfrmGeneratorEditor;

implementation

{$R *.DFM}

end.
