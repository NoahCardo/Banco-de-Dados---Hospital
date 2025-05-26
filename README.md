# 🏥 Criando um Banco de Dados para um Hospital

Um pequeno hospital local busca desenvolver um novo sistema para gerenciar suas operações, transferindo dados antigos armazenados em planilhas para um banco de dados estruturado. O objetivo é criar um **Diagrama Entidade-Relacionamento (DER)** adequado e expandir funcionalidades conforme necessário.

## ⚕️🌈🚑 PARTE 1 - O Hospital Fundamental: Modelagem Inicial

## 📌 Entidades Principais
- 🩹 `Pacientes`: Dados Pessoais, Documentos e Convênio Médico;
- 🥼 `Médicos`: Generalistas, Especialistas ou Residentes, podendo ter Múltiplas Especialidades (Como Clínicos Gerais, Dermatologistas, Gastroenterologistas e Pediatras);
- 🔎 `Consultas`: Registros de Atendimentos com Data, Médico Responsável, Paciente e Convênio.

---

![Diagrama DER - Banco de Dados Hospital](./bdd_hospital_parte1.drawio.png)

---

## ⚕️🌈🚑 PARTE 2 - Os Segredos do Hospital: Expandindo o Banco de Dados

## 📌 Novos Requisitos
A segunda versão do sistema introduziu funcionalidades essenciais para o **Controle de Internações**, incluindo:
- 🗓️ `Internação`: Registro de Data de Entrada, Data de Previsão de Alta, Data de Alta e Procedimento;
- 🧑🏽‍⚕️ `Enfermeiro`: Controle dos Enfermeiros responsáveis pela internação, incluindo Nome, CPF e Registro no Conselho de Enfermagem (COREN ou CRE);
- 🛏️ `Quarto`: Vinculação da Internação a um Quarto específico, com Número e Tipo do Quarto (Com Descrição e Valor da Diária).

## 📌 Modificações no Modelo
- **Novas Entidades**: `Internação`, `Enfermeiro` e `Quarto`.

---

![Diagrama DER - Banco de Dados Hospital - Parte 2](./bdd_hospital_parte2.drawio.png)

---

![Script SQL - Banco de Dados Hospital](./Banco_de_Dados_Hospital_Script.png)

---

## 🐬 Arquivo .sql Referente à Parte 2: [Banco de Dados em MySQL - Parte 2](./Banco_de_Dados_Hospital_Script_Parte2.sql)

---

## 📋 Entidades (Em Tabelas)

### `Médicos`
Armazena os dados dos médicos.

| Campo       | Tipo          | Descrição                                      |
|------------|--------------|------------------------------------------------|
| id_medicos | integer [PK]  | Identificador único do médico                 |
| nome       | varchar(255)  | Nome completo do médico                       |
| cpf        | varchar(14)   | Cadastro de Pessoa Física (CPF) - único       |
| crm        | varchar(20)   | Registro do Conselho Regional de Medicina (CRM) |
| especialidade | varchar(255) | Especialidade médica |

### `Consultas`
Registra as consultas médicas realizadas.

| Campo               | Tipo           | Descrição                                    |
|---------------------|---------------|----------------------------------------------|
| id_consultas       | integer [PK]   | Identificador único da consulta             |
| data_e_hora_cnslt  | datetime       | Data e hora da consulta                     |
| medico_resp        | varchar(255)   | Nome do médico responsável pela consulta    |
| valor              | decimal        | Valor da consulta                           |
| num_da_carteira    | varchar(15)    | Número da carteirinha do plano de saúde     |
| especialidade_desejada | varchar(255) | Especialidade médica solicitada             |

### `Pacientes`
Registra os pacientes atendidos pelo hospital.

| Campo       | Tipo         | Descrição                                |
|------------|------------|------------------------------------------|
| id_pacientes | integer [PK] | Identificador único do paciente         |
| nome        | varchar(255) | Nome completo                           |
| cpf         | varchar(14)  | Cadastro de Pessoa Física (CPF) - único  |
| rg          | varchar(12)  | Registro Geral (RG)                     |
| data_nasc   | date        | Data de nascimento                      |
| endereco    | varchar(255)| Endereço do paciente                    |
| telefone    | varchar(15) | Telefone para contato                   |
| email_pac   | varchar(255) | E-mail do paciente                      |

### `Convênio`
Armazena os dados dos convênios aceitos pelo hospital.

