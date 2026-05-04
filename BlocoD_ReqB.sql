USE EvertecDB;
GO

-- PROBLEMA: O alias da tabela Cidades é 'ci', mas o WHERE usa 'cidade.Estado'.
-- Isso causa erro pois o alias 'cidade' não existe na query.

-- Query original com erro:
-- SELECT c.Nome, ci.Nome AS Cidade
-- FROM Clientes c
-- INNER JOIN Cidades ci ON c.Codigo_Cidade = ci.Codigo_Cidade
-- WHERE cidade.Estado = 'SP';

-- Query corrigida:
SELECT c.Nome, ci.Nome AS Cidade
FROM CLIENTES c
INNER JOIN CIDADES ci ON c.Codigo_Cidade = ci.Codigo_Cidade
WHERE ci.Estado = 'SP';