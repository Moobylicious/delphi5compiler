unit CrystalDataObject_TLB;

// ************************************************************************ //
// WARNING                                                                    
// -------                                                                    
// The types declared in this file were generated from data read from a       
// Type Library. If this type library is explicitly or indirectly (via        
// another type library referring to this type library) re-imported, or the   
// 'Refresh' command of the Type Library Editor activated while editing the   
// Type Library, the contents of this file will be regenerated and all        
// manual modifications will be lost.                                         
// ************************************************************************ //

// PASTLWTR : $Revision:   1.88.1.0.1.0  $
// File generated on 14/12/2017 16:36:56 from Type Library described below.

// *************************************************************************//
// NOTE:                                                                      
// Items guarded by $IFDEF_LIVE_SERVER_AT_DESIGN_TIME are used by properties  
// which return objects that may need to be explicitly created via a function 
// call prior to any access via the property. These items have been disabled  
// in order to prevent accidental use from within the object inspector. You   
// may enable them by defining LIVE_SERVER_AT_DESIGN_TIME or by selectively   
// removing them from the $IFDEF blocks. However, such items must still be    
// programmatically created via a method of the appropriate CoClass before    
// they can be used.                                                          
// ************************************************************************ //
// Type Lib: D:\Dev\Projects\Playsafe Systems\Trunk\Delphi Projects\Build\cdo32.dll (1)
// IID\LCID: {7C5A4C06-A559-11D0-881A-00AA00BA30B7}\0
// Helpfile: 
// DepndLst: 
//   (1) v2.0 stdole, (C:\Windows\SysWOW64\stdole2.tlb)
// Errors:
//   Error creating palette bitmap of (TCrystalComObject) : Server D:\Dev\Projects\Playsafe Systems\Trunk\Delphi Projects\Build\cdo32.dll contains no icons
// ************************************************************************ //
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers. 
interface

uses Windows, ActiveX, Classes, Graphics, OleServer, OleCtrls, StdVCL;

// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:        
//   Type Libraries     : LIBID_xxxx                                      
//   CoClasses          : CLASS_xxxx                                      
//   DISPInterfaces     : DIID_xxxx                                       
//   Non-DISP interfaces: IID_xxxx                                        
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  CrystalDataObjectMajorVersion = 1;
  CrystalDataObjectMinorVersion = 0;

  LIBID_CrystalDataObject: TGUID = '{7C5A4C06-A559-11D0-881A-00AA00BA30B7}';

  IID_ICrystalDataObject: TGUID = '{7C5A4C13-A559-11D0-881A-00AA00BA30B7}';
  CLASS_CrystalComObject: TGUID = '{7C5A4C14-A559-11D0-881A-00AA00BA30B7}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  ICrystalDataObject = interface;
  ICrystalDataObjectDisp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  CrystalComObject = ICrystalDataObject;


// *********************************************************************//
// Interface: ICrystalDataObject
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {7C5A4C13-A559-11D0-881A-00AA00BA30B7}
// *********************************************************************//
  ICrystalDataObject = interface(IDispatch)
    ['{7C5A4C13-A559-11D0-881A-00AA00BA30B7}']
    function  Get_RowCount: Integer; safecall;
    procedure AddRows(RowData: OleVariant); safecall;
    procedure Reset; safecall;
    function  DeleteField(const FieldName: WideString): WordBool; safecall;
    function  getEOF: WordBool; safecall;
    function  MoveNext: WordBool; safecall;
    function  MoveFirst: WordBool; safecall;
    function  GetColCount: Smallint; safecall;
    function  MoveTo(recordNum: Integer): WordBool; safecall;
    function  AddField(const FieldName: WideString; FieldType: OleVariant): WordBool; safecall;
    function  GetFieldData(column: Smallint): OleVariant; safecall;
    function  GetFieldName(column: Smallint): WideString; safecall;
    function  GetFieldType(Field: OleVariant): Smallint; safecall;
    property RowCount: Integer read Get_RowCount;
  end;

// *********************************************************************//
// DispIntf:  ICrystalDataObjectDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {7C5A4C13-A559-11D0-881A-00AA00BA30B7}
// *********************************************************************//
  ICrystalDataObjectDisp = dispinterface
    ['{7C5A4C13-A559-11D0-881A-00AA00BA30B7}']
    property RowCount: Integer readonly dispid 1;
    procedure AddRows(RowData: OleVariant); dispid 2;
    procedure Reset; dispid 3;
    function  DeleteField(const FieldName: WideString): WordBool; dispid 4;
    function  getEOF: WordBool; dispid 5;
    function  MoveNext: WordBool; dispid 6;
    function  MoveFirst: WordBool; dispid 7;
    function  GetColCount: Smallint; dispid 8;
    function  MoveTo(recordNum: Integer): WordBool; dispid 9;
    function  AddField(const FieldName: WideString; FieldType: OleVariant): WordBool; dispid 10;
    function  GetFieldData(column: Smallint): OleVariant; dispid 11;
    function  GetFieldName(column: Smallint): WideString; dispid 12;
    function  GetFieldType(Field: OleVariant): Smallint; dispid 13;
  end;

// *********************************************************************//
// The Class CoCrystalComObject provides a Create and CreateRemote method to          
// create instances of the default interface ICrystalDataObject exposed by              
// the CoClass CrystalComObject. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoCrystalComObject = class
    class function Create: ICrystalDataObject;
    class function CreateRemote(const MachineName: string): ICrystalDataObject;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TCrystalComObject
