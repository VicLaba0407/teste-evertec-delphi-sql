unit UnitRelatorio;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Data.DB, ADODB, Vcl.Grids, Vcl.DBGrids, ShellAPI;

type
  TFrmRelatorio = class(TForm)
    ADOConnection1: TADOConnection;
    qryRelatorio: TADOQuery;
    dsRelatorio: TDataSource;
    DBGrid1: TDBGrid;
    edtEstado: TEdit;
    edtCodCidade: TEdit;
    edtCodCliente: TEdit;
    btnVisualizar: TButton;
    btnExportarExcel: TButton;
    btnExportarPDF: TButton;
    btnFechar: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    procedure btnVisualizarClick(Sender: TObject);
    procedure btnExportarExcelClick(Sender: TObject);
    procedure btnExportarPDFClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    procedure MontarQuery;
    procedure ExportarParaHTML(AArquivo: string; AbrirDepois: Boolean);
  end;

var
  FrmRelatorio: TFrmRelatorio;

implementation

{$R *.dfm}

procedure TFrmRelatorio.FormShow(Sender: TObject);
begin
  edtEstado.Clear;
  edtCodCidade.Clear;
  edtCodCliente.Clear;
  DBGrid1.DataSource := dsRelatorio;
end;

procedure TFrmRelatorio.MontarQuery;
var
  SQL: string;
begin
  SQL :=
    'SELECT cl.CODIGO_CLIENTE, cl.NOME, cl.CGC_CPF_CLIENTE, ' +
    '       cl.TELEFONE, cl.CEP, ' +
    '       ci.NOME AS CIDADE, ci.ESTADO ' +
    'FROM CLIENTES cl ' +
    'INNER JOIN CIDADES ci ON cl.CODIGO_CIDADE = ci.CODIGO_CIDADE ' +
    'WHERE 1=1 ';

  if Trim(edtEstado.Text) <> '' then
    SQL := SQL + 'AND ci.ESTADO = ' +
           QuotedStr(UpperCase(Trim(edtEstado.Text))) + ' ';

  if Trim(edtCodCidade.Text) <> '' then
    SQL := SQL + 'AND ci.CODIGO_CIDADE = ' +
           Trim(edtCodCidade.Text) + ' ';

  if Trim(edtCodCliente.Text) <> '' then
    SQL := SQL + 'AND cl.CODIGO_CLIENTE = ' +
           Trim(edtCodCliente.Text) + ' ';

  SQL := SQL + 'ORDER BY ci.ESTADO, ci.NOME, cl.NOME';

  qryRelatorio.Close;
  qryRelatorio.SQL.Text := SQL;
  qryRelatorio.Open;
end;

procedure TFrmRelatorio.btnVisualizarClick(Sender: TObject);
begin
  try
    MontarQuery;
    if qryRelatorio.IsEmpty then
      ShowMessage('Nenhum registro encontrado com os filtros informados!');
  except
    on E: Exception do
      ShowMessage('Erro ao filtrar: ' + E.Message);
  end;
end;

procedure TFrmRelatorio.ExportarParaHTML(AArquivo: string; AbrirDepois: Boolean);
var
  SL: TStringList;
  UltimoEstado, UltimaCidade: string;
