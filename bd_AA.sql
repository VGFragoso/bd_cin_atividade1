--Scripts - Victor
-- Tipos Telefone/Endereço
CREATE OR REPLACE TYPE tp_telefone AS OBJECT(
    DDD             VARCHAR2(2),
    Num             VARCHAR2(10)
);

CREATE OR REPLACE TYPE tp_varr_telefones AS VARRAY(3) OF tp_varr_telefone;

CREATE OR REPLACE TYPE tp_endereco AS OBJECT(
    cep                 VARCHAR2(15),
    pais                VARCHAR2(40),
    estado              VARCHAR2(30),
    cidade              VARCHAR2(50),
    complemento         VARCHAR2(60);


-- Entidades 

CREATE OR REPLACE TYPE tp_passageiro AS OBJECT(
    cpf                 NUMBER,
    nome                VARCHAR2(100),
    sexo                CHAR,
    data_nascimento     DATE,
    endereco            tp_endereco
) NOT FINAL;

CREATE OR REPLACE TYPE tp_passageiro_menor UNDER tp_passageiro(
    telefone_emergencia     tp_varr_telefones,
    responsavel_telefone    VARCHAR2(100),
    autorizacao_viagem      BOOLEAN
);

CREATE OR REPLACE TYPE tp_passageiro_maior UNDER tp_passageiro(
    telefone                tp_varr_telefones,
    email                   VARCHAR2(50)
);

CREATE TABLE HOTEL (
  cod_hotel      NUMBER PRIMARY KEY NOT NULL,
  nome           VARCHAR(60),
  endereco       tp_endereco
);


