USE EvertecDB;
GO

-- PROBLEMA: O EXISTS não está correlacionado com a tabela CLIENTES.
-- A subquery 'SELECT 1 FROM Cidades WHERE Nome = TUPA' sempre retorna
-- verdadeiro se existir qualquer cidade chamada TUPA, retornando 
-- TODOS os clientes independente de sua cidade.

-- Query original com erro:
-- SELECT c.Nome
-- FROM Clientes c
-- WHERE EXISTS (SELECT 1 FROM Cidades WHERE Nome = 'TUPA');

-- Query corrigida (correlacionada):
SELECT c.Nome
FROM CLIENTES c
WHERE EXISTS (
    SELECT 1 FROM CIDADES ci
    WHERE ci.Codigo_Cidade = c.Codigo_Cidade
    AND ci.Nome = 'TUPA'
);