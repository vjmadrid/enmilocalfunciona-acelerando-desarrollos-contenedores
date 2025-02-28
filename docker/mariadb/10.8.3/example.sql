-- MariaDB script

-- Drop the database if it exists
DROP DATABASE IF EXISTS acme;

-- Create the database
CREATE DATABASE acme;

-- Use the database
USE acme;

-- Table 'UserData'
DROP TABLE IF EXISTS UserData;

CREATE TABLE UserData (
    id CHAR(36) NOT NULL PRIMARY KEY,
    data VARCHAR(160) NOT NULL
);