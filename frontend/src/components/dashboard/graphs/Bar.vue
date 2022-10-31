<template>
    <Bar v-if="loaded"
      :chart-options="chartOptions"
      :chart-data="chartData"
      :chart-id="chartId"
      :dataset-id-key="datasetIdKey"
      :plugins="plugins"
      :css-classes="cssClasses"
      :styles="styles"
      :width="width"
      :height="height"
    />
  </template>
  
  <script>
  import { Bar } from 'vue-chartjs'
  import { Chart as ChartJS, Title, Tooltip, Legend, BarElement, CategoryScale, LinearScale } from 'chart.js'

  import WorkingTime from '../../../api/WorkingTime'
  import tools from '../../../utils/tools'

  ChartJS.register(Title, Tooltip, Legend, BarElement, CategoryScale, LinearScale)
  
  export default {
    name: 'BarChart',
    components: { Bar },
    props: {
      chartId: {
        type: String,
        default: 'bar-chart'
      },
      datasetIdKey: {
        type: String,
        default: 'label'
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
    data: () => ({
      loaded: false,
      chartData: null,

    }),
    async mounted () {
      this.loaded = false

      try {
        const userID=1
        let start='2022-10-24 00:00:00'
        let end='2022-10-30 23:59:59'
        const res = await WorkingTime.getAllWorkingTimesUser(userID, start, end)
        const weekList = tools.getWeekList(res.data)
        const weekWorkingTime = tools.getWeekWorkTime(weekList)
        start = start.slice(0, 10)
        end = end.slice(0, 10)
   
        console.log(weekWorkingTime)

        this.chartData = {
          labels: [ 'Monday', 'Tuesday', 'Wednesday', "Thursday", "Friday", "Saturday", "Sunday" ],
          datasets: [ { 
            label: `Working Time (hours) from ${start} to ${end}`,
            data: weekWorkingTime,
            backgroundColor:[
            'rgba(255, 99, 132, 0.2)',
            'rgba(255, 159, 64, 0.2)',
            'rgba(255, 205, 86, 0.2)',
            'rgba(75, 192, 192, 0.2)',
            'rgba(54, 162, 235, 0.2)',
            'rgba(153, 102, 255, 0.2)',
            'rgba(20, 222, 207, 0.2)'
            ],
            borderColor: [
            'rgb(255, 99, 132)',
            'rgb(255, 159, 64)',
            'rgb(255, 205, 86)',
            'rgb(75, 192, 192)',
            'rgb(54, 162, 235)',
            'rgb(153, 102, 255)',
            'rgb(201, 203, 207)'
            ],
            borderWidth: 1
          }]
        }
        this.chartOptions = {
          responsive: true,
          maintainAspectRatio: false
        }
        this.loaded = true
        this.datasets= [{
          label: 'My First Dataset',
          
          }]
      } catch (e) {
        console.error(e)
      }
    }
  }
  </script>
  