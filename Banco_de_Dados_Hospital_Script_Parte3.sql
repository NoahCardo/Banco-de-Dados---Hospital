-- Criando o Banco de Dados
CREATE DATABASE IF NOT EXISTS Banco_de_Dados_Hospital_Script;
USE Banco_de_Dados_Hospital_Script;

-- Criando Tabelas
CREATE TABLE `Especialistas` (
  `id_especialidade` INTEGER PRIMARY KEY,
  `nome_especialidade` VARCHAR(255)
);

CREATE TABLE `Convênio` (
  `id_convenio` INTEGER PRIMARY KEY,
  `nome_conv` VARCHAR(255) NOT NULL,
  `cnpj_conv` VARCHAR(18) UNIQUE NOT NULL,
  `tempo_de_carencia` DATE
);

CREATE TABLE `Médicos` (
  `id_medicos` INTEGER PRIMARY KEY,
  `nome` VARCHAR(255) NOT NULL,
  `cpf` VARCHAR(14) UNIQUE NOT NULL,
  `crm` VARCHAR(20) UNIQUE NOT NULL COMMENT 'O chamado "CRM Médico" é um Registro que Todo Profissional de Medicina Precisa Ter para Atuar no Brasil.',
  `id_especialidade` INTEGER,
  `id_convenio` INTEGER,
  FOREIGN KEY (`id_especialidade`) REFERENCES `Especialistas` (`id_especialidade`),
  FOREIGN KEY (`id_convenio`) REFERENCES `Convênio` (`id_convenio`)
);

CREATE TABLE `Pacientes` (
  `id_pacientes` INTEGER PRIMARY KEY,
  `nome` VARCHAR(255) NOT NULL,
  `cpf` VARCHAR(14) UNIQUE NOT NULL,
  `rg` VARCHAR(12),
  `data_nasc` DATE,
  `endereco` VARCHAR(255),
  `telefone` VARCHAR(15),
  `email_pac` VARCHAR(255),
  `id_convenio` INTEGER,
  FOREIGN KEY (`id_convenio`) REFERENCES `Convênio` (`id_convenio`)
);

CREATE TABLE `Consultas` (
  `id_consultas` INTEGER PRIMARY KEY,
  `data_e_hora_cnslt` DATETIME NOT NULL,
  `id_medicos` INTEGER NOT NULL,
  `valor` DECIMAL,
  `num_da_carteira` VARCHAR(15) UNIQUE NOT NULL,
  `especialidade_desejada` INTEGER NOT NULL,
  `fk_pacientes` INTEGER NOT NULL,
  `id_convenio` INTEGER,
  FOREIGN KEY (`id_medicos`) REFERENCES `Médicos` (`id_medicos`),
  FOREIGN KEY (`fk_pacientes`) REFERENCES `Pacientes` (`id_pacientes`),
  FOREIGN KEY (`especialidade_desejada`) REFERENCES `Especialistas` (`id_especialidade`),
  FOREIGN KEY (`id_convenio`) REFERENCES `Convênio` (`id_convenio`)
);

CREATE TABLE `Receitas_do_Médico` (
  `id_receitas` INTEGER PRIMARY KEY,
  `med_rctds` TEXT,
  `quant_med` INT,
  `instruções_uso` TEXT,
  `relatorio_impresso` TEXT,
  `relatorio_virtual` TEXT,
  `id_consultas` INTEGER NOT NULL,
  FOREIGN KEY (`id_consultas`) REFERENCES `Consultas` (`id_consultas`)
);

CREATE TABLE `Quarto` (
  `id_quarto` INTEGER PRIMARY KEY,
  `numero` INT,
  `tipo_de_quarto` VARCHAR(255),
  `descricao` TEXT,
  `valor_diar` DECIMAL
);

CREATE TABLE `Enfermeiro` (
  `id_enfermeiro` INTEGER PRIMARY KEY,
  `nome` VARCHAR(255) NOT NULL,
  `cpf` VARCHAR(14) UNIQUE NOT NULL,
  `coren` VARCHAR(15) UNIQUE NOT NULL COMMENT 'O chamado "COREN" é um Registro Obrigatório para Enfermeiros, Garantindo que Estejam Habilitados a Atuar no Brasil.'
);

