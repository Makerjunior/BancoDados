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

  --  Indices 
  -- Criando índices para ordenação, manipulação, agrupamento e organização
  CREATE INDEX idex_departamentos ON funcionarios(departamento);
  
  -- Ordena de acordo com os 6 primeiro caracteres
  CREATE INDEX index_nomes ON funcionarios(nome(6));

-- Manipulação de dados
 #Inserindo funcionarios 
-- podemos indicar um id desde que ele não exista 
INSERT INTO funcionarios(id,nome,salario,departamento) VALUES(1,'Junior',1200,'TI');
INSERT INTO funcionarios(id,nome,salario,departamento) VALUES(2,'Gustavo',1300,'Infra estrutura'); 
-- Podemos omitir o id
INSERT INTO funcionarios(nome,salario,departamento) VALUES('João',1400,'TI');
INSERT INTO funcionarios(nome,salario,departamento) VALUES('Carlos',2000,'Infra Estrutura');
INSERT INTO funcionarios(nome,salario,departamento) VALUES('José',1500,'Financeiro');

-- Inserindo varios registros
INSERT INTO funcionarios(nome, salario, departamento) 
VALUES
('Naruto', 2500, 'Marketing'),
('Goku', 3000, 'TI'),
('Luffy', 2800, 'Operações'),
('Sakura', 2200, 'Recursos Humanos'),
('Vegeta', 3200, 'Financeiro'),
('Ichigo', 2700, 'Atendimento ao Cliente'),
('Erza', 2900, 'Vendas'),
('Kaneki', 2600, 'Desenvolvimento de Software'),
('Saitama', 3500, 'Gerência'),
('Levi', 2400, 'Compras');

SELECT * FROM funcionarios;

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
INSERT INTO veiculos (funcionario_id, veiculo, placa)
VALUES 
(1, 'Caravam', 'ABC1234'),
(1, 'Opala', 'DBA3465'),
(4, 'Monza', 'ODH2376'), 
(null,'GOL','SG4585');

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

--  Relacionamentos INNER JOIN
SELECT * FROM  funcionarios;
SELECT  * FROM veiculos;

SELECT  * FROM funcionarios INNER JOIN veiculos ON funcionario_id =funcionarios.id;
SELECT  * FROM funcionarios f INNER JOIN veiculos v ON v.funcionario_id =f.id;
SELECT  f.nome, v.veiculo, v.placa FROM funcionarios f INNER JOIN veiculos v ON v.funcionario_id=f.id;
SELECT f.nome AS 'Nome', v.veiculo AS 'Veiculo' FROM funcionarios f INNER JOIN veiculos v ON v.funcionario_id=f.id;

-- LEFT JOIN
SELECT  * FROM funcionarios f LEFT JOIN veiculos v ON v.funcionario_id =f.id;
-- RIGHT JOIN
SELECT  * FROM funcionarios f RIGHT JOIN veiculos v ON v.funcionario_id =f.id;
-- FULL JOIN
SELECT  * FROM funcionarios f LEFT JOIN veiculos v ON v.funcionario_id =f.id
UNION 
SELECT  * FROM funcionarios f RIGHT JOIN veiculos v ON v.funcionario_id =f.id;

-- Criação de tabela com chave estrageira em funcionarios
CREATE TABLE cpfs (
id int UNSIGNED NOT NULL,
cpf varchar(14) NOT NULL,
PRIMARY KEY (id),
   CONSTRAINT fk_cpf FOREIGN KEY (id) REFERENCES funcionarios(id)
)

INSERT INTO cpfs(id,cpf) 
VALUES
( 1 , '111.111.111-11 '),
( 2 , '222.222.222-22 '),
( 3 , '333.333.333-33 '),
( 4 , '444.444.444-44 ');

SELECT f.nome, f.departamento, c.cpf, f.salario FROM funcionarios f INNER JOIN cpfs c ON f.id=c.id;
SELECT * FROM funcionarios  INNER JOIN cpfs USING(id);

-- SELF Join
CREATE TABLE clientes
(
	id int unsigned not null auto_increment,
    nome varchar(45) not null,
    quem_indicou int unsigned,
    PRIMARY KEY (id),
    CONSTRAINT fk_quem_indicou FOREIGN KEY (quem_indicou) REFERENCES clientes (id)
);


INSERT INTO clientes (id, nome, quem_indicou) VALUES 
(1, 'André', NULL),
(2, 'Samuel', 1),
(3, 'Carlos', 2)
(4, 'Rafael', 1);

SELECT * FROM clientes;

SELECT a.nome AS "CLIENTE", b.nome AS "QUEM INDICOU" 
FROM clientes a join clientes b ON a.quem_indicou = b.id;  # SELF JOIN

-- Relacionamento triplo
SELECT * FROM funcionarios 
INNER JOIN veiculos ON veiculos.funcionario_id = funcionarios.id 
INNER JOIN cpfs ON cpfs.id = funcionarios.id;

SELECT 
f.nome         as "NOME", 
f.departamento as "DEPARTAMENTO",
c.cpf          as "CPF",
v.veiculo      as "VEICULO",
v.placa        as "PLACA",
f.salario      as "SALÁRIO" 
FROM funcionarios f
INNER JOIN veiculos v ON v.funcionario_id = f.id 
INNER JOIN cpfs c ON c.id = f.id;

-- Visões
CREATE VIEW funcionarios_a AS SELECT * FROM funcionarios WHERE salario >= 1700;
SELECT * FROM funcionarios_a;

