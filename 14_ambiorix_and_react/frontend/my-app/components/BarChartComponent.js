// src/BarChartComponent.js

import React from "react";
import ReactECharts from "echarts-for-react";


const BarChartComponent = ({ userCount }) => {
  const barOptions = {
    tooltip: {
      trigger: "axis",
    },
    title: {
      text: "User Registrations Per Year",
      textStyle: {
        align: "center",
      },
    },
    xAxis: {
      type: "category",
      data: userCount.map((item) => item.Year),
    },
    yAxis: {
      type: "value",
    },
    series: [
      {
        data: userCount.map((item) => item.countOfUsers),
        type: "bar",
        animationDelay: (idx) => idx * 100,
        animationDuration: 1000,
        animationEasing: "elasticOut",
        emphasis: {
          itemStyle: {
            shadowBlur: 10,
            shadowOffsetX: 0,
            shadowColor: "rgba(0, 0, 0, 0.5)",
          },
        },
      },
    ],
    dataZoom: [
      {
        type: "inside",
        start: 0,
        end: 100,
        zoomOnMouseWheel: true,
        moveOnMouseMove: true,
        preventDefaultMouseMove: false,
      },
    ],
    animationEasing: "elasticOut",
    animationDelayUpdate: (idx) => idx * 50,
  };

  return (
    <div style={{ height: "300px", width: "100%" }}>
      <ReactECharts option={barOptions} />
    </div>
  );
};

export default BarChartComponent;
