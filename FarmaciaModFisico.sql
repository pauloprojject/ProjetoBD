SET DATEFORMAT dmy

CREATE DATABASE FARMACIA
GO

USE FARMACIA
GO

CREATE TABLE Funcionario(
Cod_Funcionario INT IDENTITY NOT NULL,
Nome VARCHAR(150) NOT NULL,
CPF VARCHAR(12) NOT NULL,
RG VARCHAR(16) NOT NULL,
Salario NUMERIC(10,2) NOT NULL,
Cidade VARCHAR(70) NOT NULL,
Bairro VARCHAR(50) NOT NULL,
Rua VARCHAR(150) NOT NULL,
Num INT NOT NULL,
Celular VARCHAR (18) NOT NULL,
Telefone VARCHAR (9),
CONSTRAINT PK_Funcionario PRIMARY KEY (Cod_Funcionario),
CONSTRAINT AK_Funcioario_Celular UNIQUE (Celular),
CONSTRAINT CK_Funcionario_CPF CHECK (LEN(CPF)=11),
CONSTRAINT CK_Funcionario_Salario CHECK (Salario > 0)
)

CREATE TABLE Cliente(
Cod_Cliente INT IDENTITY NOT NULL,
Nome VARCHAR(150) NOT NULL,
CPF VARCHAR(12) NOT NULL,
RG VARCHAR(16) NOT NULL,
Cidade VARCHAR(70) NOT NULL,
Bairro VARCHAR(50) NOT NULL,
Rua VARCHAR(150) NOT NULL,
Num INT NOT NULL,
Celular VARCHAR (18) NOT NULL,
Telefone VARCHAR (9),
CONSTRAINT PK_Cliente PRIMARY KEY (Cod_Cliente),
CONSTRAINT AK_Cliente_Celular UNIQUE (Celular),
CONSTRAINT CK_Cliente_CPF CHECK (LEN(CPF)=11),
)

CREATE TABLE Medicamento(
Cod_Med INT,
Nome VARCHAR(100),
Compos_Química VARCHAR(255),
Lote INT,
Validade VARCHAR(20),
Preco DECIMAL(6,2),
CONSTRAINT PK_Medicamento PRIMARY KEY (Cod_Med),
CONSTRAINT CK_Medicamento_Preco CHECK (Preco > 0)
)

CREATE TABLE Receita(
Cod_Prescricao INT,
Prescrição VARCHAR(255),
Assinatura VARCHAR(255),
Data DATETIME,
Tipo VARCHAR (70),
CONSTRAINT PK_Receita PRIMARY KEY (Cod_Prescricao),
)

CREATE TABLE Compra(
Num_compra INT,
Cod_Medicamento INT,
Cod_Cliente INT,
Qtd_comprada INT,
CONSTRAINT FK_Compra_Cod_Medicamento  FOREIGN KEY (Cod_Medicamento) REFERENCES Medicamento,
CONSTRAINT FK_Compra_Cod_Cliente FOREIGN KEY (Cod_Cliente) REFERENCES Cliente,
CONSTRAINT PK_Compra PRIMARY KEY (Num_Compra, Cod_Medicamento, Cod_Cliente),
CONSTRAINT CK_Compra_Quantidade CHECK (Qtd_comprada > 0),
)

CREATE TABLE Farmaceutico(
CRF INT,
Nome VARCHAR(150) NOT NULL,
Cod_Farmaceutico INT IDENTITY NOT NULL,
CPF VARCHAR(12) NOT NULL,
RG VARCHAR(16) NOT NULL,
Salario NUMERIC(10,2) NOT NULL,
Cidade VARCHAR(70) NOT NULL,
Bairro VARCHAR(50) NOT NULL,
Rua VARCHAR(150) NOT NULL,
Num INT NOT NULL,
Celular VARCHAR (18) NOT NULL,
Telefone VARCHAR (9),
Cod_Prescricao INT,
CONSTRAINT PK_Farmaceutico PRIMARY KEY (CRF),
CONSTRAINT AK_Farmaceutico_Celular UNIQUE (Celular),
CONSTRAINT CK_Farmaceutico_CPF CHECK (LEN(CPF)=11),
CONSTRAINT CK_Farmaceutico_Salario CHECK (Salario > 0),
CONSTRAINT FK_Cod_Prescricao FOREIGN KEY (Cod_Prescricao) REFERENCES Receita
)

