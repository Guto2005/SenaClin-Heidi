CREATE DATABASE senaclin

USE senaclin

CREATE TABLE Paciente (

codPaciente INT AUTO_INCREMENT NOT NULL, 

nome VARCHAR(50) NOT NULL,

telefone CHAR(11) NOT NULL,

cpf CHAR(11) NOT NULL,

tipoLogradouro VARCHAR(15) NOT NULL,

nomeLogradouro VARCHAR(50) NOT NULL,

numero VARCHAR(6) NOT NULL,

complemento VARCHAR(10) DEFAULT 'não existe',

CONSTRAINT PRIMARY KEY (codPaciente),

CONSTRAINT CHECK (tipoLogradouro='Praça' OR tipoLogradouro='Rua' OR tipoLogradouro='Avenida' OR tipoLogradouro='Rodovia' OR tipoLogradouro='Viela')

);

/* Consertos Rapidos */

/*1- Adicionar à tabela Paciente um novo atributo, chamado Cidade;*/ 
ALTER TABLE Paciente
ADD cidade VARCHAR(30) NOT NULL;


CREATE TABLE Dentista (
codDentista INT AUTO_INCREMENT NOT NULL,

nome VARCHAR(50) NOT NULL,

cro CHAR(8) NOT NULL,

especialidade CHAR(22) NOT NULL,

telefone CHAR (11) NOT NULL,

celular CHAR (14) NOT NULL,

CONSTRAINT PRIMARY KEY (codDentista)

);

/* Consertos Rapidos de erros */

ALTER TABLE Dentista
ADD constraint ck_especialidade check (especialidade= 'Ortodontia' or especialidade= 'geral' or especialidade= 'Periodontia' or especialidade= 'implantodontia' or especialidade= ' ');

ALTER TABLE Dentista
MODIFY COLUMN especialidade VARCHAR(100) NOT null;

CREATE TABLE Consulta (
codConsulta INT AUTO_INCREMENT NOT NULL, 
datahora DATETIME NOT NULL,
tipoConsulta VARCHAR(15) NOT NULL,
codPaciente INT NOT NULL,
codDentista INT NOT NULL,
observacao VARCHAR(100),
CONSTRAINT PRIMARY KEY (codConsulta),
CONSTRAINT FK_paciente_consulta FOREIGN KEY (codPaciente) REFERENCES Paciente (codPaciente),
CONSTRAINT FK_dentista_consulta FOREIGN KEY (codDentista) REFERENCES Dentista (codDentista)
);

/* Consertos Rapidos de erros */

ALTER TABLE Consulta
ADD constraint ck_tipoConsulta check (tipoconsulta= 'avaliação' or tipoconsulta= 'Tratamento');


/* AREA DE INSERÇÕES */


/* Pacientes */

/* 2-Inserir 6 pacientes de forma implícita, sendo 3 de Santos, 1 de Guarujá e 2 de São Vicente; */

INSERT INTO paciente (
nome, telefone,cpf,tipoLogradouro,nomeLogradouro,numero,complemento,cidade
)
VALUES(
'Gustavo','13991905643','47494767061','Rua','Arlindo Nogueira','190','casa','Santos'
);

INSERT INTO paciente (
nome, telefone,cpf,tipoLogradouro,nomeLogradouro,numero,complemento,cidade
)
VALUES(
'Adalberto','13982876124','95456866005','Rua','Campos Melo','290','Apartamento','Santos'
);

INSERT INTO paciente (
nome, telefone,cpf,tipoLogradouro,nomeLogradouro,numero,complemento,cidade
)
VALUES(
'Marcela','13983120987','93642017010','Rua','Manuel Torinho','274','Apartamento','Santos'
);

INSERT INTO paciente (
nome, telefone,cpf,tipoLogradouro,nomeLogradouro,numero,complemento,cidade
)
VALUES(
'Giovanna','13982140912','15477993073','Rua','Abolição','278','casa','Guarujá'
);

INSERT INTO paciente (
nome, telefone,cpf,tipoLogradouro,nomeLogradouro,numero,complemento,cidade
)
VALUES(
'Bruna','13981253411','96971715055','Rua','Adão de Barros','223','casa','São Vicente'
);

INSERT INTO paciente (
nome, telefone,cpf,tipoLogradouro,nomeLogradouro,numero,complemento,cidade
)
VALUES(
'Marcos','13991876347','40968974007','Rua','Adão Gonçalves','200','Apartamento','São Vicente'
);

/* Dentistas */

/*3- Inserir 4 dentistas de forma explícita, sendo 1 de cada especialidade; */

INSERT INTO Dentista (
nome,cro,especialidade,telefone,celular
)
VALUES(
'Patricia','12345678','Ortodontia','13982356316','56139914032107'
);

INSERT INTO Dentista (
nome,cro,especialidade,telefone,celular
)
VALUES(
'Marcelo','87654321','Implantodontia','13987654324','56139998765432'
);

INSERT INTO Dentista (
nome,cro,especialidade,telefone,celular
)
VALUES(
'Matheus','10764678','Geral','13989856432','56139854433222'
);

INSERT INTO Dentista (
nome,cro,especialidade,telefone,celular
)
VALUES(
'Eugenio','12244676','Periodontia','13988776412','56139911022101'
);