CREATE TABLE `Internação` (
  `id_internacao` INTEGER PRIMARY KEY,
  `id_medicos` INTEGER NOT NULL,
  `id_pacientes` INTEGER NOT NULL,
  `id_enfermeiro` INTEGER NOT NULL,
  `data_entrada` DATETIME NOT NULL,
  `previsao_alta` DATE NOT NULL,
  `data_alta` DATE,
  `procedimento` TEXT NOT NULL,
  `id_quarto` INTEGER NOT NULL,
  FOREIGN KEY (`id_medicos`) REFERENCES `Médicos` (`id_medicos`),
  FOREIGN KEY (`id_pacientes`) REFERENCES `Pacientes` (`id_pacientes`),
  FOREIGN KEY (`id_quarto`) REFERENCES `Quarto` (`id_quarto`),
  FOREIGN KEY (`id_enfermeiro`) REFERENCES `Enfermeiro` (`id_enfermeiro`)
);

CREATE TABLE `Internação_Enfermeiro` (
  `id_internacao` INTEGER NOT NULL,
  `id_enfermeiro` INTEGER NOT NULL,
  PRIMARY KEY (`id_internacao`, `id_enfermeiro`),
  FOREIGN KEY (`id_internacao`) REFERENCES `Internação` (`id_internacao`),
  FOREIGN KEY (`id_enfermeiro`) REFERENCES `Enfermeiro` (`id_enfermeiro`)
);

-- Inserindo Dados na Tabela "Especialistas"
INSERT INTO Especialistas (id_especialidade, nome_especialidade) VALUES
(1, "Endocrinologia"), (2, "Psicologia"), (3, "Cardiologia"),
(4, "Ortopedia"), (5, "Radiologia"), (6, "Clínica Geral"),
(7, "Dermatologia"), (8, "Pediatria"), (9, "Gastroenterologia"), (10, "UTI");

-- Inserindo Dados na Tabela "Convênio"
INSERT INTO Convênio (id_convenio, nome_conv, cnpj_conv, tempo_de_carencia) VALUES
(1, "Dame Notre", "12.345.678/0001-99", "31/12/2029"),
(2, "Deminu", "98.765.432/0001-11", "15/10/2029"),
(3, "Auxilium Salutis", "56.789.012/0001-22", "05/11/2029"),
(4, "Lima", "34.567.890/0001-44", "01/01/2029"),
(5, "Senior Prevent", "78.345.621/0001-88", "31/12/2029");

-- Inserindo Dados na Tabela "Médicos"
INSERT INTO Médicos (id_medicos, nome, cpf, crm, id_especialidade, id_convenio) VALUES
(1, "Noah Ferreira Silva", "551.375.620-50", "7475179905", 1, 1),
(2, "Yasmin Cristina Sartori", "506.347.664-14", "2640237340", 2, 1),
(3, "Laysla Rayssa Correia Santiago", "556.700.859-81", "7983950691", 3, 2),
(4, "Esther Justino Esmeralda", "571.535.997-70", "9036895695", 4, 2),
(5, "Marcio Dias Kathelyn", "575.980.585-71", "3893788456", 5, 3),
(6, "Victor Ramon Sebastian Silva", "579.447.835-50", "5609621297", 6, 3),
(7, "Alisson Sebastian Silva", "514.273.328-35", "5349985756", 6, 4),
(8, "Jullia Alves Pires", "570.267.296-75", "3220639927", 7, 4),
(9, "William Cardozo Ordalio", "572.479.735-36", "9313610503", 8, 5),
(10, "Livia Maciel Costa", "535.501.359-63", "2826159517", 9, 5);

