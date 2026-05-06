object FrmCidades: TFrmCidades
  Left = 0
  Top = 0
  Caption = 'Cadastro de Cidades'
  ClientHeight = 441
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object Label1: TLabel
    Left = 40
    Top = 24
    Width = 42
    Height = 15
    Caption = 'C'#243'digo:'
  end
  object Label2: TLabel
    Left = 40
    Top = 45
    Width = 36
    Height = 15
    Caption = 'Nome:'
  end
  object Label3: TLabel
    Left = 40
    Top = 78
    Width = 38
    Height = 15
    Caption = 'Estado:'
  end
  object Label4: TLabel
    Left = 40
    Top = 103
    Width = 58
    Height = 15
    Caption = 'CEP Inicial:'
  end
  object Label5: TLabel
    Left = 40
    Top = 135
    Width = 52
    Height = 15
    Caption = 'CEP Final:'
  end
  object edtEstado: TEdit
    Left = 104
    Top = 74
    Width = 121
    Height = 23
    MaxLength = 2
    TabOrder = 0
    Text = 'edtEstado'
  end
  object edtCepInicial: TEdit
    Left = 104
    Top = 103
    Width = 121
    Height = 23
    MaxLength = 8
    TabOrder = 1
    Text = 'edtCepInicial'
  end
  object edtCepFinal: TEdit
    Left = 104
    Top = 132
    Width = 121
    Height = 23
    MaxLength = 8
    TabOrder = 2
    Text = 'edtCepFinal'
  end
  object btnNovo: TButton
    Left = 56
    Top = 296
    Width = 75
    Height = 25
    Caption = 'Novo'
    TabOrder = 3
    OnClick = btnNovoClick
  end
  object btnSalvar: TButton
    Left = 160
    Top = 296
    Width = 75
    Height = 25
    Caption = 'Salvar'
    TabOrder = 4
    OnClick = btnSalvarClick
  end
  object btnExcluir: TButton
    Left = 272
    Top = 296
    Width = 75
    Height = 25
    Caption = 'Excluir'
    TabOrder = 5
    OnClick = btnExcluirClick
  end
  object btnCancelar: TButton
    Left = 392
    Top = 296
    Width = 75
    Height = 25
    Caption = 'Cancelar'
    TabOrder = 6
    OnClick = btnCancelarClick
  end
  object DBGrid1: TDBGrid
    Left = 272
    Top = 8
    Width = 320
    Height = 120
    DataSource = dsCidades
    TabOrder = 7
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
    OnCellClick = DBGrid1CellClick
  end
  object edtNome: TEdit
    Left = 104
    Top = 45
    Width = 121
    Height = 23
    TabOrder = 8
    Text = 'edtNome'
  end
  object edtCodigo: TEdit
    Left = 104
    Top = 16
    Width = 121
    Height = 23
    Enabled = False
    TabOrder = 9
    Text = 'edtCodigo'
  end
  object ADOConnection1: TADOConnection
    Connected = True
    ConnectionString = 
      'Provider=SQLOLEDB.1;Integrated Security=SSPI;Persist Security In' +
      'fo=False;Initial Catalog=EvertecDB;Data Source=.\SQLEXPRESS'
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    Left = 40
    Top = 376
  end
  object qryCidades: TADOQuery
    Active = True
    Connection = ADOConnection1
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT * FROM CIDADES ORDER BY Nome')
    Left = 136
    Top = 376
  end
  object dsCidades: TDataSource
    DataSet = qryCidades
    Left = 216
    Top = 376
  end
end
