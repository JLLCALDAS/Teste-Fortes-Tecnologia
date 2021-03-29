unit dtmConections;

interface

uses
  System.SysUtils,
  System.Classes,
  System.IniFiles,
  System.IOUtils,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  FireDAC.Phys.PG,
  FireDAC.Phys.PGDef,
  FireDAC.VCLUI.Wait,
  Data.DB,
  FireDAC.Comp.Client,
  FireDAC.Stan.Param,
  FireDAC.DatS,
  FireDAC.DApt.Intf,
  FireDAC.DApt,
  FireDAC.Comp.DataSet,
  FireDAC.VCLUI.Error,
  FireDAC.VCLUI.Login,
  FireDAC.Comp.UI,
  classeCommon, FireDAC.Phys.FB, FireDAC.Phys.FBDef;

type
  TDBConfig = record
    Database: String;
    UserName: String;
    Pw: string;
    DriverID: String;
    Port: string;
    Server: string;
  end;

  TdtmConection = class(TDataModule)
    ABCConnection: TFDConnection;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    FDGUIxErrorDialog1: TFDGUIxErrorDialog;
    FDPhysPgDriverLink1: TFDPhysPgDriverLink;
    FDGUIxLoginDialog1: TFDGUIxLoginDialog;
    procedure ABCConnectionBeforeConnect(Sender: TObject);
  private
    procedure SetParamsConnection(Config: TDBConfig);
    function LoadParamsIni: TDBConfig;
  public

    function VerificaConexao: boolean;
    function Conectar: boolean;
    function Desconectar: boolean;
  end;

var
  dtmConection: TdtmConection;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TdtmConection.ABCConnectionBeforeConnect(Sender: TObject);
var
  Config: TDBConfig;
begin
  Config := LoadParamsIni;

  SetParamsConnection(Config);
end;

function TdtmConection.Conectar: boolean;
var
  vCnx: boolean;
begin
  try
    ABCConnection.Connected:=True;
  finally
    vCnx:=ABCConnection.Connected;
    Result:=vCnx;
  end;
end;

function TdtmConection.Desconectar: boolean;
var
  vCnx: boolean;
begin
  try
    ABCConnection.Connected:=False;
  finally
    vCnx:=not ABCConnection.Connected;
    Result:=vCnx;
  end;
end;

function TdtmConection.LoadParamsIni: TDBConfig;
var
  Ini: TIniFile;
begin
  Ini := TIniFile.Create(TPath.Combine(TDirectory.GetCurrentDirectory, 'ABC.ini'));

  Result.Database := Ini.ReadString('DB', 'Database', 'ABC');
  Result.UserName := Ini.ReadString('DB', 'User_Name', 'SYSDBA');
  Result.Pw := Ini.ReadString('DB', 'Pw', 'masterkey');
  Result.DriverID := Ini.ReadString('DB', 'DriverID', 'FB');
  Result.Port := Ini.ReadString('DB', 'Port', '5433');
  Result.server := Ini.ReadString('DB', 'Server', 'localhost');

  Ini.Free;
end;

procedure TdtmConection.SetParamsConnection(Config: TDBConfig);
begin
  ABCConnection.Params.Clear;
  ABCConnection.Params.AddPair('Database', Config.Database);
  ABCConnection.Params.AddPair('User_Name', Config.UserName);
  ABCConnection.Params.AddPair('Password', Config.Pw);
  ABCConnection.Params.AddPair('DriverID', Config.DriverID);
  ABCConnection.Params.AddPair('Server', Config.Server);
  ABCConnection.Params.AddPair('Port', Config.Port);
end;

function TdtmConection.VerificaConexao: boolean;
var
  vCnx: boolean;
begin
  vCnx:=ABCConnection.Connected;
  Result:=vCnx;
end;

end.