begin
  if qryRelatorio.IsEmpty then
  begin
    ShowMessage('Nenhum dado para exportar! Clique em Filtrar primeiro.');
    Exit;
  end;

  SL := TStringList.Create;
  try
    SL.Add('<html>');
    SL.Add('<head>');
    SL.Add('<meta charset="UTF-8">');
    SL.Add('<style>');
    SL.Add('  body { font-family: Arial; font-size: 11pt; }');
    SL.Add('  h2 { color: #2F5496; }');
    SL.Add('  table { border-collapse: collapse; width: 100%; }');
    SL.Add('  th { background-color: #2F5496; color: white; padding: 6px; border: 1px solid #ccc; }');
    SL.Add('  td { padding: 5px; border: 1px solid #ccc; }');
    SL.Add('  tr:nth-child(even) { background-color: #EEF2FF; }');
    SL.Add('  .grupo { background-color: #D6E4F7; font-weight: bold; padding: 5px; }');
    SL.Add('</style>');
    SL.Add('</head>');
    SL.Add('<body>');
    SL.Add('<h2>Listagem de Clientes por Cidade/Estado</h2>');
    SL.Add('<p>Gerado em: ' + DateTimeToStr(Now) + '</p>');
    SL.Add('<table>');

    SL.Add('<tr>');
    SL.Add('  <th>C&oacute;digo</th>');
    SL.Add('  <th>Nome</th>');
    SL.Add('  <th>CPF/CNPJ</th>');
    SL.Add('  <th>Telefone</th>');
    SL.Add('  <th>CEP</th>');
    SL.Add('  <th>Cidade</th>');
    SL.Add('  <th>Estado</th>');
    SL.Add('</tr>');

    UltimoEstado := '';
    UltimaCidade := '';

    qryRelatorio.First;
    while not qryRelatorio.Eof do
    begin
      if qryRelatorio.FieldByName('ESTADO').AsString <> UltimoEstado then
      begin
        UltimoEstado := qryRelatorio.FieldByName('ESTADO').AsString;
        UltimaCidade := '';
        SL.Add('<tr><td colspan="7" class="grupo">Estado: ' +
               UltimoEstado + '</td></tr>');
      end;

      if qryRelatorio.FieldByName('CIDADE').AsString <> UltimaCidade then
      begin
        UltimaCidade := qryRelatorio.FieldByName('CIDADE').AsString;
        SL.Add('<tr><td colspan="7" class="grupo">&nbsp;&nbsp;Cidade: ' +
               UltimaCidade + '</td></tr>');
      end;

      SL.Add('<tr>');
      SL.Add('  <td>' + qryRelatorio.FieldByName('CODIGO_CLIENTE').AsString + '</td>');
      SL.Add('  <td>' + qryRelatorio.FieldByName('NOME').AsString + '</td>');
      SL.Add('  <td>' + qryRelatorio.FieldByName('CGC_CPF_CLIENTE').AsString + '</td>');
      SL.Add('  <td>' + qryRelatorio.FieldByName('TELEFONE').AsString + '</td>');
      SL.Add('  <td>' + qryRelatorio.FieldByName('CEP').AsString + '</td>');
      SL.Add('  <td>' + qryRelatorio.FieldByName('CIDADE').AsString + '</td>');
      SL.Add('  <td>' + qryRelatorio.FieldByName('ESTADO').AsString + '</td>');
      SL.Add('</tr>');

      qryRelatorio.Next;
    end;

    SL.Add('<tr>');
    SL.Add('  <td colspan="7" style="text-align:right; font-weight:bold;">');
    SL.Add('    Total de registros: ' + IntToStr(qryRelatorio.RecordCount));
    SL.Add('  </td>');
    SL.Add('</tr>');

    SL.Add('</table>');
    SL.Add('</body>');
    SL.Add('</html>');

    SL.SaveToFile(AArquivo, TEncoding.UTF8);

    if AbrirDepois then
      ShellExecute(0, 'open', PChar(AArquivo), nil, nil, SW_SHOWNORMAL);

  finally
    SL.Free;
  end;
end;

procedure TFrmRelatorio.btnExportarExcelClick(Sender: TObject);
var
  SaveDlg: TSaveDialog;
begin
  try
    MontarQuery;

    SaveDlg := TSaveDialog.Create(nil);
    try
      SaveDlg.Title      := 'Salvar como Excel';
      SaveDlg.Filter     := 'Excel|*.xls';
      SaveDlg.DefaultExt := 'xls';
      SaveDlg.FileName   := 'Relatorio_Clientes.xls';

      if SaveDlg.Execute then
      begin
        ExportarParaHTML(SaveDlg.FileName, True);
        ShowMessage('Excel gerado com sucesso!' + #13#10 + SaveDlg.FileName);
      end;
    finally
      SaveDlg.Free;
    end;

  except
    on E: Exception do
      ShowMessage('Erro ao exportar Excel: ' + E.Message);
  end;
end;

procedure TFrmRelatorio.btnExportarPDFClick(Sender: TObject);
var
  ArqHTML: string;
begin
  try
    MontarQuery;

    ArqHTML := GetEnvironmentVariable('TEMP') + '\Relatorio_Clientes.html';
    ExportarParaHTML(ArqHTML, True);

    ShowMessage(
      'O relat&oacute;rio foi aberto no seu navegador.' + #13#10 +
      'Para salvar como PDF: use Ctrl+P e escolha Salvar como PDF.'
    );

  except
    on E: Exception do
      ShowMessage('Erro ao gerar PDF: ' + E.Message);
  end;
end;

procedure TFrmRelatorio.btnFecharClick(Sender: TObject);
begin
  Close;
end;

end.
