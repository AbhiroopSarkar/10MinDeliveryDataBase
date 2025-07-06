-- 1. CREATE SQL SERVER LOGINS WITH PASSWORDS
CREATE LOGIN adminLogin WITH PASSWORD = 'admin@123';
CREATE LOGIN vendorLogin WITH PASSWORD = 'vendor@123';

-- 2. MAP LOGIN TO DATABASE USERS
USE [10MinDB];

CREATE USER admin_user FOR LOGIN adminLogin;
CREATE USER vendor_user FOR LOGIN vendorLogin;


-- 3. CREATE ROLES
CREATE ROLE AdminRole;
CREATE ROLE VendorRole;

-- 4. ASSIGN USERS TO ROLES
ALTER ROLE AdminRole ADD MEMBER admin_user;
EXEC sp_addrolemember 'VendorRole', 'vendor_user';

-- 5. GRANT / REVOKE PERMISSIONS TO ROLES
GRANT SELECT, INSERT, UPDATE, DELETE ON Users TO AdminRole;
GRANT SELECT, UPDATE ON Products TO AdminRole;
GRANT SELECT, UPDATE ON Inventory TO VendorRole;
