program Project1;

uses
  Vcl.Forms,
  UnitPrincipal in '..\BlocoC\UnitPrincipal.pas' {FrmPrincipal},
  UnitCidades in '..\BlocoC\UnitCidades.pas' {FrmCidades},
  UnitClientes in '..\BlocoC\UnitClientes.pas' {FrmClientes};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmPrincipal, FrmPrincipal);
  Application.CreateForm(TFrmCidades, FrmCidades);
  Application.CreateForm(TFrmClientes, FrmClientes);
  Application.Run;
end.
