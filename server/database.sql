CREATE TABLE DEPARTMENTS
(
	DEPARTMENT_CODE INT PRIMARY KEY CHECK(DEPARTMENT_CODE > 0),
	DEPARTMENT_NAME VARCHAR(50) NOT NULL,
	IS_VISIBLE BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE CATEGORIES
(
	CATEGORY VARCHAR(50) PRIMARY KEY,
	IS_VISIBLE BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE USER_TYPE
(
    USER_TYPE VARCHAR(15) PRIMARY KEY,
    IS_VISIBLE BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE TEACHER_DESIGNATION
(
    DESIGNATION VARCHAR(30) PRIMARY KEY,
    IS_VISIBLE BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE LEVELS
(
    LEVEL_NO INT PRIMARY KEY,
    IS_VISIBLE BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE TERMS
(
    TERM_NO INT PRIMARY KEY,
    IS_VISIBLE BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE USERS
(
    USER_ID INT PRIMARY KEY,
    FIRST_NAME VARCHAR(50) NOT NULL,
    LAST_NAME VARCHAR(50) NOT NULL,
    PHONE_NUMBER VARCHAR(14) NOT NULL UNIQUE,
    LIBRARY_PASSWORD VARCHAR(32) NOT NULL,
    USER_TYPE VARCHAR(15) ,
    FOREIGN KEY(USER_TYPE) REFERENCES USER_TYPE(USER_TYPE)
);

CREATE TABLE STUDENTS
(
	STUDENT_ID INT PRIMARY KEY,
	CURRENT_LEVEL INT ,
	CURRENT_TERM INT ,
	DEPARTMENT_CODE INT,
    IS_VISIBLE BOOLEAN NOT NULL DEFAULT TRUE,
    FOREIGN KEY (STUDENT_ID) REFERENCES USERS(USER_ID),
    FOREIGN KEY(CURRENT_LEVEL) REFERENCES LEVELS(LEVEL_NO),
    FOREIGN KEY(CURRENT_TERM) REFERENCES TERMS(TERM_NO),
	FOREIGN KEY(DEPARTMENT_CODE) REFERENCES DEPARTMENTS(DEPARTMENT_CODE)
);

CREATE TABLE TEACHERS
(
	TEACHER_ID INT PRIMARY KEY,
	DESIGNATION VARCHAR(30),
	DEPARTMENT_CODE INT,
    IS_VISIBLE BOOLEAN NOT NULL DEFAULT TRUE,
    FOREIGN KEY (TEACHER_ID) REFERENCES USERS(USER_ID),
    FOREIGN KEY(DESIGNATION) REFERENCES TEACHER_DESIGNATION(DESIGNATION),
	FOREIGN KEY(DEPARTMENT_CODE) REFERENCES DEPARTMENTS(DEPARTMENT_CODE)
);

CREATE TABLE STAFFS
(
	STAFF_ID INT PRIMARY KEY,
    IS_VISIBLE BOOLEAN NOT NULL DEFAULT TRUE,
    FOREIGN KEY (STAFF_ID) REFERENCES USERS(USER_ID)
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
	FOREIGN KEY(CATEGORY) REFERENCES CATEGORIES(CATEGORY),
    IS_VISIBLE BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE BOOKS
(
	BOOK_ID SERIAL PRIMARY KEY,
	TITLE VARCHAR(100) NOT NULL,
	CATEGORY VARCHAR(50) NOT NULL,
	PUBLISHER_ID INT NOT NULL,
	SHELF_ID INT,
	FOREIGN KEY(PUBLISHER_ID) REFERENCES PUBLISHERS(PUBLISHER_ID),
	FOREIGN KEY(SHELF_ID) REFERENCES SHELVES(SHELF_ID),
	FOREIGN KEY(CATEGORY) REFERENCES CATEGORIES(CATEGORY),
    IS_VISIBLE BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE ACQUISITION
(
	ACQUISITION_TABLE_ID SERIAL PRIMARY KEY,
	BOOK_ID INT NOT NULL CHECK (BOOK_ID > 0),
	DATE_BOUGHT DATE NOT NULL,
	COPIES_BOUGHT INT CHECK (COPIES_BOUGHT > 0),
	FOREIGN KEY(BOOK_ID) REFERENCES BOOKS(BOOK_ID),
    IS_VISIBLE BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE BOOK_AUTHOR_RELATION
(
	BOOK_ID INT NOT NULL CHECK (BOOK_ID > 0),
	AUTHOR_ID INT,
	FOREIGN KEY(BOOK_ID) REFERENCES BOOKS(BOOK_ID),
	FOREIGN KEY(AUTHOR_ID) REFERENCES AUTHORS(AUTHOR_ID),
	PRIMARY KEY(BOOK_ID,AUTHOR_ID),
    IS_VISIBLE BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE USER_BORROW_RELATION
(
	USER_ID INT,
	BOOK_ID INT NOT NULL CHECK (BOOK_ID > 0),
	DATE_APPROVED DATE DEFAULT NULL,
	DATE_RETURNED DATE DEFAULT NULL,
	FOREIGN KEY(USER_ID) REFERENCES USERS(USER_ID),
	FOREIGN KEY(BOOK_ID) REFERENCES BOOKS(BOOK_ID),
	PRIMARY KEY(USER_ID, BOOK_ID),
    IS_VISIBLE BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE FINE_STATE
(
	DAYS INT PRIMARY KEY,
	FINE_AMOUNT INT CHECK (FINE_AMOUNT > 0),
    IS_VISIBLE BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE USER_RETURN_POLICY
(
	USER_TYPE VARCHAR(15) PRIMARY KEY,
	DAYS INT CHECK (DAYS > 0),
    IS_VISIBLE BOOLEAN NOT NULL DEFAULT TRUE,
    FOREIGN KEY(USER_TYPE) REFERENCES USER_TYPE(USER_TYPE)
);

CREATE TABLE USER_TRANSACTON
(
    USER_TRANSACTON_ID SERIAL PRIMARY KEY,
	USER_ID INT NOT NULL,
	PAID INT CHECK (PAID >= 0),
	FOREIGN KEY(USER_ID) REFERENCES USERS(USER_ID),
    IS_VISIBLE BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE CART
(
	USER_ID INT NOT NULL,
	BOOK_ID INT NOT NULL CHECK (BOOK_ID > 0),
	FOREIGN KEY(USER_ID) REFERENCES USERS(USER_ID),
	FOREIGN KEY(BOOK_ID) REFERENCES BOOKS(BOOK_ID),
	PRIMARY KEY(USER_ID, BOOK_ID),
	IS_VISIBLE BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE USER_REQUEST
(
	USER_REQUEST_ID SERIAL PRIMARY KEY,
	USER_ID INT NOT NULL,
	REQUEST_DATE DATE NOT NULL,
	FOREIGN KEY(USER_ID) REFERENCES USERS(USER_ID),
	IS_VISIBLE BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE REQUEST_BOOK_RELATION
(
	USER_REQUEST_ID INT NOT NULL,
	BOOK_ID INT NOT NULL,
	REQUEST_STATUS VARCHAR(20) DEFAULT 'Pending' CHECK (REQUEST_STATUS IN ('Pending','Accepted','Rejected')),
	FOREIGN KEY(USER_REQUEST_ID) REFERENCES USER_REQUEST(USER_REQUEST_ID),
	FOREIGN KEY(BOOK_ID) REFERENCES BOOKS(BOOK_ID),
	PRIMARY KEY(USER_REQUEST_ID, BOOK_ID),
	IS_VISIBLE BOOLEAN NOT NULL DEFAULT TRUE
);