-- Inserindo Dados na Tabela "Pacientes"
INSERT INTO Pacientes (id_pacientes, nome, cpf, rg, data_nasc, endereco, telefone, email_pac, id_convenio) VALUES
(1, "Gabriel S. Assis Borges", "701.610.171-18", "22152533-3", "1996-02-26", "Rua TiLa, 25 - Rio de Janeiro/SP", "(51) 957369-1921", "gabriel.s.assis.borges40@outlook.com", 1),
(2, "Bruno Assis Borges", "476.563.921-57", "04498229-7", "1999-04-19", "Rua TiLa, 25 - Rio de Janeiro/SP", "(21) 976007-6828", "bruno.assis.borges59@yahoo.com.br", NULL),
(3, "Gabriel N. Assis Borges", "365.601.754-99", "12651482-8", "1996-05-17", "Rua TiLa, 25 - Rio de Janeiro/SP", "(51) 993313-5481", "gabriel.n.assis.borges50@outlook.com", 1),
(4, "Mayan Rocha Reis", "103.253.527-04", "27896977-3", "2006-07-17", "Avenida Nitro, 775 - Curitiba/BA", "(11) 981905-5020", "mayan.rocha.reis52@gmail.com", 2),
(5, "Samuel Cobra Souza", "528.034.098-79", "90374367-8", "1996-11-18", "Avenida Gatorion, 199 - São Paulo/RS", "(11) 919286-5673", "samuel.cobra.souza89@hotmail.com", 1),
(6, "Isabelly Aisha Marques", "085.149.006-92", "55217528-9", "2015-04-22", "Travessa Ponto Norte, 128 - Rio de Janeiro/RJ", "(11) 914898-5288", "isabelly.aisha.marques76@gmail.com", 3),
(7, "Matheus Pereira Nascimento", "676.900.735-57", "09314041-6", "1982-09-27", "Alameda TechSyn, 607 - Curitiba/RS", "(31) 995979-1392", "matheus.pereira.nascimento89@hotmail.com", 3),
(8, "Lucas Quispe Junior", "838.590.646-06", "87987235-4", "1980-03-12", "Travessa Polibee, 161 - São Paulo/PR", "(31) 976802-5229", "lucas.quispe.junior71@hotmail.com", 4),
(9, "Andrey Ordalio Ribeiro", "349.802.413-28", "50133018-6", "1996-07-14", "Alameda Zeelus, 923 - Salvador/SP", "(41) 969906-2284", "andrey.ordalio.ribeiro22@outlook.com", 2),
(10, "Juliana Santos Lima", "483.785.919-48", "91715458-8", "1996-09-06", "Alameda BloodLink, 46 - São Paulo/SP", "(21) 939547-6016", "juliana.santos.lima23@gmail.com", NULL),
(11, "Manoel Vieira Ribeiro", "131.291.015-19", "41318584-8", "2001-01-19", "Travessa Acaiacá, 56 - Salvador/PR", "(11) 926926-1589", "manoel.vieira.ribeiro20@outlook.com", 5),
(12, "Joel Brenno Choque Almeida", "749.900.667-07", "34359119-6", "1992-12-15", "Alameda Acenis, 608 - Belo Horizonte/RJ", "(31) 951422-3519", "joel.brenno.choque.almeida16@outlook.com", NULL),
(13, "Isaac Junior Lopes", "213.898.242-41", "55431596-3", "1986-11-04", "Travessa MedGur, 617 - Rio de Janeiro/BA", "(11) 928850-7018", "isaac.junior.lopes59@yahoo.com.br", NULL),
(14, "Suzana Araujo Muniz", "203.715.509-39", "58783797-2", "2000-05-13", "Avenida BrailleWay, 118 - Belo Horizonte/RJ", "(11) 980446-7993", "suzana.araujo.muniz3@gmail.com", NULL),
(15, "Maikon Padula Alvarenga", "094.366.227-32", "02094857-0", "1995-03-21", "Avenida Lume, 23 - Curitiba/RS", "(41) 961680-6957", "maikon.padula.alvarenga70@gmail.com", NULL);

-- Inserindo Dados na Tabela "Consultas"
INSERT INTO Consultas (id_consultas, data_e_hora_cnslt, id_medicos, valor, num_da_carteira, especialidade_desejada, fk_pacientes, id_convenio) VALUES
(1, '2015-03-12 14:30:00', 1, 250.00, 'CAR123456', 1, 11, 1),
(2, '2020-07-22 10:00:00', 2, 180.00, 'CAR654321', 2, 9, 2),
(3, '2017-05-15 09:15:00', 3, 300.00, 'CAR789123', 3, 13, 3),
(4, '2018-10-30 16:45:00', 4, 210.00, 'CAR987654', 4, 10, 4),
(5, '2019-06-18 13:20:00', 5, 220.00, 'CAR345678', 5, 7, 5),
(6, '2018-01-29 15:10:00', 6, 150.00, 'CAR876543', 6, 5, 1),
(7, '2021-07-07 11:30:00', 7, 150.00, 'CAR234567', 6, 8, 2),
(8, '2016-09-14 17:50:00', 8, 270.00, 'CAR321456', 7, 4, 3),
(9, '2021-12-01 08:40:00', 9, 190.00, 'CAR765432', 8, 6, 4),
(10, '2016-08-25 14:00:00', 10, 200.00, 'CAR543210', 9, 10, 5),
(11, '2021-04-11 09:50:00', 1, 260.00, 'CAR111222', 1, 12, 1),
(12, '2019-11-19 18:20:00', 2, 185.00, 'CAR333444', 2, 9, 2),
(13, '2020-08-05 12:30:00', 3, 310.00, 'CAR555666', 3, 15, 3),
(14, '2015-12-23 07:45:00', 4, 215.00, 'CAR777888', 4, 14, 4),
(15, '2018-06-30 16:10:00', 5, 225.00, 'CAR999000', 5, 13, 5),
(16, '2021-02-17 19:00:00', 6, 155.00, 'CAR112233', 6, 1, 1),
(17, '2017-11-22 10:10:00', 7, 155.00, 'CAR445566', 6, 2, 2),
(18, '2018-07-29 14:40:00', 8, 275.00, 'CAR778899', 7, 5, 3),
(19, '2015-05-03 08:15:00', 9, 195.00, 'CAR990011', 8, 6, 4),
(20, '2020-10-14 11:55:00', 10, 205.00, 'CAR332211', 9, 3, 5);

