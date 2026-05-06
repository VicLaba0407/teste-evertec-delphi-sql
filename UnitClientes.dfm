object FrmClientes: TFrmClientes
  Left = 0
  Top = 0
  Caption = 'Cadastro de Clientes'
  ClientHeight = 441
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnShow = FormShow
  TextHeight = 15
  object Label1: TLabel
    Left = 72
    Top = 8
    Width = 42
    Height = 15
    Caption = 'C'#243'digo:'
  end
  object Label2: TLabel
    Left = 72
    Top = 40
    Width = 56
    Height = 15
    Caption = 'CPF/CNPJ:'
  end
  object Label3: TLabel
    Left = 70
    Top = 67
    Width = 36
    Height = 15
    Caption = 'Nome:'
  end
  object Label4: TLabel
    Left = 72
    Top = 104
    Width = 48
    Height = 15
    Caption = 'Telefone:'
  end
  object Label5: TLabel
    Left = 72
    Top = 141
    Width = 46
    Height = 15
    Caption = 'Endre'#231'o:'
  end
  object Label6: TLabel
    Left = 72
    Top = 168
    Width = 34
    Height = 15
    Caption = 'Bairro:'
  end
  object Label7: TLabel
    Left = 72
    Top = 200
    Width = 80
    Height = 15
    Caption = 'Complemento:'
  end
  object Label8: TLabel
    Left = 72
    Top = 235
    Width = 37
    Height = 15
    Caption = 'E-mail:'
  end
  object Label9: TLabel
    Left = 72
    Top = 264
    Width = 24
    Height = 15
    Caption = 'CEP:'
  end
  object Label10: TLabel
    Left = 72
    Top = 315
    Width = 40
    Height = 15
    Caption = 'Cidade:'
  end
  object edtCodigo: TEdit
    Left = 176
    Top = 8
    Width = 121
    Height = 23
    Color = clBtnFace
    ReadOnly = True
    TabOrder = 0
    Text = 'edtCodigo'
  end
  object edtCGC: TEdit
    Left = 176
    Top = 37
    Width = 121
    Height = 23
    TabOrder = 1
    Text = 'edtCGC'
  end
  object edtNome: TEdit
    Left = 176
    Top = 66
    Width = 121
    Height = 23
    TabOrder = 2
    Text = 'edtNome'
  end
  object edtTelefone: TEdit
    Left = 176
    Top = 95
    Width = 121
    Height = 23
    TabOrder = 3
    Text = 'edtTelefone'
  end
  object edtEndreco: TEdit
    Left = 176
    Top = 138
    Width = 121
    Height = 23
    TabOrder = 4
    Text = 'edtEndreco'
  end
  object edtBairro: TEdit
    Left = 176
    Top = 167
    Width = 121
    Height = 23
    TabOrder = 5
    Text = 'edtBairro'
  end
  object edtComplemento: TEdit
    Left = 176
    Top = 196
    Width = 121
    Height = 23
    TabOrder = 6
    Text = 'edtComplemento'
  end
  object edtEmail: TEdit
    Left = 176
    Top = 232
    Width = 121
    Height = 23
    TabOrder = 7
    Text = 'edtEmail'
  end
  object edtCEP: TEdit
    Left = 176
    Top = 261
    Width = 121
    Height = 23
    TabOrder = 8
    Text = 'edtCEP'
  end
  object cmbCidade: TComboBox
    Left = 176
    Top = 312
    Width = 145
    Height = 23
    TabOrder = 9
    Text = 'cmbCidade'
  end
  object DBGrid1: TDBGrid
    Left = 303
    Top = 12
    Width = 320
    Height = 120
    DataSource = dsClientes
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    ReadOnly = True
    TabOrder = 10
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
    OnCellClick = DBGrid1CellClick
  end
  object btnNovo: TButton
    Left = 45
    Top = 376
    Width = 75
    Height = 25
    Caption = 'Novo'
    TabOrder = 11
    OnClick = btnNovoClick
  end
  object btnSalvar: TButton
    Left = 176
    Top = 376
    Width = 75
    Height = 25
    Caption = 'Salvar'
    TabOrder = 12
    OnClick = btnSalvarClick
  end
  object btnExcluir: TButton
    Left = 312
    Top = 376
    Width = 75
    Height = 25
    Caption = 'Excluir'
    TabOrder = 13
    OnClick = btnExcluirClick
  end
  object btnCancelar: TButton
    Left = 456
    Top = 376
    Width = 75
    Height = 25
    Caption = 'Cancelar'
    TabOrder = 14
    OnClick = btnCancelarClick
  end
  object ADOConnection1: TADOConnection
    ConnectionString = 
      'Provider=SQLOLEDB.1;Integrated Security=SSPI;Persist Security In' +
      'fo=False;Initial Catalog=EvertecDB;Data Source=.\SQLEXPRESS'
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    Left = 336
    Top = 168
  end
  object qryClientes: TADOQuery
    Connection = ADOConnection1
    Parameters = <>
    Left = 424
    Top = 168
  end
  object dsClientes: TDataSource
    DataSet = qryClientes
    Left = 496
    Top = 168
  end
end
