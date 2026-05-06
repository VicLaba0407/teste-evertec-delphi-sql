unit UnitCidades;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, Data.DB, ADODB, Vcl.ExtCtrls;

type
  TFrmCidades = class(TForm)
    edtCodigo: TEdit;
    edtNome: TEdit;
    edtEstado: TEdit;
    edtCepInicial: TEdit;
    edtCepFinal: TEdit;
    DBGrid1: TDBGrid;
    btnNovo: TButton;
    btnSalvar: TButton;
    btnExcluir: TButton;
    btnCancelar: TButton;
    ADOConnection1: TADOConnection;
    qryCidades: TADOQuery;
    dsCidades: TDataSource;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    procedure FormShow(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
  private
    FModo: string; // 'I' = Insert, 'U' = Update
    procedure SetCampos(habilitar: Boolean);
    procedure LimparCampos;
    procedure CarregarGrid;
  end;

var
  FrmCidades: TFrmCidades;

implementation

{$R *.dfm}

procedure TFrmCidades.CarregarGrid;
begin
  qryCidades.Close;
  qryCidades.SQL.Text := 'SELECT * FROM CIDADES ORDER BY NOME';
  qryCidades.Open;
end;

procedure TFrmCidades.LimparCampos;
begin
  edtCodigo.Clear;
  edtNome.Clear;
  edtEstado.Clear;
  edtCepInicial.Clear;
  edtCepFinal.Clear;
end;

procedure TFrmCidades.SetCampos(habilitar: Boolean);
begin
  edtNome.Enabled       := habilitar;
  edtEstado.Enabled     := habilitar;
  edtCepInicial.Enabled := habilitar;
  edtCepFinal.Enabled   := habilitar;
  btnSalvar.Enabled     := habilitar;
  btnCancelar.Enabled   := habilitar;
  btnNovo.Enabled       := not habilitar;
  btnExcluir.Enabled    := not habilitar;
end;

procedure TFrmCidades.FormShow(Sender: TObject);
begin
  FModo := '';
  SetCampos(False);
  CarregarGrid;
end;

procedure TFrmCidades.btnNovoClick(Sender: TObject);
begin
  FModo := 'I';
  LimparCampos;
  SetCampos(True);
  edtNome.SetFocus;
end;

procedure TFrmCidades.btnSalvarClick(Sender: TObject);
var
  qry: TADOQuery;
begin
  // Validações
  if Trim(edtNome.Text) = '' then
  begin
    ShowMessage('Informe o nome da cidade!');
    edtNome.SetFocus;
    Exit;
  end;
  if Trim(edtEstado.Text) = '' then
  begin
    ShowMessage('Informe o estado!');
    edtEstado.SetFocus;
    Exit;
  end;
  if Length(Trim(edtEstado.Text)) <> 2 then
  begin
    ShowMessage('Estado deve ter 2 letras! Ex: SP');
    edtEstado.SetFocus;
    Exit;
  end;
  if Trim(edtCepInicial.Text) = '' then
  begin
    ShowMessage('Informe o CEP Inicial!');
    edtCepInicial.SetFocus;
    Exit;
  end;
  if Trim(edtCepFinal.Text) = '' then
  begin
    ShowMessage('Informe o CEP Final!');
    edtCepFinal.SetFocus;
    Exit;
  end;

  qry := TADOQuery.Create(nil);
  try
    qry.Connection := ADOConnection1;

    if FModo = 'I' then
    begin
      qry.SQL.Text :=
        'INSERT INTO CIDADES (NOME, ESTADO, CEP_INICIAL, CEP_FINAL) ' +
        'VALUES (:Nome, :Estado, :CepIni, :CepFim)';
    end
    else
    begin
      qry.SQL.Text :=
        'UPDATE CIDADES SET NOME = :Nome, ESTADO = :Estado, ' +
        'CEP_INICIAL = :CepIni, CEP_FINAL = :CepFim ' +
        'WHERE CODIGO_CIDADE = :Codigo';
      qry.Parameters.ParamByName('Codigo').Value := StrToInt(edtCodigo.Text);
    end;

    qry.Parameters.ParamByName('Nome').Value   := Trim(edtNome.Text);
    qry.Parameters.ParamByName('Estado').Value := UpperCase(Trim(edtEstado.Text));
    qry.Parameters.ParamByName('CepIni').Value := Trim(edtCepInicial.Text);
    qry.Parameters.ParamByName('CepFim').Value := Trim(edtCepFinal.Text);
    qry.ExecSQL;

    ShowMessage('Cidade salva com sucesso!');
    FModo := '';
    LimparCampos;
    SetCampos(False);
    CarregarGrid;

  except
    on E: Exception do
      ShowMessage('Erro ao salvar: ' + E.Message);
  end;
  qry.Free;
end;

procedure TFrmCidades.btnExcluirClick(Sender: TObject);
var
  qry: TADOQuery;
begin
  if Trim(edtCodigo.Text) = '' then
  begin
    ShowMessage('Selecione uma cidade no grid primeiro!');
    Exit;
  end;

  if MessageDlg('Confirma a exclusão da cidade "' + edtNome.Text + '"?',
    mtConfirmation, [mbYes, mbNo], 0) = mrNo then Exit;

  qry := TADOQuery.Create(nil);
  try
    qry.Connection := ADOConnection1;
    qry.SQL.Text :=
      'DELETE FROM CIDADES WHERE CODIGO_CIDADE = :Codigo';
    qry.Parameters.ParamByName('Codigo').Value := StrToInt(edtCodigo.Text);
    qry.ExecSQL;

    ShowMessage('Cidade excluída com sucesso!');
    LimparCampos;
    CarregarGrid;

  except
    on E: Exception do
      ShowMessage('Erro ao excluir: ' + E.Message);
  end;
  qry.Free;
end;

procedure TFrmCidades.btnCancelarClick(Sender: TObject);
begin
  FModo := '';
  LimparCampos;
  SetCampos(False);
end;

procedure TFrmCidades.DBGrid1CellClick(Column: TColumn);
begin
  if qryCidades.IsEmpty then Exit;

  FModo := 'U';
  edtCodigo.Text     := qryCidades.FieldByName('CODIGO_CIDADE').AsString;
  edtNome.Text       := qryCidades.FieldByName('NOME').AsString;
  edtEstado.Text     := qryCidades.FieldByName('ESTADO').AsString;
  edtCepInicial.Text := qryCidades.FieldByName('CEP_INICIAL').AsString;
  edtCepFinal.Text   := qryCidades.FieldByName('CEP_FINAL').AsString;
  SetCampos(True);
end;

end.