CREATE TABLE Caixa(
Cod_Caixa INT IDENTITY NOT NULL,
Nome VARCHAR(150) NOT NULL,
CPF VARCHAR(12) NOT NULL,
RG VARCHAR(16) NOT NULL,
Salario NUMERIC(10,2) NOT NULL,
Cidade VARCHAR(70) NOT NULL,
Bairro VARCHAR(50) NOT NULL,
Rua VARCHAR(150) NOT NULL,
Num INT NOT NULL,
Celular VARCHAR (18) NOT NULL,
Telefone VARCHAR (9),
CONSTRAINT PK_Caixa PRIMARY KEY (Cod_Caixa),
CONSTRAINT AK_Caixa_Celular UNIQUE (Celular),
CONSTRAINT CK_Caixa_CPF CHECK (LEN(CPF)=11),
CONSTRAINT CK_Caixa_Salario CHECK (Salario > 0)
)

CREATE TABLE Paga(
Num_compra INT NOT NULL,
Cod_Medicamento INT NOT NULL,
Cod_Cliente INT NOT NULL,
Cod_caixa INT NOT NULL,
Forma_Pagamento VARCHAR(2) NOT NULL,
CONSTRAINT Fk_Paga_Num_compra FOREIGN KEY (Num_Compra, Cod_Medicamento, Cod_Cliente) REFERENCES Compra,
CONSTRAINT FK_Paga_Cod_Caixa FOREIGN KEY (Cod_Caixa) REFERENCES Caixa,
CONSTRAINT PK_Paga PRIMARY KEY (Num_compra, Cod_caixa)
)

CREATE TABLE Registra(
Num_compra INT NOT NULL,
Cod_Medicamento INT NOT NULL,
Cod_Cliente INT NOT NULL,
Cod_Funcionario INT NOT NULL,
CONSTRAINT Fk_Registra_Num_compra FOREIGN KEY (Num_Compra, Cod_Medicamento, Cod_Cliente) REFERENCES Compra,
CONSTRAINT FK_Registra_Cod_Funcionario FOREIGN KEY (Cod_Funcionario) REFERENCES Funcionario,
CONSTRAINT PK_Registra PRIMARY KEY (Num_Compra, Cod_Funcionario) 
)

CREATE TABLE Autoriza(
Cod_Medicamento INT NOT NULL,
Cod_Receita INT NOT NULL,
CONSTRAINT FK_Autoriza_Cod_Medicamento  FOREIGN KEY (Cod_Medicamento) REFERENCES Medicamento,
CONSTRAINT FK_Autoriza_Cod_Receita FOREIGN KEY (Cod_Receita) REFERENCES Receita,
CONSTRAINT PK_Autoriza PRIMARY KEY (Cod_Medicamento, Cod_Receita) 
)

CREATE TABLE Motoboy(
Cod_Motoboy INT IDENTITY NOT NULL,
Nome VARCHAR(150) NOT NULL,
CNH INT NOT NULL,
CPF VARCHAR(12) NOT NULL,
RG VARCHAR(16) NOT NULL,
Salario NUMERIC(10,2) NOT NULL,
Cidade VARCHAR(70) NOT NULL,
Bairro VARCHAR(50) NOT NULL,
Rua VARCHAR(150) NOT NULL,
Num INT NOT NULL,
Celular VARCHAR (18) NOT NULL,
Telefone VARCHAR (9),
CONSTRAINT PK_Motoboy PRIMARY KEY (Cod_Motoboy),
CONSTRAINT AK_Motoboy_Celular UNIQUE (Celular),
CONSTRAINT CK_Motoboy_CPF CHECK (LEN(CPF)=11),
CONSTRAINT CK_Motoboy_Salario CHECK (Salario > 0)
)