| Campo          | Tipo          | Descrição                              |
|---------------|--------------|----------------------------------------|
| id_convenio   | integer [PK]  | Identificador único do convênio        |
| nome_conv     | varchar(255)  | Nome do convênio                       |
| cnpj_conv     | varchar(18)   | Cadastro Nacional da Pessoa Jurídica (CNPJ) |
| tempo_de_carencia | date      | Tempo de carência contratual           |

### `Especialistas`
Gerencia os diferentes especialistas médicos disponíveis.

| Campo             | Tipo           | Descrição                         |
|------------------|---------------|-----------------------------------|
| id_especialidade | integer [PK]   | Identificador único da especialidade |
| generalistas     | varchar(255)   | Médicos generalistas             |
| pediatria        | varchar(255)   | Especialistas em pediatria       |
| clinica_geral    | varchar(255)   | Especialistas em clínica geral   |
| gastroenterologia| varchar(255)   | Especialistas em gastroenterologia |
| dermatologia     | varchar(255)   | Especialistas em dermatologia    |
| residentes       | varchar(255)   | Médicos residentes               |

### `Receitas_do_Médico`
Armazena as receitas médicas emitidas pelos médicos.

| Campo              | Tipo          | Descrição                          |
|-------------------|--------------|-----------------------------------|
| id_receitas       | integer [PK]  | Identificador único da receita    |
| med_rctds         | text         | Medicamentos receitados           |
| quant_med         | int          | Quantidade prescrita              |
| instruções_uso    | text         | Orientações sobre uso dos medicamentos |
| relatorio_impresso | text        | Relatório impresso disponível     |
| relatorio_virtual | text         | Relatório digital disponível      |

## ↓ 👤 Novas Entidades! ↓

### `Internação`
Gerencia as internações hospitalares.

| Campo         | Tipo          | Descrição                          |
|--------------|--------------|-----------------------------------|
| id_internacao | integer [PK]  | Identificador único da internação |
| id_medicos    | integer [FK]  | Médico responsável pela internação |
| id_pacientes  | integer [FK]  | Paciente internado                |
| id_enfermeiro | integer [FK]  | Enfermeiro responsável            |
| data_entrada  | datetime     | Data de entrada do paciente       |
| previsao_alta | date         | Data estimada de alta             |
| data_alta     | date         | Data real da alta                 |
| procedimento  | text         | Procedimento realizado            |

### `Enfermeiro`
Lista os enfermeiros envolvidos nas internações.

| Campo         | Tipo          | Descrição                          |
|--------------|--------------|-----------------------------------|
| id_enfermeiro| integer [PK]  | Identificador único do enfermeiro |
| nome         | varchar(255)  | Nome completo                     |
| cpf          | varchar(14)   | Cadastro de Pessoa Física (CPF) - único |
| coren        | varchar(15)   | Registro no Conselho Regional de Enfermagem (COREN) |

### `Quarto`
Registra os quartos disponíveis no hospital.

| Campo         | Tipo          | Descrição                          |
|--------------|--------------|-----------------------------------|
| id_quarto    | integer [PK]  | Identificador único do quarto     |
| numero       | int          | Número do quarto                  |
| tipo_de_quarto | varchar(255)| Categoria do quarto (apartamento, enfermaria) |
| descricao    | text         | Detalhes sobre o quarto           |
| valor_diar   | decimal      | Valor diário cobrado              |

---

## ⚕️🌈🚑 PARTE 3 - O Prisioneiro dos Dados: Alimentando o Banco de Dados

## 📌 Novos Requisitos
Nesta etapa, o sistema hospitalar recebe os primeiros dados inseridos, garantindo que todas as tabelas estejam corretamente preenchidas para a operação do hospital.

## Alguns deles seriam...:

