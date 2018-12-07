{ ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: 
  :: QuickReport 3.0 for Delphi and C++Builder               :: 
  ::                                                         :: 
  :: QRENVED.PAS - ENVIRONMENT EDITOR                        :: 
  ::                                                         :: 
  :: Copyright (c) 1998 QuSoft AS                            :: 
  :: All Rights Reserved                                     :: 
  ::                                                         :: 
  :: web: http://www.qusoft.no                               :: 
  ::                                                         :: 
  ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: } 
 
unit QREnvEd; 
 
interface 
 
uses 
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, QRExpr, 
  Grids, StdCtrls, Buttons, QR3Const; 
 
type 
  TQREnvironmentEditor = class(TForm) 
    VariableOKBtn: TButton; 
    AvailableGB: TGroupBox; 
    UDFGrid: TStringGrid; 
    DeleteBtn: TButton; 
    EditBtn: TButton; 
    AddBtn: TButton; 
    LocalCB: TRadioButton; 
    GlobalCB: TRadioButton; 
    NewEntryGB: TGroupBox; 
    Label1: TLabel; 
    Label2: TLabel; 
    Name: TEdit; 
    Expression: TEdit; 
    SpeedButton1: TSpeedButton; 
    NewOKBtn: TButton; 
    NewCancelBtn: TButton; 
    procedure FormCreate(Sender: TObject); 
    procedure UDFGridSetEditText(Sender: TObject; ACol, ARow: Integer; 
      const Value: String); 
    procedure EditBtnClick(Sender: TObject); 
    procedure LocalCBClick(Sender: TObject); 
    procedure VariableOKBtnClick(Sender: TObject); 
    procedure NewOKBtnClick(Sender: TObject); 
    procedure NewCancelBtnClick(Sender: TObject); 
    procedure AddBtnClick(Sender: TObject); 
    procedure SpeedButton1Click(Sender: TObject); 
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean); 
  private 
    CloseDialog : boolean; 
    NewResult : integer; 
    FEnvironment : TQREvEnvironment; 
    function WorkEnvironment : TQREvEnvironment; 
    function GetNew(var AName, AExpr : string) : boolean; 
  public 
    procedure PopulateGrid; 
    property Environment : TQREvEnvironment read FEnvironment write FEnvironment; 
  end; 
 
procedure EditEnvironment(AEnvironment : TQREvEnvironment; AllowGlobalEnv : boolean; ParentControl : TWinControl); 
 
implementation 
 
uses 
  QRExpBld; 
 
{$R *.DFM} 
 
function TQREnvironmentEditor.WorkEnvironment : TQREvEnvironment; 
begin 
  if LocalCB.Checked then 
    Result := Environment 
  else 
    Result := QRGlobalEnvironment; 
end; 
 
procedure TQREnvironmentEditor.PopulateGrid; 
var 
  I : integer; 
begin 
  if WorkEnvironment <> nil then 
  begin 
    UDFGrid.RowCount := WorkEnvironment.Count + 1; 
    for I := 0 to WorkEnvironment.Count - 1 do 
    begin 
      UDFGrid.Cells[0, I + 1] := WorkEnvironment[I]; 
      UDFGrid.Cells[1, I + 1] := TQREvEmbeddedFunction(WorkEnvironment.Objects[I]).Expression; 
    end; 
  end; 
end; 
 
procedure TQREnvironmentEditor.FormCreate(Sender: TObject); 
begin 
  UDFGrid.Cells[0, 0] := SqrName; 
  UDFGrid.Cells[1, 0] := SqrExpression; 
  Environment := nil; 
end; 
 
procedure TQREnvironmentEditor.UDFGridSetEditText(Sender: TObject; ACol, ARow: Integer; const Value: String); 
begin 
  if ACol = 0 then 
    WorkEnvironment[ARow - 1] := AnsiUppercase(Value) 
  else 
    if not WorkEnvironment.Prepared then 
    begin 
      TQREvEmbeddedFunction(WorkEnvironment.Objects[ARow - 1]).Free; 
      WorkEnvironment.Objects[ARow - 1] := TQREvEmbeddedFunction.Create(Value); 
    end else 
      UDFGrid.Cells[1, ARow] := TQREvEmbeddedFunction(WorkEnvironment.Objects[ARow - 1]).Expression; 
