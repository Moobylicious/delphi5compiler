{*************************************************************}
{                                                             }
{       Borland Delphi Visual Component Library               }
{       InterBase Express core components                     }
{                                                             }
{       Copyright (c) 2001 Jeff Overcash                      }
{                                                             }
{                                                             }
{*************************************************************}

unit IBXtrasReg;

interface

uses DsgnIntf;

{ TIBDatabaseEditor }
type

  TIBConnectionBrokerEditor = class(TComponentEditor)
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

{ TIBDatabaseEditor }

  TIBDatabaseINIEditor = class(TComponentEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

{ TIBFileNameProperty
  Property editor the DataBase Name property.  Brings up the Open dialog }

  TIBFileNameProperty = class(TStringProperty)
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
  end;

procedure Register;

implementation

uses IBFilterDialog, frmIBFilterFieldEditorU, Classes, IBScript,
     IBConnectionBroker, IBConnectionBrokerEdit, SysUtils, IBDatabaseINI,
     IBXConst, Dialogs, Forms;

{$R FilterDlg.dcr}
{$R IBXtras.dcr}

procedure Register;
begin
  RegisterComponents('InterBase', [TIBConnectionBroker, TIBFilterDialog, TIBScript, {do not localize}
    TIBSQLParser, TIBDatabaseINI]);
  RegisterPropertyEditor(TypeInfo(TStringList), TIBFilterDialog, 'Fields', TIBFilterFieldEditor);  {do not localize}
  RegisterComponentEditor(TIBConnectionBroker, TIBConnectionBrokerEditor);
  RegisterComponentEditor(TIBDatabaseINI, TIBDatabaseINIEditor);
  RegisterPropertyEditor(TypeInfo(String), TIBDatabaseINI, 'FileName', TIBFileNameProperty); {do not localize}
end;

{ TIBDatabasePoolerEditor }

procedure TIBConnectionBrokerEditor.ExecuteVerb(Index: Integer);
begin
  if Index < inherited GetVerbCount then
    inherited ExecuteVerb(Index) else
  begin
    Dec(Index, inherited GetVerbCount); 
    case Index of
      0 : if EditIBConnectionBroker(TIBConnectionBroker(Component)) then
        Designer.Modified;
    end;
  end;
end;

function TIBConnectionBrokerEditor.GetVerb(Index: Integer): string;
begin
  if Index < inherited GetVerbCount then
    Result := inherited GetVerb(Index) 
  else
  begin
    Dec(Index, inherited GetVerbCount);
    case Index of
      0 : Result := 'Connection Broker Editor';
      1 : Result := Format(SInterbaseExpressVersionEx, [IBX_Version]);
    end;
  end;
end;

function TIBConnectionBrokerEditor.GetVerbCount: Integer;
begin
  Result := inherited GetVerbCount + 2;
end;

{ TIBDatabaseINIEditor }

procedure TIBDatabaseINIEditor.ExecuteVerb(Index: Integer);
begin
  inherited;
  case Index of
    0 :
    begin
      TIBDatabaseINI(Component).ReadFromDatabase;
      Designer.Modified;
    end;
    1 :
    begin
      TIBDatabaseINI(Component).WriteToDatabase(TIBDatabaseINI(Component).Database);
      Designer.Modified;
    end;
    2 : TIBDatabaseINI(Component).SaveToINI;
  end;
end;

function TIBDatabaseINIEditor.GetVerb(Index: Integer): string;
begin
  case Index of
    0 : Result := 'Pull values';
    1 : Result := 'Push values';
    2 : Result := 'Write to INI';
  end;
end;

function TIBDatabaseINIEditor.GetVerbCount: Integer;
begin
  Result := 3
end;

{ TIBFileNameProperty }
procedure TIBFileNameProperty.Edit;
begin
  with TOpenDialog.Create(Application) do
    try
      InitialDir := ExtractFilePath(GetStrValue);
      Filter := 'INI Files|*.ini'; {do not localize}
      DefaultExt := '*.ini'; {do not localize}
      if Execute then
        SetStrValue(FileName);
    finally
      Free
    end;
end;

function TIBFileNameProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog];
end;

end.