- Inclua ao menos dez médicos de diferentes especialidades.
- Ao menos sete especialidades (considere a afirmação de que “entre as especialidades há pediatria, clínica geral, gastrenterologia e dermatologia”).
- Inclua ao menos 15 pacientes.
- Registre 20 consultas de diferentes pacientes e diferentes médicos (alguns pacientes realizam mais que uma consulta). As consultas devem ter ocorrido entre 01/01/2015 e 01/01/2022. Ao menos dez consultas devem ter receituário com dois ou mais medicamentos.
- Inclua ao menos quatro convênios médicos, associe ao menos cinco pacientes e cinco consultas.
- Criar entidade de relacionamento entre médico e especialidade. 
- Criar Entidade de Relacionamento entre internação e enfermeiro. 
- Arrumar a chave estrangeira do relacionamento entre convênio e médico.
- Criar entidade entre internação e enfermeiro.
- Colocar chaves estrangeira dentro da internação (Chaves Médico e Paciente).
- Registre ao menos sete internações. Pelo menos dois pacientes devem ter se internado mais de uma vez. Ao menos três quartos devem ser cadastrados. As internações devem ter ocorrido entre 01/01/2015 e 01/01/2022.
- Considerando que “a princípio o hospital trabalha com apartamentos, quartos duplos e enfermaria”, inclua ao menos esses três tipos com valores diferentes.
- Inclua dados de dez profissionais de enfermaria. Associe cada internação a ao menos dois enfermeiros.
- Os dados de tipo de quarto, convênio e especialidade são essenciais para a operação do sistema e, portanto, devem ser povoados assim que o sistema for instalado.

---

## 🐬 Arquivo .sql Referente à Parte 3: [Banco de Dados em MySQL - Parte 3](./Banco_de_Dados_Hospital_Script_Atual.sql)

---

## 📋 Entidades (Em Tabelas) Atualizadas

### `Médicos`
| Campo          | Tipo          | Descrição                                        |
|--------------|--------------|--------------------------------------------------|
| id_medicos   | integer [PK]  | Identificador único do médico                    |
| nome         | varchar(255)  | Nome completo do médico                          |
| cpf          | varchar(14)   | Cadastro de Pessoa Física (CPF) - único         |
| crm          | varchar(20)   | Registro do Conselho Regional de Medicina (CRM) |
| id_especialidade | integer  | Identificador da especialidade médica           |
| id_convenio  | integer       | Identificador do convênio associado              |

### `Consultas`
| Campo               | Tipo          | Descrição                                      |
|---------------------|--------------|----------------------------------------------|
| id_consultas       | integer [PK]  | Identificador único da consulta               |
| data_e_hora_cnslt  | datetime     | Data e hora da consulta                       |
| id_medicos         | integer       | Identificador do médico responsável           |
| valor              | decimal       | Valor da consulta                            |
| num_da_carteira    | varchar(15)   | Número da carteira do convênio - único       |
| especialidade_desejada | integer  | Identificador da especialidade médica         |
| fk_pacientes       | integer       | Identificador do paciente                     |
| id_convenio        | integer       | Identificador do convênio associado           |

### `Pacientes`
| Campo          | Tipo          | Descrição                                        |
|--------------|--------------|--------------------------------------------------|
| id_pacientes | integer [PK]  | Identificador único do paciente                  |
| nome         | varchar(255)  | Nome completo do paciente                        |
| cpf          | varchar(14)   | Cadastro de Pessoa Física (CPF) - único         |
| rg           | varchar(12)   | Registro Geral (RG)                             |
| data_nasc    | date          | Data de nascimento                              |
| endereco     | varchar(255)  | Endereço completo                               |
| telefone     | varchar(15)   | Número de telefone                              |
| email_pac    | varchar(255)  | E-mail do paciente                              |
| id_convenio  | integer       | Identificador do convênio associado              |

### `Convênio`
| Campo          | Tipo          | Descrição                                         |
|--------------|--------------|--------------------------------------------------|
| id_convenio  | integer [PK]  | Identificador único do convênio                  |
| nome_conv    | varchar(255) | Nome do convênio médico                          |
| cnpj_conv    | varchar(18)  | CNPJ do convênio - único                         |
| tempo_de_carencia | date     | Tempo de carência para utilização                |

### `Especialistas`
| Campo              | Tipo          | Descrição                                         |
|--------------------|--------------|--------------------------------------------------|
| id_especialidade  | integer [PK]  | Identificador único da especialidade             |
| nome_especialidade | varchar(255) | Nome da especialidade médica                     |

### `Receitas_do_Médico`
| Campo           | Tipo          | Descrição                                     |
|---------------|--------------|---------------------------------------------|
| id_receitas   | integer [PK]  | Identificador único da receita médica       |
| med_rctds     | text          | Medicamentos receitados                     |
| quant_med     | int           | Quantidade de medicamentos                  |
| instruções_uso | text         | Instruções de uso dos medicamentos          |
| relatorio_impresso | text     | Relatório impresso                          |
| relatorio_virtual | text      | Relatório digital                           |
| id_consultas  | integer       | Identificador da consulta associada         |