CREATE TABLE Entrega(
Receber_Valor DECIMAL(6,2),
Cod_Motoboy INT,
Num_Compra INT,
Cod_Medicamento INT NOT NULL,
Cod_Cliente INT NOT NULL,
CONSTRAINT FK_Entrega_Cod_Motoboy  FOREIGN KEY (Cod_Motoboy) REFERENCES Motoboy,
CONSTRAINT FK_Entrega_Num_compra FOREIGN KEY (Num_compra, Cod_Medicamento, Cod_Cliente) REFERENCES Compra,
CONSTRAINT PK_Entrega PRIMARY KEY (Receber_Valor, Cod_Motoboy, Num_Compra)
)


-- INSERINDO FUNCIONÁRIOS
INSERT INTO Funcionario(Nome, CPF, RG, Salario, Cidade, Bairro, Rua, Num, Celular, Telefone)
VALUES ('Alecsander', 12345678901, 123456, 2000.00 , 'João Pessoa', 'Geisel', 'Logo Ali', 10, '98888-8888', Null)

INSERT INTO Funcionario (Nome, CPF, RG, Salario ,Cidade, Bairro, Rua, Num, Celular, Telefone)
VALUES ('Jefferson', 12345678902, 123457, 2500, 'João Pessoa', 'BDI', 'Logo lá', 20, '98888-8880', Null)

INSERT INTO Funcionario (Nome, CPF, RG, Salario ,Cidade, Bairro, Rua, Num, Celular, Telefone)
VALUES ('Paulo', 12345678903, 123458, 3000,'Cabedelo', 'Camalau', 'Logo aculá', 40, '98888-8882', Null)

INSERT INTO Funcionario (Nome, CPF, RG, Salario ,Cidade, Bairro, Rua, Num, Celular, Telefone)
VALUES ('Joaozin', 12345678904, 123459, 3500, 'Bayeux', 'centro', 'Longe', 50, '98888-8883', Null)

INSERT INTO Funcionario (Nome, CPF, RG, Salario ,Cidade, Bairro, Rua, Num, Celular, Telefone)
VALUES ('Mariazinha', 12345678905, 123450, 2000, 'Santa Rita', 'Tibiri', 'Rua alegre', 50, '98888-8884', Null)


-- INSERINDO CLIENTES
INSERT INTO Cliente (Nome, CPF, RG, Cidade, Bairro, Rua, Num, Celular, Telefone)
VALUES ('Cliente1', 12345678901, 123456, 'João Pessoa', 'Geisel', 'Logo Ali', 10, '98888-8888', Null)

INSERT INTO Cliente (Nome, CPF, RG, Cidade, Bairro, Rua, Num, Celular, Telefone)
VALUES ('Cliente2', 12345678902, 123457, 'João Pessoa', 'BDI', 'Logo lá', 20, '98888-8880', Null)

INSERT INTO Cliente (Nome, CPF, RG, Cidade, Bairro, Rua, Num, Celular, Telefone)
VALUES ('Cliente3', 12345678903, 123458, 'Cabedelo', 'Camalau', 'Logo aculá', 40, '98888-8882', Null)

INSERT INTO Cliente (Nome, CPF, RG, Cidade, Bairro, Rua, Num, Celular, Telefone)
VALUES ('Cliente4', 12345678904, 123459, 'Bayeux', 'centro', 'Longe', 50, '98888-8883', Null)

INSERT INTO Cliente (Nome, CPF, RG, Cidade, Bairro, Rua, Num, Celular, Telefone)
VALUES ('Cliente5', 12345678905, 123450, 'Santa Rita', 'Tibiri', 'Rua alegre', 50, '98888-8884', Null)


-- INSERINDO MEDICAMENTOS
INSERT INTO Medicamento(Cod_Med, Nome, Compos_Química, Lote, Validade, Preco)
VALUES(1, 'Paracetamol', 'paracetamol e o ácido acético', 12345, '24 meses', 2.50)

INSERT INTO Medicamento(Cod_Med, Nome, Compos_Química, Lote, Validade, Preco)
VALUES(2, 'Atroveran', 'Ibuprofeno 400mg', 12346, '24 meses', 12.50)

INSERT INTO Medicamento(Cod_Med, Nome, Compos_Química, Lote, Validade, Preco)
VALUES(3, 'Paco', 'paracetamol + fosfato de codeína', 12355, '12 meses', 32.00)

INSERT INTO Medicamento(Cod_Med, Nome, Compos_Química, Lote, Validade, Preco)
VALUES(4, 'Diazepam', 'benzodiazepínicos', 12347, '18 meses', 4.50)