UPDATE funcionarios SET salario = 1500 WHERE id = 3;

DROP VIEW funcionarios_a;
CREATE VIEW funcionarios_a AS SELECT * FROM funcionarios WHERE salario >= 2000;



SELECT  * FROM funcionarios f ;

##  6.2

SELECT COUNT(*) FROM funcionarios; 
SELECT COUNT(*) FROM funcionarios WHERE salario >2000; 
SELECT COUNT(*) FROM funcionarios WHERE  salario AND  departamento = 'TI'; 
SELECT * FROM funcionarios WHERE  salario AND  departamento = 'TI'; 
SELECT  SUM(salario) AS 'Salario dos funcionarios' FROM funcionarios; 
SELECT  AVG(salario) AS 'Media de salarios' FROM funcionarios; 
SELECT Max(salario) FROM funcionarios; 
SELECT MIN(salario) FROM funcionarios; 
SELECT DISTINCT(departamento) FROM funcionarios;
SELECT * FROM funcionarios ORDER BY nome;
SELECT * FROM funcionarios ORDER BY salario;
SELECT * FROM funcionarios ORDER BY nome DESC ;


SELECT * FROM funcionarios LIMIT 4;

SELECT * FROM funcionarios LIMIT 3,5;

SELECT departamento, AVG(salario) FROM funcionarios GROUP BY departamento; 
SELECT departamento, AVG(salario) FROM funcionarios GROUP BY departamento HAVING AVG(salario) > 2000 ; 
SELECT  departamento, COUNT(*) FROM funcionarios GROUP BY departamento ; 
SELECT nome, departamento  FROM funcionarios WHERE departamento IN ('TI','Infra estrutura')

## Até aki está documentado em Documentação Banco/Documentacaobkp1 ...


# Gerenciamento de acesos tipos de acesos
CREATE USER 'usuario1'@'200.204.196.180' IDENTIFIED WITH mysql_native_password BY '<12345>';
CREATE USER 'usuario2'@localhost IDENTIFIED WITH mysql_native_password BY '<123456>';
CREATE USER 'usuario3'@'%' IDENTIFIED WITH mysql_native_password BY '<123457>';

## Adicioando acesos
CREATE USER 'mentemaker1'@localhost IDENTIFIED WITH mysql_native_password BY '<123456>';
GRANT ALL ON banco_mentemaker1.* TO'mentemaker1'@localhost;

CREATE USER 'mentemaker2'@'%' IDENTIFIED WITH mysql_native_password BY '<123457>';
GRANT SELECT ON banco_mentemaker2.* TO'mentemaker2'@'%';

CREATE USER 'mentemaker3'@'%' IDENTIFIED WITH mysql_native_password BY '<1234578>';
GRANT SELECT ON banco_mentemaker3.funcionarios TO'mentemaker3'@'%';

## Removendo acesso
REVOKE SELECT ON banco_mentemaker1.* FROM 'mentemaker1'@'localhost';
REVOKE ALL ON banco_mentemaker1.* FROM 'mentemaker1'@'localhost';
DROP USER IF EXISTS 'mentemaker1'@'localhost';

## Consulta de usuarios
SELECT user FROM mysql.user;
SHOW GRANTS FOR 'mentemaker3'@'%';


### Transaçoes
SHOW ENGINES;

CREATE TABLE contas(
  id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
  titular VARCHAR (50),
  saldo DOUBLE not null,
  PRIMARY KEY (id)
)engine = InnoDB;

## adicionado contas
INSERT INTO contas VALUES('Jose', '1000');
INSERT INTO contas VALUES('Pedro', '2000');

start transaction;
UPDATE contas SET saldo = saldo - 100 WHERE id=1;
UPDATE contas SET saldo = saldo + 100 WHERE id=2;
commit;

start transaction;
UPDATE contas SET saldo = saldo - 100 WHERE id=1;
UPDATE contas SET saldo = saldo + 100 WHERE id=2;
rollback;



### Stored Procedures

CREATE TABLE pedidos(
  id int primary key autoincrement not null,
  descicao varchar(100) not null,
  valor double not null DEFAULT '0',
  pago varchar(3) not null DEFAULT 'NAO',
  PRIMARY KEY (codigo)
);
## Inserindo pedidos
insert into pedido values ('computador','49876');
insert into pedido values ('celular','23.50');
insert into pedido values ('tv','1000');
 
 ## Criando Stored Procedures para apagar pedidos que nao foram pagos
 # Devemos buscar pela janela de criacao de Procedures
 CREATE PROCEDURE sp_apaga_pedidos()
 BEGIN
 SET_SQL_SAFE_UPDATES=0;
 DELETE from pedidos where pago='NAO';
 END;
 ##################################################
 
 # Voltando a janela principal
 CALL sp_apaga_pedidos();


## Triggers
# Tabela exemplo
create table estoque(
  id int NOT NULL AUTO_INCREMENT,
  nome VARCHAR(10),
  quantidade INT UNSIGNED ZEROFILL,
  PRIMARY KEY (id)
);

# Adicionamos um trigger na tabela pedidos, sempre for adicionado elementos no estoque
# os dados da tabela pedidos que nao foram pagos serao apagados
CREATE trigger limpa_pedidos
BEFORE INSERT
ON estoque
FOR EACH ROW
CALL  sp_apaga_pedidos(); 

## Inserindo na tabela estoque
INSERT INTO estoque VALUES('Notebook', '10'),('Mouse', '10');









SELECT * FROM contas;

