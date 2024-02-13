SET @user_db = 'user_database';
SET @password_db = 'password_database';
SET @host_db = 'host_database';
SET @version_db = 'version_database';

-- Create databases
CREATE DATABASE IF NOT EXISTS @user_db;
CREATE DATABASE IF NOT EXISTS @password_db;
CREATE DATABASE IF NOT EXISTS @host_db;
CREATE DATABASE IF NOT EXISTS @version_db;

-- Use user database
USE @user_db;

-- Create tables for user database
CREATE TABLE IF NOT EXISTS users (
    id INT PRIMARY KEY,
    username VARCHAR(50),
    email VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS user_logs (
    log_id INT PRIMARY KEY,
    user_id INT,
    log_message VARCHAR(255),
    log_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- Use password database
USE @password_db;

-- Create tables for password database
CREATE TABLE IF NOT EXISTS passwords (
    password_id INT PRIMARY KEY,
    user_id INT,
    password_value VARCHAR(100),
    password_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE IF NOT EXISTS password_history (
    history_id INT PRIMARY KEY,
    password_id INT,
    old_password VARCHAR(100),
    change_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (password_id) REFERENCES passwords(password_id)
);

-- Use host database
USE @host_db;

-- Create tables for host database
CREATE TABLE IF NOT EXISTS hosts (
    host_id INT PRIMARY KEY,
    host_name VARCHAR(50),
    ip_address VARCHAR(15)
);

CREATE TABLE IF NOT EXISTS host_logs (
    log_id INT PRIMARY KEY,
    host_id INT,
    log_message VARCHAR(255),
    log_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (host_id) REFERENCES hosts(host_id)
);

-- Use version database
USE @version_db;

-- Create tables for version database
CREATE TABLE IF NOT EXISTS versions (
    version_id INT PRIMARY KEY,
    version_number VARCHAR(20),
    release_date DATE
);

CREATE TABLE IF NOT EXISTS version_logs (
    log_id INT PRIMARY KEY,
    version_id INT,
    log_message VARCHAR(255),
    log_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (version_id) REFERENCES versions(version_id)
);