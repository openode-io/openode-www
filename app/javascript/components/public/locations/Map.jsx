import React from "react";
import {
  ComposableMap,
  Geographies,
  Geography,
  Marker
} from "react-simple-maps";

const geoUrl = "/maps/world.json";

const markers = [];

class Map extends React.Component {

  constructor(props) {
    super(props);

    this.state = {
      markers: this.props.markers || markers
    };
  };

  render() {
    return (
      <ComposableMap>
        <Geographies geography={geoUrl}>
          {({ geographies }) =>
            geographies
              .map(geo => (
                <Geography
                  key={geo.rsmKey}
                  geography={geo}
                  fill="transparent"
                  stroke="#5D5A6D"
                />
              ))
          }
        </Geographies>
        {this.state.markers.map(({ name, coordinates, markerOffset, markerColor,textColor }) => (
          <Marker key={name} coordinates={coordinates.reverse()}>
            <circle r={5} fill={markerColor} stroke="transparent" strokeWidth={1} />
          </Marker>
        ))}
      </ComposableMap>
    );
  }
};

export default Map;