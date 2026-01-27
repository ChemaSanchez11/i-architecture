CREATE TABLE config (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    value TEXT NOT NULL,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

INSERT INTO `i-architecture`.`config` (`id`, `name`, `value`, `updated_at`) VALUES (1, 'img_about', 'about.jpg', '2026-01-27 21:52:01');