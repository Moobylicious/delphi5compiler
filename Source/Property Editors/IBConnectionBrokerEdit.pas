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

unit IBConnectionBrokerEdit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, IBConnectionBroker, IB, IBXConst;

type
  TIBConnectionBrokerEditForm = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    GroupBox1: TGroupBox;
    UserName: TEdit;
    Password: TEdit;
    SQLRole: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    DatabaseParams: TMemo;
    OKBtn: TButton;
    CancelBtn: TButton;
    HelpBtn: TButton;
    Label5: TLabel;
    Label6: TLabel;
    CharacterSet: TComboBox;
    Label7: TLabel;
    Label8: TLabel;
    Test: TButton;
    ServerName: TEdit;
    Protocol: TComboBox;
    DatabaseName: TEdit;
    procedure UserNameChange(Sender: TObject);
    procedure PasswordChange(Sender: TObject);
    procedure SQLRoleChange(Sender: TObject);
    procedure CharacterSetChange(Sender: TObject);
    procedure TestClick(Sender: TObject);
  private
    { Private declarations }
    Database: TIBConnectionBroker;
    function Edit: Boolean;
    function GetParam(Name: string): string;
    procedure AddParam(Name, Value: string);
    procedure DeleteParam(Name: string);
  public
    { Public declarations }
  end;

  function EditIBConnectionBroker(AConnectionBroker: TIBConnectionBroker): Boolean;

implementation

{$R *.dfm}

uses LibHelp, IBDatabase, TypInfo;


function EditIBConnectionBroker(AConnectionBroker: TIBConnectionBroker): Boolean;
begin
  with TIBConnectionBrokerEditForm.Create(Application) do
  try
    try
      Database := AConnectionBroker;
      Result := Edit;
    except
      Result := false;
    end;
  finally
    Free;
  end;
end;

function TIBConnectionBrokerEditForm.GetParam(Name: string): string;
var
  i: Integer;
begin
  Result := '';
  for i := 0 to DatabaseParams.Lines.Count - 1 do
  begin
    if (Pos(Name, LowerCase(DatabaseParams.Lines.Names[i])) = 1) then {mbcs ok}
    begin
      Result := DatabaseParams.Lines.Values[DatabaseParams.Lines.Names[i]];
      break;
    end;
  end;
end;

procedure TIBConnectionBrokerEditForm.AddParam(Name, Value: string);
var
  i: Integer;
  found: boolean;
begin
  found := False;
  if Trim(Value) <> '' then  {do not localize}
  begin
    for i := 0 to DatabaseParams.Lines.Count - 1 do
    begin
      if (Pos(Name, LowerCase(DatabaseParams.Lines.Names[i])) = 1) then {mbcs ok}
      begin
        DatabaseParams.Lines.Values[DatabaseParams.Lines.Names[i]] := Value;
        found := True;
        break;
      end;
    end;
    if not found then
      DatabaseParams.Lines.Add(Name + '=' + Value); {do not localize}
  end
  else
    DeleteParam(Name);
end;

procedure TIBConnectionBrokerEditForm.DeleteParam(Name: string);
var
  i: Integer;
begin
    for i := 0 to DatabaseParams.Lines.Count - 1 do
    begin
      if (Pos(Name, LowerCase(DatabaseParams.Lines.Names[i])) = 1) then {mbcs ok}
      begin
        DatabaseParams.Lines.Delete(i);
        break;
      end;
    end;
end;

