# BancoDados
 Mysql-server

 Com esse Dockerfile, a imagem pode ser construída com o seguinte comando na linha de comando:
```
docker build -t my-mysql-image:banco .
```
E depois, um container pode ser iniciado a partir dessa imagem com o seguinte comando:
```
docker run --name my-mysql-container -p 3306:3306 -d my-mysql-image
```
Este comando inicia um novo container chamado my-mysql-container a partir da imagem my-mysql-image, mapeia a porta 3306 do container para a porta 3306 do host e executa o container em segundo plano (-d).


---



## Criação do banco de dados:

```sql
-- Criação de Banco de Dados
CREATE DATABASE meu_banco_de_dados;
```

A query acima cria um novo banco de dados chamado "meu_banco_de_dados".

---

### Criação da tabela "funcionarios":

```sql
-- Criando tabela funcionarios
CREATE TABLE funcionarios(
    id int UNSIGNED NOT NULL AUTO_INCREMENT,
    nome varchar(45) NOT NULL,
    salario DOUBLE NOT NULL DEFAULT '0',
    departamento VARCHAR(45) NOT NULL,
    PRIMARY KEY (id)
);
```

A query acima cria a tabela "funcionarios" no banco de dados. A tabela possui as colunas "id", "nome", "salario" e "departamento", onde "id" é uma chave primária com auto incremento.

---

### Criação da tabela "veiculos" com chave estrangeira:

```sql
-- Criação de tabela com chave estrangeira, cada veiculo terá uma relação com um funcionário
CREATE TABLE veiculos(
    id int UNSIGNED NOT NULL AUTO_INCREMENT,
    funcionario_id int UNSIGNED DEFAULT NULL,
    veiculo VARCHAR(45) NOT NULL DEFAULT '',
    placa VARCHAR(10) NOT NULL DEFAULT '',
    PRIMARY KEY(id),
    CONSTRAINT fk_veiculos_funcionarios FOREIGN KEY(funcionario_id) REFERENCES funcionarios(id)
);
```

A query acima cria a tabela "veiculos" com a coluna "funcionario_id" como uma chave estrangeira que referencia a coluna "id" da tabela "funcionarios". Isso estabelece uma relação entre as duas tabelas.

---

### Criação da tabela "salarios":

```sql
-- Criação da tabela salários
CREATE TABLE salarios(
    faixa VARCHAR(45) NOT NULL,
    inicio DOUBLE  NOT NULL,
    fim DOUBLE  NOT NULL,
    PRIMARY KEY(faixa)
);
```

A query acima cria a tabela "salarios" com as colunas "faixa", "inicio" e "fim". A coluna "faixa" é definida como chave primária.

---

### Alteração do nome do campo na tabela "funcionarios":

```sql
-- Alterando o nome do campo na tabela funcionarios
ALTER TABLE funcionarios CHANGE COLUMN nome nome_funcionario VARCHAR(50) NOT NULL;
ALTER TABLE funcionarios CHANGE COLUMN nome_funcionario nome VARCHAR(50) NOT NULL;
```

As queries acima alteram o nome da coluna "nome" para "nome_funcionario" na tabela "funcionarios" e, em seguida, alteram o nome de volta para "nome".

---

### Deletando tabela "salarios":

```sql
-- Deletando tabela salarios
DROP TABLE salarios;
```

A query acima exclui a tabela "salarios" do banco de dados.

---

### Criação de índices:

```sql
-- Criando índice idex_departamentos na coluna departamento da tabela funcionarios
CREATE INDEX idex_departamentos ON funcionarios(departamento);

-- Ordena de acordo com os 6 primeiros caracteres
CREATE INDEX index_nomes ON funcionarios(nome(6));
```

As duas queries acima criam índices na tabela "funcionarios" para melhorar a ordenação, manipulação, agrupamento e organização dos dados. O primeiro índice, "idex_departamentos", é criado na coluna "departamento". O segundo índice, "index_nomes", é criado na coluna "nome

" considerando apenas os primeiros 6 caracteres.

---

### Manipulação de dados:

