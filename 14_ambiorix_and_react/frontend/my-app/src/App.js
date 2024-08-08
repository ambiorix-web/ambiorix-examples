// src/App.js
import React, { useEffect, useState } from "react";
import axios from "axios";
import BarChartComponent from "./BarChartComponent";
import UserTableComponent from "./UserTableComponent";
import MapComponent from "./userLocationComponent";
import Layout from "./Layout";
import FooterComponent from "./footerComponent";
import DonutComponent from "./donutChart";
import StatusIndicator from "./StatusIndicator";

import {
  Grid,
  Typography,
  Paper,
  Box,
  Container,
  MenuItem,
  Select,
  FormControl,
  InputLabel,
} from "@mui/material";

function App() {
  const [testMessage, setTestMessage] = useState("");
  const [errorMessage, setErrorMessage] = useState(null);
  const [rowData, setRowData] = useState([]);
  const [userCount, setBarData] = useState([]);
  const [userGenderCount, setGenderCountData] = useState([]);
  const [countryData, setCountryData] = useState([]);
  const [selectedYear, setSelectedYear] = useState(new Date().getFullYear());
  const backendUrl = "http://127.0.0.1:1000/api/status";

  useEffect(() => {
    fetchUsers();
    fetchTest();
    getUserCountPerYear();
    getUserCountryData();
    getGenderCountPerYear(selectedYear);
    const interval1 = setInterval(fetchUsers, 10000);
    const interval2 = setInterval(fetchTest, 1000);
    const interval3 = setInterval(getUserCountPerYear, 10000);
    const interval4 = setInterval(getUserCountryData, 600000);
    const interval5 = setInterval(
      () => getGenderCountPerYear(selectedYear),
      10000
    );

    return () => {
      clearInterval(interval1);
      clearInterval(interval2);
      clearInterval(interval3);
      clearInterval(interval4);
      clearInterval(interval5);
    };
  }, [selectedYear]);

  const fetchUsers = async () => {
    try {
      console.log("Fetching users");
      const response = await axios.get("http://127.0.0.1:1000/api/users");
      console.log("Response:", response);

      const data = response.data;
      setRowData(data);
    } catch (error) {
      console.error("Error fetching users:", error);
      setErrorMessage("Error fetching users. Please try again later.");
    }
  };

  const getUserCountPerYear = async () => {
    try {
      console.log("Fetching user count per year");
      const response = await axios.get("http://127.0.0.1:1000/api/user-count");
      console.log("Response:", response);
      setBarData(response.data);
    } catch (error) {
      console.error("Error fetching user count:", error);
      setErrorMessage("Error fetching user count. Please try again later.");
    }
  };

  const getUserCountryData = async () => {
    try {
      console.log("Fetching user country data");
      const response = await axios.get(
        "http://127.0.0.1:1000/api/user-location"
      );
      console.log("Response:", response);
      setCountryData(response.data);
    } catch (error) {
      console.error("Error fetching user country data:", error);
      setErrorMessage(
        "Error fetching user country data. Please try again later."
      );
    }
  };

  const fetchTest = async () => {
    try {
      const response = await axios.get("http://127.0.0.1:1000/api/test");

      setTestMessage(response.data);

      setErrorMessage(null);
    } catch (error) {
      console.error("Error fetching test message:", error);
      setErrorMessage("Error fetching test message. Please try again later.");
    }
  };

  const getGenderCountPerYear = async (year) => {
    try {
      const response = await axios.get(
        `http://127.0.0.1:1000/api/user-gender-count/${year}`
      );
      setGenderCountData(response.data);
    } catch (error) {
      console.error("Error fetching gender count:", error);
      setErrorMessage("Error fetching gender count. Please try again later.");
    }
  };

  return (
    <>
      <Layout>
        <Container maxWidth="lg">
          <Grid container spacing={3}>
            <Grid item xs={12}>
              <Typography variant="h6" gutterBottom>
                <StatusIndicator backendUrl={backendUrl} />
              </Typography>
            </Grid>
            <Grid item xs={12}>
              <Paper elevation={3} style={{ padding: "20px" }}>
                <BarChartComponent userCount={userCount} />
              </Paper>
            </Grid>
            <Grid item xs={12}>
              <Paper elevation={3} style={{ padding: "20px" }}>
                <Typography variant="h6" gutterBottom>
                  User Registration By Country
                </Typography>
                <div style={{ height: "400px", width: "100%" }}>
                  <MapComponent countryData={countryData} />
                </div>
              </Paper>
            </Grid>
            <Grid item xs={12}>
              <Paper
                elevation={3}
                style={{ padding: "20px", height: "400px", overflow: "auto" }}
              >
                <UserTableComponent rowData={rowData} />
              </Paper>
            </Grid>
            <Grid item xs={12}>
              <Paper elevation={3} style={{ padding: "20px" }}>
                <FormControl fullWidth>
                  <InputLabel>Year</InputLabel>
                  <Select
                    value={selectedYear}
                    onChange={(e) => setSelectedYear(e.target.value)}
                  >
                    {Array.from(
                      { length: 20 },
                      (_, i) => new Date().getFullYear() - i
                    ).map((year) => (
                      <MenuItem key={year} value={year}>
                        {year}
                      </MenuItem>
                    ))}
                  </Select>
                </FormControl>
                <DonutComponent userGenderCount={userGenderCount} />
              </Paper>
            </Grid>
          </Grid>
        </Container>
      </Layout>
      <Box mt={3}>
        <FooterComponent
          testMessage={testMessage}
          errorMessage={errorMessage}
        />
      </Box>
    </>
  );
}

export default App;
