###Tabelas e Chave estrangeira :
`funcionarios`, `veiculos` e `salarios`.

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

## Chave estrangeira
Nas tabelas : `funcionarios`, `veiculos` e `salarios`. A tabela `funcionarios` tem uma chave primária na coluna `id`, que é usada como chave estrangeira na tabela `veiculos`.

Aqui está um exemplo de como as chaves primárias e estrangeiras funcionam nas tabelas desse script:

```
-- Tabela funcionarios
CREATE TABLE funcionarios(
    id int UNSIGNED NOT NULL AUTO_INCREMENT,
    nome varchar(45) NOT NULL,
    salario DOUBLE NOT NULL DEFAULT '0',
    departamento VARCHAR(45) NOT NULL,
    PRIMARY KEY (id)
);

-- Tabela veiculos
CREATE TABLE veiculos(
    id int UNSIGNED NOT NULL AUTO_INCREMENT,
    funcionario_id int UNSIGNED DEFAULT NULL,
    veiculo VARCHAR(45) NOT NULL DEFAULT '',
    placa VARCHAR(10) NOT NULL DEFAULT '',
    PRIMARY KEY(id),
    CONSTRAINT fk_veiculos_funcionarios FOREIGN KEY(funcionario_id) REFERENCES funcionarios(id)
);

-- Exemplo de inserção de dados
INSERT INTO funcionarios (nome, salario, departamento) VALUES ('João', 2500.00, 'RH');
INSERT INTO veiculos (funcionario_id, veiculo, placa) VALUES (1, 'Carro', 'AAA-1234');

-- Exemplo de consulta com junção entre as tabelas
SELECT f.nome, v.veiculo, v.placa 
FROM funcionarios f 
JOIN veiculos v ON f.id = v.funcionario_id 
WHERE f.departamento = 'RH';
```

Nesse exemplo, a tabela `funcionarios` tem uma chave primária na coluna `id`. Essa chave primária é usada como chave estrangeira na tabela `veiculos`, na coluna `funcionario_id`. Isso significa que cada registro em `veiculos` está associado a um registro em `funcionarios`. Se um registro em `funcionarios` é excluído, todos os registros na tabela de `veiculos` que se referem a esse registro são atualizados ou excluídos automaticamente, dependendo das configurações de restrição da chave estrangeira.

O exemplo de inserção de dados mostra como podemos inserir dados nas tabelas relacionadas. Primeiro, inserimos um registro na tabela de `funcionarios` com `id = 1`, e depois inserimos um registro na tabela de `veiculos` com `funcionario_id = 1`. Isso estabelece uma relação entre esses dois registros.

O exemplo de consulta mostra como podemos combinar as duas tabelas usando uma junção (`JOIN`) na cláusula `FROM`. Combinamos os registros em ambas as tabelas onde o `id` em `funcionarios` corresponde ao `funcionario_id` em `veiculos`. A consulta retorna os nomes dos funcionários, juntamente com informações sobre seus veículos, para aqueles que trabalham no departamento de RH.