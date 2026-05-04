USE EvertecDB;
GO

CREATE PROCEDURE SP_CLIENTES
    @Operacao        CHAR(1),
    @Codigo          INT          = NULL,
    @CGC_CPF         VARCHAR(18)  = NULL,
    @Nome            VARCHAR(150) = NULL,
    @Telefone        VARCHAR(15)  = NULL,
    @Endereco        VARCHAR(200) = NULL,
    @Bairro          VARCHAR(100) = NULL,
    @Complemento     VARCHAR(100) = NULL,
    @Email           VARCHAR(100) = NULL,
    @Cep             CHAR(8)      = NULL,
    @Codigo_Cidade   INT          = NULL
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRAN
            IF @Operacao = 'I'
                INSERT INTO CLIENTES (CGC_CPF_Cliente, Nome, Telefone, Endereco, Bairro, Complemento, E_mail, Cep, Codigo_Cidade)
                VALUES (@CGC_CPF, @Nome, @Telefone, @Endereco, @Bairro, @Complemento, @Email, @Cep, @Codigo_Cidade)

            ELSE IF @Operacao = 'U'
                UPDATE CLIENTES
                SET CGC_CPF_Cliente = @CGC_CPF,
                    Nome            = @Nome,
                    Telefone        = @Telefone,
                    Endereco        = @Endereco,
                    Bairro          = @Bairro,
                    Complemento     = @Complemento,
                    E_mail          = @Email,
                    Cep             = @Cep,
                    Codigo_Cidade   = @Codigo_Cidade
                WHERE Codigo_Cliente = @Codigo

            ELSE IF @Operacao = 'D'
                DELETE FROM CLIENTES
                WHERE Codigo_Cliente = @Codigo

        COMMIT
        SELECT 'Operação realizada com sucesso!' AS Mensagem
    END TRY
    BEGIN CATCH
        ROLLBACK
        SELECT ERROR_MESSAGE() AS Mensagem
    END CATCH
END
GO