USE EvertecDB;
GO

SELECT c.Nome
FROM CLIENTES c
WHERE EXISTS (
    SELECT 1 FROM CIDADES ci
    WHERE ci.Codigo_Cidade = c.Codigo_Cidade
    AND ci.Nome = 'TUPA'
);