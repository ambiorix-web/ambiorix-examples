// src/userLocationComponent.js

import React from 'react';
import { MapContainer, TileLayer, Marker, Popup } from 'react-leaflet';
import L from 'leaflet';
import 'leaflet/dist/leaflet.css';

// Fix for default marker icon issue in React-Leaflet
delete L.Icon.Default.prototype._getIconUrl;

L.Icon.Default.mergeOptions({
  iconRetinaUrl: 'https://unpkg.com/leaflet@1.7.1/dist/images/marker-icon-2x.png',
  iconUrl: 'https://unpkg.com/leaflet@1.7.1/dist/images/marker-icon.png',
  shadowUrl: 'https://unpkg.com/leaflet@1.7.1/dist/images/marker-shadow.png',
});

const MapComponent = ({ countryData }) => {
  return (
    <MapContainer style={{ height: '100%', width: '100%' }} center={[51.505, -0.09]} zoom={2}>
      <TileLayer
        url="https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png"
        attribution='&copy; <a href="https://osm.org/copyright">OpenStreetMap</a> contributors'
      />
      {countryData.map((country, idx) => (
        <Marker key={idx} position={[country.latitude, country.longitude]}>
          <Popup>
            {country.name}: {country.userCount}
          </Popup>
        </Marker>
      ))}
    </MapContainer>
  );
};

export default MapComponent;
