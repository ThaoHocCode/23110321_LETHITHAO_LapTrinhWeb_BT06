-- Tạo database nếu chưa có
USE master;
GO

IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'jpast56')
BEGIN
    CREATE DATABASE jpast56;
END
GO

USE jpast56;
GO

-- Tạo bảng categories
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='categories' and xtype='U')
BEGIN
    CREATE TABLE categories (
        id INT IDENTITY(1,1) PRIMARY KEY,
        categoryName NVARCHAR(255) NOT NULL,
        images NVARCHAR(MAX),
        status INT DEFAULT 1
    );
END
GO

-- Tạo bảng users  
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='users' and xtype='U')
BEGIN
    CREATE TABLE users (
        id INT IDENTITY(1,1) PRIMARY KEY,
        username NVARCHAR(255) UNIQUE NOT NULL,
        password NVARCHAR(255) NOT NULL,
        email NVARCHAR(255),
        fullname NVARCHAR(255),
        phone NVARCHAR(20),
        images NVARCHAR(MAX),
        roleid INT DEFAULT 2,
        createDate DATE DEFAULT GETDATE(),
        active INT DEFAULT 1
    );
END
GO

-- Tạo bảng videos
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='videos' and xtype='U')
BEGIN
    CREATE TABLE videos (
        id INT IDENTITY(1,1) PRIMARY KEY,
        title NVARCHAR(255) NOT NULL,
        description NVARCHAR(MAX),
        poster NVARCHAR(MAX),
        views INT DEFAULT 0,
        active INT DEFAULT 1,
        categoryId INT,
        FOREIGN KEY (categoryId) REFERENCES categories(id)
    );
END
GO

-- Thêm dữ liệu mẫu cho categories
IF NOT EXISTS (SELECT * FROM categories)
BEGIN
    INSERT INTO categories (categoryName, images, status) VALUES
    (N'Công nghệ', 'https://via.placeholder.com/300x200', 1),
    (N'Giáo dục', 'https://via.placeholder.com/300x200', 1),
    (N'Giải trí', 'https://via.placeholder.com/300x200', 1),
    (N'Thể thao', 'https://via.placeholder.com/300x200', 1),
    (N'Âm nhạc', 'https://via.placeholder.com/300x200', 1);
END
GO

-- Thêm dữ liệu mẫu cho users
IF NOT EXISTS (SELECT * FROM users)
BEGIN
    INSERT INTO users (username, password, email, fullname, phone, roleid, active) VALUES
    ('admin', '123456', 'admin@example.com', N'Quản trị viên', '0123456789', 1, 1),
    ('user1', '123456', 'user1@example.com', N'Người dùng 1', '0987654321', 2, 1),
    ('user2', '123456', 'user2@example.com', N'Người dùng 2', '0912345678', 2, 1);
END
GO

-- Thêm dữ liệu mẫu cho videos
IF NOT EXISTS (SELECT * FROM videos)
BEGIN
    INSERT INTO videos (title, description, poster, views, active, categoryId) VALUES
    (N'Video về Spring Boot', N'Hướng dẫn lập trình Spring Boot cơ bản', 'https://via.placeholder.com/400x300', 150, 1, 1),
    (N'Khóa học Java', N'Khóa học Java từ cơ bản đến nâng cao', 'https://via.placeholder.com/400x300', 200, 1, 2),
    (N'Nhạc thư giãn', N'Playlist nhạc thư giãn cho lập trình viên', 'https://via.placeholder.com/400x300', 75, 1, 5);
END
GO

PRINT 'Database và tables đã được tạo thành công!';
GO