```sql
-- Inserindo funcionarios
-- Podemos indicar um id desde que ele não exista
INSERT INTO funcionarios(id, nome, salario, departamento) VALUES(1, 'Junior', 1200, 'TI');
INSERT INTO funcionarios(id, nome, salario, departamento) VALUES(2, 'Gustavo', 1300, 'Infra estrutura');
-- Podemos omitir o id
INSERT INTO funcionarios(nome, salario, departamento) VALUES('João', 1400, 'TI');
INSERT INTO funcionarios(nome, salario, departamento) VALUES('Carlos', 2000, 'Infra Estrutura');
INSERT INTO funcionarios(nome, salario, departamento) VALUES('José', 1500, 'Financeiro');
```

As queries acima inserem registros na tabela "funcionarios". Os registros são inseridos fornecendo valores para as colunas "id", "nome", "salario" e "departamento". O primeiro exemplo mostra como inserir um registro com um ID específico, desde que ele não exista na tabela. Os próximos exemplos omitem o ID, permitindo que o banco de dados gere automaticamente o valor para a coluna "id".

---

### Inserindo vários registros de uma vez:

```sql
-- Inserindo vários registros
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
```

A query acima insere vários registros de uma só vez na tabela "funcionarios". Cada registro é especificado entre parênteses, separados por vírgula.

---

### SELECT na tabela "funcionarios":

```sql
SELECT * FROM funcionarios;
```

A query acima seleciona todos os registros da tabela "funcionarios" e retorna todas as colunas.

---

### SELECT com filtro na tabela "funcionarios":

```sql
SELECT * FROM funcionarios WHERE departamento = 'TI';
SELECT * FROM funcionarios WHERE id = 3;
SELECT * FROM funcionarios WHERE salario > 8000;
```

As queries acima selecionam registros da tabela "funcionarios" com base em determinados critérios de filtro. A primeira query retorna os registros onde o departamento é igual a 'TI'. A segunda query retorna o registro com o ID igual a 3. A terceira query retorna os registros onde o salário é maior que 8000.

---

### Update de todas as colunas da tabela "funcionarios":

```sql
SET SQL_SAFE_UPDATES = 0;
UPDATE funcionarios SET salario = ROUND(salario * 1.1, 2); -- 10% de aumento e arredonda para 2 casas decimais
```

A primeira query desativa a restrição de atualização segura. Em seguida, a segunda query atualiza o valor da coluna "salario" na tabela "funcionarios". Cada salário é aumentado em 10% multiplicando

 pelo fator 1.1 e arredondando para 2 casas decimais.

---

### DELETE da tabela "funcionarios":

```sql
DELETE FROM funcionarios WHERE id = 5;
```

A query acima exclui o registro da tabela "funcionarios" onde o ID é igual a 5.

---

### Inserindo veículos na tabela "veiculos":

```sql
INSERT INTO veiculos (funcionario_id, veiculo, placa)
VALUES
(1, 'Caravam', 'ABC1234'),
(1, 'Opala', 'DBA3465'),
(4, 'Monza', 'ODH2376'),
(null, 'GOL', 'SG4585');
```

A query acima insere registros na tabela "veiculos". Cada registro especifica o ID do funcionário, o veículo e a placa.

---

### SELECT na tabela "veiculos":

```sql
SELECT * FROM veiculos;
```

A query acima seleciona todos os registros da tabela "veiculos" e retorna todas as colunas.

---

### Inserindo faixas de salários na tabela "salarios":

```sql
INSERT INTO salarios (faixa, inicio, fim) VALUES ('Analista Jr', 1000, 2000);
INSERT INTO salarios (faixa, inicio, fim) VALUES ('Analista Pleno', 2000, 4000);
```

As queries acima inserem registros na tabela "salarios". Cada registro especifica a faixa salarial, o salário inicial e o salário final.

---

### SELECT em apenas uma coluna da tabela "funcionarios":

```sql
SELECT nome AS 'Funcionario', salario AS 'Salario' FROM funcionarios WHERE salario > 1500;
```

A query acima seleciona apenas as colunas "nome" e "salario" da tabela "funcionarios". A coluna "nome" é renomeada para 'Funcionario' e a coluna "salario" é renomeada para 'Salario'. A cláusula WHERE filtra os registros onde o salário é maior que 1500.

---

