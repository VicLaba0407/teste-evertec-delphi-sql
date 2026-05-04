USE EvertecDB;
GO

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'CIDADES')
BEGIN
    CREATE TABLE CIDADES (
        Codigo_Cidade  INT          NOT NULL IDENTITY(1,1),
        Nome           VARCHAR(100) NOT NULL,
        Estado         CHAR(2)      NOT NULL,
        Cep_Inicial    CHAR(8)      NOT NULL,
        Cep_Final      CHAR(8)      NOT NULL,
        CONSTRAINT PK_CIDADES PRIMARY KEY (Codigo_Cidade)
    );
END
GO

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'CLIENTES')
BEGIN
    CREATE TABLE CLIENTES (
        Codigo_Cliente   INT          NOT NULL IDENTITY(1,1),
        CGC_CPF_Cliente  VARCHAR(18)  NOT NULL,
        Nome             VARCHAR(150) NOT NULL,
        Telefone         VARCHAR(15)      NULL,
        Endereco         VARCHAR(200)     NULL,
        Bairro           VARCHAR(100)     NULL,
        Complemento      VARCHAR(100)     NULL,
        E_mail           VARCHAR(100)     NULL,
        Cep              CHAR(8)          NULL,
        Codigo_Cidade    INT          NOT NULL,
        CONSTRAINT PK_CLIENTES    PRIMARY KEY (Codigo_Cliente),
        CONSTRAINT FK_CLI_CIDADES FOREIGN KEY (Codigo_Cidade)
            REFERENCES CIDADES(Codigo_Cidade)
    );
END
GO