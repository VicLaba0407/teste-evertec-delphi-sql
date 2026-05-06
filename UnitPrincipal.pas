unit UnitPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.Menus, UnitCidades;

type
  TFrmPrincipal = class(TForm)
    MainMenu1: TMainMenu;
    Cadastros1: TMenuItem;
    Cidades2: TMenuItem;
    Clientes2: TMenuItem;
    Relatorios1: TMenuItem;
    procedure Cidades2Click(Sender: TObject);
    procedure Clientes2Click(Sender: TObject);
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

{$R *.dfm}

procedure TFrmPrincipal.Cidades2Click(Sender: TObject);
var
  frm: TFrmCidades;
begin
  frm := TFrmCidades.Create(Self);
  try
    frm.ShowModal;
  finally
    frm.Free;
  end;
end;

procedure TFrmPrincipal.Clientes2Click(Sender: TObject);
begin
  ShowMessage('Em desenvolvimento...');
end;

end.
