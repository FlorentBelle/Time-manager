INSERT INTO roles (id, role_name, inserted_at, updated_at, "isAuthoriseAdmin", "isAuthoriseManager")
VALUES (1, 'User', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, false, false);
INSERT INTO roles (id, role_name, inserted_at, updated_at, "isAuthoriseAdmin", "isAuthoriseManager")
VALUES (2, 'Manager', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, false, true);
INSERT INTO roles (id, role_name, inserted_at, updated_at, "isAuthoriseAdmin", "isAuthoriseManager")
VALUES (3, 'Admin', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, true, true);