object FrmRelatorio: TFrmRelatorio
  Left = 0
  Top = 0
  Caption = 'Relat'#243'rios'
  ClientHeight = 495
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 38
    Height = 15
    Caption = 'Estado:'
  end
  object Label2: TLabel
    Left = 8
    Top = 56
    Width = 82
    Height = 15
    Caption = 'C'#243'digo Cidade:'
  end
  object Label3: TLabel
    Left = 8
    Top = 101
    Width = 82
    Height = 15
    Caption = 'C'#243'digo Cliente:'
  end
  object edtEstado: TEdit
    Left = 8
    Top = 32
    Width = 121
    Height = 23
    TabOrder = 0
    Text = 'edtEstado'
  end
  object edtCodCidade: TEdit
    Left = 8
    Top = 77
    Width = 121
    Height = 23
    TabOrder = 1
    Text = 'edtCodCidade'
  end
  object edtCodCliente: TEdit
    Left = 8
    Top = 122
    Width = 121
    Height = 23
    TabOrder = 2
    Text = 'edtCodCliente'
  end
  object btnVisualizar: TButton
    Left = 8
    Top = 151
    Width = 75
    Height = 25
    Caption = 'Visualizar'
    TabOrder = 3
    OnClick = btnVisualizarClick
  end
  object btnFechar: TButton
    Left = 112
    Top = 151
    Width = 75
    Height = 25
    Caption = 'Fechar'
    TabOrder = 4
  end
  object DBGrid1: TDBGrid
    Left = 320
    Top = 256
    Width = 320
    Height = 120
    TabOrder = 5
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
  end
  object btnExportarExcel: TButton
    Left = 216
    Top = 151
    Width = 75
    Height = 25
    Caption = 'Exportar Excel'
    TabOrder = 6
  end
  object btnExportarPdf: TButton
    Left = 320
    Top = 151
    Width = 75
    Height = 25
    Caption = 'Exportar PDF'
    TabOrder = 7
  end
  object ADOConnection1: TADOConnection
    Left = 40
    Top = 208
  end
  object qryRelatorio: TADOQuery
    Connection = ADOConnection1
    Parameters = <>
    Left = 128
    Top = 208
  end
  object dsRelatorio: TDataSource
    DataSet = qryRelatorio
    Left = 208
    Top = 208
  end
end
