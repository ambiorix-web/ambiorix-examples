// src/UserTableComponent.js

import React from "react";
import { AgGridReact } from "ag-grid-react";
import "ag-grid-community/styles/ag-grid.css";
import "ag-grid-community/styles/ag-theme-quartz.css";

const UserTableComponent = ({ rowData }) => {
  const columnDefs = [
    { field: "name", headerName: "User Name" },
    { field: "registered_date", headerName: "Registered Date" },
    { field: "created_at", headerName: "Creation Date" },
    { field: "phone_number", headerName: "Phone Number" },
  ];

  return (
    <div className="ag-theme-quartz" style={{ height: "350px", width: "100%" }}>
    <h3> Last Added User in DB</h3>
      <AgGridReact
        rowData={rowData}
        columnDefs={columnDefs}
        pagination={true}
        paginationPageSize={10}
      />
    </div>
  );
};

export default UserTableComponent;
