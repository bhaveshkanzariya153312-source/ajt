CREATE DATABASE IF NOT EXISTS smart_library
  CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE smart_library;

CREATE TABLE IF NOT EXISTS users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(64) NOT NULL,
    role VARCHAR(20) NOT NULL DEFAULT 'ADMIN',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS books (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(150) NOT NULL,
    author VARCHAR(100) NOT NULL,
    category VARCHAR(80),
    isbn VARCHAR(50) UNIQUE,
    quantity INT NOT NULL DEFAULT 1,
    available INT NOT NULL DEFAULT 1,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_books_title (title),
    INDEX idx_books_author (author),
    INDEX idx_books_category (category),
    INDEX idx_books_isbn (isbn)
);

CREATE TABLE IF NOT EXISTS students (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(120) NOT NULL,
    email VARCHAR(120),
    phone VARCHAR(30),
    course VARCHAR(80),
    password VARCHAR(64) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_students_name (name)
);

CREATE TABLE IF NOT EXISTS issues (
    id INT PRIMARY KEY AUTO_INCREMENT,
    book_id INT NOT NULL,
    student_id INT NOT NULL,
    issue_date DATE NOT NULL,
    due_date DATE NOT NULL,
    return_date DATE NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'ISSUED',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_issue_book FOREIGN KEY (book_id) REFERENCES books(id),
    CONSTRAINT fk_issue_student FOREIGN KEY (student_id) REFERENCES students(id),
    INDEX idx_issue_status (status),
    INDEX idx_issue_student (student_id),
    INDEX idx_issue_due (due_date)
);

-- Demo Admin: admin / admin123
INSERT INTO users(username,password,role)
VALUES ('admin', SHA2('admin123',256), 'ADMIN')
ON DUPLICATE KEY UPDATE password=SHA2('admin123',256), role='ADMIN';

-- The old demo "user" account is not used any more.
DELETE FROM users WHERE username='user';

-- Demo Student: ID 1 / student123
INSERT INTO students(id,name,email,phone,course,password)
SELECT 1,'Demo Student','student@example.com','9876543210','BCA',SHA2('student123',256)
WHERE NOT EXISTS (SELECT 1 FROM students);

-- Keep the demo student's password consistent if the script is run again.
UPDATE students SET password=SHA2('student123',256) WHERE id=1;

INSERT INTO books(title,author,category,isbn,quantity,available)
SELECT 'Java Programming','Herbert Schildt','Programming','9780001',5,5
WHERE NOT EXISTS (SELECT 1 FROM books WHERE isbn='9780001');

INSERT INTO books(title,author,category,isbn,quantity,available)
SELECT 'JSP & Servlets','Marty Hall','Web Technology','9780002',4,4
WHERE NOT EXISTS (SELECT 1 FROM books WHERE isbn='9780002');

INSERT INTO books(title,author,category,isbn,quantity,available)
SELECT 'Database Management','Raghu Ramakrishnan','Database','9780003',6,6
WHERE NOT EXISTS (SELECT 1 FROM books WHERE isbn='9780003');

INSERT INTO books(title,author,category,isbn,quantity,available)
SELECT 'Computer Networks','Andrew Tanenbaum','Networking','9780004',3,3
WHERE NOT EXISTS (SELECT 1 FROM books WHERE isbn='9780004');

INSERT INTO books(title,author,category,isbn,quantity,available)
SELECT 'Software Engineering','Ian Sommerville','Software','9780005',5,5
WHERE NOT EXISTS (SELECT 1 FROM books WHERE isbn='9780005');
