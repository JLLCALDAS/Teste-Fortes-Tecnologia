/******************************************************************************/
/***          Generated by IBExpert 2012.02.21 26/03/2021 20:29:51          ***/
/******************************************************************************/

SET SQL DIALECT 3;

SET NAMES NONE;

SET CLIENTLIB 'C:\Firebird\Firebird-2.5\bin\fbclient.dll';

CREATE DATABASE 'C:\Users\DES\Documents\Embarcadero\Studio\Projects\Win32\TesteFortesTecnologia\DataBase\POSTO_ABC.FDB'
USER 'SYSDBA' PASSWORD 'masterkey'
PAGE_SIZE 16384
DEFAULT CHARACTER SET NONE COLLATION NONE;



/******************************************************************************/
/***                               Generators                               ***/
/******************************************************************************/

CREATE GENERATOR GEN_USUARIO;
SET GENERATOR GEN_USUARIO TO 0;

CREATE GENERATOR GEN_CLIENTE;
SET GENERATOR GEN_CLIENTE TO 0;

CREATE GENERATOR GEN_BOMBAS;
SET GENERATOR GEN_BOMBAS TO 0;

CREATE GENERATOR GEN_TANQUECOMBUSTIVEL;
SET GENERATOR GEN_TANQUECOMBUSTIVEL TO 0;

CREATE GENERATOR GEN_ABASTECIMENTO;
SET GENERATOR GEN_ABASTECIMENTO TO 0;


/******************************************************************************/
/***                                 Tables                                 ***/
/******************************************************************************/


CREATE TABLE ABC_USUARIO (
    ID_USUARIO   INTEGER NOT NULL,
    LOGIN        VARCHAR(8) NOT NULL,
    SENHA        VARCHAR(60) NOT NULL,
    EMAIL        VARCHAR(60) 
);

CREATE TABLE ABC_CLIENTE (
    ID_CLIENTE   INTEGER NOT NULL,
    NOME         VARCHAR(50) NOT NULL,
    CEP          VARCHAR(15) NOT NULL,
    TIPO_PESSOA  VARCHAR(1) NOT NULL,
    CPF_CNPJ     VARCHAR(20) NOT NULL,    
    LOGRADOURO   VARCHAR(60) NOT NULL,
    NUMERO       VARCHAR(10) NOT NULL,
    COMPLEMENTO  VARCHAR(40) NOT NULL,
    CIDADE       VARCHAR(40) NOT NULL,
    SIGLA_UF     VARCHAR(2) NOT NULL
);

CREATE TABLE ABC_TANQUECOMBUSTIVEL (
    ID_TANQUECOMBUSTIVEL   INTEGER NOT NULL,
    DESCRICAO             VARCHAR(50) NOT NULL
);

CREATE TABLE ABC_BOMBAS (
    ID_BOMBA   INTEGER NOT NULL,
    DESCRICAO  VARCHAR(50) NOT NULL,
    SIGLA      VARCHAR(4) NOT NULL,
    ID_TANQUECOMBUSTIVEL   INTEGER NOT NULL
);

CREATE TABLE ABC_ABASTECIMENTO (
    ID_ABASTECIMENTO   INTEGER NOT NULL,
    ID_CLIENTE  INTEGER NOT NULL,
    ID_BOMBA      INTEGER NOT NULL,
    DATA_ABASTECIMENTO   TIMESTAMP,
    IMPOSTO_ABASTECIMENTO NUMERIC(15,2),
    QTD_LITRO      NUMERIC(15,4),
    VLR_LITRO   NUMERIC(15,4),
    TOTAL_ABASTECIMENTO NUMERIC(15,2),
    TOTAL_IMPOSTO NUMERIC(15,2)    
);


/******************************************************************************/
/***                              Primary Keys                              ***/
/******************************************************************************/

ALTER TABLE ABC_USUARIO ADD CONSTRAINT PK_USUARIO PRIMARY KEY (ID_USUARIO);
ALTER TABLE ABC_CLIENTE ADD CONSTRAINT PK_CLIENTE PRIMARY KEY (ID_CLIENTE);
ALTER TABLE ABC_TANQUECOMBUSTIVEL ADD CONSTRAINT PK_TANQUECOMBUSTIVEL PRIMARY KEY (ID_TANQUECOMBUSTIVEL);
ALTER TABLE ABC_BOMBAS ADD CONSTRAINT PK_BOMBAS PRIMARY KEY (ID_BOMBA);
ALTER TABLE ABC_ABASTECIMENTO ADD CONSTRAINT PK_ABASTECIMENTO PRIMARY KEY (ID_ABASTECIMENTO);