### Unindo dois ou mais SELECT:

```sql
SELECT * FROM funcionarios f WHERE nome = 'junior'
UNION
SELECT * FROM funcionarios f WHERE nome = 'Carlos';
```

A query acima une os resultados de dois SELECTs usando a cláusula UNION. O primeiro SELECT seleciona os registros onde o nome é 'junior' e o segundo SELECT seleciona os registros onde o nome é 'Carlos'.

---

### Relacionamentos INNER JOIN:

```sql
SELECT * FROM funcionarios INNER JOIN veiculos ON funcionario_id = funcionarios.id;
SELECT * FROM funcionarios f INNER JOIN veiculos v ON v.funcionario_id = f.id;
SELECT f.nome, v.veiculo, v.placa FROM funcionarios f INNER JOIN veiculos v ON v.funcionario_id = f.id;
SELECT f.nome AS 'Nome', v.veiculo AS 'Veiculo' FROM funcionarios f INNER JOIN veiculos v ON v.funcionario_id = f.id;
```

As queries acima fazem uso do INNER JOIN para combinar registros de duas tabelas: "funcionarios" e "veiculos". Os registros são combinados com base na coluna "funcionario_id" na tabela "veiculos" e "id" na tabela "funcionarios". O resultado inclui todas as colunas das duas tabelas.

---

### LEFT JOIN, RIGHT JOIN e FULL JOIN:

```sql
SELECT * FROM funcionarios f LEFT JOIN veiculos v ON v.funcionario

_id = f.id;
SELECT * FROM funcionarios f RIGHT JOIN veiculos v ON v.funcionario_id = f.id;
SELECT * FROM funcionarios f FULL JOIN veiculos v ON v.funcionario_id = f.id;
```

As queries acima fazem uso de diferentes tipos de JOINs. O LEFT JOIN retorna todos os registros da tabela à esquerda (funcionarios) e os registros correspondentes da tabela à direita (veiculos). O RIGHT JOIN retorna todos os registros da tabela à direita e os registros correspondentes da tabela à esquerda. O FULL JOIN retorna todos os registros de ambas as tabelas, combinando os registros quando houver correspondência.

---

### Criação da tabela "cpfs" com chave estrangeira em "funcionarios":

```sql
CREATE TABLE cpfs (
id int UNSIGNED NOT NULL,
cpf varchar(14) NOT NULL,
PRIMARY KEY (id),
CONSTRAINT fk_cpf FOREIGN KEY (id) REFERENCES funcionarios(id)
)
```

A query acima cria a tabela "cpfs" com duas colunas: "id" e "cpf". A coluna "id" é uma chave estrangeira que referencia a coluna "id" da tabela "funcionarios".

---

### Inserindo CPFs na tabela "cpfs":

```sql
INSERT INTO cpfs (id, cpf) 
VALUES
(1, '111.111.111-11'),
(2, '222.222.222-22'),
(3, '333.333.333-33'),
(4, '444.444.444-44');
```

A query acima insere registros na tabela "cpfs", especificando o ID do funcionário e o CPF correspondente.

---

### SELECT com JOIN entre "funcionarios" e "cpfs":

```sql
SELECT f.nome, f.departamento, c.cpf, f.salario FROM funcionarios f INNER JOIN cpfs c ON f.id=c.id;
SELECT * FROM funcionarios INNER JOIN cpfs USING(id);
```

As queries acima realizam um JOIN entre as tabelas "funcionarios" e "cpfs", combinando os registros com base na coluna "id". O resultado inclui as colunas "nome" e "departamento" da tabela "funcionarios", além da coluna "cpf" da tabela "cpfs".

---

### SELF JOIN na tabela "clientes":

```sql
CREATE TABLE clientes (
id int unsigned not null auto_increment,
nome varchar(45) not null,
quem_indicou int unsigned,
PRIMARY KEY (id),
CONSTRAINT fk_quem_indicou FOREIGN KEY (quem_indicou) REFERENCES clientes (id)
);

INSERT INTO clientes (id, nome, quem_indicou) VALUES
(1, 'André', NULL),
(2, 'Samuel', 1),
(3, 'Carlos', 2),
(4, 'Rafael', 1);

SELECT * FROM clientes;

SELECT a.nome AS "CLIENTE", b.nome AS "QUEM INDICOU" 
FROM clientes a JOIN clientes b ON a.quem_indicou = b.id;  -- SELF JOIN
```

