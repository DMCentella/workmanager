CREATE DATABASE db_gestion_trabajadores 
CHARACTER SET utf8mb4 
COLLATE utf8mb4_unicode_ci;

USE db_gestion_trabajadores;

CREATE TABLE roles (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL UNIQUE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(100) NOT NULL,
    enabled BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE usuario_roles (
    usuario_id INT NOT NULL,
    rol_id INT NOT NULL,
    PRIMARY KEY (usuario_id, rol_id),
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE CASCADE,
    FOREIGN KEY (rol_id) REFERENCES roles(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE trabajadores (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    telefono INT NOT NULL,
    sexo VARCHAR(20) NOT NULL,
    salario DOUBLE NOT NULL,
    fecha DATE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO roles (id, nombre) VALUES 
(1, 'ROLE_ADMIN'), 
(2, 'ROLE_USER');

-- admin = 12345 sandra 12345
INSERT INTO usuarios (id, username, password, enabled) VALUES
(1, 'admin', '$2a$10$9ljZB/xbLL0x1eNabW.pcuGkf29auxoRSIvu7Cdu/zWrsmOLFaqUK', TRUE),
(2, 'sandra', '$2a$10$bWE4naRodj1HAY/GZyei2OzbTuj7ZRBmOwbiHBPyPh7rpZ6.BAU2u', TRUE);

INSERT INTO usuario_roles (usuario_id, rol_id) VALUES
(1, 1),  
(2, 2);  
INSERT INTO trabajadores (nombre, apellido, email, telefono, sexo, salario, fecha) VALUES
('Sandra', 'Lopez', 'sandra.lopez@example.com', 987654321, 'Femenino', 2500.50, '2024-04-10'),
('Luis', 'Ramirez', 'luis.ramirez@example.com', 923456789, 'Masculino', 3100.00, '2023-12-05'),
('Ana', 'Torres', 'ana.torres@example.com', 954321654, 'Femenino', 2800.75, '2024-02-18'),
('María', 'Silva', 'maria.silva@example.com', 987123456, 'Femenino', 2900.50, '2024-01-20'),
('Jorge', 'Paredes', 'jorge.paredes@example.com', 965432187, 'Masculino', 3500.75, '2023-09-08'),
('Patricia', 'Gonzales', 'patricia.gonzales@example.com', 943218765, 'Femenino', 2700.00, '2024-03-12'),
('Roberto', 'Flores', 'roberto.flores@example.com', 921876543, 'Masculino', 3300.25, '2023-10-25'),
('Carmen', 'Vargas', 'carmen.vargas@example.com', 956789012, 'Femenino', 2600.80, '2024-05-07'),
('Diego', 'Castro', 'diego.castro@example.com', 934567890, 'Masculino', 3400.00, '2023-08-14'),
('Lucía', 'Reyes', 'lucia.reyes@example.com', 978901234, 'Femenino', 2850.50, '2024-02-28'),
('Fernando', 'Morales', 'fernando.morales@example.com', 945678901, 'Masculino', 3150.75, '2023-12-19'),
('Isabella', 'Mendoza', 'isabella.mendoza@example.com', 912345678, 'Femenino', 2950.00, '2024-01-15'),
('Carlos', 'Jimenez', 'carlos.jimenez@example.com', 998877665, 'Masculino', 3200.50, '2023-11-20'),
('Valentina', 'Rojas', 'valentina.rojas@example.com', 987654320, 'Femenino', 2750.25, '2024-03-05'),
('Miguel', 'Herrera', 'miguel.herrera@example.com', 923456788, 'Masculino', 3450.00, '2023-10-10');

CREATE INDEX idx_trabajadores_nombre ON trabajadores(nombre);
CREATE INDEX idx_trabajadores_apellido ON trabajadores(apellido);
CREATE INDEX idx_trabajadores_email ON trabajadores(email);
CREATE INDEX idx_trabajadores_sexo ON trabajadores(sexo);

SELECT ' ROLES ' AS '';
SELECT * FROM roles;

SELECT ' USUARIOS ' AS '';
SELECT id, username, enabled, created_at FROM usuarios;

SELECT ' USUARIO_ROLES ' AS '';
SELECT * FROM usuario_roles;

SELECT ' TRABAJADORES ' AS '';
SELECT * FROM trabajadores;

SELECT ' USUARIOS CON SUS ROLES ' AS '';
SELECT 
    u.id,
    u.username,
    u.enabled,
    GROUP_CONCAT(r.nombre) AS roles
FROM usuarios u
LEFT JOIN usuario_roles ur ON u.id = ur.usuario_id
LEFT JOIN roles r ON ur.rol_id = r.id
GROUP BY u.id, u.username, u.enabled;

SELECT ' ESTADÍSTICAS ' AS '';
SELECT 
    (SELECT COUNT(*) FROM roles) AS total_roles,
    (SELECT COUNT(*) FROM usuarios) AS total_usuarios,
    (SELECT COUNT(*) FROM trabajadores) AS total_trabajadores;

SHOW TABLES;
SELECT username, password
FROM usuarios;