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