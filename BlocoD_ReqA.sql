USE EvertecDB;
GO

-- PROBLEMA: c.Nome não está no GROUP BY, causando erro.
-- A query original faz SELECT de Nome mas agrupa só por Codigo_Cidade.
-- CORREÇÃO: Adicionar c.Nome ao GROUP BY ou remover do SELECT.

-- Query original com erro:
-- SELECT c.Codigo_Cidade, c.Nome, COUNT(*) AS Total
-- FROM Clientes c
-- GROUP BY c.Codigo_Cidade;

-- Query corrigida:
SELECT c.Codigo_Cidade, c.Nome, COUNT(*) AS Total
FROM CLIENTES c
GROUP BY c.Codigo_Cidade, c.Nome;