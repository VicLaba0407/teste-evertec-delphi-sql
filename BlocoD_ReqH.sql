USE EvertecDB;
GO

-- PROBLEMA: Consulta lenta pois não há índices em Codigo_Cidade e Nome.
-- O SQL Server faz um 'Table Scan' (varre a tabela inteira) 
-- em vez de um 'Index Seek' (busca direta).

-- SOLUÇÃO 1: Criar índice composto em Codigo_Cidade e Nome
-- Isso permite busca direta pelos dois campos usados no WHERE.
CREATE INDEX IDX_CLIENTES_CIDADE_NOME 
ON CLIENTES (Codigo_Cidade, Nome);
GO

-- SOLUÇÃO 2: Como o LIKE usa 'MARIA%' (começa com),
-- o índice em Nome funciona bem pois busca pelo início da string.
-- Se fosse '%MARIA%' o índice não ajudaria.

-- SOLUÇÃO 3: Verificar o plano de execução
-- Selecionar a query abaixo e pressionar Ctrl+L para ver o plano:
SELECT Nome
FROM CLIENTES
WHERE Codigo_Cidade = 10
AND Nome LIKE 'MARIA%';

-- OUTRAS AÇÕES PARA MELHORAR PERFORMANCE:
-- - Usar NOLOCK se leitura suja for aceitável: FROM CLIENTES WITH (NOLOCK)
-- - Verificar estatísticas: UPDATE STATISTICS CLIENTES
-- - Verificar fragmentação do índice: sys.dm_db_index_physical_stats