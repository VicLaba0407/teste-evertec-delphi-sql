USE EvertecDB;
GO

CREATE VIEW VW_CIDADES_CLIENTES AS
SELECT 
    ci.Codigo_Cidade,
    ci.Nome AS Cidade,
    ci.Estado,
    COUNT(c.Codigo_Cliente) AS Total_Clientes
FROM CIDADES ci
LEFT JOIN CLIENTES c ON ci.Codigo_Cidade = c.Codigo_Cidade
GROUP BY ci.Codigo_Cidade, ci.Nome, ci.Estado;
GO

-- Consultar a view
SELECT * FROM VW_CIDADES_CLIENTES;