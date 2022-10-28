
<template>
    <Line
        :chart-options="chartOptions"
        :chart-data="chartData"
        :chartId = "chartId"
        :width = "width"
        :height = "height"
        :cssClasses = "cssClasses"
        :styles = "styles"
        :plugins = "plugins"
    />
  </template>
  
<script>

  import { Line } from 'vue-chartjs'

  import {
  Chart as ChartJS,
  Title,
  Tooltip,
  Legend,
  LineElement,
  LinearScale,
  PointElement,
  CategoryScale,
  } from 'chart.js'

  ChartJS.register(
  Title,
  Tooltip,
  Legend,
  LineElement,
  LinearScale,
  PointElement,
  CategoryScale
  )
  
  export default {
    name: 'LineChart',
    components: {
        Line
    },
    props: {
      chartId: {
      type: String,
      default: 'line-chart'
      },
      width: {
      type: Number,
      default: 400
      },
      height: {
      type: Number,
      default: 400
      },
      cssClasses: {
      default: '',
      type: String
      },
      styles: {
        type: Object,
        default: () => {}
      },
      plugins: {
        type: Object,
        default: () => {}
      }
    },
    data() {
      return {
        chartData: {
          labels: ['January', 'February', 'March', 'April', 'May', 'June', 'July'],
          datasets: [
              {
              label: 'Data One',
              backgroundColor: '#f87979',
              data: [40, 39, 10, 40, 39, 80, 40]
              }
          ]
        },
        chartOptions: {
          responsive: true,
          maintainAspectRatio: false
        }
      }
    }
  }
</script>