A primeira query cria a tabela "clientes" com as colunas "id", "nome" e "quem_indicou". A coluna "quem_indicou" é uma chave estrangeira que referencia a coluna "id" da própria tabela.

A segunda query insere registros na tabela "clientes", incluindo um registro com valor nulo para "quem_indicou".

A terceira query seleciona todos os registros da tabela "clientes".

A última query realiza um SELF JOIN na tabela "clientes", combinando os registros com base na coluna "quem_indicou" e retornando os nomes do cliente e de quem o indicou.

---

### Relacionamento triplo entre "funcionarios", "veiculos" e "cpfs":

```sql
SELECT * FROM funcionarios 
INNER JOIN veiculos ON veiculos.funcionario_id = funcionarios.id 
INNER JOIN cpfs ON cpfs.id = funcionarios.id;

SELECT 
f.nome as "NOME", 
f.departamento as "DEPARTAMENTO",
c.cpf as "CPF",
v.veiculo as "VEICULO",
v.placa as "PL

ACA",
f.salario as "SALÁRIO" 
FROM funcionarios f
INNER JOIN veiculos v ON v.funcionario_id = f.id 
INNER JOIN cpfs c ON c.id = f.id;
```

As queries acima realizam um relacionamento triplo entre as tabelas "funcionarios", "veiculos" e "cpfs".

A primeira query combina os registros das três tabelas com base nas chaves estrangeiras, retornando todos os campos das tabelas.

A segunda query seleciona campos específicos das tabelas "funcionarios", "veiculos" e "cpfs" e exibe o resultado.

---

### Visões:

```sql
CREATE VIEW funcionarios_a AS SELECT * FROM funcionarios WHERE salario >= 1700;
SELECT * FROM funcionarios_a;

UPDATE funcionarios SET salario = 1500 WHERE id = 3;

DROP VIEW funcionarios_a;
CREATE VIEW funcionarios_a AS SELECT * FROM funcionarios WHERE salario >= 2000;

SELECT * FROM funcionarios;
```

As queries acima envolvem a criação, atualização, exclusão e seleção de uma visão chamada "funcionarios_a".

A primeira query cria uma visão chamada "funcionarios_a" que seleciona todos os registros da tabela "funcionarios" onde o salário é maior ou igual a 1700.

A segunda query seleciona todos os registros da visão "funcionarios_a".

A terceira query atualiza o salário do funcionário com ID 3 para 1500.

A quarta query exclui a visão "funcionarios_a".

A última query cria uma nova visão "funcionarios_a" que seleciona todos os registros da tabela "funcionarios" onde o salário é maior ou igual a 2000.

A última seleção exibe todos os registros da tabela "funcionarios".

---

### Funções de Agregação:

```sql
SELECT COUNT(*) FROM funcionarios; 
SELECT COUNT(*) FROM funcionarios WHERE salario > 2000; 
SELECT COUNT(*) FROM funcionarios WHERE salario AND departamento = 'TI'; 
SELECT * FROM funcionarios WHERE salario AND departamento = 'TI'; 
SELECT SUM(salario) AS 'Salario dos funcionarios' FROM funcionarios; 
SELECT AVG(salario) AS 'Media de salarios' FROM funcionarios; 
SELECT MAX(salario) FROM funcionarios; 
SELECT MIN(salario) FROM funcionarios; 
SELECT DISTINCT(departamento) FROM funcionarios;
SELECT * FROM funcionarios ORDER BY nome;
SELECT * FROM funcionarios ORDER BY salario;
SELECT * FROM funcionarios ORDER BY nome DESC;

SELECT * FROM funcionarios LIMIT 4;
SELECT * FROM funcionarios LIMIT 3, 5;

SELECT departamento, AVG(salario) FROM funcionarios GROUP BY departamento; 
SELECT departamento, AVG(salario) FROM funcionarios GROUP BY departamento HAVING AVG(salario) > 2000; 
SELECT departamento, COUNT(*) FROM funcionarios GROUP BY departamento; 
SELECT nome, departamento FROM funcionarios WHERE departamento IN ('TI','Infra estrutura');
```

