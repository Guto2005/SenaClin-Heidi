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

CREATE TABLE Dentista (
codDentista INT AUTO_INCREMENT NOT NULL,

nome VARCHAR(50) NOT NULL,

cro CHAR(8) NOT NULL,

especialidade CHAR(22) NOT NULL,

telefone CHAR (11) NOT NULL,

celular CHAR (14) NOT NULL,

CONSTRAINT PRIMARY KEY (codDentista)

);

ALTER TABLE Dentista
ADD constraint ck_especialidade check (especialidade= 'Ortodontia' or especialidade= 'geral' or especialidade= 'Periodontia' or especialidade= 'implantodontia' or especialidade= ' ');

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

ALTER TABLE Consulta
ADD constraint ck_tipoConsulta check (tipoconsulta= 'avaliação' or tipoconsulta= 'Tratamento');
