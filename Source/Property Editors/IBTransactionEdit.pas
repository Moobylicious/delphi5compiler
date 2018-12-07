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

unit IBTransactionEdit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, IBDatabase, IB, ExtCtrls, IBXConst;

type
  TIBTransactionEditForm = class(TForm)
    GroupBox1: TGroupBox;
    HelpBtn: TButton;
    Cancelbtn: TButton;
    OKBtn: TButton;
    rbSnapShot: TRadioButton;
    rbReadCommitted: TRadioButton;
    rbReadOnlyTableStability: TRadioButton;
    rbReadWriteTableStability: TRadioButton;
    TransactionParams: TMemo;
    Panel1: TPanel;
    Label1: TLabel;
    procedure OKBtnClick(Sender: TObject);
    procedure rbSnapShotClick(Sender: TObject);
    procedure rbReadCommittedClick(Sender: TObject);
    procedure rbReadOnlyTableStabilityClick(Sender: TObject);
    procedure rbReadWriteTableStabilityClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure HelpBtnClick(Sender: TObject);
    procedure TransactionParamsClick(Sender: TObject);
    procedure TransactionParamsExit(Sender: TObject);

  private
    { Private declarations }
    Transaction: TIBTransaction;
    function Edit: Boolean;
    procedure ParseParams;
    procedure ClearParamSelection;

  public
    { Public declarations }
  end;

var
  IBTransactionEditForm: TIBTransactionEditForm;

  function EditIBtransaction(Atransaction: TIBtransaction): Boolean;

implementation

{$R *.DFM}

uses
  LibHelp;

function EditIBtransaction(ATransaction: TIBtransaction): Boolean;
begin
  with TIBtransactionEditForm.Create(Application) do
  try
    Transaction := ATransaction;
    Result := Edit;
  finally
    Free;
  end;
end;

function TIBtransactionEditForm.Edit: Boolean;
begin
  TransactionParams.Lines := Transaction.Params;
  ParseParams;
  Result := False;
  if ShowModal = mrOk then
  begin
    Transaction.Params := TransactionParams.Lines;
    Result := True;
  end;
end;

type
  TTransactionParam = (concurrency, read_committed, rec_version, nowait,
    consistency, read, write);
  TTransactionParams = set of TTransactionParam;

procedure TIBTransactionEditForm.ParseParams;
var
  I: Integer;
  st: string;
  Value: TTransactionParams;

begin
  Value := [];
  for I := 0 to TransactionParams.Lines.Count - 1 do
  begin
    st := LowerCase(Trim(TransactionParams.Lines[I]));
    if st = '' then    {do not localize}
      continue;
    if st = 'concurrency' then  {do not localize}
      Include(Value, concurrency)
    else if st = 'read_committed' then  {do not localize}
      Include(Value, read_committed)
    else if st = 'rec_version' then  {do not localize}
      Include(Value, rec_version)
    else if st = 'nowait' then    {do not localize}
      Include(Value, nowait)
    else if st = 'read' then    {do not localize}
      Include(Value, read)
    else if st = 'write' then     {do not localize}
      Include(Value, write)
    else if st = 'consistency' then   {do not localize}
      Include(Value, consistency)
    else begin
      Value := [];
      break;
    end;
  end;
  ClearParamSelection;
  if Value = [concurrency, nowait] then
    rbSnapShot.Checked := True
  else if Value = [read_committed, rec_version, nowait] then
    rbReadCommitted.Checked := True
  else if Value = [read, consistency] then
    rbReadOnlyTableStability.Checked := True
  else if Value = [write, consistency] then
    rbReadWriteTableStability.Checked := True;
end;

procedure TIBTransactionEditForm.ClearParamSelection;
begin
  rbSnapShot.Checked := False;
  rbReadCommitted.Checked := False;
  rbReadOnlyTableStability.Checked := False;
  rbReadWriteTableStability.Checked := False;
end;

procedure TIBTransactionEditForm.OKBtnClick(Sender: TObject);
begin
  ModalResult := mrNone;
  if Transaction.Active then
  begin
    if MessageDlg(SCommitTransaction, mtConfirmation,
      mbOkCancel, 0) <> mrOk then Exit;
    Transaction.Rollback;
  end;
  ModalResult := mrOk;
end;

procedure TIBTransactionEditForm.FormCreate(Sender: TObject);
begin
  HelpContext := hcDIBTransactionEdit;
end;

procedure TIBTransactionEditForm.HelpBtnClick(Sender: TObject);
begin
  Application.HelpContext(HelpContext);
end;

procedure TIBTransactionEditForm.rbSnapShotClick(Sender: TObject);
begin
  TransactionParams.clear;
  TransactionParams.Lines.Add('concurrency'); { do not localize }
  TransactionParams.Lines.Add('nowait'); { do not localize }
end;

procedure TIBTransactionEditForm.rbReadCommittedClick(Sender: TObject);
begin
  TransactionParams.clear;
  TransactionParams.Lines.Add('read_committed'); { do not localize }
  TransactionParams.Lines.Add('rec_version'); { do not localize }
  TransactionParams.Lines.Add('nowait'); { do not localize }
end;

procedure TIBTransactionEditForm.rbReadOnlyTableStabilityClick(Sender: TObject);
begin
  TransactionParams.clear;
  TransactionParams.Lines.Add('read'); { do not localize }
  TransactionParams.Lines.Add('consistency'); { do not localize }
end;

procedure TIBTransactionEditForm.rbReadWriteTableStabilityClick(Sender: TObject);
begin
  TransactionParams.clear;
  TransactionParams.Lines.Add('write'); { do not localize }
  TransactionParams.Lines.Add('consistency'); { do not localize }
end;

procedure TIBTransactionEditForm.TransactionParamsClick(Sender: TObject);
begin
  ClearParamSelection;
end;

procedure TIBTransactionEditForm.TransactionParamsExit(Sender: TObject);
begin
  ParseParams;
end;

end.
