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

INSERT INTO Consulta (datahora, tipoconsulta, codpaciente, coddentista, observacao)
VALUES ('2024-05-23 12:00:00', 'Avaliação', 1, 1, NULL);
 
INSERT INTO Consulta (datahora, tipoconsulta, codpaciente, coddentista, observacao)
VALUES ('2024-05-24 13:00:00', 'Avaliação', 2, 4, null);
 
INSERT INTO Consulta (datahora, tipoconsulta, codpaciente, coddentista, observacao)
VALUES ('2024-05-25 14:00:00', 'Avaliação', 3, 4, null);
 



DELETE FROM consulta

/* EXEMPLO 
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
*/

/* UPDATES */

UPDATE dentista 
SET especialidade = 'Geral', telefone= '11223344550', celular= '123456789'
WHERE codDentista= 2;

UPDATE consulta
SET datahora = '2024-05-30 15:00:00'
WHERE codconsulta= 2;

UPDATE consulta
SET tipoconsulta= 'tratamento', observacao= 'Tratamento será realizado em 10 consultas. Prioridade: Moderada. Remédio aplicado: Ponstan, caso sinta dores'
WHERE codconsulta= 2;

/* Selects */

SELECT * FROM dentista

SELECT nome, cidade FROM paciente
WHERE cidade='Santos'
ORDER BY nome ASC /*A-Z*/





SELECT consulta.datahora,dentista.nome, paciente.nome,dentista.telefone, paciente.telefone
FROM consulta
INNER JOIN paciente
ON  paciente.codPaciente = consulta.codPaciente
INNER JOIN dentista
ON consulta.codDentista = dentista.codDentista

SELECT * FROM dentista
SELECT * FROM consulta

/* 11- Criar uma query que exiba a quantidade de dentistas que a clínica possui, agrupando-os por especialidade, ordenando pelo nome da especialidade de A-Z. Para isto, você utilizará o comando group by do sql.  */

SELECT COUNT(codDentista) AS 'Dentistas Registrados',especialidade FROM dentista
GROUP BY especialidade
ORDER BY especialidade ASC /*A-Z*/

/* 12-Criar uma query que mostre a quantidade de consultas que a clínica possui em determinado período do ano. Escolher um mês que retorne ao menos uma consulta, e incluir o mês como filtro. */

SELECT COUNT(codConsulta) AS quantidade_consultas
FROM consulta
WHERE datahora >= '2024-05-25'
