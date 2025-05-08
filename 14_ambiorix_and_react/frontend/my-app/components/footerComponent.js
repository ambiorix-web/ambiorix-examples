import React from "react";
import { Box, Typography, Container } from "@mui/material";

const FooterComponent = ({ testMessage, errorMessage }) => {
  return (
    <Box
      component="footer"
      sx={{
        py: 2,
        backgroundColor: (theme) =>
          theme.palette.mode === 'light' ? theme.palette.grey[200] : theme.palette.grey[800],
        textAlign: 'center',
        width: '100%',
      }}
    >
      <Container maxWidth="lg">
        {errorMessage ? (
          <Typography variant="body1" color="error">
            {errorMessage}
          </Typography>
        ) : (
          <Typography variant="body1">
            Current Time from Server: {testMessage}
          </Typography>
        )}
      </Container>
    </Box>
  );
};

export default FooterComponent;