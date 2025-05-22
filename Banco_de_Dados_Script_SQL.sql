CREATE TABLE `Médicos` (
  `id_medicos` integer PRIMARY KEY,
  `nome` varchar(255),
  `cpf` varchar(11) UNIQUE,
  `crm` varchar(20) UNIQUE COMMENT 'O chamado "CRM Médico" é um Registro que Todo Profissional de Medicina Precisa Ter para Atuar no Brasil.',
  `especialidade` varchar(255)
);

CREATE TABLE `Consultas` (
  `id_consultas` integer PRIMARY KEY,
  `planilhas` text,
  `data_e_hora_cnslt` datetime,
  `medico_resp` varchar(255),
  `valor_ou_conven` varchar(255),
  `num_da_carteira` varchar(20),
  `especialidade_desejada` varchar(255)
);

CREATE TABLE `Pacientes` (
  `id_pacientes` integer PRIMARY KEY,
  `nome` varchar(255),
  `cpf` varchar(11) UNIQUE,
  `rg` varchar(11),
  `data_nasc` date,
  `endereco` varchar(255),
  `telefone` varchar(15)
);

CREATE TABLE `Convênio` (
  `id_convenio` integer PRIMARY KEY,
  `nome_conv` varchar(255),
  `cnpj_conv` varchar(18),
  `tempo_de_carencia` date
);

CREATE TABLE `Especialistas` (
  `id_especialidade` integer PRIMARY KEY,
  `generalistas` varchar(255),
  `pediatria` varchar(255),
  `clinica_geral` varchar(255),
  `gastroenterologia` varchar(255),
  `dermatologia` varchar(255),
  `residentes` varchar(255)
);

CREATE TABLE `Receitas_do_Médico` (
  `id_receitas` integer PRIMARY KEY,
  `med_rctds` text,
  `quant_med` varchar(255),
  `instruções_uso` text,
  `relatorio_impresso` text,
  `relatorio_virtual` text
);

CREATE TABLE `Internação` (
  `id_internacao` integer PRIMARY KEY,
  `id_medicos` integer,
  `id_pacientes` integer,
  `id_enfermeiro` integer,
  `data_entrada` datetime,
  `previsao_alta` date,
  `data_alta` date,
  `procedimento` text
);

CREATE TABLE `Enfermeiro` (
  `id_enfermeiro` integer PRIMARY KEY,
  `nome` varchar(255),
  `cpf` varchar(11) UNIQUE,
  `coren` varchar(15) UNIQUE COMMENT 'O chamado "COREN" (Conselho Regional de Enfermagem) é um Registro Obrigatório para Enfermeiros, Garantindo que Estejam Habilitados a Atuar no Brasil.',
  `especialidade` varchar(255)
);

CREATE TABLE `Quarto` (
  `id_quarto` integer PRIMARY KEY,
  `numero` int,
  `tipo_de_quarto` varchar(255),
  `descricao` text,
  `valor_diar` decimal
);

ALTER TABLE `Internação` ADD FOREIGN KEY (`id_medicos`) REFERENCES `Médicos` (`id_medicos`);

ALTER TABLE `Internação` ADD FOREIGN KEY (`id_pacientes`) REFERENCES `Pacientes` (`id_pacientes`);

ALTER TABLE `Internação` ADD FOREIGN KEY (`id_enfermeiro`) REFERENCES `Enfermeiro` (`id_enfermeiro`);

ALTER TABLE `Médicos` ADD FOREIGN KEY (`id_medicos`) REFERENCES `Consultas` (`id_consultas`);

ALTER TABLE `Consultas` ADD FOREIGN KEY (`id_consultas`) REFERENCES `Pacientes` (`id_pacientes`);

ALTER TABLE `Pacientes` ADD FOREIGN KEY (`id_pacientes`) REFERENCES `Convênio` (`id_convenio`);

ALTER TABLE `Consultas` ADD FOREIGN KEY (`id_consultas`) REFERENCES `Receitas_do_Médico` (`id_receitas`);

ALTER TABLE `Médicos` ADD FOREIGN KEY (`id_medicos`) REFERENCES `Receitas_do_Médico` (`id_receitas`);

ALTER TABLE `Médicos` ADD FOREIGN KEY (`id_medicos`) REFERENCES `Especialistas` (`id_especialidade`);

ALTER TABLE `Internação` ADD FOREIGN KEY (`id_internacao`) REFERENCES `Quarto` (`id_quarto`);
