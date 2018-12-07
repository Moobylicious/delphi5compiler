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

unit IBDBReg;

(*
 * Compiler defines
 *)
{$A+}                           (* Aligned records: On *)
{$B-}                           (* Short circuit boolean expressions: Off *)
{$G+}                           (* Imported data: On *)
{$H+}                           (* Huge Strings: On *)
{$J-}                           (* Modification of Typed Constants: Off *)
{$M+}                           (* Generate run-time type information: On *)
{$O+}                           (* Optimization: On *)
{$Q-}                           (* Overflow checks: Off *)
{$R-}                           (* Range checks: Off *)
{$T+}                           (* Typed address: On *)
{$U+}                           (* Pentim-safe FDIVs: On *)
{$W-}                           (* Always generate stack frames: Off *)
{$X+}                           (* Extended syntax: On *)
{$Z1}                           (* Minimum Enumeration Size: 1 Byte *)

interface

uses Windows, SysUtils, Classes, Graphics, Dialogs, Controls, Forms, TypInfo,
     DsgnIntf, DB, ParentageSupport, dsndb, DBReg, ColnEdit, FldLinks, SQLEdit,
     DataModelSupport, IBTable, IBDatabase, IBUpdateSQLEditor,  IBEventsEditor,
     IBXConst, IBCustomDataset, IBQuery, IBSQL, DSDesign;

type

  TIBDSDesigner = class(TDSDesigner)
  public
    function DoCreateField(const FieldName: string; Origin: string): TField; override;
  end;

