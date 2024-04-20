-- Tipo Aux -- Endereço, Telefone

CREATE OR REPLACE TYPE tp_endereco AS OBJECT(
	cep VARCHAR2(10),
	pais VARCHAR2(50),
	estado VARCHAR2(50),
	cidade VARCHAR2(50),
	complemento VARCHAR2(50)   
);

CREATE OR REPLACE TYPE tp_varr_telefone AS OBJECT(
    ddd VARCHAR(2),
    num VARCHAR(2)
);

CREATE OR REPLACE TYPE tp_va_telefones AS VARRAY(3) OF tp_varr_telefone;

--Entidades--

--Passageiros (maior/menor)
CREATE TYPE tp_passageiro AS OBJECT(
    cpf NUMBER,
    nome VARCHAR2(50),
    sexo CHAR,
    endereco tp_endereco,
    data_nascimento DATE
)NOT FINAL;

CREATE OR REPLACE TYPE tp_passageiros_menorid UNDER tp_passageiro(
    fone_emergencia tp_va_telefones,
    responsavel_telefone VARCHAR2(18),
    autorizacao_viagem CHAR
);

CREATE OR REPLACE TYPE tp_passageiros_menorid UNDER tp_passageiro(
    telefone tp_va_telefones,
    email VARCHAR2 (50)
);
