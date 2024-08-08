// src/Layout.js

import React from 'react';
import { AppBar, Toolbar, Typography, Container, Box } from '@mui/material';
import AppInfoComponent from './AppInfoComponent';

const Layout = ({ children }) => {
  return (
    <>
      <AppBar position="static">
        <Toolbar>
          <Typography variant="h6" sx={{ flexGrow: 1 }}>
            Random User Info Analyser
          </Typography>
          <AppInfoComponent />
        </Toolbar>
      </AppBar>
      <Container maxWidth="lg">
        <Box mt={3}>{children}</Box>
      </Container>
    </>
  );
};

export default Layout;
