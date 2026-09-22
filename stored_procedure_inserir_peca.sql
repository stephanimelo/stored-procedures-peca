USE db_pecas;
GO

-- Stored Procedure para inserir um registro na tabela Peca, usando parâmetros
CREATE PROCEDURE sp_InserirPeca
    @CodPeca CHAR(2),
    @NomePeca VARCHAR(30),
    @CorPeca VARCHAR(20),
    @PesoPeca INT,
    @CidadePeca VARCHAR(30)
AS
BEGIN
    INSERT INTO Peca (CodPeca, NomePeca, CorPeca, PesoPeca, CidadePeca)
    VALUES (@CodPeca, @NomePeca, @CorPeca, @PesoPeca, @CidadePeca);
END;
GO

-- Teste da procedure
EXEC sp_InserirPeca
    @CodPeca = 'P4',
    @NomePeca = 'Parafuso',
    @CorPeca = 'Prata',
    @PesoPeca = 5,
    @CidadePeca = 'Curitiba';
GO

-- Conferência
SELECT * FROM Peca;