INSERT INTO Medicamento(Cod_Med, Nome, Compos_Química, Lote, Validade, Preco)
VALUES(5, 'Panvel', 'Diclofenaco', 13345, '24 meses', 9.49)


--INSERINDO RECEITAS
INSERT INTO Receita(Cod_Prescricao, Prescrição, Assinatura, Data, Tipo)
VALUES(123, 'Paracetamol tomar de 12 em 12 horas', 'Dr. Paulo Paulada', 10/10/20, 'A1')

INSERT INTO Receita(Cod_Prescricao, Prescrição, Assinatura, Data, Tipo)
VALUES(133, 'Paco tomar de 1 vez ao dia', 'Dr. Jeff bay', 10/1/20, 'B1')

INSERT INTO Receita(Cod_Prescricao, Prescrição, Assinatura, Data, Tipo)
VALUES(143, 'Panvel tomar de 12 em 12 horas', 'Dr. Paulo Paulada', 1/10/20, 'C1')

INSERT INTO Receita(Cod_Prescricao, Prescrição, Assinatura, Data, Tipo)
VALUES(153, 'Diazepam tomar de 1 vez ao dia durante 30 dias', 'Dr. Alecsander underground', 10/11/20, 'C2')

INSERT INTO Receita(Cod_Prescricao, Prescrição, Assinatura, Data, Tipo)
VALUES(163, 'Atroveram tomar de 8 em 8 horas durante 7 dias', 'Dr. Alecsander underground', 1/12/20, 'A1')

-- INSERINDO COMPRAS
INSERT INTO Compra (Num_compra,Cod_Medicamento,Cod_Cliente, Qtd_comprada)
VALUES (1 , 1, 1, 5)

INSERT INTO Compra (Num_compra,Cod_Medicamento,Cod_Cliente, Qtd_comprada)
VALUES (2 , 2, 2, 10)

INSERT INTO Compra (Num_compra,Cod_Medicamento,Cod_Cliente, Qtd_comprada)
VALUES (3, 3, 3, 8)

INSERT INTO Compra (Num_compra,Cod_Medicamento,Cod_Cliente, Qtd_comprada)
VALUES (4, 3, 3, 2)

INSERT INTO Compra (Num_compra,Cod_Medicamento,Cod_Cliente, Qtd_comprada)
VALUES (5, 5, 5, 15)

-- INSERINDO FARMACEUTICO
INSERT INTO Farmaceutico(CRF, Nome, CPF, RG, Salario, Cidade, Bairro, Rua, Num, Celular, Telefone, Cod_Prescricao)
VALUES (1234, 'Farmaceutico1',  12345678901, 123456, 4000, 'João Pessoa', 'Geisel', 'Logo Ali', 10, '98888-8888', '3222-2222', 123)

INSERT INTO Farmaceutico(CRF, Nome, CPF, RG, Salario, Cidade, Bairro, Rua, Num, Celular, Telefone, Cod_Prescricao)
VALUES (1235, 'Farmaceutico2', 12345678902, 123455, 5000, 'João Pessoa', 'Geisel', 'ACULÁ', 20, '98888-9999', Null, 133)

INSERT INTO Farmaceutico(CRF, Nome, CPF, RG, Salario, Cidade, Bairro, Rua, Num, Celular, Telefone, Cod_Prescricao)
VALUES (1236, 'Farmaceutico3', 12345678903, 123454, 4500, 'João Pessoa', 'Geisel', 'Longe demais', 30, '98888-7777', '3244-4444', 143)

INSERT INTO Farmaceutico(CRF, Nome, CPF, RG, Salario, Cidade, Bairro, Rua, Num, Celular, Telefone, Cod_Prescricao)
VALUES (1237, 'Farmaceutico4', 12345678904, 123453, 4000, 'João Pessoa', 'Geisel', 'Bem pertin', 40, '98888-6666', Null, 153)

INSERT INTO Farmaceutico(CRF, Nome, CPF, RG, Salario, Cidade, Bairro, Rua, Num, Celular, Telefone, Cod_Prescricao)
VALUES (1238, 'Farmaceutico5', 12345678905, 123452, 6000, 'João Pessoa', 'Geisel', 'Só é ir reto', 50, '98888-5555', Null, 143)

