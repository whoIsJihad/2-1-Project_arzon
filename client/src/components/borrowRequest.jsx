import React, { Fragment, useEffect, useState } from "react";
import { Link, useParams } from "react-router-dom";

const BorrowRequests = () => {
    const [students, setStudents] = useState([]);
    const [teachers, setTeachers] = useState([]);
    const [staffs, setStaffs] = useState([]);
    const [selectedOption, setSelectedOption] = useState('students');

    const fetchData = async () => {
        switch (selectedOption) {
            case 'students':
                await getStudents();
                break;
            case 'teachers':
                await getTeachers();
                break;
            case 'staffs':
                await getStaffs();
                break;
            default:
                break;
        }
    };

    const getStudents = async () => {
        try {
            const user = await fetch("http://localhost:5000/getID", { method: "GET", headers: { token: localStorage.token, "Content-Type": "application/json" } });
            const user_id = await user.json();
            const response = await fetch(`http://localhost:5000/studentborrowRequests/${user_id}`);
            const jsonData = await response.json();
            setStudents(jsonData);
        } catch (err) {
            console.error(err.message);
        }
    }

    const getTeachers = async () => {
        try {
            const user = await fetch("http://localhost:5000/getID", { method: "GET", headers: { token: localStorage.token, "Content-Type": "application/json" } });
            const user_id = await user.json();
            const response = await fetch(`http://localhost:5000/teacherborrowRequests/${user_id}`);
            const jsonData = await response.json();
            setTeachers(jsonData);
        } catch (err) {
            console.error(err.message);
        }
    }

    const getStaffs = async () => {
        try {
            const user = await fetch("http://localhost:5000/getID", { method: "GET", headers: { token: localStorage.token, "Content-Type": "application/json" } });
            const user_id = await user.json();
            const response = await fetch(`http://localhost:5000/staffborrowRequests/${user_id}`);
            const jsonData = await response.json();
            setStaffs(jsonData);
        } catch (err) {
            console.error(err.message);
        }
    }

    const formatDate = (dateString) => {
        const options = { year: 'numeric', month: 'long', day: 'numeric' };
        const formattedDate = new Date(dateString).toLocaleDateString(undefined, options);
        return formattedDate;
    };

    const handleAcceptClick = (requestId) => {
        console.log(`Accept request with ID: ${requestId}`);
    };

    const handleDenyClick = (requestId) => {
        console.log(`Deny request with ID: ${requestId}`);
    };

    useEffect(() => {
        fetchData();
    }, [selectedOption]);

    return (
        <Fragment>
            <h1 className="text-center head-color mb-5 fixed-header">Borrow Requests</h1>
            <h1 className="text-center mb-5" style={{ color: "white" }}>BIBLIOPHILE</h1>
            <div>
                <button style={{ width: '33%', border: '1px solid grey' }} onClick={() => setSelectedOption('students')}>
                    Student
                </button>
                <button style={{ width: '33%', border: '1px solid grey' }} onClick={() => setSelectedOption('teachers')}>
                    Teacher
                </button>
                <button style={{ width: '33%', border: '1px solid grey' }} onClick={() => setSelectedOption('staffs')}>
                    Staff
                </button>
            </div>
            <div className="boxes-container mt-5">
                {selectedOption === 'students' && students.map((student, index) => (
                    <div key={index} className="box">
                        <span className="option-text">
                            Name :
                            <Link to={`/studentProfile/${student.student_id}`} className="option-link">
                                {student.name}
                            </Link>
                        </span>
                        <span className="option-text">
                            Book:
                            <Link to={`/showBookDetails/${student.book_id}`} className="option-button">
                                {student.title}
                            </Link>
                        </span>
                        <span className="option-text">
                            Date: {formatDate(student.date_borrowed)}
                        </span>
                        <div className="buttons-container mt-2">
                            <button
                                className="btn accept-button mr-3"
                                onClick={() => handleAcceptClick(student.request_id)}
                            >
                                Accept
                            </button>
                            <button
                                className="btn deny-button"
                                onClick={() => handleDenyClick(student.request_id)}
                            >
                                Deny
                            </button>
                        </div>
                        <p> </p>
                        <p>
                            {student.request_status}...
                        </p>
                    </div>
                ))}

                {selectedOption === 'teachers' && teachers.map((teacher, index) => (
                    <div key={index} className="box">
                        <span className="option-text">
                            Name :
                            <Link to={`/showStudentDetails/${teacher.teacher_id}`} className="option-link">
                                {teacher.name}
                            </Link>
                        </span>
                        <span className="option-text">
                            Book:
                            <Link to={`/showBookDetails/${teacher.book_id}`} className="option-button">
                                {teacher.title}
                            </Link>
                        </span>
                        <span className="option-text">
                            Date: {formatDate(teacher.date_borrowed)}
                        </span>
                        <div className="buttons-container mt-2">
                            <button
                                className="btn accept-button mr-3"
                                onClick={() => handleAcceptClick(teacher.request_id)}
                            >
                                Accept
                            </button>
                            <button
                                className="btn deny-button"
                                onClick={() => handleDenyClick(teacher.request_id)}
                            >
                                Deny
                            </button>
                        </div>
                        <p> </p>
                        <p>
                            {teacher.request_status}...
                        </p>
                    </div>
                ))}

                {selectedOption === 'staffs' && staffs.map((staff, index) => (
                    <div key={index} className="box">
                        <span className="option-text">
                            Name :
                            <Link to={`/staffProfile/${staff.staff_id}`} className="option-link">
                                {staff.name}
                            </Link>
                        </span>
                        <span className="option-text">
                            Book:
                            <Link to={`/showBookDetails/${staff.book_id}`} className="option-button">
                                {staff.title}
                            </Link>
                        </span>
                        <span className="option-text">
                            Date: {formatDate(staff.date_borrowed)}
                        </span>
                        <div className="buttons-container mt-2">
                            <button
                                className="btn accept-button mr-3"
                                onClick={() => handleAcceptClick(staff.request_id)}
                            >
                                Accept
                            </button>
                            <button
                                className="btn deny-button"
                                onClick={() => handleDenyClick(staff.request_id)}
                            >
                                Deny
                            </button>
                        </div>
                        <p> </p>
                        <p>
                            {staff.request_status}...
                        </p>
                    </div>
                ))}
            </div>
        </Fragment>
    );
};

export default BorrowRequests;
