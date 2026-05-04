USE EvertecDB;
GO

-- PROBLEMA: HAVING é usado para filtrar resultados de GROUP BY.
-- Sem GROUP BY, o HAVING não funciona corretamente para filtrar linhas.
-- O correto é usar WHERE para filtrar linhas individuais.

-- Query original com erro:
-- SELECT Codigo_Cidade, Nome
-- FROM Cidades
-- HAVING Estado = 'SP';

-- Query corrigida:
SELECT Codigo_Cidade, Nome
FROM CIDADES
WHERE Estado = 'SP';