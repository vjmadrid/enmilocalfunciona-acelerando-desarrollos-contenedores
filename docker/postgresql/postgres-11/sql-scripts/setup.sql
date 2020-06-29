-- Create tables
DROP TABLE IF EXISTS custom_role;
CREATE TABLE IF NOT EXISTS custom_role (
    id BIGSERIAL PRIMARY KEY,
    name varchar(15) NOT NULL DEFAULT '',
    created_at timestamp NULL DEFAULT NULL,
    updated_at timestamp NULL DEFAULT NULL,
    deleted_at timestamp NULL DEFAULT NULL
);

DROP TABLE IF EXISTS custom_user;
CREATE TABLE IF NOT EXISTS custom_user (
    id BIGSERIAL PRIMARY KEY,
    name varchar(15) NOT NULL DEFAULT '',
    role_id BIGINT REFERENCES custom_role(id),
    created_at timestamp NULL DEFAULT NULL,
    updated_at timestamp NULL DEFAULT NULL,
    deleted_at timestamp NULL DEFAULT NULL
);

-- Insert data
INSERT INTO custom_role (name, created_at, updated_at, deleted_at) VALUES ('ADMIN', NOW(),null, null);
INSERT INTO custom_role (name, created_at, updated_at, deleted_at) VALUES ('OPERATOR', NOW(),null, null);
INSERT INTO custom_role (name, created_at, updated_at, deleted_at) VALUES ('VIEWER', NOW(),null, null);

INSERT INTO custom_user (name,  role_id, created_at, updated_at, deleted_at) VALUES ('admin', 1, NOW(),null, null);
INSERT INTO custom_user (name,  role_id, created_at, updated_at, deleted_at) VALUES ('opera1', 2, NOW(),null, null);
INSERT INTO custom_user (name,  role_id, created_at, updated_at, deleted_at) VALUES ('opera2', 2, NOW(),null, null);
INSERT INTO custom_user (name,  role_id, created_at, updated_at, deleted_at) VALUES ('viewer', 3, NOW(),null, null);
