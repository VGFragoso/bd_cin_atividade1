CREATE OR REPLACE TYPE tp_endereco AS OBJECT(
	cep VARCHAR2(10),
	pais VARCHAR2(50),
	estado VARCHAR2(50),
	cidade VARCHAR2(50),
	complemento VARCHAR2(50)   
);

CREATE OR REPLACE TYPE tp_telefone AS OBJECT(
    ddd VARCHAR(2),
    num VARCHAR(11)
);

CREATE OR REPLACE TYPE tp_va_telefones AS VARRAY(3) OF tp_telefone;

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

CREATE OR REPLACE TYPE tp_passageiros_maiorid UNDER tp_passageiro(
    telefone tp_va_telefones,
    email VARCHAR2 (50)
);

-- Estadia --

CREATE TYPE tp_estadia AS OBJECT(
    cod_estadia number,
    Data_checkin date,
    data_checkout date,
    valor_estadia number(38,02)
);

CREATE TABLE tb_estadia OF tp_estadia (
    CONSTRAINT pk_estadia PRIMARY KEY (cod_estadia)
);

-- Hotel --

CREATE TYPE tp_hotel AS OBJECT(
    pk_cod_hotel number,
    nome VARCHAR(20),
    endereco tp_endereco 
);

-- Passagem -- 

CREATE TYPE tp_passagem AS OBJECT(
    num_passagem NUMBER,
    data_ida DATE ,
    data_volta DATE,
    valor_passagem NUMBER(10,2)
);

-- Voos --

CREATE TYPE tp_voo AS OBJECT(
    num_voo NUMBER,
    origem VARCHAR (3),
    destino VARCHAR (3),
    hora_embarque DATE,
    hora_desembraque DATE
);

-- Relacionamentos--

-- Entidade associativa (Reserva) --

CREATE TYPE tp_reserva AS OBJECT(
    passageiro REF tp_passageiro,
    passagem REF tp_passagem,
    data_compra DATE,
    localizador VARCHAR2(50),
    tipo_passageiro CHAR
);

-- Comprar --

CREATE TYPE tp_comprar AS OBJECT(
    num_reserva REF tp_reserva,
    num_estadia REF tp_estadia
);

CREATE TYPE tb_comprar_nt AS TABLE OF tp_comprar;

ALTER TYPE tp_reserva ADD ATTRIBUTE(
    comprar_id REF  tp_comprar
) CASCADE;

-- Refere-se --
CREATE TYPE tp_rel_referese_passagens AS OBJECT(
    passagem REF tp_passagem
) NOT FINAL;

CREATE TYPE tb_rel_referese_passagens_nt AS TABLE OF tp_rel_referese_passagens;

ALTER TYPE tp_voo ADD ATTRIBUTE(
    Passagens  tb_rel_referese_passagens_nt
) CASCADE;

-- Registra --

CREATE TYPE tp_registrar AS OBJECT(
    num_estadia REF tp_estadia,
    cod_hotel REF tp_hotel
);

CREATE TYPE tp_registrar_nt AS TABLE OF tp_registrar;

ALTER TYPE tp_hotel ADD ATTRIBUTE(
    estadia tp_registrar_nt
)CASCADE;

-- Tabelas --

 
