USE EvertecDB;
GO

-- PROBLEMA: O INSERT fornece apenas 3 valores mas a tabela exige 4
-- campos NOT NULL (Nome, Estado, Cep_Inicial, Cep_Final).
-- Falta o valor de Cep_Final, causando erro de sintaxe.

-- Query original com erro:
-- INSERT INTO Cidades (Nome, Estado, Cep_Inicial, Cep_Final)
-- VALUES ('Tupa', 'SP', '17600000');

-- Query corrigida:
INSERT INTO CIDADES (Nome, Estado, Cep_Inicial, Cep_Final)
VALUES ('Tupa', 'SP', '17600000', '17699999');