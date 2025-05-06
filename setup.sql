-- Crear base de datos
CREATE DATABASE IF NOT EXISTS `i-architecture` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `i-architecture`;

-- Tabla: projects
CREATE TABLE projects (
                          id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
                          shortname VARCHAR(100) NOT NULL UNIQUE,
                          name VARCHAR(255) NOT NULL,
                          img_header VARCHAR(255),
                          visible TINYINT(1) NOT NULL DEFAULT 1,
                          timecreated INT UNSIGNED NOT NULL,
                          timemodified INT UNSIGNED NOT NULL
) ENGINE=InnoDB;

-- Índice para visibilidad
CREATE INDEX idx_projects_visible ON projects (visible);

-- Tabla: modules
CREATE TABLE modules (
                         id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
                         project_id INT UNSIGNED NOT NULL,
                         ordering INT UNSIGNED NOT NULL,
                         type ENUM(
                             'image_pair',
                             'image_text_left',
                             'image_text_right',
                             'large_image',
                             'large_text',
                             'text_pair'
                             ) NOT NULL,
                         content JSON NOT NULL,
                         visible TINYINT(1) NOT NULL DEFAULT 1,
                         timecreated INT UNSIGNED NOT NULL,
                         timemodified INT UNSIGNED NOT NULL,

                         FOREIGN KEY (project_id) REFERENCES projects(id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- Índice compuesto para búsquedas eficientes
CREATE INDEX idx_modules_project_visible_ordering ON modules (project_id, visible, ordering);
