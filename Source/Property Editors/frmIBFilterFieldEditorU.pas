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

unit frmIBFilterFieldEditorU;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, DsgnIntf, IBCustomDataset;

type

  TIBFilterFieldEditor = class(TPropertyEditor)
    function GetAttributes : TPropertyAttributes; override;
    function GetValue : String; override;
    procedure Edit; override;
  end;

  TfrmIBFilterFieldEditor = class(TForm)
    lstFieldList: TListBox;
    Label1: TLabel;
    Label2: TLabel;
    edtAlias: TEdit;
    btnAdd: TButton;
    btnRemove: TButton;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure lstFieldListClick(Sender: TObject);
    procedure edtAliasChange(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnRemoveClick(Sender: TObject);
  private
    FAliasList: TStringList;
    FDataSet: TIBCustomDataSet;
    procedure SetAliasList(const Value: TStringList);
    { Private declarations }
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
    procedure SetList(list : TStringList);
    function GetList : TStringList;
    property AliasList : TStringList read FAliasList write SetAliasList;
    property DataSet : TIBCustomDataSet read FDataSet write FDataSet;
    { Public declarations }
  end;

implementation

uses IBFilterDialog, frmIBAvailableFieldsU, IBXConst;

{$R *.DFM}

{ TIBFilterFieldEditor }

procedure TIBFilterFieldEditor.Edit;
var
  d : TfrmIBFilterFieldEditor;
  c : TIBFilterDialog;
  list : TStringList;
begin
  c := GetComponent(0) as TIBFilterDialog;
  if not Assigned(c.DataSet) then
    raise Exception.Create(SDatabaseNotAssigned);
  d := TfrmIBFilterFieldEditor.Create(Application);
  try
    D.Caption := c.Name + '.' + GetName + '-' + D.Caption;  {do not localize}
    list := TStringList(GetOrdValue);
    D.SetList(list);
    D.DataSet := c.DataSet;
    if D.ShowModal = mrOK then
    begin
      SetOrdValue(LongInt(D.GetList));
    end;
  finally
    D.Free;
  end;
end;

function TIBFilterFieldEditor.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog];
end;

function TIBFilterFieldEditor.GetValue: String;
begin
  Result := Format( '<%s>', [GetPropType^.Name] ); {do not localize}
end;

constructor TfrmIBFilterFieldEditor.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FAliasList := TStringList.Create;
end;

destructor TfrmIBFilterFieldEditor.Destroy;
begin
  FAliasList.Free;
  inherited Destroy;
end;

function TfrmIBFilterFieldEditor.GetList: TStringList;
var
  i : Integer;
begin
  Result := TStringList.Create;
  for i := 0 to lstFieldList.Items.Count - 1 do
    Result.Add(lstFieldList.Items[i] + ';' + AliasList[i]); {do not localize}
end;

procedure TfrmIBFilterFieldEditor.lstFieldListClick(Sender: TObject);
begin
  edtAlias.Text := FAliasList[lstFieldList.ItemIndex];
  ActiveControl := edtAlias;
end;

procedure TfrmIBFilterFieldEditor.SetAliasList(const Value: TStringList);
begin
  FAliasList := Value;
end;

procedure TfrmIBFilterFieldEditor.SetList(list: TStringList);
var
  j, p : Integer;
  field, display : String;
begin
  for j := 0 to list.Count - 1 do
  begin
    p := Pos(';', list.Strings[j]);  {do not localize}
    field := Copy(list.Strings[j], 1, p - 1);
    if p = Length(list.Strings[j]) then
      display := ''
    else
      display := Copy(list.Strings[j], p+1, Length(list.Strings[j]));
    lstFieldList.Items.Add(field);
    FAliasList.Add(display);
  end;
  if list.Count <> 0 then
  begin
    edtAlias.Enabled := true;
    lstFieldList.ItemIndex := 0;
    lstFieldListClick(nil);
  end;
end;

procedure TfrmIBFilterFieldEditor.edtAliasChange(Sender: TObject);
begin
  FAliasList[lstFieldList.ItemIndex] := edtAlias.Text;
end;

procedure TfrmIBFilterFieldEditor.btnAddClick(Sender: TObject);
var
  f : TfrmIBAvailableFields;
  i : Integer;
begin
  f := TfrmIBAvailableFields.Create(self);
  try
    f.DataSet := FDataSet;
    if f.ShowModal = mrOK then
      for i := 0 to (f.lstFields.Items.Count - 1) do
        if f.lstfields.Selected[i] then
        begin
          lstFieldList.Items.Add(f.lstFields.Items[i]);
          FAliasList.Add('');
        end;
  finally
    f.Free;
  end;
  if lstFieldList.Items.Count > 0 then
    edtAlias.Enabled := true;
end;

procedure TfrmIBFilterFieldEditor.btnRemoveClick(Sender: TObject);
var
  i : Integer;
begin
  for i := (lstFieldList.Items.Count - 1) downto 0 do
    if lstfieldList.Selected[i] then
    begin
      lstFieldList.Items.Delete(i);
      FAliasList.Delete(i);
    end;
  if lstFieldList.Items.Count = 0 then
    edtAlias.Enabled := false;
end;

end.
