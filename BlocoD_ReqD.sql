USE EvertecDB;
GO

-- PROBLEMA: O BETWEEN exige que o valor menor venha primeiro.
-- 'BETWEEN 200 AND 100' nunca retorna resultados pois 
-- nenhum número é ao mesmo tempo >= 200 e <= 100.

-- Query original com erro:
-- DELETE FROM Clientes
-- WHERE Codigo_Cliente BETWEEN 200 AND 100;

-- Query corrigida:
DELETE FROM CLIENTES
WHERE Codigo_Cliente BETWEEN 100 AND 200;