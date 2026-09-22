USE db_pecas;
GO

-- Ajuste no tamanho da coluna CodPeca para comportar 5000 códigos distintos
ALTER TABLE Embarq DROP CONSTRAINT FK_Embarq_Peca;
ALTER TABLE Embarq DROP CONSTRAINT PK_Embarq;
ALTER TABLE Peca DROP CONSTRAINT PK_Peca;

ALTER TABLE Peca ALTER COLUMN CodPeca CHAR(6) NOT NULL;
ALTER TABLE Embarq ALTER COLUMN CodPeca CHAR(6) NOT NULL;

ALTER TABLE Peca ADD CONSTRAINT PK_Peca PRIMARY KEY (CodPeca);
ALTER TABLE Embarq ADD CONSTRAINT PK_Embarq PRIMARY KEY (CodPeca, CodFornec);
ALTER TABLE Embarq ADD CONSTRAINT FK_Embarq_Peca FOREIGN KEY (CodPeca) REFERENCES Peca(CodPeca);
GO

-- Stored Procedure para inserir 5000 registros distintos na tabela Peca
CREATE PROCEDURE sp_Inserir5000Pecas
AS
BEGIN
    DECLARE @i INT = 1;
    DECLARE @CodPeca CHAR(6);

    WHILE @i <= 5000
    BEGIN
        SET @CodPeca = 'P' + RIGHT('00000' + CAST(@i AS VARCHAR(5)), 5);

        INSERT INTO Peca (CodPeca, NomePeca, CorPeca, PesoPeca, CidadePeca)
        VALUES (
            @CodPeca,
            'Peca ' + CAST(@i AS VARCHAR(10)),
            CASE (@i % 4)
                WHEN 0 THEN 'Cinza'
                WHEN 1 THEN 'Preto'
                WHEN 2 THEN 'Verde'
                ELSE 'Azul'
            END,
            (@i % 50) + 1,
            CASE (@i % 3)
                WHEN 0 THEN 'Porto Alegre'
                WHEN 1 THEN 'Rio de Janeiro'
                ELSE 'São Paulo'
            END
        );

        SET @i = @i + 1;
    END
END;
GO

-- Executar a procedure
EXEC sp_Inserir5000Pecas;
GO

-- Conferência
SELECT COUNT(*) AS TotalPecas FROM Peca;