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

unit IBUtils;

interface

uses
  Windows, Classes, SysUtils;

const
  CRLF = #13 + #10;
  CR   = #13;
  LF   = #10;
  TAB  = #9;
  NULL_TERMINATOR = #0;

function Max(n1, n2: Integer): Integer;
function Min(n1, n2: Integer): Integer;
function RandomString(iLength: Integer): String;
function RandomInteger(iLow, iHigh: Integer): Integer;
function StripString(st: String; CharsToStrip: String): String;
function FormatIdentifier(Dialect: Integer; Value: String): String;
function FormatIdentifierValue(Dialect: Integer; Value: String): String;
function ExtractIdentifier(Dialect: Integer; Value: String): String;
function QuoteIdentifier(Dialect: Integer; Value: String): String;

var
  CopyMasterFieldToDetail : Boolean;

implementation

function Max(n1, n2: Integer): Integer;
begin
  if (n1 > n2) then
    result := n1
  else
    result := n2;
end;

function Min(n1, n2: Integer): Integer;
begin
  if (n1 < n2) then
    result := n1
  else
    result := n2;
end;

function RandomString(iLength: Integer): String;
begin
  result := '';
  while Length(result) < iLength do
    result := result + IntToStr(RandomInteger(0, High(Integer)));
  if Length(result) > iLength then
    result := Copy(result, 1, iLength);
end;

function RandomInteger(iLow, iHigh: Integer): Integer;
begin
  result := Random(iHigh - iLow) + iLow;
end;

function StripString(st: String; CharsToStrip: String): String;
var
  i: Integer;
begin
  result := '';
  for i := 1 to Length(st) do begin
    if AnsiPos(st[i], CharsToStrip) = 0 then
      result := result + st[i];
  end;
end;

function FormatIdentifier(Dialect: Integer; Value: String): String;
begin
  Value := Trim(Value);
  if Dialect = 1 then
    Value := AnsiUpperCase(Value)
  else
    if (Value <> '') and (Value[1] = '"') then
      Value := '"' + StringReplace (TrimRight(Value), '"', '""', [rfReplaceAll]) + '"'
    else
      Value := AnsiUpperCase(Value);
  Result := Value;
end;

function FormatIdentifierValue(Dialect: Integer; Value: String): String;
begin
  Value := Trim(Value);
  if Dialect = 1 then
    Value := AnsiUpperCase(Value)  
  else
  begin
    if (Value <> '') and (Value[1] = '"') then
    begin
      Delete(Value, 1, 1);
      Delete(Value, Length(Value), 1);
      Value := StringReplace (Value, '""', '"', [rfReplaceAll]);
    end
    else
      Value := AnsiUpperCase(Value);
  end;
  Result := Value;
end;

function ExtractIdentifier(Dialect: Integer; Value: String): String;
begin
  Value := Trim(Value);
  if Dialect = 1 then
    Value := AnsiUpperCase(Value)
  else
  begin
    if (Value <> '') and (Value[1] = '"') then
    begin
      Delete(Value, 1, 1);
      Delete(Value, Length(Value), 1);
      Value := StringReplace (Value, '""', '"', [rfReplaceAll]);
    end
    else
      Value := AnsiUpperCase(Value);
  end;
  Result := Value;
end;

function QuoteIdentifier(Dialect: Integer; Value: String): String;
begin
  if Dialect = 1 then
    Value := AnsiUpperCase(Trim(Value))
  else
    Value := '"' + StringReplace (Value, '"', '""', [rfReplaceAll]) + '"';
  Result := Value;
end;

initialization
  CopyMasterFieldToDetail := false;
end.