function TIBConnectionBrokerEditForm.Edit: Boolean;
var
  st: string;

  procedure DecomposeDatabaseName;
  var
    Idx1, Idx2: Integer;
    st: string;
  begin
    if Pos('\\', Database.DatabaseName) <> 0 then {do not localize}
    begin
      Protocol.ItemIndex := 1;
      st := copy(Database.DatabaseName, 3, Length(Database.DatabaseName));
      Idx1 := Pos('\', st); {do not localize}
      if Idx1 = 0 then
        IBError(ibxeUnknownError, [nil])
      else begin
        ServerName.Text := Copy(st, 1, Idx1 - 1);
        DatabaseName.Text:= Copy(st, Idx1 + 1, Length(st));
      end;
    end
    else begin
      Idx1 := Pos(':', Database.DatabaseName ); {do not localize}
      If (Idx1 = 0) or (Idx1 = 2) then
      begin
        DatabaseName.Text := Database.DatabaseName;
      end
      else
      begin
        Idx2 := Pos('@', Database.DatabaseName); {do not localize}
        if Idx2 = 0 then
        begin
          Protocol.ItemIndex := 0;
          ServerName.Text := copy(Database.DatabaseName, 1, Idx1 - 1);
          DatabaseName.Text := copy(Database.DatabaseName, Idx1 + 1,
            Length(Database.DatabaseName));
        end
        else begin
          Protocol.ItemIndex := 2;
          ServerName.Text := copy(Database.DatabaseName, 1, Idx2 - 1);
          DatabaseName.Text := copy(Database.DatabaseName, Idx2 + 1,
            Length(Database.DatabaseName));
        end;
      end;
    end;
  end;
begin
  DecomposeDatabaseName;
  DatabaseParams.Lines := Database.Params;
  UserName.Text := GetParam('user_name');   {do not localize}
  Password.Text := GetParam('password');    {do not localize}
  SQLRole.Text := GetParam('sql_role');     {do not localize}
  st := GetParam('lc_ctype');               {do not localize}
  if (st <> '') then
    CharacterSet.ItemIndex := CharacterSet.Items.IndexOf(st);
  Result := False;
  if ShowModal = mrOk then
  begin
    Database.DatabaseName := DatabaseName.Text;
    case Protocol.ItemIndex of
      0: Database.DatabaseName := Format('%s:%s', [ServerName.Text, DatabaseName.Text]); {do not localize}
      1: Database.DatabaseName := Format('\\%s\%s', [ServerName.Text, DatabaseName.Text]); {do not localize}
      2: Database.DatabaseName := Format('%s@%s', [ServerName.Text, DatabaseName.Text]); {do not localize}
    end;
    Database.Params := DatabaseParams.Lines;
    Result := True;
  end;
end;

procedure TIBConnectionBrokerEditForm.UserNameChange(Sender: TObject);
begin
  AddParam('user_name', UserName.Text);  {do not localize}
end;

procedure TIBConnectionBrokerEditForm.PasswordChange(Sender: TObject);
begin
  AddParam('password', Password.Text); {do not localize}
end;

procedure TIBConnectionBrokerEditForm.SQLRoleChange(Sender: TObject);
begin
  AddParam('sql_role_name', SQLRole.Text); {do not localize}
end;

procedure TIBConnectionBrokerEditForm.CharacterSetChange(Sender: TObject);
begin
  if (CharacterSet.Text <> 'None') then {do not localize}
    AddParam('lc_ctype', CharacterSet.Text) {do not localize}
  else
    DeleteParam('lc_ctype');  {do not localize}
end;

procedure TIBConnectionBrokerEditForm.TestClick(Sender: TObject);
var
  tempDB : TIBDatabase;
begin
  Test.Enabled := false;
  tempDB := TIBDatabase.Create(nil);
  try
    case Protocol.ItemIndex of
      0: tempDB.DatabaseName := Format('%s:%s', [ServerName.Text, DatabaseName.Text]); {do not localize}
      1: tempDB.DatabaseName := Format('\\%s\%s', [ServerName.Text, DatabaseName.Text]); {do not localize}
      2: tempDB.DatabaseName := Format('%s@%s', [ServerName.Text, DatabaseName.Text]); {do not localize}
    end;
    tempDB.Params.Assign(DatabaseParams.Lines);
    tempDB.LoginPrompt := false;
    tempDB.Connected := true;
    ShowMessage(SIBSuccessConnect);
  finally
    tempDB.Free;
    Test.Enabled := true;
  end;
end;

end.
