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

unit IBEventsEditor;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, StdCtrls, Grids, IBEvents;

type
  TIBEventsEditor = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    cEvents: TStringGrid;
    RequestedEvents: TLabel;
    bOK: TButton;
    bCancel: TButton;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function EditAlerterEvents( Events: TStrings): Boolean;

implementation

{$R *.DFM}

function EditAlerterEvents( Events: TStrings): Boolean;
var
  i: integer;
begin
  result := false;
  with TIBEventsEditor.Create(Application) do
  begin
    try
      cEvents.RowCount := Events.Count;
      for i := 1 to cEvents.RowCount do
        cEvents.Cells[0, i-1] := IntToStr(i);
      for i := 0 to Events.Count-1 do
        cEvents.Cells[1, i] := Events[i];
      if ShowModal = mrOk then
      begin
        result := true;
        Events.Clear;
        for i := 0 to cEvents.RowCount - 1 do
          if length( cEvents.Cells[1, i]) <> 0 then
            Events.Add( cEvents.Cells[1, i]);
      end;
    finally
      Free;
    end;
  end;
end;

procedure TIBEventsEditor.Button1Click(Sender: TObject);
begin
  cEvents.RowCount := cEvents.RowCount + 1;
  cEvents.Cells[0, cEvents.RowCount - 1] := IntToStr(cEvents.RowCount);
end;

// Scale the TStringGrid for fonts since it does not automatically scale
procedure TIBEventsEditor.FormCreate(Sender: TObject);
begin
  cEvents.DefaultRowHeight := trunc(16 * (PixelsPerInch / 96));
  cEvents.ColWidths[1] := trunc(227 * (cEvents.Width / 271));
end;

end.
