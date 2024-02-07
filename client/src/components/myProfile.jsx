import React, { Fragment, useEffect, useState } from "react";
import { useParams } from "react-router-dom";

const MyProfile = () => {
  const [user, setUser] = useState([]);
  const [shelves, setShelves] = useState([]);
  const { id } = useParams();

  const getInfo = async () => {
    try {
      const response = await fetch(`http://localhost:5000/myProfile/${id}`);
      const jsonData = await response.json();
      setUser(jsonData[0]);
      setShelves(jsonData);
    } catch (err) {
      console.error("Failed to fetch user details");
    }
  };

  useEffect(() => {
    getInfo();
  }, []);

  return (
    <Fragment>
      <div className="book-details-container">
        <h1 className="text-center head-color mb-5" style={{ fontSize: '50px' }}>My Profile</h1>
        <table className="table mx-auto">
          <tbody>
            <tr className="text-center">
              <td className="head-color">ID</td>
              <td className="table-row-2">{user.staff_id}</td>
            </tr>
            <tr className="text-center">
              <td className="head-color">First Name</td>
              
              <td className="table-row-2">{user.name}</td>
            </tr>
            <tr className="text-center mt-3">
              <td className="head-color">Phone Number</td>
              
              <td className="table-row-2">{user.phone_number}</td>
            </tr>
            <tr className="text-center mt-3">
              <td className="head-color">Shelves Managed</td>
              
              <td className="table-row-2">
                <ul className="author-list">
                  {shelves.map(shelf => (
                    <li key={shelf.shelf_id}>Shelf ID - {shelf.shelf_id} ({shelf.category})</li>
                  ))}
                </ul>
              </td>
            </tr>
          </tbody>
        </table>
      </div>
    </Fragment>
  );
}

export default MyProfile;