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

unit frmIBAvailableFieldsU;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, IBCustomDataset;

type
  TfrmIBAvailableFields = class(TForm)
    GroupBox1: TGroupBox;
    lstFields: TListBox;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
  private
    FDataSet: TIBcustomDataset;
    procedure SetDataSet(const Value: TIBCustomDataset);
    { Private declarations }
  public
    property DataSet : TIBCustomDataset read FDataSet write SetDataSet;
    { Public declarations }
  end;

implementation

uses frmIBFilterFieldEditorU;

{$R *.DFM}

{ TfrmAvailableFields }

procedure TfrmIBAvailableFields.SetDataSet(const Value: TIBCustomDataset);
var
  i : Integer;
  p : TfrmIBFilterFieldEditor;
begin
  FDataSet := Value;
  p := Owner as TfrmIBFilterFieldEditor;
  for i := 0 to FDataSet.FieldList.Count - 1 do
    if p.lstFieldList.Items.IndexOf(FDataSet.FieldList.Fields[i].FieldName) < 0 then
      lstFields.Items.Add(FDataSet.FieldList.Fields[i].FieldName);
  lstFields.Sorted := true;
end;

end.