As queries acima utilizam funções de agregação para obter informações estatísticas sobre os dados na tabela "funcionarios".

- A primeira query retorna o número total de registros na tabela "funcionarios".
- A segunda query retorna o número de registros na tabela "funcionarios" onde o salário é maior que 2000.
- A terceira query retorna o número de registros na tabela "funcionarios" onde o salário é diferente de zero e o departamento é 'TI'.
- A quarta query retorna todos os

 registros da tabela "funcionarios" onde o salário é diferente de zero e o departamento é 'TI'.
- A quinta query retorna a soma de todos os salários dos funcionários.
- A sexta query retorna a média dos salários dos funcionários.
- A sétima query retorna o valor máximo do salário na tabela "funcionarios".
- A oitava query retorna o valor mínimo do salário na tabela "funcionarios".
- A nona query retorna os departamentos distintos na tabela "funcionarios".
- As três queries seguintes realizam ordenações na tabela "funcionarios" por nome, salário e nome em ordem decrescente, respectivamente.
- As duas queries seguintes utilizam a cláusula LIMIT para retornar um número específico de registros da tabela "funcionarios".
- As duas queries seguintes utilizam a cláusula GROUP BY para agrupar os registros da tabela "funcionarios" por departamento e calcular a média dos salários para cada grupo. A segunda query adiciona a cláusula HAVING para filtrar os grupos com média de salários maior que 2000.
- A última query retorna os nomes e departamentos dos funcionários onde o departamento é 'TI' ou 'Infra estrutura'.

---


## Gerenciamento de Acessos - Tipos de Acessos
Nesta seção, estamos criando três usuários com diferentes configurações de acesso:

O usuário 'usuario1' é criado com acesso permitido somente a partir do endereço IP '200.204.196.180'.
O usuário 'usuario2' é criado com acesso permitido apenas a partir do host local ('localhost').
O usuário 'usuario3' é criado com acesso permitido a partir de qualquer host ('%').

```sql
CREATE USER 'usuario1'@'200.204.196.180' IDENTIFIED WITH mysql_native_password BY '<12345>';
CREATE USER 'usuario2'@'localhost' IDENTIFIED WITH mysql_native_password BY '<123456>';
CREATE USER 'usuario3'@'%' IDENTIFIED WITH mysql_native_password BY '<123457>';
```

## Adicionando Acessos
Nesta seção, estamos adicionando diferentes tipos de acesso para os usuários criados anteriormente:

O usuário 'mentemaker1' recebe todos os privilégios no banco de dados 'banco_mentemaker1'.
O usuário 'mentemaker2' recebe apenas o privilégio de SELECT no banco de dados 'banco_mentemaker2'.
O usuário 'mentemaker3' recebe o privilégio de SELECT apenas na tabela 'funcionarios' do banco de dados 'banco_mentemaker3'.

```sql
CREATE USER 'mentemaker1'@'localhost' IDENTIFIED WITH mysql_native_password BY '<123456>';
GRANT ALL ON banco_mentemaker1.* TO 'mentemaker1'@'localhost';

CREATE USER 'mentemaker2'@'%' IDENTIFIED WITH mysql_native_password BY '<123457>';
GRANT SELECT ON banco_mentemaker2.* TO 'mentemaker2'@'%';

CREATE USER 'mentemaker3'@'%' IDENTIFIED WITH mysql_native_password BY '<1234578>';
GRANT SELECT ON banco_mentemaker3.funcionarios TO 'mentemaker3'@'%';
```

## Removendo Acessos
Nesta seção, estamos revogando e removendo acessos para o usuário 'mentemaker1':

Revogamos o privilégio SELECT no banco de dados 'banco_mentemaker1'.
Revogamos todos os privilégios no banco de dados 'banco_mentemaker1'.
Removemos o usuário 'mentemaker1' do host 'localhost'.

```sql
REVOKE SELECT ON banco_mentemaker1.* FROM 'mentemaker1'@'localhost';
REVOKE ALL ON banco_mentemaker1.* FROM 'mentemaker1'@'localhost';
DROP USER IF EXISTS 'mentemaker1'@'localhost';
```