### `Internação`
| Campo        | Tipo          | Descrição                                    |
|------------|--------------|--------------------------------------------|
| id_internacao | integer [PK]  | Identificador único da internação           |
| id_medicos  | integer       | Identificador do médico responsável         |
| id_pacientes | integer       | Identificador do paciente internado        |
| id_enfermeiro | integer      | Identificador do enfermeiro responsável    |
| data_entrada | datetime      | Data e hora de entrada                      |
| previsao_alta | date         | Data prevista para alta                     |
| data_alta   | date          | Data real da alta                           |
| procedimento | text          | Procedimentos realizados                    |
| id_quarto   | integer       | Identificador do quarto onde ocorreu a internação |

### `Enfermeiro`
| Campo        | Tipo          | Descrição                                    |
|------------|--------------|--------------------------------------------|
| id_enfermeiro | integer [PK]  | Identificador único do enfermeiro          |
| nome        | varchar(255)  | Nome completo do enfermeiro                |
| cpf         | varchar(14)   | Cadastro de Pessoa Física (CPF) - único    |
| coren       | varchar(15)   | Registro no Conselho Regional de Enfermagem |

### `Quarto`
| Campo           | Tipo          | Descrição                                     |
|---------------|--------------|---------------------------------------------|
| id_quarto     | integer [PK]  | Identificador único do quarto               |
| numero        | int           | Número do quarto                            |
| tipo_de_quarto | varchar(255) | Categoria do quarto (apartamento, enfermaria) |
| descricao     | text          | Detalhes sobre o quarto                     |
| valor_diar    | decimal       | Valor diário cobrado                         |

## ↓ 👤 Novas Entidades! ↓

### `Internação_Enfermeiro`
| Campo           | Tipo          | Descrição                                |
|---------------|--------------|----------------------------------------|
| id_internacao | integer [FK]  | Identificador da internação             |
| id_enfermeiro | integer [FK]  | Identificador do enfermeiro associado   |

---

## ⚕️🌈🚑 PARTE 4 - A Ordem do Alterar: Alterando o Banco de Dados

## 📌 Novos Requisitos
Nesta etapa, o sistema hospitalar passará por algumas atualizações em seus dados, garantindo um gerenciamento mais eficiente dos médicos de seu hospital.
Para isso, será necessário adicionar ao banco de dados um indicativo para registrar se os médicos ainda estão atuando no hospital ou não; além disso, será preciso atualizar os registros existentes, marcando ao menos dois médicos como inativos e os demais como ativos.

### Demonstração:

```sql
ALTER TABLE Médicos 
ADD COLUMN em_atividade BOOLEAN DEFAULT TRUE;

-- Médicos Inativos
UPDATE Médicos 
SET em_atividade = FALSE 
WHERE id_medicos IN (3, 7);

-- Médicos Ativos
UPDATE Médicos 
SET em_atividade = TRUE 
WHERE id_medicos NOT IN (3, 7);
```

---

## 🐬 Arquivo .sql Referente à Parte 4: [Banco de Dados em MySQL - Parte 4](./Banco_de_Dados_Hospital_Script_Atual.sql)

---

## ⚕️🌈🚑 PARTE 5 - As Relíquias dos Dados: Consultas

## 📌 Novos Requisitos
Agora, por fim, com um banco bem estruturado e desenhado em mãos, é possível realizar testes, simulando relatórios ou telas que o sistema possa necessitar.

##  Vamos Testar 11 Ocorrências Juntos?

### 1. Todos os dados e o valor médio das consultas do ano de 2020 e das que foram feitas sob convênio.

```sql
-- Valor médio das consultas do ano de 2020
SELECT AVG(valor) AS media_2020
FROM Consultas
WHERE YEAR(data_e_hora_cnslt) = 2020;

-- Valor médio das consultas feitas sob convênio
SELECT AVG(valor) AS media_com_convenio
FROM Consultas
WHERE id_convenio IS NOT NULL;
```

### 2. Todos os dados das internações que tiveram data de alta maior que a data prevista para a alta.

```sql
SELECT * FROM Internação WHERE data_alta > previsao_alta;
```

### 3. Receituário completo da primeira consulta registrada com receituário associado.

```sql
SELECT r.*
FROM Receitas_do_Médico r
JOIN Consultas c ON r.id_consultas = c.id_consultas
ORDER BY c.data_e_hora_cnslt ASC
LIMIT 1;
```

