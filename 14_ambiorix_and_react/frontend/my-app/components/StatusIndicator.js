// src/StatusIndicator.js

import React, { useEffect, useState } from 'react';
import axios from 'axios';

const StatusIndicator = ({ backendUrl }) => {
  const [isAlive, setIsAlive] = useState(null);

  const checkBackendStatus = async () => {
    try {
      const response = await axios.get(backendUrl);
      if (response.status === 200 && response.data.message === 'ok') {
        setIsAlive(true);
      } else {
        setIsAlive(false);
      }
    } catch (error) {
      setIsAlive(false);
    }
  };

  useEffect(() => {
    checkBackendStatus();
    const interval = setInterval(checkBackendStatus, 5000); 
    return () => clearInterval(interval);
  }, [backendUrl]);

  return (
    <div style={{ display: 'flex', alignItems: 'center' }}>
    <span style={{ fontSize: '14px' , marginRight: '8px' }}>
        <b>Server Status :</b> {isAlive === null ? 'Checking...' : isAlive ? 'Online' : 'Offline'}
      </span>
      <div
        style={{
          height: '12px',
          width: '12px',
          borderRadius: '50%',
          backgroundColor: isAlive === null ? 'gray' : isAlive ? 'limegreen' : 'red',
          marginRight: '8px',
        }}
      ></div>
      
    </div>
  );
};

export default StatusIndicator;