## Consulta de Usuários
Nesta seção, estamos realizando consultas relacionadas aos usuários:

Consultamos todos os usuários presentes no servidor MySQL.
Exibimos as permissões concedidas ao usuário 'mentemaker3' para todos os hosts.

```sql
SELECT user FROM mysql.user;
SHOW GRANTS FOR 'mentemaker3'@'%';
```

## Transações - Informações do Banco de Dados
Nesta seção, estamos exibindo informações sobre os motores de armazenamento disponíveis no banco de dados e criando a tabela 'contas' usando o mecanismo de armazenamento InnoDB.

```sql
SHOW ENGINES;

CREATE TABLE contas (
  id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
  titular VARCHAR(50),
  saldo DOUBLE NOT NULL
) ENGINE = InnoDB

;
```

## Adicionando Contas
Nesta seção, estamos inserindo registros na tabela 'contas', representando contas com seus respectivos titulares e saldos.

```sql
INSERT INTO contas (titular, saldo) VALUES ('Jose', 1000);
INSERT INTO contas (titular, saldo) VALUES ('Pedro', 2000);
```

## Transações - Atualização de Saldo
Nesta seção, estamos realizando operações de atualização de saldo dentro de transações:

Iniciamos uma transação.
Atualizamos o saldo de duas contas.
Confirmamos a transação (commit).
Iniciamos outra transação.
Atualizamos novamente o saldo das mesmas contas.
Cancelamos a transação (rollback).

```sql
START TRANSACTION;
UPDATE contas SET saldo = saldo - 100 WHERE id = 1;
UPDATE contas SET saldo = saldo + 100 WHERE id = 2;
COMMIT;

START TRANSACTION;
UPDATE contas SET saldo = saldo - 100 WHERE id = 1;
UPDATE contas SET saldo = saldo + 100 WHERE id = 2;
ROLLBACK;
```

## Stored Procedures
Nesta seção, estamos criando a tabela 'pedidos' para armazenar informações sobre pedidos, inserindo registros nessa tabela e criando uma Stored Procedure chamada 'sp_apaga_pedidos' para apagar os pedidos não pagos. Em seguida, chamamos essa Stored Procedure para executar a remoção dos pedidos não pagos.

```sql
CREATE TABLE pedidos (
  id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
  descricao VARCHAR(100) NOT NULL,
  valor DOUBLE NOT NULL DEFAULT '0',
  pago VARCHAR(3) NOT NULL DEFAULT 'NAO'
);

INSERT INTO pedidos (descricao, valor) VALUES ('computador', 49876);
INSERT INTO pedidos (descricao, valor) VALUES ('celular', 23.50);
INSERT INTO pedidos (descricao, valor) VALUES ('tv', 1000);

CREATE PROCEDURE sp_apaga_pedidos()
BEGIN
  SET SQL_SAFE_UPDATES = 0;
  DELETE FROM pedidos WHERE pago = 'NAO';
END;

CALL sp_apaga_pedidos();
```

## Triggers
Nesta seção, estamos criando a tabela 'estoque' para armazenar informações sobre itens do estoque. Criamos um trigger chamado 'limpa_pedidos', que é acionado antes de inserir elementos na tabela 'estoque'. Esse trigger chama a Stored Procedure 'sp_apaga_pedidos' para apagar os pedidos não pagos. Por fim, inserimos alguns registros na tabela 'estoque'.

```sql
CREATE TABLE estoque (
  id INT NOT NULL AUTO_INCREMENT,
  nome VARCHAR(10),
  quantidade INT UNSIGNED ZEROFILL,
  PRIMARY KEY (id)
);

CREATE TRIGGER limpa_pedidos
BEFORE INSERT ON estoque
FOR EACH ROW
CALL sp_apaga_pedidos();

INSERT INTO estoque (nome, quantidade) VALUES ('Notebook', 10);
INSERT INTO estoque (nome, quantidade) VALUES ('Mouse', 10);
```

## Consulta de Contas
Nesta seção, estamos consultando os registros da tabela 'contas', exibindo todas as informações relacionadas às contas presentes no banco de dados.

```sql
SELECT * FROM contas;
```