-- INSERINDO CAIXA
INSERT INTO Caixa(Nome, CPF, RG, Salario, Cidade, Bairro, Rua, Num, Celular, Telefone)
VALUES ('Caixa1', 12345678901, 123456, 2000 , 'João Pessoa', 'Geisel', 'Logo Ali', 10, '98888-8888', Null)

INSERT INTO Caixa (Nome, CPF, RG, Salario ,Cidade, Bairro, Rua, Num, Celular, Telefone)
VALUES ('Caixa2', 12345678902, 123457, 1500, 'João Pessoa', 'BDI', 'Logo lá', 20, '99999-8880', Null)

INSERT INTO Caixa (Nome, CPF, RG, Salario ,Cidade, Bairro, Rua, Num, Celular, Telefone)
VALUES ('Caixa3', 12345678903, 123458, 1500,'Cabedelo', 'Camalau', 'Logo aculá', 40, '99999-8882', Null)

INSERT INTO Caixa (Nome, CPF, RG, Salario ,Cidade, Bairro, Rua, Num, Celular, Telefone)
VALUES ('Caixa4', 12345678904, 123459, 1500, 'Bayeux', 'centro', 'Longe', 50, '98888-8883', Null)

INSERT INTO Caixa (Nome, CPF, RG, Salario ,Cidade, Bairro, Rua, Num, Celular, Telefone)
VALUES ('Caixa5', 12345678905, 123450, 1500, 'Santa Rita', 'Tibiri', 'Rua alegre', 50, '98888-8884', Null)


-- INSERINDO PAGA
INSERT INTO Paga(Num_compra, Cod_Medicamento, Cod_Cliente, Cod_caixa, Forma_Pagamento)
VALUES (1,1,1,1, 'D')

INSERT INTO Paga(Num_compra, Cod_Medicamento, Cod_Cliente, Cod_caixa, Forma_Pagamento)
VALUES (2,2,2,1, 'CD')

INSERT INTO Paga(Num_compra, Cod_Medicamento, Cod_Cliente, Cod_caixa, Forma_Pagamento)
VALUES (3,3,3,3, 'CC')

INSERT INTO Paga(Num_compra, Cod_Medicamento, Cod_Cliente, Cod_caixa, Forma_Pagamento)
VALUES (4,3,3,3, 'CC')

INSERT INTO Paga(Num_compra, Cod_Medicamento, Cod_Cliente, Cod_caixa, Forma_Pagamento)
VALUES (5,5,5,5, 'D')

-- INSERINDO REGISTRA
INSERT INTO Registra(Num_compra, Cod_Medicamento, Cod_Cliente,Cod_Funcionario)
VALUES(1,1,1,1)

INSERT INTO Registra(Num_compra, Cod_Medicamento, Cod_Cliente,Cod_Funcionario)
VALUES(2,2,2,2)

INSERT INTO Registra(Num_compra, Cod_Medicamento, Cod_Cliente,Cod_Funcionario)
VALUES(3,3,3,3)

INSERT INTO Registra(Num_compra, Cod_Medicamento, Cod_Cliente,Cod_Funcionario)
VALUES(4,3,3,3)

INSERT INTO Registra(Num_compra, Cod_Medicamento, Cod_Cliente,Cod_Funcionario)
VALUES(5,5,5,5)

-- INSERINDO AUTORIZA
INSERT INTO Autoriza(Cod_Medicamento, Cod_Receita)
VALUES(1,123)

INSERT INTO Autoriza(Cod_Medicamento, Cod_Receita)
VALUES(2,133)

INSERT INTO Autoriza(Cod_Medicamento, Cod_Receita)
VALUES(3,143)

INSERT INTO Autoriza(Cod_Medicamento, Cod_Receita)
VALUES(4,153)

INSERT INTO Autoriza(Cod_Medicamento, Cod_Receita)
VALUES(5,163)


--INSERINDO MOTOBOY
INSERT INTO Motoboy(Nome, CNH,  CPF, RG, Salario, Cidade, Bairro, Rua, Num, Celular, Telefone)
VALUES ('Motoboy1', 123459, 12345678901, 123456, 2500 , 'João Pessoa', 'Geisel', 'Logo Ali', 10, '98888-8888', Null)

