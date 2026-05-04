USE EvertecDB;
GO

-- PROBLEMAS IDENTIFICADOS NA PROCEDURE ORIGINAL:
-- 1. Sem controle de transação (BEGIN TRAN / COMMIT / ROLLBACK)
-- 2. Sem tratamento de erro (BEGIN TRY / BEGIN CATCH)
-- 3. UPDATE em CIDADES sem WHERE - altera TODAS as cidades
-- 4. @@IDENTITY pode retornar ID de trigger, usar SCOPE_IDENTITY()
-- 5. Sem validação se Codigo_Cidade existe antes de inserir
-- 6. Sem validação de campos obrigatórios (Nome, CGC_CPF)
-- 7. Mistura INSERT com UPDATE sem parâmetro de operação
-- 8. SELECT 'OK' no final não informa o código gerado

-- PROCEDURE CORRIGIDA:
CREATE PROCEDURE SP_GRAVAR_CLIENTE
    @Codigo_Cliente     INT OUTPUT,
    @CGC_CPF_Cliente    VARCHAR(18),
    @Nome               VARCHAR(150),
    @Telefone           VARCHAR(15)  = NULL,
    @Email              VARCHAR(100) = NULL,
    @CEP                CHAR(8)      = NULL,
    @Codigo_Cidade      INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Validação de campos obrigatórios
    IF @Nome IS NULL OR LTRIM(RTRIM(@Nome)) = ''
    BEGIN
        SELECT 'ERRO: Nome é obrigatório.' AS Mensagem;
        RETURN;
    END

    IF @CGC_CPF_Cliente IS NULL OR LTRIM(RTRIM(@CGC_CPF_Cliente)) = ''
    BEGIN
        SELECT 'ERRO: CPF/CNPJ é obrigatório.' AS Mensagem;
        RETURN;
    END

    -- Validação se cidade existe
    IF NOT EXISTS (SELECT 1 FROM CIDADES WHERE Codigo_Cidade = @Codigo_Cidade)
    BEGIN
        SELECT 'ERRO: Cidade não encontrada.' AS Mensagem;
        RETURN;
    END

    BEGIN TRY
        BEGIN TRAN
            INSERT INTO CLIENTES (CGC_CPF_Cliente, Nome, Telefone, E_mail, CEP, Codigo_Cidade)
            VALUES (@CGC_CPF_Cliente, @Nome, @Telefone, @Email, @CEP, @Codigo_Cidade)

            -- SCOPE_IDENTITY() é mais seguro que @@IDENTITY
            SET @Codigo_Cliente = SCOPE_IDENTITY()

        COMMIT
        SELECT @Codigo_Cliente AS Codigo_Gerado, 'Cliente gravado com sucesso!' AS Mensagem
    END TRY
    BEGIN CATCH
        ROLLBACK
        SELECT ERROR_MESSAGE() AS Mensagem
    END CATCH
END
GO