-- Inserindo Dados na Tabela "Enfermeiro"
INSERT INTO Enfermeiro (id_enfermeiro, nome, cpf, coren) VALUES
(1, "Leticia Azevedo", "557.928.554-04", "52711"),
(2, "Aurora DalMagro", "479.160.206-45", "30450"),
(3, "Wesley Augusto", "871.806.170-24", "61351"),
(4, "Julio Barros", "151.307.133-54", "12018"),
(5, "Gabriel Campos", "138.556.515-23", "73106"),
(6, "Jailson Campos", "190.276.736-59", "65316"),
(7, "Debora Alves", "876.678.243-04", "13093"),
(8, "Andressa Santos", "956.302.295-59", "51855"),
(9, "Ricardo Monteiro", "119.187.339-02", "87478"),
(10, "Alini Nascimento", "300.971.309-66", "68799");

-- Inserindo Dados na Tabela "Quarto"
INSERT INTO Quarto (id_quarto, numero, tipo_de_quarto, descricao, valor_diar) VALUES
(1, 101, 'Apartamento', 'Quarto individual com banheiro privativo, TV e frigobar', 500.00),
(2, 102, 'Apartamento', 'Quarto individual com banheiro privativo e área de estar', 550.00),
(3, 201, 'Quarto Duplo', 'Quarto compartilhado com outro paciente, banheiro privativo', 350.00),
(4, 202, 'Quarto Duplo', 'Quarto compartilhado com outro paciente', 300.00),
(5, 301, 'Enfermaria', 'Quarto coletivo com 4 leitos, banheiro compartilhado', 200.00),
(6, 302, 'Enfermaria', 'Quarto coletivo com 6 leitos, banheiro compartilhado', 150.00),
(7, 401, 'UTI', 'Unidade de Terapia Intensiva com monitoramento 24h', 800.00);

-- Inserindo Dados na Tabela "Internação"
INSERT INTO Internação (id_internacao, id_medicos, id_pacientes, id_enfermeiro, data_entrada, previsao_alta, data_alta, procedimento, id_quarto) VALUES
(1, 3, 1, 5, '2015-03-15 10:00:00', '2015-03-20', '2015-03-19', 'Monitoramento cardíaco', 7),
(2, 6, 2, 8, '2016-05-20 14:30:00', '2016-05-25', '2016-05-24', 'Tratamento de infecção', 3),
(3, 9, 6, 10, '2017-02-10 09:15:00', '2017-02-15', '2017-02-14', 'Observação pediátrica', 1),
(4, 4, 10, 6, '2018-07-05 16:45:00', '2018-07-12', '2018-07-11', 'Cirurgia ortopédica', 2),
(5, 1, 11, 2, '2019-09-18 08:20:00', '2019-09-25', '2019-09-23', 'Controle glicêmico', 4),
(6, 3, 1, 5, '2020-11-22 11:10:00', '2020-11-28', '2020-11-27', 'Exames cardíacos', 7),
(7, 10, 3, 1, '2021-04-30 13:45:00', '2021-05-05', '2021-05-04', 'Tratamento gastrointestinal', 5);

-- Inserindo Dados na Tabela "Internação_Enfermeiro"
INSERT INTO Internação_Enfermeiro (id_internacao, id_enfermeiro) VALUES
(1, 5), (1, 9),
(2, 8), (2, 7),
(3, 10), (3, 8),
(4, 6), (4, 3),
(5, 2), (5, 4),
(6, 5), (6, 9),
(7, 1), (7, 10);

