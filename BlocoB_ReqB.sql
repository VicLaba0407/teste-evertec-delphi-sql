USE EvertecDB;
GO

SELECT c.Nome, ci.Nome AS Cidade
FROM CLIENTES c
INNER JOIN CIDADES ci ON c.Codigo_Cidade = ci.Codigo_Cidade;