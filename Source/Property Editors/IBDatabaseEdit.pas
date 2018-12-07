{*************************************************************}
{                                                             }
{       Borland Delphi Visual Component Library               }
{       InterBase Express core components                     }
{                                                             }
{       Copyright (c) 1998-2002 Borland Software Corporation  }
{                                                             }
{    InterBase Express is based in part on the product        }
{    Free IB Components, written by Gregory H. Deatz for      }
{    Hoagland, Longo, Moran, Dunst & Doukas Company.          }
{    Free IB Components is used under license.                }
{                                                             }
{    Additional code created by Jeff Overcash and used        }
{    with permission.                                         }
{*************************************************************}

unit IBDatabaseEdit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, IBDatabase, IB, IBXConst;

type
  TIBDatabaseEditForm = class(TForm)
    Panel1: TPanel;
    DatabaseName: TEdit;
    Label1: TLabel;
    LocalRbtn: TRadioButton;
    RemoteRbtn: TRadioButton;
    Browse: TButton;
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
    LoginPrompt: TCheckBox;
    Label6: TLabel;
    CharacterSet: TComboBox;
    ServerName: TEdit;
    Protocol: TComboBox;
    Label7: TLabel;
    Label8: TLabel;
    Test: TButton;
    procedure RemoteRbtnClick(Sender: TObject);
    procedure BrowseClick(Sender: TObject);
    procedure LocalRbtnClick(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure HelpBtnClick(Sender: TObject);
    procedure UserNameChange(Sender: TObject);
    procedure PasswordChange(Sender: TObject);
    procedure SQLRoleChange(Sender: TObject);
    procedure CharacterSetChange(Sender: TObject);
    procedure TestClick(Sender: TObject);
  private
    { Private declarations }
    Database: TIBDatabase;
    function Edit: Boolean;
    function GetParam(Name: string): string;
    procedure AddParam(Name, Value: string);
    procedure DeleteParam(Name: string);
  public
    { Public declarations }
  end;

var
  IBDatabaseEditForm: TIBDatabaseEditForm;

  function EditIBDatabase(ADatabase: TIBDatabase): Boolean;

implementation

{$R *.DFM}

uses LibHelp, TypInfo;

function EditIBDatabase(ADatabase: TIBDatabase): Boolean;
begin
  with TIBDatabaseEditForm.Create(Application) do
  try
    try
      Database := ADatabase;
      Result := Edit;
    except
      Result := false;
    end;
  finally
    Free;
  end;
end;

function TIBDatabaseEditForm.GetParam(Name: string): string;
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

procedure TIBDatabaseEditForm.AddParam(Name, Value: string);
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

procedure TIBDatabaseEditForm.DeleteParam(Name: string);
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

function TIBDatabaseEditForm.Edit: Boolean;
var
  st: string;

  procedure DecomposeDatabaseName;
  var
    Idx1, Idx2: Integer;
    st: string;
  begin
    if Pos('\\', Database.DatabaseName) <> 0 then {do not localize}
    begin
      LocalRBtn.Checked := False;
      RemoteRbtn.Checked := True;
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
    else
    begin
      Idx1 := Pos(':', Database.DatabaseName ); {do not localize}
      If (Idx1 = 0) or (Idx1 = 2) then
      begin
        DatabaseName.Text := Database.DatabaseName;
      end
      else
      begin
        LocalRBtn.Checked := False;
        RemoteRbtn.Checked := True;
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
  LoginPrompt.Checked := Database.LoginPrompt;
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
    if LocalRbtn.Checked then
      DatabaseName.Text := Database.DatabaseName
    else
      case Protocol.ItemIndex of
        0: Database.DatabaseName := Format('%s:%s', [ServerName.Text, DatabaseName.Text]); {do not localize}
        1: Database.DatabaseName := Format('\\%s\%s', [ServerName.Text, DatabaseName.Text]); {do not localize}
        2: Database.DatabaseName := Format('%s@%s', [ServerName.Text, DatabaseName.Text]); {do not localize}
      end;
    Database.Params := DatabaseParams.Lines;
    Database.LoginPrompt := LoginPrompt.Checked;
    Result := True;
  end;
end;

procedure TIBDatabaseEditForm.RemoteRbtnClick(Sender: TObject);
begin
  Browse.Enabled := False;
  Label7.Enabled := True;
  Label8.Enabled := True;
  Protocol.Enabled := True;
  ServerName.Enabled := True;
end;

procedure TIBDatabaseEditForm.BrowseClick(Sender: TObject);
begin
  with TOpenDialog.Create(Application) do
    try
      InitialDir := ExtractFilePath(DatabaseName.Text);
      Filter := SDatabaseFilter;
      if Execute then
        DatabaseName.Text := FileName;
    finally
      Free
    end;
end;

procedure TIBDatabaseEditForm.LocalRbtnClick(Sender: TObject);
begin
  Browse.Enabled := True;
  Label7.Enabled := False;
  Label8.Enabled := False;
  ServerName.Enabled := False;
  Protocol.Enabled := False;
end;

procedure TIBDatabaseEditForm.OKBtnClick(Sender: TObject);
begin
  ModalResult := mrNone;
  if Database.Connected then
  begin
    if MessageDlg(SDisconnectDatabase, mtConfirmation,
      mbOkCancel, 0) <> mrOk then Exit;
    Database.Close;
  end;
  ModalResult := mrOk;
end;

procedure TIBDatabaseEditForm.FormCreate(Sender: TObject);
begin
  HelpContext := hcDIBDataBaseEdit;
end;

procedure TIBDatabaseEditForm.HelpBtnClick(Sender: TObject);
begin
  Application.HelpContext(HelpContext);
end;

procedure TIBDatabaseEditForm.UserNameChange(Sender: TObject);
begin
  AddParam('user_name', UserName.Text);  {do not localize}
end;

procedure TIBDatabaseEditForm.PasswordChange(Sender: TObject);
begin
  AddParam('password', Password.Text); {do not localize}
end;

procedure TIBDatabaseEditForm.SQLRoleChange(Sender: TObject);
begin
  AddParam('sql_role_name', SQLRole.Text); {do not localize}
end;

procedure TIBDatabaseEditForm.CharacterSetChange(Sender: TObject);
begin
  if (CharacterSet.Text <> 'None') then {do not localize}
    AddParam('lc_ctype', CharacterSet.Text) {do not localize}
  else
    DeleteParam('lc_ctype');  {do not localize}
end;

procedure TIBDatabaseEditForm.TestClick(Sender: TObject);
var
  tempDB : TIBDatabase;
begin
  Test.Enabled := false;
  tempDB := TIBDatabase.Create(nil);
  try
    if LocalRbtn.Checked then
      tempDB.DatabaseName := DatabaseName.Text
    else
      case Protocol.ItemIndex of
        0: tempDB.DatabaseName := Format('%s:%s', [ServerName.Text, DatabaseName.Text]); {do not localize}
        1: tempDB.DatabaseName := Format('\\%s\%s', [ServerName.Text, DatabaseName.Text]); {do not localize}
        2: tempDB.DatabaseName := Format('%s@%s', [ServerName.Text, DatabaseName.Text]); {do not localize}
      end;
    tempDB.Params.Assign(DatabaseParams.Lines);
    tempDB.LoginPrompt := LoginPrompt.Checked;
    tempDB.Connected := true;
    ShowMessage(SIBSuccessConnect);
  finally
    tempDB.Free;
    Test.Enabled := true;
  end;
end;

end.