// Help String      : Crystal Data Object
// Default Interface: ICrystalDataObject
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TCrystalComObjectProperties= class;
{$ENDIF}
  TCrystalComObject = class(TOleServer)
  private
    FIntf:        ICrystalDataObject;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps:       TCrystalComObjectProperties;
    function      GetServerProperties: TCrystalComObjectProperties;
{$ENDIF}
    function      GetDefaultInterface: ICrystalDataObject;
  protected
    procedure InitServerData; override;
    function  Get_RowCount: Integer;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: ICrystalDataObject);
    procedure Disconnect; override;
    procedure AddRows(RowData: OleVariant);
    procedure Reset;
    function  DeleteField(const FieldName: WideString): WordBool;
    function  getEOF: WordBool;
    function  MoveNext: WordBool;
    function  MoveFirst: WordBool;
    function  GetColCount: Smallint;
    function  MoveTo(recordNum: Integer): WordBool;
    function  AddField(const FieldName: WideString): WordBool; overload;
    function  AddField(const FieldName: WideString; FieldType: OleVariant): WordBool; overload;
    function  GetFieldData(column: Smallint): OleVariant;
    function  GetFieldName(column: Smallint): WideString;
    function  GetFieldType(Field: OleVariant): Smallint;
    property  DefaultInterface: ICrystalDataObject read GetDefaultInterface;
    property RowCount: Integer read Get_RowCount;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TCrystalComObjectProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TCrystalComObject
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TCrystalComObjectProperties = class(TPersistent)
  private
    FServer:    TCrystalComObject;
    function    GetDefaultInterface: ICrystalDataObject;
    constructor Create(AServer: TCrystalComObject);
  protected
    function  Get_RowCount: Integer;
  public
    property DefaultInterface: ICrystalDataObject read GetDefaultInterface;
  published
  end;
{$ENDIF}


procedure Register;

implementation

uses ComObj;

class function CoCrystalComObject.Create: ICrystalDataObject;
begin
  Result := CreateComObject(CLASS_CrystalComObject) as ICrystalDataObject;
end;

class function CoCrystalComObject.CreateRemote(const MachineName: string): ICrystalDataObject;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_CrystalComObject) as ICrystalDataObject;
end;

procedure TCrystalComObject.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{7C5A4C14-A559-11D0-881A-00AA00BA30B7}';
    IntfIID:   '{7C5A4C13-A559-11D0-881A-00AA00BA30B7}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TCrystalComObject.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as ICrystalDataObject;
  end;
end;

procedure TCrystalComObject.ConnectTo(svrIntf: ICrystalDataObject);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TCrystalComObject.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TCrystalComObject.GetDefaultInterface: ICrystalDataObject;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call ''Connect'' or ''ConnectTo'' before this operation');
  Result := FIntf;
end;

constructor TCrystalComObject.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TCrystalComObjectProperties.Create(Self);
{$ENDIF}
end;

destructor TCrystalComObject.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TCrystalComObject.GetServerProperties: TCrystalComObjectProperties;
begin
  Result := FProps;
end;
{$ENDIF}

function  TCrystalComObject.Get_RowCount: Integer;
begin
  Result := DefaultInterface.Get_RowCount;
end;

procedure TCrystalComObject.AddRows(RowData: OleVariant);
begin
  DefaultInterface.AddRows(RowData);
end;

procedure TCrystalComObject.Reset;
begin
  DefaultInterface.Reset;
end;

function  TCrystalComObject.DeleteField(const FieldName: WideString): WordBool;
begin
  Result := DefaultInterface.DeleteField(FieldName);
end;

function  TCrystalComObject.getEOF: WordBool;
begin
  Result := DefaultInterface.getEOF;
end;

function  TCrystalComObject.MoveNext: WordBool;
begin
  Result := DefaultInterface.MoveNext;
end;

function  TCrystalComObject.MoveFirst: WordBool;
begin
  Result := DefaultInterface.MoveFirst;
end;

function  TCrystalComObject.GetColCount: Smallint;
begin
  Result := DefaultInterface.GetColCount;
end;

function  TCrystalComObject.MoveTo(recordNum: Integer): WordBool;
begin
  Result := DefaultInterface.MoveTo(recordNum);
end;

function  TCrystalComObject.AddField(const FieldName: WideString): WordBool;
begin
  Result := DefaultInterface.AddField(FieldName, EmptyParam);
end;

function  TCrystalComObject.AddField(const FieldName: WideString; FieldType: OleVariant): WordBool;
begin
  Result := DefaultInterface.AddField(FieldName, FieldType);
end;

function  TCrystalComObject.GetFieldData(column: Smallint): OleVariant;
begin
  Result := DefaultInterface.GetFieldData(column);
end;

function  TCrystalComObject.GetFieldName(column: Smallint): WideString;
begin
  Result := DefaultInterface.GetFieldName(column);
end;

function  TCrystalComObject.GetFieldType(Field: OleVariant): Smallint;
begin
  Result := DefaultInterface.GetFieldType(Field);
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TCrystalComObjectProperties.Create(AServer: TCrystalComObject);
begin
  inherited Create;
  FServer := AServer;
end;

function TCrystalComObjectProperties.GetDefaultInterface: ICrystalDataObject;
begin
  Result := FServer.DefaultInterface;
end;

function  TCrystalComObjectProperties.Get_RowCount: Integer;
begin
  Result := DefaultInterface.Get_RowCount;
end;

{$ENDIF}

procedure Register;
begin
  RegisterComponents('ActiveX',[TCrystalComObject]);
end;

end.
