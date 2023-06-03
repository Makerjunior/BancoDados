-- Active: 1685670931144@@127.0.0.1@3306@databas
-- Criação de Banco de Dados
CREATE Table funcionarios(
    id int UNSIGNED NOT NULL AUTO_INCREMENT,
    nome varchar(45) NOT NULL,
    salario DOUBLE NOT NULL DEFAULT '0',
    departamento VARCHAR(45) NOT NULL,
    PRIMARY KEY (id)
    
);

-- Criação de tabela com chave estrageira ou seja cada veiculo terá uma relação com um funcionário
  CREATE TABLE veiculos(
    id int UNSIGNED NOT NULL AUTO_INCREMENT,
    funcionario_id int UNSIGNED DEFAULT NULL,
    veiculo VARCHAR(45) NOT NULL DEFAULT '',
    placa VARCHAR(10) NOT NULL DEFAULT '',
    PRIMARY KEY(id),
    CONSTRAINT fk_veiculos_funcionarios FOREIGN KEY(funcionario_id) REFERENCES funcionarios(id)
  );

  CREATE TABLE salarios(
    faixa VARCHAR(45) NOT NULL,
    inicio DOUBLE  NOT NULL,
    fim DOUBLE  NOT NULL,
    PRIMARY KEY(faixa)
  );

-- Alterando o nome do campo na tabela funcionarios
  ALTER TABLE funcionarios CHANGE COLUMN nome nome_funcionario VARCHAR(50) NOT NULL;
  
  ALTER TABLE funcionarios CHANGE COLUMN nome_funcionario nome VARCHAR(50) NOT NULL;

  -- Deletando tabela
  DROP TABLE salarios;

  --Indices 
  -- Criando índices para ordenação, manipulação, agrupamento e organização
  CREATE INDEX idex_departamentos ON funcionarios(departamento);
  
  -- Oedena de acordocom os 6 primeiro caracteres
  CREATE INDEX index_nomes ON funcionarios(nome(6));

--Manipulação de dados
SELECT * FROM funcionarios;
INSERT INTO funcionarios(id,nome,salario,departamento) VALUES(1,"Junior",1200,"TI");
INSERT INTO funcionarios(id,nome,salario,departamento) VALUES(2,"Gustavo",1300,"Infra estrutura");
INSERT INTO funcionarios(nome,salario,departamento) VALUES("João",1400,"TI");
INSERT INTO funcionarios(nome,salario,departamento) VALUES("Carlos",2000,"Infra Estrutura");
INSERT INTO funcionarios(nome,salario,departamento) VALUES("José",1500,"Financeiro");

-- SELECT com filtro
SELECT * FROM funcionarios WHERE departamento = "TI";
SELECT * FROM funcionarios WHERE id=3;

--Update de todas as colunas da tabela
SET SQL_SAFE_UPDATES=0;
UPDATE funcionarios SET salario=salario *5;