Este script SQL cria três tabelas: `funcionarios`, `veiculos` e `salarios`.

A tabela `funcionarios` tem os seguintes campos:

- `id` - inteiro sem sinal que identifica de forma única cada registro na tabela
- `nome` - string de até 45 caracteres que contém o nome do funcionário
- `salario` - número em ponto flutuante que armazena o salário do funcionário, com o valor padrão definido como 0
- `departamento` - string de até 45 caracteres que contém o departamento em que o funcionário trabalha

A tabela `veiculos` tem os seguintes campos:

- `id` - inteiro sem sinal que identifica de forma única cada registro na tabela
- `funcionario_id` - inteiro sem sinal que é uma chave estrangeira referenciando o `id` do funcionário associado a este veículo. Pode ser nulo, indicando que o veículo não está atualmente associado a nenhum funcionário.
- `veiculo` - string de até 45 caracteres que contém o tipo de veículo (por exemplo, "carro" ou "moto")
- `placa` - string de até 10 caracteres que contém a placa do veículo

A tabela `salarios` tem os seguintes campos:

- `faixa` - string de até 45 caracteres que identifica a faixa salarial, por exemplo, "até R$ 1000,00" ou "de R$ 2000,00 a R$ 3000,00"
- `inicio` - número em ponto flutuante que indica o valor inicial da faixa salarial 
- `fim` - número em ponto flutuante que indica o valor final da faixa salarial

O script também faz as seguintes alterações:

- Renomeia a coluna `nome` na tabela `funcionarios` para `nome_funcionario`, depois renomeia novamente para apenas `nome`.
- Exclui a tabela `salarios`.
- Cria dois índices na tabela `funcionarios` para melhorar a performance de consultas: um índice em `departamento` e outro índice nos primeiros seis caracteres de `nome`.

Exemplo de inserção de um registro na tabela `funcionarios`:
```sql
INSERT INTO funcionarios (nome, salario, departamento) 
VALUES ('João Silva', 2500.00, 'Vendas');
```

Exemplo de inserção de um registro na tabela `veiculos`, associando-o a um funcionário:
```sql
INSERT INTO veiculos (funcionario_id, veiculo, placa) 
VALUES (1, 'Carro', 'ABC1234');
```

Exemplo de consulta para encontrar todos os funcionários do departamento de vendas:
```sql
SELECT * FROM funcionarios WHERE departamento = 'Vendas';
```

Exemplo de consulta para encontrar todos os veículos associados a um determinado funcionário:
```sql
SELECT * FROM veiculos WHERE funcionario_id = 1;
```
02/06/2023 11:56:11


Refaça e explique tbm como fuinciona as chaves primaria e estrangeira site exemplos



-- Active: 1685717414463@@127.0.0.1@3306@database
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
02/06/2023 11:57:35


Este script SQL cria três tabelas: funcionarios, veiculos e salarios.

A tabela funcionarios tem uma chave primária na coluna id. Uma chave primária é um campo ou conjunto de campos que identifica de forma única cada registro em uma tabela. No caso do script, a chave primária é definida com a cláusula PRIMARY KEY, que indica que a coluna id é a chave primária da tabela. A opção AUTO_INCREMENT é usada para gerar automaticamente valores únicos para a coluna id. O tipo de dados UNSIGNED é usado para garantir que o valor da coluna id seja sempre positivo.

A tabela veiculos tem uma chave primária na coluna id, assim como a tabela funcionarios. Além disso, a tabela veiculos tem uma chave estrangeira na coluna funcionario_id. Uma chave estrangeira é um campo ou conjunto de campos em uma tabela que se refere à chave primária em outra tabela. No caso do script, a cláusula CONSTRAINT é usada para definir a chave estrangeira, que é chamada de fk_veiculos_funcionarios. Isso significa que a coluna funcionario_id em veiculos referencia a coluna id em funcionarios.

Isso significa que se um registro é excluído da tabela de funcionarios, todos os registros associados a ele em veiculos também serão excluídos (a menos que isso seja impedido por outras restrições). Por exemplo, se o registro com id = 1 em funcionarios for excluído, todos os registros em veiculos com funcionario_id = 1 também serão excluídos.

O script também cria índices em funcionarios para melhorar a eficiência das consultas. A cláusula CREATE INDEX é usada para criar esses índices. O primeiro índice é criado na coluna departamento, que pode ser útil para consultas que precisam agrupar ou ordenar funcionários por departamento. O segundo índice é criado nos primeiros seis caracteres da coluna nome, o que pode ser útil para consultas que precisam localizar rapidamente funcionários com nomes semelhantes.