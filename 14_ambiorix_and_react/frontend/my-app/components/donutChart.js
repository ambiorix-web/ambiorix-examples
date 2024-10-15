// DonutComponent.js
import React from "react";
import ReactECharts from "echarts-for-react";

const DonutComponent = ({ userGenderCount }) => {
  const option = {
    title: {
      text: "Gender Distribution Per Year",
      left: "center",
    },
    tooltip: {
      trigger: "item",
    },
    legend: {
      orient: "vertical",
      left: "left",
    },
    series: [
      {
        name: "Gender",
        type: "pie",
        radius: ["50%", "70%"],
        avoidLabelOverlap: false,
        label: {
          show: true,
          position: "outside",
          formatter: '{b}: {d}%'
        },
        itemStyle: {
          borderRadius: 10,
          borderColor: "#fff",
          borderWidth: 2,
        },
        emphasis: {
          label: {
            show: true,
            fontSize: 40,
            fontWeight: "bold",
          },
        },
        labelLine: {
          show: false,
        },
        data: userGenderCount.map((item) => ({
          value: item.percentage,
          name: item.gender,
        })),
      },
    ],
  };

  return (
    <ReactECharts option={option} style={{ height: "400px", width: "100%" }} />
  );
};

export default DonutComponent;