{ TIBFileNameProperty
  Property editor the DataBase Name property.  Brings up the Open dialog }

  TIBFileNameProperty = class(TStringProperty)
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
  end;

  { TIBNameProperty
  }
  TIBNameProperty = class(TStringProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
  end;

  { TIBStoredProcNameProperty
    Editor for the TIBStoredProc.StoredProcName property.  Displays a drop-down list of all
    the StoredProcedures in the Database.}
  TIBStoredProcNameProperty = class(TIBNameProperty)
  public
    procedure GetValues(Proc: TGetStrProc); override;
  end;

  { TIBTableNameProperty
    Editor for the TIBTable.TableName property.  Displays a drop-down list of all
    the Tables in the Database.}
  TIBTableNameProperty = class(TIBNameProperty)
  public
    procedure GetValues(Proc: TGetStrProc); override;
  end;

  TDBStringProperty = class(TStringProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure GetValueList(List: TStrings); virtual;
    procedure GetValues(Proc: TGetStrProc); override;
  end;

  TIBIndexFieldNamesProperty = class(TDBStringProperty)
  public
    procedure GetValueList(List: TStrings); override;
  end;

  TIBIndexNameProperty = class(TDBStringProperty)
  public
    procedure GetValueList(List: TStrings); override;
  end;

{ TIBDatabaseEditor }

  TIBDatabaseEditor = class(TComponentEditor)
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

{ TIBTransactionEditor }

  TIBTransactionEditor = class(TComponentEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

{ TIBServiceEditor }

  TIBServiceEditor = class(TComponentEditor)
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

  TIBSecurityEditor = class(TIBServiceEditor)
    procedure ExecuteVerb(Index: Integer); override;
  end;

  TIBDataSetBaseEditor = class(TDataSetEditor)
  protected
    IBDataset: TIBCustomDataset;
    FGetTableNamesProc: TGetTableNamesProc;
    FGetFieldnamesProc: TGetFieldNamesProc;
    procedure GetTableNames(List: TStrings; SystemTables: Boolean);
    procedure GetFieldNames(const TableName: string; List: TStrings);
    function GetDSDesignerClass: TDSDesignerClass; override;
  end;

{ TIBQueryEditor }

  TIBQueryEditor = class(TIBDataSetBaseEditor)
  public
    procedure EditSQL;
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

{ TIBStoredProcEditor }

  TIBStoredProcEditor = class(TIBDataSetBaseEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

{ TIBDataSetEditor }

  TIBDataSetEditor = class(TIBDataSetBaseEditor)
  public
    procedure EditSQL;
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

{ TIBUpdateSQLEditor }

  TIBUpdateSQLEditor = class(TComponentEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
   function GetVerbCount: Integer; override;
  end;

  TIBStoredProcParamsProperty = class(TCollectionProperty)
  public
    procedure Edit; override;
  end;

  TIBTableFieldLinkProperty = class(TFieldLinkProperty)
  private
    FTable: TIBTable;
  protected
    function GetIndexFieldNames: string; override;
    function GetMasterFields: string; override;
    procedure SetIndexFieldNames(const Value: string); override;
    procedure SetMasterFields(const Value: string); override;
  public
    procedure Edit; override;
  end;

{ TSQLPropertyEditor }

  TSQLPropertyEditor = class(TClassProperty)
  protected
    FGetTableNamesProc: TGetTableNamesProc;
    FGetFieldnamesProc: TGetFieldNamesProc;
  public
    procedure EditSQL;
    function GetAttributes: TPropertyAttributes; override;
  end;

{ TIBQuerySQLProperty }

  TIBQuerySQLProperty = class(TSQLPropertyEditor)
  protected
    Query: TIBQuery;
    procedure GetTableNames(List: TStrings; SystemTables: Boolean);
    procedure GetFieldNames(const TableName: string; List: TStrings);
  public
    procedure Edit; override;
  end;

{ TIBDatasetSQLProperty }

  TIBDatasetSQLProperty = class(TSQLPropertyEditor)
  protected
    IBDataset: TIBDataset;
    procedure GetTableNames(List: TStrings; SystemTables: Boolean);
    procedure GetFieldNames(const TableName: string; List: TStrings);
  public
    procedure Edit; override;
  end;

{ TIBGeneratorFieldProperty }

  TIBGeneratorFieldProperty = class(TPropertyEditor)
  public
    procedure Edit; override;
    function  GetAttributes: TPropertyAttributes; override;
    function  GetValue: string; override;
  end;

{ TIBServiceFilesProperty }

  TIBRestoreFilesProperty = class(TClassProperty)
  public
    procedure Edit; override;
    function GetAttributes : TPropertyAttributes; override;
    function GetValue : String; override;
  end;

  TIBBackupFilesProperty = class(TPropertyEditor)
  public
    procedure Edit; override;
    function GetAttributes : TPropertyAttributes; override;
    function GetValue : String; override;
  end;

{ TIBSQLProperty }

  TIBSQLProperty = class(TSQLPropertyEditor)
  protected
    IBSQL: TIBSQL;
    procedure GetTableNames(List: TStrings; SystemTables: Boolean);
    procedure GetFieldNames(const TableName: string; List: TStrings);
  public
    procedure Edit; override;
  end;

  TIBEventListProperty = class(TClassProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure Edit; override;
  end;

  { TIBNameProperty
  }
  TIBPageSizeProperty = class(TIntegerProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc); override;
  end;


{ DataModel Designer stuff }

  TIBSQLSprig = class(TSprig)
  public
    procedure FigureParent; override;
    function AnyProblems: Boolean; override;
    function DragDropTo(AItem: TSprig): Boolean; override;
    function DragOverTo(AItem: TSprig): Boolean; override;
    class function PaletteOverTo(AParent: TSprig; AClass: TClass): Boolean; override;
  end;

  TIBCustomDataSetSprig = class(TDataSetSprig)
  public
    procedure FigureParent; override;
    function AnyProblems: Boolean; override;
    function DragDropTo(AItem: TSprig): Boolean; override;
    function DragOverTo(AItem: TSprig): Boolean; override;
    function GetDSDesignerClass: TDSDesignerClass; override;
    class function PaletteOverTo(AParent: TSprig; AClass: TClass): Boolean; override;
  end;

  TIBQuerySprig = class(TIBCustomDataSetSprig)
  public
    function AnyProblems: Boolean; override;
  end;

  TIBDatasetSprig = class(TIBCustomDataSetSprig)
  public
    function AnyProblems: Boolean; override;
  end;

  TIBTableSprig = class(TIBCustomDataSetSprig)
  public
    function AnyProblems: Boolean; override;
    function Caption: string; override;
  end;

  TIBStoredProcSprig = class(TIBCustomDataSetSprig)
  public
    function AnyProblems: Boolean; override;
    function Caption: string; override;
  end;

  TIBUpdateSQLSprig = class(TSprigAtRoot)
  public
    function AnyProblems: Boolean; override;
  end;

  TIBDatabaseSprig = class(TSprigAtRoot)
  public
    function AnyProblems: Boolean; override;
    function Caption: string; override;
  end;

  TIBTransactionSprig = class(TSprig)
  public
    function Caption: string; override;
    procedure FigureParent; override;
    function AnyProblems: Boolean; override;
    function DragDropTo(AItem: TSprig): Boolean; override;
    function DragOverTo(AItem: TSprig): Boolean; override;
    class function PaletteOverTo(AParent: TSprig; AClass: TClass): Boolean; override;
  end;

  TIBDatabaseInfoSprig = class(TSprig)
  public
    class function ParentProperty: string; override;
  end;

  TIBEventsSprig = class(TSprig)
  public
    class function ParentProperty: string; override;
    function AnyProblems: Boolean; override;
  end;

  TIBTransactionIsland = class(TIsland)
  public
    function VisibleTreeParent: Boolean; override;
  end;

  TIBSQLIsland = class(TIsland)
  public
    function VisibleTreeParent: Boolean; override;
  end;

  TIBCustomDataSetIsland = class(TDataSetIsland)
  public
    function VisibleTreeParent: Boolean; override;
  end;

  TIBTableIsland = class(TIBCustomDataSetIsland)
  end;

  TIBTableMasterDetailBridge = class(TMasterDetailBridge)
  public
    function CanEdit: Boolean; override;
    class function OmegaIslandClass: TIslandClass; override;
    class function GetOmegaSource(AItem: TPersistent): TDataSource; override;
    class procedure SetOmegaSource(AItem: TPersistent; ADataSource: TDataSource); override;
    function Caption: string; override;
    function Edit: Boolean; override;
  end;

  TIBQueryIsland = class(TIBCustomDataSetIsland)
  end;

  TIBQueryMasterDetailBridge = class(TMasterDetailBridge)
  public
    class function RemoveMasterFieldsAsWell: Boolean; override;
    class function OmegaIslandClass: TIslandClass; override;
    class function GetOmegaSource(AItem: TPersistent): TDataSource; override;
    class procedure SetOmegaSource(AItem: TPersistent; ADataSource: TDataSource); override;
    function Caption: string; override;
  end;

procedure Register;

implementation

uses IB, IBStoredProc, IBUpdateSQL,
     IBIntf, IBSQLMonitor, IBDatabaseInfo, IBEvents,
     IBServices, IBInstall, IBDatabaseEdit, IBTransactionEdit,
     IBBatchMove, DBLogDlg, IBExtract, IBGeneratorEditor, IBUtils,
     IBServiceEditor, IBRestoreEditor, IBSecurityEditor, IBDCLConst;

procedure InternalGetTableNames(Database: TIBDatabase;
  List: TStrings; SystemTables: Boolean);
var
  Query : TIBSQL;
begin
  if not Database.Connected then
    Database.Open;
  if not Database.InternalTransaction.Active then
    Database.InternalTransaction.StartTransaction;
  Query := TIBSQL.Create(nil);
  try
    Query.GoToFirstRecordOnExecute := False;
    Query.Database := Database;
    Query.Transaction := Database.InternalTransaction;
    if SystemTables then
      Query.SQL.Text := 'Select RDB$RELATION_NAME from RDB$RELATIONS ' + {do not localize}
                        'ORDER BY RDB$RELATION_NAME' {do not localize}
    else
      Query.SQL.Text := 'Select RDB$RELATION_NAME from RDB$RELATIONS ' + {do not localize}
                        ' where RDB$SYSTEM_FLAG = 0 ' + {do not localize}
                        'ORDER BY RDB$RELATION_NAME'; {do not localize}
    Query.Prepare;
    Query.ExecQuery;
    with List do
    begin
      BeginUpdate;
      try
        Clear;
        while (not Query.EOF) and (Query.Next <> nil) do
          List.Add(TrimRight(Query.Current[0].AsString));
      finally
        EndUpdate;
      end;
    end;
  finally
    Query.Free;
    Database.InternalTransaction.Commit;
  end;
end;

procedure Register;
var
  IB60Client : Boolean;
begin
  IB60Client := false;
  RegisterComponents(IBPalette1, [TIBTable, TIBQuery,
    TIBStoredProc, TIBDatabase, TIBTransaction, TIBUpdateSQL,
    TIBDataSet, TIBSQL, TIBDatabaseInfo, TIBSQLMonitor, TIBEvents, TIBExtract]);
  try
    IB60Client := (GetIBClientVersion >= 6);
    if (TryIBLoad) and IB60Client then
      RegisterComponents(IBPalette2, [TIBConfigService, TIBBackupService,
        TIBRestoreService, TIBValidationService, TIBStatisticalService,
        TIBLogService, TIBSecurityService, TIBServerProperties, TIBLicensingService,
        TIBInstall, TIBUninstall]);
  except
    // Eat the exception if the TryIBLoad fails.  This will load the main components
    //   but delay the actual exception about the missing client dll until use
    //   of a component - as per Sparky
  end;
  RegisterClasses([TIBStringField, TIBBCDField]);
  RegisterFields([TIBStringField, TIBBCDField]);
  RegisterPropertyEditor(TypeInfo(TIBFileName), TIBDatabase, 'DatabaseName', TIBFileNameProperty); {do not localize}
  RegisterPropertyEditor(TypeInfo(string), TIBStoredProc, 'StoredProcName', TIBStoredProcNameProperty); {do not localize}
  RegisterPropertyEditor(TypeInfo(TParams), TIBStoredProc, 'Params', TIBStoredProcParamsProperty);
  RegisterPropertyEditor(TypeInfo(string), TIBTable, 'TableName', TIBTableNameProperty); {do not localize}
  RegisterPropertyEditor(TypeInfo(string), TIBTable, 'IndexName', TIBIndexNameProperty); {do not localize}
  RegisterPropertyEditor(TypeInfo(string), TIBTable, 'IndexFieldNames', TIBIndexFieldNamesProperty); {do not localize}
  RegisterPropertyEditor(TypeInfo(string), TIBTable, 'MasterFields', TIBTableFieldLinkProperty); {do not localize}
  RegisterPropertyEditor(TypeInfo(TStrings), TIBQuery, 'SQL', TIBQuerySQLProperty); {do not localize}
  RegisterPropertyEditor(TypeInfo(TStrings), TIBDataSet, 'SelectSQL', TIBDatasetSQLProperty); {do not localize}
  RegisterPropertyEditor(TypeInfo(TStrings), TIBSQL, 'SQL', TIBSQLProperty); {do not localize}
  RegisterPropertyEditor(TypeInfo(TStrings), TIBEvents, 'Events', TIBEventListProperty); {do not localize}
  RegisterPropertyEditor(TypeInfo(TIBGeneratorField), TIBDataset, 'GeneratorField', TIBGeneratorFieldProperty); {do not localize}
  RegisterPropertyEditor(TypeInfo(TIBGeneratorField), TIBQuery, 'GeneratorField', TIBGeneratorFieldProperty); {do not localize}

  RegisterComponentEditor(TIBDatabase, TIBDatabaseEditor);
  RegisterComponentEditor(TIBTransaction, TIBTransactionEditor);
  RegisterComponentEditor(TIBUpdateSQL, TIBUpdateSQLEditor);
  RegisterComponentEditor(TIBDataSet, TIBDataSetEditor);
  RegisterComponentEditor(TIBQuery, TIBQueryEditor);
  RegisterComponentEditor(TIBStoredProc, TIBStoredProcEditor);

  if IB60Client then
  begin
    RegisterComponentEditor(TIBConfigService, TIBServiceEditor);
    RegisterComponentEditor(TIBBackupService, TIBServiceEditor);
    RegisterComponentEditor(TIBLogService, TIBSecurityEditor);
    RegisterComponentEditor(TIBRestoreService, TIBSecurityEditor);
    RegisterPropertyEditor(TypeInfo(Integer), TIBRestoreService, 'PageSize', TIBPageSizeProperty);  {do not localize}
    RegisterPropertyEditor(TypeInfo(TStrings), TIBRestoreService, 'DataBaseName', TIBRestoreFilesProperty); {do not localize}
    RegisterPropertyEditor(TypeInfo(TStrings), TIBRestoreService, 'BackupFile', TIBRestoreFilesProperty); {do not localize}
    RegisterPropertyEditor(TypeInfo(TStrings), TIBBackupService, 'BackupFile', TIBRestoreFilesProperty); {do not localize}
    RegisterComponentEditor(TIBSecurityService, TIBSecurityEditor);
    RegisterComponentEditor(TIBServerProperties, TIBSecurityEditor);
    RegisterComponentEditor(TIBStatisticalService, TIBServiceEditor);
    RegisterComponentEditor(TIBValidationService, TIBServiceEditor);
  end;
  RegisterSprigType(TIBDatabase, TIBDatabaseSprig);
  RegisterSprigType(TIBTransaction, TIBTransactionSprig);

  RegisterSprigType(TIBDatabaseInfo, TIBDatabaseInfoSprig);
  RegisterSprigType(TIBEvents, TIBEventsSprig);
  RegisterSprigType(TIBSQL, TIBSQLSprig);

  RegisterSprigType(TIBUpdateSQL, TIBUpdateSQLSprig);

  RegisterSprigType(TIBCustomDataSet, TIBCustomDataSetSprig);
  RegisterSprigType(TIBDataSet, TIBDataSetSprig);
  RegisterSprigType(TIBQuery, TIBQuerySprig);
  RegisterSprigType(TIBTable, TIBTableSprig);
  RegisterSprigType(TIBStoredProc, TIBStoredProcSprig);

  RegisterIslandType(TIBTransactionSprig, TIBTransactionIsland);
  RegisterIslandType(TIBSQLSprig, TIBSQLIsland);
  RegisterIslandType(TIBCustomDataSetSprig, TIBCustomDataSetIsland);
  RegisterIslandType(TIBTableSprig, TIBTableIsland);
  RegisterIslandType(TIBQuerySprig, TIBQueryIsland);

  RegisterBridgeType(TDataSetIsland, TIBTableIsland, TIBTableMasterDetailBridge);
  RegisterBridgeType(TDataSetIsland, TIBQueryIsland, TIBQueryMasterDetailBridge);
end;

{ TIBFileNameProperty }
procedure TIBFileNameProperty.Edit;
begin
  with TOpenDialog.Create(Application) do
    try
      InitialDir := ExtractFilePath(GetStrValue);
      Filter := SDatabasefiles; 
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

{ TIBNameProperty }

function TIBNameProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paValueList, paSortList];
end;

{ TIBStoredProcNameProperty }

procedure TIBStoredProcNameProperty.GetValues(Proc: TGetStrProc);
var
   StoredProc : TIBStoredProc;
   i : integer;
begin
    StoredProc := GetComponent(0) as TIBStoredProc;
    with StoredProc do
      for I := 0 to StoredProcedureNames.Count - 1 do
        Proc (StoredProcedureNames[i]);
end;

{ TIBTableNameProperty }

procedure TIBTableNameProperty.GetValues(Proc: TGetStrProc);
var
   TableName : TIBTable;
   i : integer;
begin
  TableName := GetComponent(0) as TIBTable;
  if Assigned(TableName.DataBase) then
    with TableName do
      for I := 0 to TableNames.Count - 1 do
        Proc (TableNames[i]);
end;

{ TDBStringProperty }

function TDBStringProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paValueList, paSortList, paMultiSelect];
end;

procedure TDBStringProperty.GetValueList(List: TStrings);
begin
end;

procedure TDBStringProperty.GetValues(Proc: TGetStrProc);
var
  I: Integer;
  Values: TStringList;
begin
  Values := TStringList.Create;
  try
    GetValueList(Values);
    for I := 0 to Values.Count - 1 do Proc(Values[I]);
  finally
    Values.Free;
  end;
end;

{ Utility Functions }

function GetPropertyValue(Instance: TPersistent; const PropName: string): TPersistent;
var
  PropInfo: PPropInfo;
begin
  Result := nil;
  PropInfo := TypInfo.GetPropInfo(Instance.ClassInfo, PropName);
  if (PropInfo <> nil) and (PropInfo^.PropType^.Kind = tkClass) then
    Result := TObject(GetOrdProp(Instance, PropInfo)) as TPersistent;
end;

function GetIndexDefs(Component: TPersistent): TIndexDefs;
var
  DataSet: TDataSet;
begin
  DataSet := Component as TDataSet;
  Result := GetPropertyValue(DataSet, 'IndexDefs') as TIndexDefs; {do not localize}
  if Assigned(Result) then
  begin
    Result.Updated := False;
    Result.Update;
  end;
end;

{ TIBIndexFieldNamesProperty }

procedure TIBIndexFieldNamesProperty.GetValueList(List: TStrings);
var
  I: Integer;
  IndexDefs: TIndexDefs;
begin
  IndexDefs := GetIndexDefs(GetComponent(0));
  for I := 0 to IndexDefs.Count - 1 do
    with IndexDefs[I] do
      if (Options * [ixExpression, ixDescending] = []) and (Fields <> '') then {do not localize}
        List.Add(Fields);
end;


{ TIBIndexNameProperty }

procedure TIBIndexNameProperty.GetValueList(List: TStrings);
begin
  GetIndexDefs(GetComponent(0)).GetItemNames(List);
end;

{ TSQLPropertyEditor }

procedure TSQLPropertyEditor.EditSQL;
var
  SQLText: string;
  SQL: TStrings;
begin
  SQL := TStringList.Create;
  try
    SQL.Assign(TStrings(GetOrdValue));
    SQLText := SQL.Text;
    if (SQLEdit.EditSQL(SQLText, FGetTableNamesProc, FGetFieldNamesProc)) and
      (SQL.Text <> SQLText) then
    begin
      SQL.Text := SQLText;
      SetOrdValue(LongInt(SQL));
      Designer.Modified;
    end;
  finally
    SQL.free;
  end;
end;

function TSQLPropertyEditor.GetAttributes: TPropertyAttributes;
begin
  Result := inherited GetAttributes + [paDialog] - [paSubProperties];
end;

{ TIBQuerySQLProperty }

procedure TIBQuerySQLProperty.Edit;
begin
  Query := TIBQuery(GetComponent(0));
  if Assigned(Query.Database) then
  begin
    FGetTableNamesProc := GetTableNames;
    FGetFieldNamesProc := GetFieldNames;
  end
  else
  begin
    FGetTableNamesProc := nil;
    FGetFieldNamesProc := nil;
  end;
  EditSQL;
end;

procedure TIBQuerySQLProperty.GetFieldNames(const TableName: string;
  List: TStrings);
var
  S : TStringList;
  i : Integer;
begin
  List.Clear;
  S := TStringList.Create;
  try
    S.sorted := true;
    Query.Database.GetFieldNames(QuoteIdentifier(Query.Database.SQLDialect, TableName), S);
    for i := 0 to S.Count - 1 do
      List.Add(S[i]);
  finally
    S.Free;
  end;
end;

procedure TIBQuerySQLProperty.GetTableNames(List: TStrings;
  SystemTables: Boolean);
begin
  InternalGetTableNames(Query.Database, List, SystemTables);
  TStringList(List).Sorted := True;
end;

{ TIBDatasetSQLProperty }

procedure TIBDatasetSQLProperty.Edit;
begin
  IBDataset := TIBDataset(GetComponent(0));
  if Assigned(IBDataSet.Database) then
  begin
    FGetTableNamesProc := GetTableNames;
    FGetFieldNamesProc := GetFieldNames;
  end
  else
  begin
    FGetTableNamesProc := nil;
    FGetFieldNamesProc := nil;
  end;
  EditSQL;
end;

procedure TIBDatasetSQLProperty.GetFieldNames(const TableName: string;
  List: TStrings);
var
  S : TStringList;
  i : Integer;
begin
  List.Clear;
  S := TStringList.Create;
  try
    S.sorted := true;
    IBDataset.Database.GetFieldNames(QuoteIdentifier(IBDataset.Database.SQLDialect, TableName), S);
    for i := 0 to S.Count - 1 do
      List.Add(S[i]);
  finally
    S.Free;
  end;
end;

procedure TIBDatasetSQLProperty.GetTableNames(List: TStrings;
  SystemTables: Boolean);
begin
  InternalGetTableNames(IBDataset.Database, List, SystemTables);
  TStringList(List).Sorted := True;
end;

{ TIBSQLProperty }

procedure TIBSQLProperty.Edit;
begin
  IBSQL := TIBSQL(GetComponent(0));
  if Assigned(IBSQL.Database) then
  begin
    FGetTableNamesProc := GetTableNames;
    FGetFieldNamesProc := GetFieldNames;
  end
  else
  begin
    FGetTableNamesProc := nil;
    FGetFieldNamesProc := nil;
  end;
  EditSQL;
end;

procedure TIBSQLProperty.GetFieldNames(const TableName: string;
  List: TStrings);
var
  S : TStringList;
  i : Integer;
begin
  List.Clear;
  S := TStringList.Create;
  try
    S.sorted := true;
    IBSQL.Database.GetFieldNames(QuoteIdentifier(IBSQL.Database.SQLDialect, TableName), S);
    for i := 0 to S.Count - 1 do
      List.Add(S[i]);
  finally
    S.Free;
  end;
end;

procedure TIBSQLProperty.GetTableNames(List: TStrings;
  SystemTables: Boolean);
begin
  InternalGetTableNames(IBSQL.Database, List, SystemTables);
  TStringList(List).Sorted := True;
end;

{ TIBUpdateSQLEditor }

procedure TIBUpdateSQLEditor.ExecuteVerb(Index: Integer);
begin
  if EditIBUpdateSQL(TIBUpdateSQL(Component)) then Designer.Modified;
end;

function TIBUpdateSQLEditor.GetVerb(Index: Integer): string;
begin
  case Index of
    0 : Result := SIBUpdateSQLEditor;
    2: Result := Format(SInterbaseExpressVersionEx, [IBX_Version]);
  end;
end;

function TIBUpdateSQLEditor.GetVerbCount: Integer;
begin
  Result := 2;
end;

{ TIBDataSetEditor }

procedure TIBDataSetEditor.EditSQL;
var
  SQLText: string;
  SQL: TStrings;
begin
  SQL := TStringList.Create;
  try
    SQL.Assign(TIBDataset(Component).SelectSQL);
    SQLText := SQL.Text;
    if (SQLEdit.EditSQL(SQLText, FGetTableNamesProc, FGetFieldNamesProc)) and
      (SQL.Text <> SQLText) then
    begin
      SQL.Text := SQLText;
      TIBDataset(Component).SelectSQL.Assign(SQL);
      Designer.Modified;
    end;
  finally
    SQL.free;
  end;
end;

procedure TIBDataSetEditor.ExecuteVerb(Index: Integer);
begin
  if Index < inherited GetVerbCount then
    inherited ExecuteVerb(Index) else
  begin
    Dec(Index, inherited GetVerbCount);
    case Index of
      0:
        if EditIBDataSet(TIBDataSet(Component)) then
          Designer.Modified;
      1: (Component as TIBDataSet).ExecSQL;
      2:
      begin
        IBDataset := Component as TIBDataset;
        if Assigned(IBDataSet.Database) then
        begin
          FGetTableNamesProc := GetTableNames;
          FGetFieldNamesProc := GetFieldNames;
        end
        else
        begin
          FGetTableNamesProc := nil;
          FGetFieldNamesProc := nil;
        end;
        EditSQL;
      end;
    end;
  end;
end;

function TIBDataSetEditor.GetVerb(Index: Integer): string;
begin
  if Index < inherited GetVerbCount then
    Result := inherited GetVerb(Index) else
  begin
    Dec(Index, inherited GetVerbCount);
    case Index of
      0: Result := SIBDataSetEditor;
      1: Result := SExecute;
      2: Result := SEditSQL;
      3: Result := Format(SInterbaseExpressVersionEx, [IBX_Version]);
    end;
  end;
end;

function TIBDataSetEditor.GetVerbCount: Integer;
begin
  Result := inherited GetVerbCount + 4;
end;

{ TIBEventListProperty }

function TIBEventListProperty.GetAttributes: TPropertyAttributes;
begin
  Result := inherited GetAttributes + [paDialog] - [paSubProperties];
end;

procedure TIBEventListProperty.Edit;
var
  Events: TStrings;
begin
  Events := TStringList.Create;
  try
    Events.Assign( TStrings(GetOrdValue));
    if EditAlerterEvents( Events) then SetOrdValue( longint(Events));
  finally
    Events.Free;
  end;
end;

{ TIBDatabaseEditor }
procedure TIBDatabaseEditor.ExecuteVerb(Index: Integer);
begin
  if Index < inherited GetVerbCount then
    inherited ExecuteVerb(Index) else
  begin
    Dec(Index, inherited GetVerbCount);
    case Index of
      0 : if EditIBDatabase(TIBDatabase(Component)) then Designer.Modified;
    end;
  end;
end;

function TIBDatabaseEditor.GetVerb(Index: Integer): string;
begin
  if Index < inherited GetVerbCount then
    Result := inherited GetVerb(Index) 
  else
  begin
    Dec(Index, inherited GetVerbCount);
    case Index of
      0 : Result := SIBDatabaseEditor;
      1 : Result := Format(SInterbaseExpressVersionEx, [IBX_Version]);
    end;
  end;
end;

function TIBDatabaseEditor.GetVerbCount: Integer;
begin
  Result := inherited GetVerbCount + 2;
end;

{ TIBTransactionEditor }

procedure TIBTransactionEditor.ExecuteVerb(Index: Integer);
begin
  case Index of
    0: if EditIBTransaction(TIBTransaction(Component)) then Designer.Modified;
  end;
end;

function TIBTransactionEditor.GetVerb(Index: Integer): string;
begin
  case Index of
    0: Result := SIBTransactionEditor;
    1: Result := Format(SInterbaseExpressVersionEx, [IBX_Version]);
  end;
end;

function TIBTransactionEditor.GetVerbCount: Integer;
begin
  Result := 2;
end;

{ TIBQueryEditor }

procedure TIBQueryEditor.EditSQL;
var
  SQLText: string;
  SQL: TStrings;
begin
  SQL := TStringList.Create;
  try
    SQL.Assign(TIBQuery(Component).SQL);
    SQLText := SQL.Text;
    if (SQLEdit.EditSQL(SQLText, FGetTableNamesProc, FGetFieldNamesProc)) and
      (SQL.Text <> SQLText) then
    begin
      SQL.Text := SQLText;
      TIBQuery(Component).SQL.Assign(SQL);
      Designer.Modified;
    end;
  finally
    SQL.free;
  end;
end;

procedure TIBQueryEditor.ExecuteVerb(Index: Integer);
begin
  if Index < inherited GetVerbCount then
    inherited ExecuteVerb(Index) else
  begin
    IBDataSet := Component as TIBQuery;
    Dec(Index, inherited GetVerbCount);
    case Index of
      0: (IBDataSet as TIBQuery).ExecSQL;
      1:
      begin
        if Assigned(IBDataSet.Database) then
        begin
          FGetTableNamesProc := GetTableNames;
          FGetFieldNamesProc := GetFieldNames;
        end
        else
        begin
          FGetTableNamesProc := nil;
          FGetFieldNamesProc := nil;
        end;
        EditSQL;
      end;
    end;
  end;
end;

function TIBQueryEditor.GetVerb(Index: Integer): string;
begin
  if Index < inherited GetVerbCount then
    Result := inherited GetVerb(Index) else
  begin
    Dec(Index, inherited GetVerbCount);
    case Index of
      0: Result := SExecute;
      1: Result := SEditSQL;
      2: Result := Format(SInterbaseExpressVersionEx, [IBX_Version]);
    end;
  end;
end;

function TIBQueryEditor.GetVerbCount: Integer;
begin
  Result := inherited GetVerbCount + 3;
end;

{ TIBStoredProcEditor }

procedure TIBStoredProcEditor.ExecuteVerb(Index: Integer);
begin
  if Index < inherited GetVerbCount then
    inherited ExecuteVerb(Index) else
  begin
    Dec(Index, inherited GetVerbCount);
    if Index = 0 then
      (Component as TIBStoredProc).ExecProc;
  end;
end;

function TIBStoredProcEditor.GetVerb(Index: Integer): string;
begin
  if Index < inherited GetVerbCount then
    Result := inherited GetVerb(Index) else
  begin
    Dec(Index, inherited GetVerbCount);
    case Index of
      0: Result := SExecute;
      1: Result := Format(SInterbaseExpressVersionEx, [IBX_Version]);
    end;
  end;
end;

function TIBStoredProcEditor.GetVerbCount: Integer;
begin
  Result := inherited GetVerbCount + 2;
end;

{ TIBStoredProcParamsProperty }

procedure TIBStoredProcParamsProperty.Edit;
var
  StoredProc: TIBStoredProc;
  Params: TParams;
begin
  StoredProc := (GetComponent(0) as TIBStoredProc);
  Params := TParams.Create(nil);
  try
    StoredProc.CopyParams(Params);
  finally
    Params.Free;
  end;
  inherited Edit;
end;

{ TIBTableFieldLinkProperty }

procedure TIBTableFieldLinkProperty.Edit;
begin
  FTable := DataSet as TIBTable;
  inherited Edit;
end;

function TIBTableFieldLinkProperty.GetIndexFieldNames: string;
begin
  Result := FTable.IndexFieldNames;
end;

function TIBTableFieldLinkProperty.GetMasterFields: string;
begin
  Result := FTable.MasterFields;
end;

procedure TIBTableFieldLinkProperty.SetIndexFieldNames(const Value: string);
begin
  FTable.IndexFieldNames := Value;
end;

procedure TIBTableFieldLinkProperty.SetMasterFields(const Value: string);
begin
  FTable.MasterFields := Value;
end;

{ TIBDatabaseSprig }

function TIBDatabaseSprig.AnyProblems: Boolean;
begin
  Result := (TIBDatabase(Item).DatabaseName = '') or
            (TIBDatabase(Item).DefaultTransaction = nil);
end;

function TIBDatabaseSprig.Caption: string;
begin
  Result := CaptionFor(TIBDatabase(Item).DatabaseName, UniqueName);
end;

{ TIBTransactionSprig }

function TIBTransactionSprig.AnyProblems: Boolean;
begin
  Result := TIBTransaction(Item).DefaultDatabase = nil;
end;

function TIBTransactionSprig.Caption: string;
begin
  if (TIBTransaction(Item).DefaultDatabase <> nil) and
     (TIBTransaction(Item).DefaultDatabase.DefaultTransaction = Item) then
    Result := CaptionFor(Format(SDefaultTransaction, [UniqueName]))
  else
    Result := inherited Caption;
end;

procedure TIBTransactionSprig.FigureParent;
begin
  SeekParent(TIBTransaction(Item).DefaultDatabase).Add(Self);
end;

function TIBTransactionSprig.DragDropTo(AItem: TSprig): Boolean;
begin
  Result := False;
  if AItem is TIBDatabaseSprig then
  begin
    Result := TIBDatabase(AItem.Item) <> TIBTransaction(Item).DefaultDatabase;
    if Result then
    begin
      TIBTransaction(Item).DefaultDatabase := TIBDatabase(AItem.Item);
      TIBDatabase(AItem.Item).DefaultTransaction := TIBTransaction(Item);
    end;
  end
end;

function TIBTransactionSprig.DragOverTo(AItem: TSprig): Boolean;
begin
  Result := (AItem is TIBDatabaseSprig);
end;

class function TIBTransactionSprig.PaletteOverTo(AParent: TSprig; AClass: TClass): Boolean;
begin
  Result := (AParent is TIBDatabaseSprig);
end;

{ support stuff for sprigs }

function IBAnyProblems(ATransaction: TIBTransaction; ADatabase: TIBDatabase): Boolean;
begin
  Result := (ATransaction = nil) or
            (ADatabase = nil) or
            (ATransaction.DefaultDatabase <> ADatabase);
end;

procedure IBFigureParent(ASprig: TSprig; ATransaction: TIBTransaction; ADatabase: TIBDatabase);
begin
  if ATransaction <> nil then
    ASprig.SeekParent(ATransaction).Add(ASprig)
  else if ADatabase <> nil then
    ASprig.SeekParent(ADatabase).Add(ASprig)
  else
    ASprig.Root.Add(ASprig);
end;

function IBDragOver(ASprig: TSprig): Boolean;
begin
  Result := (ASprig is TIBTransactionSprig) or
            (ASprig is TIBDatabaseSprig);
end;

function IBDropOver(AParent: TSprig; var ATransaction: TIBTransaction; var ADatabase: TIBDatabase): Boolean;
var
  vParentTransaction: TIBTransaction;
  vParentDatabase: TIBDatabase;
begin
  Result := False;
  if AParent is TIBTransactionSprig then
  begin
    vParentTransaction := TIBTransaction(AParent.Item);
    Result := vParentTransaction <> ATransaction;
    if Result then
      ATransaction := vParentTransaction;
    if (vParentTransaction.DefaultDatabase = nil) or
       (ADatabase <> vParentTransaction.DefaultDatabase) then
    begin
      Result := True;
      ADatabase := vParentTransaction.DefaultDatabase;
    end;
  end else if AParent is TIBDatabaseSprig then
  begin
    vParentDatabase := TIBDatabase(AParent.Item);
    Result := vParentDatabase <> ADatabase;
    if Result then
      ADatabase := vParentDatabase;
    if (vParentDatabase.DefaultTransaction = nil) or
       (ATransaction <> vParentDatabase.DefaultTransaction) then
    begin
      Result := True;
      ATransaction := vParentDatabase.DefaultTransaction;
    end;
  end;
end;

{ TIBSQLSprig }

function TIBSQLSprig.AnyProblems: Boolean;
begin
  Result := IBAnyProblems(TIBSQL(Item).Transaction,
                          TIBSQL(Item).Database) or
            (TIBSQL(Item).SQL.Count = 0);
end;

function TIBSQLSprig.DragDropTo(AItem: TSprig): Boolean;
var
  vTransaction: TIBTransaction;
  vDatabase: TIBDatabase;
begin
  with TIBSQL(Item) do
  begin
    vTransaction := Transaction;
    vDatabase := Database;
    Result := IBDropOver(AItem, vTransaction, vDatabase);
    if Result then
    begin
      Transaction := vTransaction;
      Database := vDatabase;
    end;
  end;
end;

function TIBSQLSprig.DragOverTo(AItem: TSprig): Boolean;
begin
  Result := IBDragOver(AItem);
end;

procedure TIBSQLSprig.FigureParent;
begin
  IBFigureParent(Self, TIBSQL(Item).Transaction,
                       TIBSQL(Item).Database);
end;

class function TIBSQLSprig.PaletteOverTo(AParent: TSprig; AClass: TClass): Boolean;
begin
  Result := IBDragOver(AParent);
end;

{ TIBCustomDataSetSprig }

function TIBCustomDataSetSprig.AnyProblems: Boolean;
begin
  Result := IBAnyProblems(TIBCustomDataSet(Item).Transaction,
                          TIBCustomDataSet(Item).Database);
end;

procedure TIBCustomDataSetSprig.FigureParent;
begin
  IBFigureParent(Self, TIBCustomDataSet(Item).Transaction,
                       TIBCustomDataSet(Item).Database);
end;

function TIBCustomDataSetSprig.DragDropTo(AItem: TSprig): Boolean;
var
  vTransaction: TIBTransaction;
  vDatabase: TIBDatabase;
begin
  with TIBCustomDataSet(Item) do
  begin
    vTransaction := Transaction;
    vDatabase := Database;
    Result := IBDropOver(AItem, vTransaction, vDatabase);
    if Result then
    begin
      Transaction := vTransaction;
      Database := vDatabase;
    end;
  end;
end;

function TIBCustomDataSetSprig.DragOverTo(AItem: TSprig): Boolean;
begin
  Result := IBDragOver(AItem);
end;

class function TIBCustomDataSetSprig.PaletteOverTo(AParent: TSprig; AClass: TClass): Boolean;
begin
  Result := IBDragOver(AParent);
end;

function TIBCustomDataSetSprig.GetDSDesignerClass: TDSDesignerClass;
begin
  Result := TIBDSDesigner;
end;

{ TIBStoredProcSprig }

function TIBStoredProcSprig.AnyProblems: Boolean;
begin
  Result := inherited AnyProblems or
            (TIBStoredProc(Item).StoredProcName = '');
end;

function TIBStoredProcSprig.Caption: string;
begin
  Result := CaptionFor(TIBStoredProc(Item).StoredProcName, UniqueName);
end;

{ TIBTableSprig }

function TIBTableSprig.AnyProblems: Boolean;
begin
  Result := inherited AnyProblems or
            (TIBTable(Item).TableName = '');
end;

function TIBTableSprig.Caption: string;
begin
  Result := CaptionFor(TIBTable(Item).TableName, UniqueName);
end;

{ TIBQuerySprig }

function TIBQuerySprig.AnyProblems: Boolean;
begin
  Result := inherited AnyProblems or
            (TIBQuery(Item).SQL.Count = 0);
end;

{ TIBDatasetSprig }

function TIBDatasetSprig.AnyProblems: Boolean;
begin
  Result := inherited AnyProblems or
            (TIBDataset(Item).SelectSQL.Count = 0);
end;

{ TIBDatabaseInfoSprig }

class function TIBDatabaseInfoSprig.ParentProperty: string;
begin
  Result := 'Database'; { do not localize }
end;

{ TIBUpdateSQLSprig }

function TIBUpdateSQLSprig.AnyProblems: Boolean;
begin
  with TIBUpdateSQL(Item) do
    Result := (ModifySQL.Count = 0) and
              (InsertSQL.Count = 0) and
              (DeleteSQL.Count = 0) and
              (RefreshSQL.Count = 0);
end;

{ TIBEventsSprig }

function TIBEventsSprig.AnyProblems: Boolean;
begin
  Result := inherited AnyProblems or
            (TIBEvents(Item).Events.Count = 0);
end;

class function TIBEventsSprig.ParentProperty: string;
begin
  Result := 'Database'; { do not localize }
end;

{ TIBTableMasterDetailBridge }

function TIBTableMasterDetailBridge.CanEdit: Boolean;
begin
  Result := True;
end;

function TIBTableMasterDetailBridge.Caption: string;
begin
  if TIBTable(Omega.Item).MasterFields = '' then
    Result := SNoMasterFields
  else
    Result := TIBTable(Omega.Item).MasterFields;
end;

function TIBTableMasterDetailBridge.Edit: Boolean;
var
  vPropEd: TIBTableFieldLinkProperty;
begin
  vPropEd := TIBTableFieldLinkProperty.CreateWith(TDataSet(Omega.Item));
  try
    vPropEd.Edit;
    Result := vPropEd.Changed;
  finally
    vPropEd.Free;
  end;
end;

class function TIBTableMasterDetailBridge.GetOmegaSource(
  AItem: TPersistent): TDataSource;
begin
  Result := TIBTable(AItem).MasterSource;
end;

class function TIBTableMasterDetailBridge.OmegaIslandClass: TIslandClass;
begin
  Result := TIBTableIsland;
end;

class procedure TIBTableMasterDetailBridge.SetOmegaSource(
  AItem: TPersistent; ADataSource: TDataSource);
begin
  TIBTable(AItem).MasterSource := ADataSource;
end;

{ TIBQueryMasterDetailBridge }

function TIBQueryMasterDetailBridge.Caption: string;
begin
  Result := SParamsFields;
end;

class function TIBQueryMasterDetailBridge.GetOmegaSource(
  AItem: TPersistent): TDataSource;
begin
  Result := TIBQuery(AItem).DataSource;
end;

class function TIBQueryMasterDetailBridge.OmegaIslandClass: TIslandClass;
begin
  Result := TIBQueryIsland;
end;

class function TIBQueryMasterDetailBridge.RemoveMasterFieldsAsWell: Boolean;
begin
  Result := False;
end;

class procedure TIBQueryMasterDetailBridge.SetOmegaSource(
  AItem: TPersistent; ADataSource: TDataSource);
begin
  TIBQuery(AItem).DataSource := ADataSource;
end;

{ TIBCustomDataSetIsland }

function TIBCustomDataSetIsland.VisibleTreeParent: Boolean;
begin
  Result := False;
end;

{ TIBSQLIsland }

function TIBSQLIsland.VisibleTreeParent: Boolean;
begin
  Result := False;
end;

{ TIBTransactionIsland }

function TIBTransactionIsland.VisibleTreeParent: Boolean;
begin
  Result := TIBTransaction(Sprig.Item).DefaultDatabase = nil;
end;

{ TIBGeneratorFieldProperty }

procedure TIBGeneratorFieldProperty.Edit;
const
  GENSQL =
    'SELECT RDB$GENERATOR_NAME FROM RDB$GENERATORS ' +  {Do not localize}
    'WHERE RDB$SYSTEM_FLAG = 0 OR RDB$SYSTEM_FLAG is NULL'; {Do not localize}
var
  DataSet: TIBCustomDataSet;
  Gen : TIBGeneratorField;
  sqlGen : TIBSQL;
  DidActivate, DidConnect : Boolean;
  I : Integer;
begin
  DidActivate := false;
  DidConnect := false;
  DataSet := TIBCustomDataSet(GetComponent(0));
  if Dataset.Database = nil then
    IBError(ibxeDatabaseNotAssigned, []);
  if DataSet.Transaction = nil then
    IBError(ibxeTransactionNotAssigned, []);
  with TfrmGeneratorEditor.Create(nil) do
  try
    DataSet.FieldDefs.Update;
    cbxFields.Items.BeginUpdate;
    try
      cbxFields.Items.Clear;
      for I := 0 to DataSet.FieldDefs.Count - 1 do
        cbxFields.Items.Add(DataSet.FieldDefs[I].Name);
    finally
      cbxFields.Items.EndUpdate;
    end;
    Gen := TIBGeneratorField(GetOrdProp(DataSet, 'GeneratorField')); {Do not localize}
    sqlGen := TIBSQL.Create(DataSet.Database);
    sqlGen.Transaction := DataSet.Transaction;
    try
      sqlGen.SQL.Text := GENSQL;
      if not DataSet.Database.Connected then
      begin
        DataSet.Database.Connected := true;
        DidConnect := true;
      end;
      if not DataSet.Transaction.Active then
      begin
        DataSet.Transaction.Active := true;
        DidActivate := true;
      end;
      sqlGen.ExecQuery;
      while not sqlGen.Eof do
      begin
        cbxGenerators.Items.Add(sqlGen.Fields[0].AsString);
        sqlGen.Next;
      end;
    finally
      sqlGen.Free;
      if DidActivate then
        DataSet.Transaction.Active := false;
      if DidConnect then
        DataSet.Database.Connected := false;
    end;
    cbxGenerators.Text := Gen.Generator;
    cbxFields.Text := Gen.Field;
    grpApplyEvent.ItemIndex := Ord(Gen.ApplyEvent);
    Caption := DataSet.Name + ' GeneratorField';  {Do not localize}
    if ShowModal = mrOK then
    begin
      Gen.Generator := Trim(cbxGenerators.Text);
      Gen.Field := Trim(cbxFields.Text);
      Gen.ApplyEvent := TIBGeneratorApplyEvent(grpApplyEvent.ItemIndex);
      Gen.IncrementBy := StrToInt(edtIncrement.Text); 
      Modified;
    end;
  finally
    Free;
  end;
end;

function TIBGeneratorFieldProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog, paReadOnly];
end;

function TIBGeneratorFieldProperty.GetValue: string;
begin
  Result := TIBGeneratorField(GetOrdProp(GetComponent(0), 'GeneratorField')).ValueName; {Do not localize}
end;

{ TIBDataSetBaseEditor }

function TIBDataSetBaseEditor.GetDSDesignerClass: TDSDesignerClass;
begin
  Result := TIBDSDesigner;
end;

procedure TIBDataSetBaseEditor.GetFieldNames(const TableName: string;
  List: TStrings);
var
  S : TStringList;
  i : Integer;
begin
  List.Clear;
  S := TStringList.Create;
  try
    S.sorted := true;
    IBDataset.Database.GetFieldNames(QuoteIdentifier(IBDataset.Database.SQLDialect, TableName), S);
    for i := 0 to S.Count - 1 do
      List.Add(S[i]);
  finally
    S.Free;
  end;
end;

procedure TIBDataSetBaseEditor.GetTableNames(List: TStrings;
  SystemTables: Boolean);
begin
  InternalGetTableNames(IBDataset.Database, List, SystemTables);
  TStringList(List).Sorted := True;
end;

{ TIBServiceEditor }

procedure TIBServiceEditor.ExecuteVerb(Index: Integer);
begin
  if Index < inherited GetVerbCount then
    inherited ExecuteVerb(Index) else
  begin
    Dec(Index, inherited GetVerbCount);
    case Index of
      0 :
        if EditIBService(TIBCustomService(Component)) then
          Designer.Modified;
    end;
  end;
end;

function TIBServiceEditor.GetVerb(Index: Integer): string;
begin
  if Index < inherited GetVerbCount then
    Result := inherited GetVerb(Index)
  else
  begin
    Dec(Index, inherited GetVerbCount);
    case Index of
      0 : Result := SIBServiceEditor;
      1 : Result := Format(SInterbaseExpressVersionEx, [IBX_Version]);
    end;
  end;
end;

function TIBServiceEditor.GetVerbCount: Integer;
begin
  Result := inherited GetVerbCount + 2;
end;

{ TIBPageSizeProperty }

function TIBPageSizeProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paValueList, paSortList];
end;

procedure TIBPageSizeProperty.GetValues(Proc: TGetStrProc);
begin
  Proc('1024'); {do not localize}
  Proc('2048'); {do not localize}
  Proc('4096'); {do not localize}
  Proc('8192'); {do not localize}
end;

{ TIBServiceFilesProperty }

procedure TIBRestoreFilesProperty.Edit;
var
  t : TStrings;
begin
  t := TStringList.Create;
  t.Assign(TStrings(GetOrdValue));
  with TfrmIBRestoreEditor.Create(Application, t) do
  try
    if GetName = 'BackupFile' then   {do not localize}
    begin
      Caption := SBackupCaption;
      if GetComponent(0).ClassName = 'TIBBackupService' then   {do not localize}
        sgDatabaseFiles.Cells[1,0] := SRestoreSize
      else
        sgDatabaseFiles.ColCount := 1;
    end;
    if ShowModal = mrOK then
    begin
      GetStrings(t);
      SetOrdValue(Longint(t));
    end;
  finally
    t.Free;
    Free;
  end;
end;

function TIBRestoreFilesProperty.GetAttributes: TPropertyAttributes;
begin
  Result := inherited GetAttributes + [paDialog] - [paSubProperties];
end;

function TIBRestoreFilesProperty.GetValue: String;
var
  t : TStrings;
begin
  t := TStrings(GetOrdValue);
  if t.Count > 0 then
    Result := t[0]
  else
    Result := '';
end;

{ TIBBackupFilesProperty }

procedure TIBBackupFilesProperty.Edit;
var
  t : TStrings;
begin
  t := TStrings(GetOrdProp(GetComponent(0), 'BackupFile')); {do not localize}
  with TfrmIBRestoreEditor.Create(Application, t) do
  try
    Caption := SBackupCaption;
    ShowModal;
  finally
    Free;
  end;
end;

function TIBBackupFilesProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog, paReadOnly];
end;

function TIBBackupFilesProperty.GetValue: String;
var
  t : TStrings;
begin
  t := TStrings(GetOrdProp(GetComponent(0), 'Backupfile')); {do not localize}
  if t.Count > 0 then
    Result := t[0]
  else
    Result := '';
end;

{ TIBSecurityEditor }

procedure TIBSecurityEditor.ExecuteVerb(Index: Integer);
begin
  case Index of
    0 :
      if EditIBSecurity(TIBCustomService(Component)) then
        Designer.Modified;
  end;
end;

{ TIBDSDesigner }

function TIBDSDesigner.DoCreateField(const FieldName: string;
  Origin: string): TField;
var
  FieldAliasName, RelationName : String;
  f : TIBXSQLVar;
  DidActivate : Boolean;
begin
  DidActivate := false;
  Result := inherited DoCreateField(FieldName, Origin);
  with (DataSet as TIBCustomDataSet) do
  begin
    if not Transaction.InTransaction then
    begin
      Transaction.StartTransaction;
      DidActivate := true;
    end;
    f := Current.ByName(FieldName);
    if Assigned(f) then
    begin
      { Get the field name }
      SetString(FieldAliasName, f.Data^.sqlname, f.data^.sqlname_length);
      SetString(RelationName, f.data^.relname, f.data^.relname_length);
      if (RelationName <> '') and (FieldAliasName <> '') then
        Result.Origin := QuoteIdentifier(Database.SQLDialect, RelationName) + '.' + {do not localize}
                      QuoteIdentifier(Database.SQLDialect, FieldAliasName);
    end;

    if DidActivate then
      Transaction.Commit;
  end;
end;

end.