-- Inserindo Dados na Tabela "Receitas_do_Médico"
INSERT INTO Receitas_do_Médico (id_receitas, med_rctds, quant_med, instruções_uso, relatorio_impresso, relatorio_virtual, id_consultas) VALUES
(1, 'Paracetamol 500mg; Ibuprofeno 400mg', 2, 'Tomar 1 comprimido de cada a cada 8 horas', 'Relatório impresso da consulta 1', 'relatorio1.pdf', 1),
(2, 'Diazepam 5mg; Fluoxetina 20mg', 2, 'Diazepam antes de dormir, Fluoxetina pela manhã', 'Relatório impresso da consulta 2', 'relatorio2.pdf', 2),
(3, 'Losartana 50mg; Hidroclorotiazida 25mg', 2, 'Tomar 1 comprimido de cada pela manhã', 'Relatório impresso da consulta 3', 'relatorio3.pdf', 3),
(4, 'Dipirona 500mg; Cetoprofeno 100mg', 2, 'Tomar 1 comprimido de cada a cada 6 horas', 'Relatório impresso da consulta 4', 'relatorio4.pdf', 4),
(5, 'Omeprazol 20mg; Domperidona 10mg', 2, 'Omeprazol antes do café, Domperidona antes das refeições', 'Relatório impresso da consulta 5', 'relatorio5.pdf', 5),
(6, 'Amoxicilina 500mg; Dipirona 500mg', 2, 'Amoxicilina a cada 8 horas, Dipirona a cada 6 horas', 'Relatório impresso da consulta 6', 'relatorio6.pdf', 6),
(7, 'Paracetamol 500mg; Loratadina 10mg', 2, 'Paracetamol a cada 8 horas, Loratadina 1x ao dia', 'Relatório impresso da consulta 7', 'relatorio7.pdf', 7),
(8, 'Sulfametoxazol 400mg; Trimetoprima 80mg', 2, 'Tomar 1 comprimido a cada 12 horas', 'Relatório impresso da consulta 8', 'relatorio8.pdf', 8),
(9, 'Amoxicilina 250mg; Prednisolona 20mg', 2, 'Amoxicilina a cada 8 horas, Prednisolona pela manhã', 'Relatório impresso da consulta 9', 'relatorio9.pdf', 9),
(10, 'Pantoprazol 40mg; Metoclopramida 10mg', 2, 'Pantoprazol antes do café, Metoclopramida antes das refeições', 'Relatório impresso da consulta 10', 'relatorio10.pdf', 10),
(11, 'Cefalexina 500mg', 1, 'Tomar 1 comprimido a cada 8 horas', 'Relatório impresso da consulta 11', 'relatorio11.pdf', 11),
(12, 'Sinvastatina 20mg', 1, 'Tomar 1 comprimido antes de dormir', 'Relatório impresso da consulta 12', 'relatorio12.pdf', 12),
(13, 'AAS 100mg', 1, 'Tomar 1 comprimido pela manhã', 'Relatório impresso da consulta 13', 'relatorio13.pdf', 13),
(14, 'Ranitidina 150mg', 1, 'Tomar 1 comprimido antes das refeições', 'Relatório impresso da consulta 14', 'relatorio14.pdf', 14),
(15, 'Dexametasona 4mg', 1, 'Tomar 1 comprimido a cada 12 horas', 'Relatório impresso da consulta 15', 'relatorio15.pdf', 15),
(16, 'Nimesulida 100mg', 1, 'Tomar 1 comprimido a cada 12 horas', 'Relatório impresso da consulta 16', 'relatorio16.pdf', 16),
(17, 'Cloridrato de sertralina 50mg', 1, 'Tomar 1 comprimido pela manhã', 'Relatório impresso da consulta 17', 'relatorio17.pdf', 17),
(18, 'Maleato de enalapril 10mg', 1, 'Tomar 1 comprimido pela manhã', 'Relatório impresso da consulta 18', 'relatorio18.pdf', 18),
(19, 'Cloridrato de metformina 850mg', 1, 'Tomar 1 comprimido após o almoço', 'Relatório impresso da consulta 19', 'relatorio19.pdf', 19),
(20, 'Cloridrato de fluoxetina 20mg', 1, 'Tomar 1 comprimido pela manhã', 'Relatório impresso da consulta 20', 'relatorio20.pdf', 20);
