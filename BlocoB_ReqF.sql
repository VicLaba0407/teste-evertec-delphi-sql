USE EvertecDB;
GO

-- Primeiro inserir uma cidade para poder referenciar no cliente
INSERT INTO CIDADES (Nome, Estado, Cep_Inicial, Cep_Final)
VALUES ('TUPA', 'SP', '17600000', '17699999');

-- Inserir o cliente
INSERT INTO CLIENTES (CGC_CPF_Cliente, Nome, Telefone, Endereco, Bairro, Complemento, E_mail, Cep, Codigo_Cidade)
VALUES ('123.456.789-00', 'Victória Labadesa', '(14) 99999-1234', 'Rua das Flores, 100', 'Centro', 'Apto 10', 'victoria@email.com', '17600100', 1);