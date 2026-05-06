object FrmPrincipal: TFrmPrincipal
  Left = 0
  Top = 0
  Caption = 'Sistema Cadastro - Evertec'
  ClientHeight = 441
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Menu = MainMenu1
  WindowState = wsMaximized
  TextHeight = 15
  object MainMenu1: TMainMenu
    Left = 304
    Top = 224
    object Cadastros1: TMenuItem
      Caption = 'Cadastros'
      object Cidades2: TMenuItem
        Caption = 'Cidades'
        OnClick = Cidades2Click
      end
      object Clientes2: TMenuItem
        Caption = 'Clientes'
        OnClick = Clientes2Click
      end
    end
    object Relatorios1: TMenuItem
      Caption = 'Relatorios'
    end
  end
end
