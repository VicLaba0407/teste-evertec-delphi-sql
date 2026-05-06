unit UnitClientes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  System.UITypes,
  Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, Data.DB, ADODB, Vcl.ExtCtrls,
  Vcl.ComCtrls;

type
  TFrmClientes = class(TForm)
    edtCodigo: TEdit;
    edtCGC: TEdit;
    edtNome: TEdit;
    edtTelefone: TEdit; // ⚠️ TEM QUE EXISTIR NO FORM
    edtBairro: TEdit;
    edtComplemento: TEdit;
    edtEmail: TEdit;
    edtCEP: TEdit;
    cmbCidade: TComboBox;

    DBGrid1: TDBGrid;

    btnNovo: TButton;
    btnSalvar: TButton;
    btnExcluir: TButton;
    btnCancelar: TButton;

    ADOConnection1: TADOConnection;
    qryClientes: TADOQuery;
    dsClientes: TDataSource;

    procedure FormShow(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);

  private
    FModo: string;
    procedure SetCampos(habilitar: Boolean);
    procedure LimparCampos;
    procedure CarregarGrid;
    procedure CarregarComboCidades;
    function CodigoCidadeSelecionada: Integer;
  end;

var
  FrmClientes: TFrmClientes;

implementation

{$R *.dfm}

procedure TFrmClientes.CarregarGrid;
begin
  qryClientes.Close;
  qryClientes.SQL.Text :=
    'SELECT CODIGO_CLIENTE, NOME, ENDERECO FROM CLIENTES ORDER BY NOME';
  qryClientes.Open;
end;

procedure TFrmClientes.CarregarComboCidades;
var
  qry: TADOQuery;
begin
  cmbCidade.Clear;

  qry := TADOQuery.Create(nil);
  try
    qry.Connection := ADOConnection1;
    qry.SQL.Text := 'SELECT CODIGO_CIDADE, NOME FROM CIDADES';
    qry.Open;

    while not qry.Eof do
    begin
      cmbCidade.Items.AddObject(
        qry.FieldByName('NOME').AsString,
        TObject(qry.FieldByName('CODIGO_CIDADE').AsInteger)
      );
      qry.Next;
    end;

  finally
    qry.Free;
  end;
end;

function TFrmClientes.CodigoCidadeSelecionada: Integer;
begin
  if cmbCidade.ItemIndex < 0 then
    Result := 0
  else
    Result := Integer(cmbCidade.Items.Objects[cmbCidade.ItemIndex]);
end;

procedure TFrmClientes.SetCampos(habilitar: Boolean);
begin
  edtCGC.Enabled := habilitar;
  edtNome.Enabled := habilitar;
  edtTelefone.Enabled := habilitar;
  edtEndereco.Enabled := habilitar;
  edtBairro.Enabled := habilitar;
  edtComplemento.Enabled := habilitar;
  edtEmail.Enabled := habilitar;
  edtCEP.Enabled := habilitar;
  cmbCidade.Enabled := habilitar;

  btnSalvar.Enabled := habilitar;
  btnCancelar.Enabled := habilitar;

  btnNovo.Enabled := not habilitar;
  btnExcluir.Enabled := not habilitar;
end;

procedure TFrmClientes.LimparCampos;
begin
  edtCodigo.Clear;
  edtCGC.Clear;
  edtNome.Clear;
  edtTelefone.Clear;
  edtEndereco.Clear;
  edtBairro.Clear;
  edtComplemento.Clear;
  edtEmail.Clear;
  edtCEP.Clear;
  cmbCidade.ItemIndex := -1;
end;

procedure TFrmClientes.FormShow(Sender: TObject);
begin
  FModo := '';
  CarregarComboCidades;
  SetCampos(False);
  CarregarGrid;
end;

procedure TFrmClientes.btnNovoClick(Sender: TObject);
begin
  FModo := 'I';
  LimparCampos;
  SetCampos(True);
end;

procedure TFrmClientes.btnSalvarClick(Sender: TObject);
var
  qry: TADOQuery;
  CodCidade: Integer;
begin
  if Trim(edtNome.Text) = '' then
  begin
    ShowMessage('Informe o nome');
    Exit;
  end;

  CodCidade := CodigoCidadeSelecionada;

  qry := TADOQuery.Create(nil);
  try
    qry.Connection := ADOConnection1;

    if FModo = 'I' then
    begin
      qry.SQL.Text :=
        'INSERT INTO CLIENTES (NOME, ENDERECO, CODIGO_CIDADE) ' +
        'VALUES (:Nome, :End, :Cid)';
    end
    else
    begin
      qry.SQL.Text :=
        'UPDATE CLIENTES SET NOME=:Nome, ENDERECO=:End WHERE CODIGO_CLIENTE=:Cod';
      qry.Parameters.ParamByName('Cod').Value := StrToInt(edtCodigo.Text);
    end;

    qry.Parameters.ParamByName('Nome').Value := edtNome.Text;
    qry.Parameters.ParamByName('End').Value := edtEndereco.Text;
    qry.Parameters.ParamByName('Cid').Value := CodCidade;

    qry.ExecSQL;

    ShowMessage('Salvo com sucesso');

    LimparCampos;
    CarregarGrid;

  finally
    qry.Free;
  end;
end;

procedure TFrmClientes.btnExcluirClick(Sender: TObject);
var
  qry: TADOQuery;
begin
  if Trim(edtCodigo.Text) = '' then Exit;

  qry := TADOQuery.Create(nil);
  try
    qry.Connection := ADOConnection1;
    qry.SQL.Text := 'DELETE FROM CLIENTES WHERE CODIGO_CLIENTE=:Cod';
    qry.Parameters.ParamByName('Cod').Value := StrToInt(edtCodigo.Text);
    qry.ExecSQL;

    ShowMessage('Excluído');
    LimparCampos;
    CarregarGrid;

  finally
    qry.Free;
  end;
end;

procedure TFrmClientes.btnCancelarClick(Sender: TObject);
begin
  LimparCampos;
  SetCampos(False);
end;

procedure TFrmClientes.DBGrid1CellClick(Column: TColumn);
begin
  if qryClientes.IsEmpty then Exit;

  edtCodigo.Text := qryClientes.FieldByName('CODIGO_CLIENTE').AsString;
  edtNome.Text := qryClientes.FieldByName('NOME').AsString;
  edtEndereco.Text := qryClientes.FieldByName('ENDERECO').AsString;

  SetCampos(True);
  FModo := 'U';
end;

end.
