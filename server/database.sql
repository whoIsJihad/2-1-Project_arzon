CREATE TABLE DEPARTMENTS
(
	DEPARTMENT_CODE INT PRIMARY KEY CHECK(DEPARTMENT_CODE > 0),
	DEPARTMENT_NAME VARCHAR(50) NOT NULL,
	IS_VISIBLE BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE STUDENTS
(
	STUDENT_ID INT PRIMARY KEY,
	FIRST_NAME VARCHAR(50) NOT NULL,
	LAST_NAME VARCHAR(20) NOT NULL,
	PHONE_NUMBER VARCHAR(14) NOT NULL UNIQUE,
	LIBRARY_PASSWORD VARCHAR(32) NOT NULL,
	CURRENT_LEVEL INT CHECK (CURRENT_LEVEL IN (1,2,3,4)),
	CURRENT_TERM INT CHECK (CURRENT_TERM IN (1,2)),
	DEPARTMENT_CODE INT,
    IS_VISIBLE BOOLEAN NOT NULL DEFAULT TRUE,
	FOREIGN KEY(DEPARTMENT_CODE) REFERENCES DEPARTMENTS(DEPARTMENT_CODE)
);

CREATE TABLE TEACHERS
(
	TEACHER_ID INT PRIMARY KEY,
	FIRST_NAME VARCHAR(20) NOT NULL,
	LAST_NAME VARCHAR (20) NOT NULL,
	PHONE_NUMBER VARCHAR (14) UNIQUE,
	LIBRARY_PASSWORD VARCHAR(32) NOT NULL,
	DESIGNATION VARCHAR(30) CHECK (DESIGNATION IN ('Professor','Associate Professor','Assistant Professor','Lecturer')),
	DEPARTMENT_CODE INT,
    IS_VISIBLE BOOLEAN NOT NULL DEFAULT TRUE,
	FOREIGN KEY(DEPARTMENT_CODE) REFERENCES DEPARTMENTS(DEPARTMENT_CODE)
);

CREATE TABLE STAFFS
(
	STAFF_ID INT PRIMARY KEY,
	FIRST_NAME VARCHAR(20) NOT NULL,
	LAST_NAME VARCHAR (20) NOT NULL,
	PHONE_NUMBER VARCHAR(14) NOT NULL UNIQUE,
	LIBRARY_PASSWORD VARCHAR(30) NOT NULL,
    IS_VISIBLE BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE PUBLISHERS
(
	PUBLISHER_ID SERIAL PRIMARY KEY,
	PUBLICATION_NAME VARCHAR (50) NOT NULL,
    IS_VISIBLE BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE AUTHORS
(
	AUTHOR_ID SERIAL PRIMARY KEY,
	AUTHOR_NAME VARCHAR(50) NOT NULL,
    IS_VISIBLE BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE SHELVES
(
	SHELF_ID SERIAL PRIMARY KEY,
	CATEGORY VARCHAR (50) NOT NULL,
	STAFF_ID INT NOT NULL,
	FOREIGN KEY(STAFF_ID) REFERENCES STAFFS(STAFF_ID),
    IS_VISIBLE BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE BOOKS
(
	ISBN VARCHAR(20) PRIMARY KEY,
	TITLE VARCHAR(100) NOT NULL,
	CATEGORY VARCHAR(20) NOT NULL,
	AUTHOR_ID INT NOT NULL,
	PUBLISHER_ID INT NOT NULL,
	SHELF_ID INT,
	FOREIGN KEY(PUBLISHER_ID) REFERENCES PUBLISHERS(PUBLISHER_ID),
	FOREIGN KEY(AUTHOR_ID) REFERENCES AUTHORS(AUTHOR_ID),
	FOREIGN KEY(SHELF_ID) REFERENCES SHELVES(SHELF_ID),
    IS_VISIBLE BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE ACQUISITION
(
	ACQUISITION_TABLE_ID SERIAL PRIMARY KEY,
	ISBN VARCHAR(20) NOT NULL,
	DATE_BOUGHT DATE NOT NULL,
	COPPIES_BOUGHT INT CHECK (COPPIES_BOUGHT > 0),
	FOREIGN KEY(ISBN) REFERENCES BOOKS(ISBN),
    IS_VISIBLE BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE BOOK_AUTHOR_RELATION
(
	ISBN VARCHAR(20),
	AUTHOR_ID INT,
	FOREIGN KEY(ISBN) REFERENCES BOOKS(ISBN),
	FOREIGN KEY(AUTHOR_ID) REFERENCES AUTHORS(AUTHOR_ID),
	PRIMARY KEY(ISBN,AUTHOR_ID),
    IS_VISIBLE BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE STUDENT_BORROW_RELATION
(
	STUDENT_ID INT,
	ISBN VARCHAR(20),
	DATE_BORROWED DATE NOT NULL,
	DATE_RETURNED DATE DEFAULT NULL,
	FOREIGN KEY(STUDENT_ID) REFERENCES STUDENTS(STUDENT_ID),
	FOREIGN KEY(ISBN) REFERENCES BOOKS(ISBN),
	PRIMARY KEY(STUDENT_ID, ISBN),
    IS_VISIBLE BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE TEACHER_BORROW_RELATION
(
	TEACHER_ID INT,
	ISBN VARCHAR(20),
	DATE_BORROWED DATE NOT NULL,
	DATE_RETURNED DATE DEFAULT NULL,
	FOREIGN KEY(TEACHER_ID) REFERENCES TEACHERS(TEACHER_ID),
	FOREIGN KEY(ISBN) REFERENCES BOOKS(ISBN),
	PRIMARY KEY(TEACHER_ID, ISBN),
    IS_VISIBLE BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE STAFF_BORROW_RELATION
(
	STAFF_ID INT,
	ISBN VARCHAR(20),
	DATE_BORROWED DATE NOT NULL,
	DATE_RETURNED DATE DEFAULT NULL,
	FOREIGN KEY(STAFF_ID) REFERENCES STAFFS(STAFF_ID),
	FOREIGN KEY(ISBN) REFERENCES BOOKS(ISBN),
	PRIMARY KEY(STAFF_ID, ISBN),
    IS_VISIBLE BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE FINE_STATE
(
	DAYS INT PRIMARY KEY,
	FINE_AMOUNT INT CHECK (FINE_AMOUNT >= 0),
    IS_VISIBLE BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE USER_RETURN_POLICY
(
	USER_TYPE VARCHAR(15) PRIMARY KEY,
	DAYS INT CHECK (DAYS > 0),
    IS_VISIBLE BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE STUDENT_TRANSITON
(
    STIDENT_TRANSITON_ID SERIAL PRIMARY KEY,
	STUDENT_ID INT NOT NULL,
	PAID INT CHECK (PAID > 0),
	FOREIGN KEY(STUDENT_ID) REFERENCES STUDENTS(STUDENT_ID),
    IS_VISIBLE BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE TEACHER_TRANSITON
(
    TEACHER_TRANSITON_ID SERIAL PRIMARY KEY,
	TEACHER_ID INT NOT NULL,
	PAID INT CHECK (PAID > 0),
	FOREIGN KEY(TEACHER_ID) REFERENCES TEACHERS(TEACHER_ID),
    IS_VISIBLE BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE STAFF_TRANSITON
(
    STAFF_TRANSITON_ID SERIAL PRIMARY KEY,
	STAFF_ID INT NOT NULL,
	PAID INT CHECK (PAID > 0),
	FOREIGN KEY(STAFF_ID) REFERENCES STAFFS(STAFF_ID),
    IS_VISIBLE BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE STUDENT_BOOK_REQUEST_STATUS
(
	REQUEST_ID SERIAL PRIMARY KEY,
	STUDENT_ID INT NOT NULL,
	ISBN VARCHAR(20) NOT NULL,
	REQUEST_STATUS VARCHAR(20) DEFAULT 'Pending' CHECK (REQUEST_STATUS IN ('Pending','Accepted','Rejected')),
	FOREIGN KEY(STUDENT_ID) REFERENCES STUDENTS(STUDENT_ID),
	FOREIGN KEY(ISBN) REFERENCES BOOKS(ISBN),
	IS_VISIBLE BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE TEACHER_BOOK_REQUEST_STATUS
(
	REQUEST_ID SERIAL PRIMARY KEY,
	TEACHER_ID INT NOT NULL,
	ISBN VARCHAR(20) NOT NULL,
	REQUEST_STATUS VARCHAR(20) DEFAULT 'Pending' CHECK (REQUEST_STATUS IN ('Pending','Accepted','Rejected')),
	FOREIGN KEY(TEACHER_ID) REFERENCES TEACHERS(TEACHER_ID),
	FOREIGN KEY(ISBN) REFERENCES BOOKS(ISBN),
	IS_VISIBLE BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE STAFF_BOOK_REQUEST_STATUS
(
	REQUEST_ID SERIAL PRIMARY KEY,
	STAFF_ID INT NOT NULL,
	ISBN VARCHAR(20) NOT NULL,
	REQUEST_STATUS VARCHAR(20) DEFAULT 'Pending' CHECK (REQUEST_STATUS IN ('Pending','Accepted','Rejected')),
	FOREIGN KEY(STAFF_ID) REFERENCES STAFFS(STAFF_ID),
	FOREIGN KEY(ISBN) REFERENCES BOOKS(ISBN),
	IS_VISIBLE BOOLEAN NOT NULL DEFAULT TRUE
);