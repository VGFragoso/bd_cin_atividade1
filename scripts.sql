-- Tipos Auxiliares (Telefone/Endereço) --

-- Endereço --

CREATE OR REPLACE TYPE tp_endereco AS OBJECT(
    pais varchar2(15),
    cep varchar2(9),
    estado varchar2(15),
    cidade VARCHAR2(20),
    complemento varchar2(30)
);

-- Telefone --

CREATE OR REPLACE TYPE TP_FONE AS OBJECT (
    COD_PAIS VARCHAR(3),
    COD_DDD VARCHAR(5),
    PHONE VARCHAR(10)
);
CREATE OR REPLACE TYPE TP_FONE_VA AS VARRAY(3) OF TP_FONE;

-- Entidadades --

-- Pessoa (menor/maior) --

CREATE OR REPLACE TYPE tp_pessoa AS OBJECT(
    pk_cpf VARCHAR2(11),
    NOME VARCHAR2(20),
    SEXO VARCHAR2(1),
    DATA_NASCIMENTO DATE,
    ENDERECO_PAX tp_endereco,
    TELEFONES TP_FONE_VA,
    EMAIL VARCHAR2(30)    
)NOT FINAL;

CREATE TYPE MENOR_IDADE_TP UNDER TP_PESSOA(
    autorizacao_viagem varchar2(3)  
);

--Tabela de Pessoa--

CREATE TABLE MENOR_IDADE_TB OF MENOR_IDADE_TP(
CONSTRAINT AUTORIZACAO_VALOR CHECK (autorizacao_viagem IN ('SIM', 'NAO'))
);

-- Menor de Idade --

CREATE TYPE MAIOR_IDADE_TP UNDER TP_PESSOA();

-- Maior de Idade --

CREATE TABLE MAIOR_IDADE_TB OF MAIOR_IDADE_TP;

-- Voo --

CREATE OR REPLACE TYPE VOO_TP AS OBJECT(
    pk_numero_voo NUMBER(38,0), -
    origem VARCHAR2(3),       
    destino VARCHAR2(3),      
    hora_embarque TIMESTAMP,
    hora_desembarque TIMESTAMP
);

CREATE TABLE VOO OF VOO_TP(
    CONSTRAINT voo_pkey PRIMARY KEY (pk_numero_voo) -- constraint de primary key
);

--PASSAGEM
CREATE TYPE PASSAGEM_TP AS OBJECT(    
    pk_numero_passagem VARCHAR2(22),
    valor_passagem NUMBER(38,2),
    data_ida DATE,
    data_chegada DATE
);

CREATE TABLE PASSAGEM OF PASSAGEM_TP(    
    CONSTRAINT numero_passagem_pkey PRIMARY KEY(pk_numero_passagem)
);

-- Hotel -- 
CREATE TYPE HOTEL_TP AS OBJECT(
    pkid_hotel INTEGER,
    nome VARCHAR2(30),
    endereco_hotel tp_endereco
);

CREATE TABLE HOTEL OF HOTEL_TP(
    CONSTRAINT hotel_pkey PRIMARY KEY (pkid_hotel)
);


-- Estadia --
CREATE TYPE ESTADIA_TP AS OBJECT(

 pk_cod_estadia INTEGER,
 valor_estadia NUMBER(38,2),
 data_check_in DATE,
 data_check_out DATE
);

CREATE TABLE ESTADIA OF ESTADIA_TP(
 CONSTRAINT cod_estadia_pkey PRIMARY KEY(pk_cod_estadia)
);


--RELACIONAMENTOS

CREATE OR REPLACE TYPE tp_refere_se AS OBJECT(
passagem REF PASSAGEM_TP,
voo REF VOO_TP
);

CREATE TABLE REFERE_SE_TB OF TP_REFERE_SE;

CREATE OR REPLACE TYPE TP_REGISTRADA AS OBJECT(
HOTEL REF HOTEL_TP,
ESTADIA REF ESTADIA_TP
);


CREATE TABLE ESTAD_REGISTRADA_TB OF TP_REGISTRADA(
CONSTRAINT fk_estadia
FOREIGN KEY (ESTADIA) REFERENCES ESTADIA,
CONSTRAINT fk_hotel
FOREIGN KEY (HOTEL) REFERENCES HOTEL
);


