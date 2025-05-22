# 🏥 Criando um Banco de Dados para um Hospital

Um pequeno hospital local busca desenvolver um novo sistema para gerenciar suas operações, transferindo dados antigos armazenados em planilhas para um banco de dados estruturado. O objetivo é criar um **Diagrama Entidade-Relacionamento (DER)** adequado e expandir funcionalidades conforme necessário.

## ⚕️🌈🚑 PARTE 1 - O Hospital Fundamental

## 📌 Entidades Principais
- 🩹 `Pacientes`: Dados Pessoais, Documentos e Convênio Médico;
- 🥼 `Médicos`: Generalistas, Especialistas ou Residentes, podendo ter Múltiplas Especialidades (Como Clínicos Gerais, Dermatologistas, Gastroenterologistas e Pediatras);
- 🔎 `Consultas`: Registros de Atendimentos com Data, Médico Responsável, Paciente e Convênio.

---

![Diagrama DER - Banco de Dados Hospital](./bdd_hospital_parte1.drawio.png)

---

## ⚕️🌈🚑 PARTE 2 - Expansão do Sistema

## 📌 Novos Requisitos
A segunda versão do sistema introduziu funcionalidades essenciais para o **Controle de Internações**, incluindo:
- 📅 `Internação`: Registro de Data de Entrada, Data de Previsão de Alta, Data de Alta e Procedimento;
- 🧑🏽‍⚕️ `Enfermeiro`: Controle dos Enfermeiros responsáveis pela internação, incluindo Nome, CPF e Registro no Conselho de Enfermagem (COREN ou CRE);
- 🏨 `Quarto`: Vinculação da Internação a um Quarto específico, com Número e Tipo do Quarto (Com Descrição e Valor da Diária).

### 📌 Modificações no Modelo
- **Novas Entidades**: `Internação`, `Enfermeiro` e `Quarto`.

---

![Diagrama DER - Banco de Dados Hospital - Parte 2](./bdd_hospital_parte2.drawio.png)

---

<h3 align="center">Em Desenvolvimento...</h3>

---

## 🛠 Tecnologias Usadas
- **DER**: [draw.io](https://www.drawio.com/)

---