INSERT INTO Motoboy(Nome, CNH, CPF, RG, Salario ,Cidade, Bairro, Rua, Num, Celular, Telefone)
VALUES ('Motoboy2', 123456, 12345678902, 123457, 2000, 'João Pessoa', 'BDI', 'Logo lá', 20, '98888-8880', Null)

INSERT INTO Motoboy(Nome, CNH, CPF, RG, Salario ,Cidade, Bairro, Rua, Num, Celular, Telefone)
VALUES ('Motoboy3', 523456, 12345678903, 123458, 1500,'Cabedelo', 'Camalau', 'Logo aculá', 40, '98888-8882', Null)

INSERT INTO Motoboy(Nome, CNH, CPF, RG, Salario ,Cidade, Bairro, Rua, Num, Celular, Telefone)
VALUES ('Motoboy4', 423456, 12345678904, 123459, 1800, 'Bayeux', 'centro', 'Longe', 50, '98888-8883', Null)

INSERT INTO Motoboy(Nome, CNH, CPF, RG, Salario ,Cidade, Bairro, Rua, Num, Celular, Telefone)
VALUES ('Motoboy5', 323456, 12345678905, 123450, 3000, 'Santa Rita', 'Tibiri', 'Rua alegre', 50, '98888-8884', Null)


-- INSERINDO ENTREGA
INSERT INTO Entrega(Receber_Valor, Cod_Motoboy, Num_Compra, Cod_Medicamento, Cod_Cliente)
VALUES(23.5, 1, 1, 1, 1)

INSERT INTO Entrega(Receber_Valor, Cod_Motoboy, Num_Compra, Cod_Medicamento, Cod_Cliente)
VALUES(15.5,2, 2, 2, 2)

INSERT INTO Entrega(Receber_Valor, Cod_Motoboy, Num_Compra, Cod_Medicamento, Cod_Cliente)
VALUES(20, 3, 3, 3, 3)

INSERT INTO Entrega(Receber_Valor, Cod_Motoboy, Num_Compra, Cod_Medicamento, Cod_Cliente)
VALUES(30, 4, 5, 5, 5)

INSERT INTO Entrega(Receber_Valor, Cod_Motoboy, Num_Compra, Cod_Medicamento, Cod_Cliente)
VALUES(50, 5, 4, 3, 3)


-- IN OU NOT IN
SELECT Num_compra, Forma_Pagamento 
FROM Paga
WHERE Forma_Pagamento IN ('CD','CC')

-- BETWEEN ou NOT BETWEEN
SELECT Nome, Salario
FROM Motoboy
WHERE Salario BETWEEN 1500 and 2000
ORDER BY Salario

-- IS NULL ou IS NOT NULL
SELECT CRF, Nome, Telefone
FROM Farmaceutico
WHERE Telefone IS NOT NULL
select *
from Receita

-- LIKE ou NOT LIKE
SELECT Prescrição, Tipo
FROM Receita
WHERE Tipo LIKE 'C%'

-- ORDER BY
SELECT Nome, Salario
FROM Farmaceutico
ORDER BY Salario

-- COUNT
SELECT COUNT(Salario) AS [Quantidade]
FROM Motoboy
WHERE Salario >= 2000

-- SUM
SELECT SUM(Salario) AS [Total]
FROM Farmaceutico

-- AVG
SELECT AVG(salario) AS [Valor médio]
FROM Motoboy

-- MAX ou MIN
SELECT MAX(Salario) AS [Maior salário]
FROM Caixa

-- GROUP BY
SELECT Forma_Pagamento, COUNT(*) AS [Quantidade]
FROM Paga
GROUP BY Forma_Pagamento

-- HAVING
SELECT Forma_Pagamento, COUNT(*) AS [Quantidade]
FROM Paga
GROUP BY Forma_Pagamento
HAVING COUNT(Num_compra) > 1


-- JOIN
SELECT Cliente.Nome, Compra.Num_compra, Compra.Qtd_comprada
FROM Cliente
INNER JOIN Compra
ON Cliente.Cod_Cliente = Compra.Cod_Cliente