end; 
 
procedure TQREnvironmentEditor.EditBtnClick(Sender: TObject); 
var 
  aExpression : string; 
  aName : string; 
begin 
  with UDFGrid do 
  begin 
    aName := Cells[0, Row]; 
    aExpression := TQREvEmbeddedFunction(WorkEnvironment.Objects[Row - 1]).Expression; 
    if GetExpression(aName, AExpression, self, self, Environment) then 
    begin 
      Cells[1, Row] := AExpression; 
      UDFGridSetEditText(Self, 1, Row, AExpression); 
    end; 
  end; 
end; 
 
procedure TQREnvironmentEditor.LocalCBClick(Sender: TObject); 
begin 
  PopulateGrid; 
end; 
 
procedure EditEnvironment(AEnvironment : TQREvEnvironment; AllowGlobalEnv : boolean; ParentControl : TWinControl); 
begin 
  with TQREnvironmentEditor.Create(Application) do 
  try 
    if ParentControl <> nil then 
    begin 
//      Parent := ParentControl; 
//      BorderStyle := bsNone; 
//      Top := ParentControl.Top; 
//      Left := ParentControl.Left; 
//      position := poDesigned; 
//      BringToFront; 
    end; 
    if not AllowGlobalEnv then 
      GlobalCB.Enabled := false; 
    if AEnvironment = nil then 
    begin 
      LocalCB.Enabled := false; 
      GlobalCB.Checked := true; 
    end else 
      Environment := AEnvironment; 
    PopulateGrid; 
    CloseDialog := false; 
    ShowModal; 
    repeat 
      Application.HandleMessage 
    until CloseDialog; 
  finally 
    Free 
  end; 
end; 
 
procedure TQREnvironmentEditor.VariableOKBtnClick(Sender: TObject); 
begin 
  CloseDialog := true; 
end; 
 
 
function TQREnvironmentEditor.GetNew(var AName, AExpr : string) : boolean; 
begin 
  AddBtn.Visible := false; 
  EditBtn.Visible := false; 
  DeleteBtn.Visible := false; 
  VariableOKBtn.Visible := false; 
  NewEntryGB.BringToFront; 
  NewResult := 0; 
  repeat 
    Application.HandleMessage 
  until NewResult <> 0; 
  if NewResult = 1 then 
  begin 
    AName := Name.Text; 
    AExpr := Expression.Text; 
    Result := true; 
  end else 
    Result := false; 
  AddBtn.Visible := true; 
  EditBtn.Visible := true; 
  DeleteBtn.Visible := true; 
  VariableOKBtn.Visible := true; 
  AvailableGB.BringToFront; 
end; 
 
procedure TQREnvironmentEditor.NewOKBtnClick(Sender: TObject); 
begin 
  NewResult := 1; 
end; 
 
procedure TQREnvironmentEditor.NewCancelBtnClick(Sender: TObject); 
begin 
  NewResult := 2; 
end; 
 
procedure TQREnvironmentEditor.AddBtnClick(Sender: TObject); 
var 
  NewName : string; 
  NewExpr : string; 
begin 
  if GetNew(NewName, NewExpr) then 
  begin 
    WorkEnvironment.AddFunction(NewName, NewExpr); 
    PopulateGrid; 
  end; 
end; 
 
procedure TQREnvironmentEditor.SpeedButton1Click(Sender: TObject); 
var 
  AName : string; 
  AExpr : string; 
begin 
  AName := Name.Text; 
  AExpr := Expression.Text; 
  if GetExpression(AName, AExpr, self, self, Environment) then 
    Expression.Text := AExpr; 
end; 
 
procedure TQREnvironmentEditor.FormCloseQuery(Sender: TObject; 
  var CanClose: Boolean); 
begin 
  CloseDialog := true; 
  CanClose := True; 
end; 
 
end. 