### 4. Todos os dados da consulta de maior valor e também da de menor valor (ambas as consultas não foram realizadas sob convênio).

```sql
-- Consultas sem convênio
SELECT * FROM Consultas WHERE id_convenio IS NULL;

-- Consulta de maior valor sem convênio
SELECT * FROM Consultas 
WHERE id_convenio IS NULL 
ORDER BY valor DESC 
LIMIT 1;

-- Consulta de menor valor sem convênio
SELECT * FROM Consultas 
WHERE id_convenio IS NULL 
ORDER BY valor ASC 
LIMIT 1;
```

### 5. Todos os dados das internações em seus respectivos quartos, calculando o total da internação a partir do valor de diária do quarto e o número de dias entre a entrada e a alta.

```sql
SELECT i.*, q.valor_diar, 
       DATEDIFF(i.data_alta, DATE(i.data_entrada)) AS dias_internado,
       q.valor_diar * DATEDIFF(i.data_alta, DATE(i.data_entrada))) AS total_internacao
FROM Internação i
JOIN Quarto q ON i.id_quarto = q.id_quarto;
```

### 6. Data, procedimento e número de quarto de internações em quartos do tipo “apartamento”.

```sql
SELECT i.data_entrada, i.procedimento, q.numero
FROM Internação i
JOIN Quarto q ON i.id_quarto = q.id_quarto
WHERE q.tipo_de_quarto = 'Apartamento';
```

### 7. Nome do paciente, data da consulta e especialidade de todas as consultas em que os pacientes eram menores de 18 anos na data da consulta e cuja especialidade não seja “pediatria”, ordenando por data de realização da consulta.

```sql
SELECT p.nome AS paciente, c.data_e_hora_cnslt AS data_consulta, e.nome_especialidade AS especialidade
FROM Consultas c
JOIN Pacientes p ON c.fk_pacientes = p.id_pacientes
JOIN Especialistas e ON c.especialidade_desejada = e.id_especialidade
WHERE TIMESTAMPDIFF(YEAR, p.data_nasc, c.data_e_hora_cnslt) < 18
AND e.nome_especialidade != 'Pediatria'
ORDER BY c.data_e_hora_cnslt;
```

### 8. Nome do paciente, nome do médico, data da internação e procedimentos das internações realizadas por médicos da especialidade “gastroenterologia”, que tenham acontecido em “enfermaria”.

```sql
SELECT p.nome AS paciente, m.nome AS medico, i.data_entrada, i.procedimento
FROM Internação i
JOIN Médicos m ON i.id_medicos = m.id_medicos
JOIN Especialistas e ON m.id_especialidade = e.id_especialidade
JOIN Pacientes p ON i.id_pacientes = p.id_pacientes
JOIN Quarto q ON i.id_quarto = q.id_quarto
WHERE e.nome_especialidade = 'Gastroenterologia'
AND q.tipo_de_quarto = 'Enfermaria';
```

### 9. Os nomes dos médicos, seus CRMs e a quantidade de consultas que cada um realizou.

```sql
SELECT m.nome, m.crm, COUNT(c.id_consultas) AS quantidade_consultas
FROM Médicos m
LEFT JOIN Consultas c ON m.id_medicos = c.id_medicos
GROUP BY m.id_medicos, m.nome, m.crm;
```

### 10. Todos os médicos que tenham "Gabriel" no nome. 

```sql
SELECT * FROM Médicos WHERE nome LIKE '%Gabriel%';
```

### 11. Os nomes, CREs e número de internações de enfermeiros que participaram de mais de uma internação.

```sql
SELECT e.nome, e.coren, COUNT(ie.id_internacao) AS quantidade_internacoes
FROM Enfermeiro e
JOIN Internação_Enfermeiro ie ON e.id_enfermeiro = ie.id_enfermeiro
GROUP BY e.id_enfermeiro, e.nome, e.coren
HAVING COUNT(ie.id_internacao) > 1;
```

---

## 🐬 Arquivo .sql Referente à Parte 5: [Banco de Dados em MySQL - Parte 5](./Banco_de_Dados_Hospital_Script_Atual.sql)

---

## 🛠 Tecnologias Usadas
- **DER**: [draw.io](https://www.drawio.com/)
- **Script SQL**: [dbdiagram.io](https://dbdiagram.io/)
- **MySQL Workbench**
---