/******************************************************************************/
/***                              Foreign Keys                              ***/
/******************************************************************************/

ALTER TABLE ABC_BOMBAS ADD CONSTRAINT FK_BOMBA_TANQUECOMBUSTIVEL FOREIGN KEY (ID_TANQUECOMBUSTIVEL) REFERENCES ABC_TANQUECOMBUSTIVEL (ID_TANQUECOMBUSTIVEL) ON UPDATE CASCADE;
ALTER TABLE ABC_ABASTECIMENTO ADD CONSTRAINT FK_BOMBA_ABASTECIMENTO FOREIGN KEY (ID_BOMBA) REFERENCES ABC_BOMBAS (ID_BOMBA) ON UPDATE CASCADE;
ALTER TABLE ABC_ABASTECIMENTO ADD CONSTRAINT FK_CLIENTE_ABASTECIMENTO FOREIGN KEY (ID_CLIENTE) REFERENCES ABC_CLIENTE (ID_CLIENTE) ON UPDATE CASCADE;

/******************************************************************************/
/***                              Descriptions                              ***/
/******************************************************************************/

DESCRIBE GENERATOR GEN_USUARIO
'Incrementar no PK na tabela do USUARIO';

DESCRIBE GENERATOR GEN_CLIENTE
'Incrementar no PK na tabela do CLIENTE';

DESCRIBE GENERATOR GEN_TANQUECOMBUSTIVEL
'Incrementar no PK na tabela do TANQUECOMBUSTIVEL';

DESCRIBE GENERATOR GEN_BOMBAS
'Incrementar no PK na tabela de BOMBAS';

DESCRIBE GENERATOR GEN_ABASTECIMENTO
'Incrementar no PK na tabela de ABASTECIMENTO';


/******************************************************************************/
/***                                Triggers                                ***/
/******************************************************************************/

SET TERM ^ ;

/******************************************************************************/
/***                          Triggers for tables                           ***/
/******************************************************************************/
/* Trigger: TR_USUARIO */
CREATE OR ALTER TRIGGER TR_USUARIO FOR ABC_USUARIO
ACTIVE BEFORE INSERT POSITION 0
as
begin
  new.ID_USUARIO = gen_id("GEN_USUARIO",1);
end
^

/* Trigger: TR_CLIENTE */
CREATE OR ALTER TRIGGER TR_CLIENTE FOR ABC_CLIENTE
ACTIVE BEFORE INSERT POSITION 0
as
begin
  new.ID_CLIENTE = gen_id("GEN_CLIENTE",1);
end
^

/* Trigger: TR_TANQUECOMBUSTIVEL */
CREATE OR ALTER TRIGGER TR_TANQUECOMBUSTIVEL FOR ABC_TANQUECOMBUSTIVEL
ACTIVE BEFORE INSERT POSITION 1
as
begin
  new.ID_TANQUECOMBUSTIVEL = gen_id("GEN_TANQUECOMBUSTIVEL",1);
end
^

/* Trigger: TR_BOMBAS */
CREATE OR ALTER TRIGGER TR_BOMBAS FOR ABC_BOMBAS
ACTIVE BEFORE INSERT POSITION 1
as
begin
  new.ID_BOMBA = gen_id("GEN_BOMBAS",1);
end
^

/* Trigger: TR_ABASTECIMENTO */
CREATE OR ALTER TRIGGER TR_ABASTECIMENTO FOR ABC_ABASTECIMENTO
ACTIVE BEFORE INSERT POSITION 1
as
begin
  new.ID_ABASTECIMENTO = gen_id("GEN_ABASTECIMENTO",1);
end
^

SET TERM ; ^

/******************************************************************************/
/***                          Script para inserção de usuario               ***/
/*** Usuário:Admin Senha: admin                                             ***/
/******************************************************************************/

INSERT INTO ABC_USUARIO (ID_USUARIO, LOGIN, SENHA, EMAIL) VALUES (1, 'Admin', '21232F297A57A5A743894A0E4A801FC3', 'teste@teste.com.br');