/* Consultas */

/* 4- Inserir 3 consultas, sendo 1 para o dentista que cuida de Ortodontia e 2 para o dentista cuja especialidade é Geral. O tipo de todas elas será Avaliação. */

INSERT INTO Consulta (datahora, tipoconsulta, codpaciente, coddentista, observacao)
VALUES ('2024-05-23 12:00:00', 'Avaliação', 1, 1, NULL);
 
INSERT INTO Consulta (datahora, tipoconsulta, codpaciente, coddentista, observacao)
VALUES ('2024-05-24 13:00:00', 'Avaliação', 2, 4, null);
 
INSERT INTO Consulta (datahora, tipoconsulta, codpaciente, coddentista, observacao)
VALUES ('2024-05-25 14:00:00', 'Avaliação', 3, 4, null);
 

/*NÃO EXECUTEEEEEEEE */

DELETE FROM consulta


/* UPDATES */

/* 5- Atualizar todos os dados, exceto nome e cro, do dentista que cuida de implantodontia, mudando sua especialidade para Geral; */

UPDATE dentista 
SET especialidade = 'Geral', telefone= '11223344550', celular= '123456789'
WHERE codDentista= 2;

/* 6- Atualizar a data e hora de uma consulta marcada com um dentista cuja especialidade é Geral; */

UPDATE consulta
SET datahora = '2024-05-30 15:00:00'
WHERE codconsulta= 2;

/* 7-Atualizar a consulta do dentista de especialidade ortodontia, mudando o tipo de consulta para Tratamento e inserindo uma observação do dentista com o seguinte texto: “Tratamento será realizado em 10 consultas. Prioridade: Moderada. Remédio aplicado: Ponstan, caso sinta dores” */

UPDATE consulta
SET tipoconsulta= 'tratamento', observacao= 'Tratamento será realizado em 10 consultas. Prioridade: Moderada. Remédio aplicado: Ponstan, caso sinta dores'
WHERE codconsulta= 2;

/* Selects */

SELECT * FROM dentista

/* 8- Selecionar nome e telefone de todo os pacientes que residem em Santos, em ordem alfabética; */

SELECT nome, telefone, cidade FROM paciente
WHERE cidade='Santos'
ORDER BY nome ASC /*A-Z*/

SELECT * FROM paciente

/* 9- Selecionar o nome dos dentistas, a datas da consulta, o nome do paciente e seu telefone, APENAS dos dentistas que possuem consultas; */

SELECT consulta.datahora,dentista.nome AS 'nome do dentista', paciente.nome AS 'nome do Paciente',dentista.telefone AS 'telefone do dentista', paciente.telefone AS 'telefone do Paciente'
FROM consulta
INNER JOIN paciente
ON  paciente.codPaciente = consulta.codPaciente
INNER JOIN dentista
ON consulta.codDentista = dentista.codDentista

/* 10- Selecionar o nome do dentista, a data da consulta e o tipo da consulta, MESMO quando os dentistas não possuam consultas; */

SELECT 
    consulta.datahora, 
    dentista.nome AS 'nome do dentista', 
    paciente.nome AS 'nome do paciente', 
    dentista.telefone AS 'telefone do dentista', 
    paciente.telefone AS 'telefone do paciente'
FROM 
    dentista
LEFT JOIN 
    consulta ON consulta.codDentista = dentista.codDentista
LEFT JOIN 
    paciente ON paciente.codPaciente = consulta.codPaciente;

SELECT * FROM dentista
SELECT * FROM consulta
SELECT * FROM paciente

/* 11- Criar uma query que exiba a quantidade de dentistas que a clínica possui, agrupando-os por especialidade, ordenando pelo nome da especialidade de A-Z. Para isto, você utilizará o comando group by do sql.  */

SELECT COUNT(codDentista) AS 'Dentistas Registrados',especialidade FROM dentista
GROUP BY especialidade
ORDER BY especialidade ASC /*A-Z*/

/* 12-Criar uma query que mostre a quantidade de consultas que a clínica possui em determinado período do ano. Escolher um mês que retorne ao menos uma consulta, e incluir o mês como filtro. */

SELECT COUNT(codConsulta) AS quantidade_consultas
FROM consulta
WHERE datahora >= '2024-05-25'

/* 13- Criar uma query que traga todos os tipos de consulta, agrupadas pela quantidade. */

SELECT tipoconsulta, COUNT(codConsulta) AS quantidade
FROM consulta
GROUP BY tipoconsulta;

/* 14- Criar uma query que traga o número de pacientes que a clínica possui. */

SELECT COUNT(codPaciente) AS NumeroDePaciente
FROM paciente;

/* 15- Criar uma query que traga todas as consultas da especialidade implantodontia. Deve vir na query o nome do dentista, o cro, a data da consulta e o nome do paciente, ordenados da data mais atual para a mais antiga. */

SELECT dentista.nome AS NomeDentista, dentista.CRO, consulta.datahora, paciente.nome AS NomePaciente
FROM consulta
JOIN dentista ON consulta.codDentista = dentista.codDentista
JOIN paciente ON consulta.codPaciente = paciente.codPaciente
WHERE dentista.especialidade = 'implantodontia'
ORDER BY consulta.datahora DESC;

