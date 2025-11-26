/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Other/SQLTemplate.sql to edit this template
 */
/**
 * Author:
 * Created: 26 de nov. de 2025
 */

CREATE DATABASE IF NOT EXISTS logistica
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

USE logistica;

-- ----------------------------------------------------------
-- 1. Tabela USUARIOS (Nova)
-- ----------------------------------------------------------
CREATE TABLE IF NOT EXISTS usuarios (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    senha VARCHAR(255) NOT NULL, -- Armazena o Hash SHA-256
    perfil VARCHAR(20) NOT NULL DEFAULT 'OPERADOR', -- 'ADMIN' ou 'OPERADOR'
    data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- INSERIR ADMIN PADRÃO
-- E-mail: admin@log.com
-- Senha: admin (O hash abaixo é a representação SHA-256 da palavra 'admin')
INSERT IGNORE INTO usuarios (nome, email, senha, perfil) 
VALUES ('Administrador', 'admin@log.com', '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918', 'ADMIN');


-- ----------------------------------------------------------
-- 2. Tabela CARGA
-- ----------------------------------------------------------
CREATE TABLE IF NOT EXISTS carga (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    remetente VARCHAR(255) NOT NULL,
    nf_di VARCHAR(100) NOT NULL,
    quantidade VARCHAR(100),
    peso VARCHAR(100),
    
    tipos_produto TEXT,
    tipo_produto_outro VARCHAR(255),
    tipos_volume TEXT,
    tipo_volume_outro VARCHAR(255),
    
    ct_emitido VARCHAR(10),
    ct_numero VARCHAR(100),
    temperatura VARCHAR(50),
    
    usuario_id BIGINT, -- Quem registrou a carga
    data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    -- Vínculo com o usuário
    CONSTRAINT fk_carga_usuario FOREIGN KEY (usuario_id) REFERENCES usuarios(id)
);

-- ----------------------------------------------------------
-- 3. Tabela RECEBIMENTO
-- ----------------------------------------------------------
CREATE TABLE IF NOT EXISTS recebimento (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    carga_id BIGINT NOT NULL,
    
    data_hora DATETIME,
    transportadora VARCHAR(255),
    motorista VARCHAR(255),
    placa VARCHAR(20),
    frota VARCHAR(50),
    
    irregularidades TEXT,
    resultado VARCHAR(50),
    colaborador VARCHAR(150),
    
    usuario_id BIGINT, -- Quem registrou o recebimento

    -- Vínculos
    CONSTRAINT fk_recebimento_carga FOREIGN KEY (carga_id) REFERENCES carga(id) ON DELETE CASCADE,
    CONSTRAINT fk_recebimento_usuario FOREIGN KEY (usuario_id) REFERENCES usuarios(id)
);

-- ----------------------------------------------------------
-- 4. Tabela EXPEDICAO
-- ----------------------------------------------------------
CREATE TABLE IF NOT EXISTS expedicao (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    carga_id BIGINT NOT NULL,
    
    data_hora DATETIME,
    transportadora VARCHAR(255),
    motorista VARCHAR(255),
    placa VARCHAR(20),
    frota VARCHAR(50),
    
    irregularidades TEXT,
    resultado VARCHAR(50),
    colaborador VARCHAR(150),
    
    usuario_id BIGINT, -- Quem registrou a expedição

    -- Vínculos
    CONSTRAINT fk_expedicao_carga FOREIGN KEY (carga_id) REFERENCES carga(id) ON DELETE CASCADE,
    CONSTRAINT fk_expedicao_usuario FOREIGN KEY (usuario_id) REFERENCES usuarios(id)
);