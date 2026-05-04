USE EvertecDB;
GO

CREATE PROCEDURE SP_CIDADES
    @Operacao    CHAR(1),
    @Codigo      INT          = NULL,
    @Nome        VARCHAR(100) = NULL,
    @Estado      CHAR(2)      = NULL,
    @Cep_Inicial CHAR(8)      = NULL,
    @Cep_Final   CHAR(8)      = NULL
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRAN
            IF @Operacao = 'I'
                INSERT INTO CIDADES (Nome, Estado, Cep_Inicial, Cep_Final)
                VALUES (@Nome, @Estado, @Cep_Inicial, @Cep_Final)

            ELSE IF @Operacao = 'U'
                UPDATE CIDADES
                SET Nome        = @Nome,
                    Estado      = @Estado,
                    Cep_Inicial = @Cep_Inicial,
                    Cep_Final   = @Cep_Final
                WHERE Codigo_Cidade = @Codigo

            ELSE IF @Operacao = 'D'
                DELETE FROM CIDADES
                WHERE Codigo_Cidade = @Codigo

        COMMIT
        SELECT 'Operação realizada com sucesso!' AS Mensagem
    END TRY
    BEGIN CATCH
        ROLLBACK
        SELECT ERROR_MESSAGE() AS Mensagem
    END CATCH
END
GO