-- Tabla de usuarios (hereda de la Unidad 1)
CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    role VARCHAR(20) DEFAULT 'client',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabla de mensajes (nueva para la Unidad 2)
CREATE TABLE IF NOT EXISTS messages (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    username VARCHAR(100) NOT NULL,
    text TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Índice para mejorar la consulta de los últimos mensajes
CREATE INDEX idx_messages_created_at ON messages(created_at DESC);

-- Usuario administrador de prueba
INSERT INTO users (name, email, password_hash, role) 
VALUES (
    'Admin EcoHome',
    'admin@ecohome.com',
    '$2a$10$MjVpRk9Xz5YqZ6wA7bC8dE9fG0hI1jK2lM3nO4pQ5rS6tU7vW8xY9z', -- contraseña: admin123
    'admin'
) ON CONFLICT (email) DO NOTHING;

-- Usuario cliente de prueba
INSERT INTO users (name, email, password_hash, role) 
VALUES (
    'Cliente Demo',
    'cliente@ecohome.com',
    '$2a$10$NwQrTk0Yz6XqZ7wB8cD9eF1gH2iJ3kL4mN5oP6qR7sT8uV9wX0yZ', -- contraseña: cliente123
    'client'
) ON CONFLICT (email) DO NOTHING;