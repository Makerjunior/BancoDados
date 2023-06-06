-- Active: 1685670931144@@127.0.0.1@3306@databas
-- Criação de Banco de Dados
#Criando tabela funcionarios
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

 -- Criação da tabela salários
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
  
  -- Ordena de acordo com os 6 primeiro caracteres
  CREATE INDEX index_nomes ON funcionarios(nome(6));

-- Manipulação de dados
 #Inserindo funcionarios 
INSERT INTO funcionarios(nome,salario,departamento) VALUES('João',1400,'TI');
INSERT INTO funcionarios(nome,salario,departamento) VALUES('Carlos',2000,'Infra Estrutura');
INSERT INTO funcionarios(nome,salario,departamento) VALUES('José',1500,'Financeiro');
-- podemos indicar um id desde que ele não exista 
INSERT INTO funcionarios(id,nome,salario,departamento) VALUES(4,'Junior',1200,'TI');
INSERT INTO funcionarios(id,nome,salario,departamento) VALUES(5,'Gustavo',1300,'Infra estrutura');


-- SELECT com filtro
SELECT * FROM funcionarios WHERE departamento = 'TI';
SELECT * FROM funcionarios WHERE id=3;
SELECT * FROM funcionarios WHERE  salario > 8000;

-- Update de todas as colunas da tabela
SET SQL_SAFE_UPDATES=0;
UPDATE funcionarios SET salario=ROUND(salario * 1.1, 2); # 10% de aumenton aredonta 2 casas decimais
  
--  AULA 
DELETE FROM funcionarios WHERE  id=5;
SELECT * FROM  funcionarios;


-- Inserindo Veiculos
INSERT INTO veiculos (funcionario_id, veiculo, placa) VALUES (1, 'Carro', 'ABC1234');
INSERT INTO veiculos(funcionario_id, veiculo, placa) VALUES(1, 'Opala', 'DBA3465'); 
INSERT INTO veiculos(funcionario_id, veiculo, placa) VALUES(4, 'Monza', 'ODH2376'); 

SELECT * from veiculos;

INSERT  INTO  salarios(faixa, inicio, fim ) VALUES('Analista Jr', 1000 ,2000);
INSERT  INTO  salarios(faixa, inicio, fim ) VALUES('Analista Pleno', 2000 ,4000);

-- Selec em apenas uma coluna
SELECT nome AS 'Funcionario',
salario AS 'Salario' FROM  funcionarios WHERE salario >1500;

-- Unindo dois ou mais select
SELECT * FROM funcionarios f  WHERE nome ='junior'
UNION
SELECT * FROM funcionarios f WHERE nome ='Carlos';

--  Relacionamentos JOIN

SELECT * FROM  funcionarios;
SELECT  * FROM veiculos;

SELECT  * FROM funcionarios INNER JOIN veiculos ON funcionario_id =funcionarios.id;
SELECT  * FROM funcionarios f INNER JOIN veiculos v ON v.funcionario_id =f.id;




