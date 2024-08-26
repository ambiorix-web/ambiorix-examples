import React, { useState } from "react";
import {
  IconButton,
  Dialog,
  DialogTitle,
  DialogContent,
  DialogActions,
  Typography,
} from "@mui/material";
import InfoIcon from "@mui/icons-material/Info";

const AppInfoComponent = () => {
  const [open, setOpen] = useState(false);

  const handleOpen = () => setOpen(true);
  const handleClose = () => setOpen(false);

  return (
    <>
      <IconButton color="inherit" onClick={handleOpen}>
        <InfoIcon />
      </IconButton>

      <Dialog open={open} onClose={handleClose}>
        <DialogTitle>App Info</DialogTitle>
        <DialogContent>
          <Typography variant="body1" gutterBottom>
            This app:
          </Typography>
          <ul>
            <li>
              <Typography variant="body1" gutterBottom>
                Fetches random user data from the{" "}
                <a
                  href="https://randomuser.me/api/"
                  target="_blank"
                  rel="noopener noreferrer"
                >
                  Random User API
                </a>
              </Typography>
            </li>
            <li>
              <Typography variant="body1" gutterBottom>
                Displays user statistics and visualizations
              </Typography>
            </li>
            <li>
              <Typography variant="body1" gutterBottom>
                Updates data every 10 seconds
              </Typography>
            </li>
          </ul>
          <Typography variant="body1" gutterBottom>
            Technologies used:
          </Typography>
          <ul>
            <li>
              <Typography variant="body1" gutterBottom>
                Backend: R with Ambiorix framework
              </Typography>
            </li>
            <li>
              <Typography variant="body1" gutterBottom>
                Frontend: React.js with Material-UI
              </Typography>
            </li>
            <li>
              <Typography variant="body1" gutterBottom>
                Database: PostgreSQL
              </Typography>
            </li>
          </ul>
          <Typography variant="body1" gutterBottom>
            Server status is checked every 5 second.
          </Typography>
        </DialogContent>
        <DialogActions>
          <IconButton onClick={handleClose}>Close</IconButton>
        </DialogActions>
      </Dialog>
    </>
  );
};

export default AppInfoComponent;
