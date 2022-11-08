<template>
  <div class="card-chart card">
    <div class="card-chart card-content">

      <div class="row">

        <div class="col s12">
              <h3 class="chart-card-title">Week Working time ({{contract}} hours contract)</h3>
              <span class="chart-card-info">Total:  {{totalWeekWorkTime}} hours</span>
        </div>

      </div>

      <div class="bar-week-nav">
        <div class="">
              <button class="app-button" v-on:click="getPreviousWeek">
                <svg viewBox="0 0 492 492">
                  <path d="M198.608,246.104L382.664,62.04c5.068-5.056,7.856-11.816,7.856-19.024c0-7.212-2.788-13.968-7.856-19.032l-16.128-16.12
                      C361.476,2.792,354.712,0,347.504,0s-13.964,2.792-19.028,7.864L109.328,227.008c-5.084,5.08-7.868,11.868-7.848,19.084
                      c-0.02,7.248,2.76,14.028,7.848,19.112l218.944,218.932c5.064,5.072,11.82,7.864,19.032,7.864c7.208,0,13.964-2.792,19.032-7.864
                      l16.124-16.12c10.492-10.492,10.492-27.572,0-38.06L198.608,246.104z"
                  />
                </svg>
              </button>
        </div>
        <div class="">
              <span class="chart-card-title">{{startShow}} - {{endShow}}</span>
        </div>
        <div class="">
            <button class="app-button" v-on:click="getNextWeek">
              <svg viewBox="0 0 492.004 492.004" style="enable-background:new 0 0 492.004 492.004;">
                <path d="M382.678,226.804L163.73,7.86C158.666,2.792,151.906,0,144.698,0s-13.968,2.792-19.032,7.86l-16.124,16.12
                  c-10.492,10.504-10.492,27.576,0,38.064L293.398,245.9l-184.06,184.06c-5.064,5.068-7.86,11.824-7.86,19.028
                  c0,7.212,2.796,13.968,7.86,19.04l16.124,16.116c5.068,5.068,11.824,7.86,19.032,7.86s13.968-2.792,19.032-7.86L382.678,265
                  c5.076-5.084,7.864-11.872,7.848-19.088C390.542,238.668,387.754,231.884,382.678,226.804z"
                />
              </svg>
            </button>
        </div>
      </div>

      <div class="bar-chart-container">
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
      </div>

    </div>
  </div>
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
    },
    options: {        
      legend: {
        display: false
      }
    }
  },
  data: () => ({
    loaded: false,
    chartData: null,
    startShow: null,
    endShow: null,
    weekWorkingTime: null,
    totalWeekWorkTime: null,
    labelsDates: null,
    startV: null,
    endV: null,
    colorWeek: "blue",
    contract: 35
  }),
  methods: {
    async getPreviousWeek() {
      this.startV = tools.addDays(this.startV, -7)
      this.endV = tools.addDays(this.endV, -7)
      await this.show(this.startV, this.endV)
    },
    async getNextWeek() {
      this.startV = tools.addDays(this.startV, 7)
      this.endV = tools.addDays(this.endV, 7)
      await this.show(this.startV, this.endV)
    },
    async show(start, end) {
      const userID = this.$route.params.userID
      const teamID = this.$route.params.teamID

      if (userID !== undefined) {
        const res = await WorkingTime.getAllWorkingTimesUser(userID, start, end)
        const getWeekWorkTimeResult = tools.getWeekWorkTime(res.content)
        this.weekWorkingTime = getWeekWorkTimeResult.weekWorkTimeByDay
        this.totalWeekWorkTime = getWeekWorkTimeResult.totalWeekWorkTime
        if (this.totalWeekWorkTime < 35) {
          this.colorWeek = "red-text"
        } else {
          this.colorWeek = "green-text"
        }
        this.startShow = start.slice(0, 10)
        this.endShow = end.slice(0, 10)
        this.labelsDates = tools.getDaysList(start)
        this.chartData = {
          labels: this.labelsDates,
              datasets: [ { 
                data: this.weekWorkingTime,
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
                borderWidth: 1,
              }]
            }
        this.chartOptions = {
          responsive: true,
          maintainAspectRatio: false,       
          plugins: {
            legend: {
                display: false,
            }
          }
        }

      }else if (teamID !== null) {
        const res = await WorkingTime.retrieveWorkingTimeByTeam(teamID, start, end)
        const getWeekWorkTimeResult = tools.getWeekWorkTime(res.content)
        this.weekWorkingTime = getWeekWorkTimeResult.weekWorkTimeByDay
        this.totalWeekWorkTime = getWeekWorkTimeResult.totalWeekWorkTime
        if (this.totalWeekWorkTime < 35) {
          this.colorWeek = "red-text"
        } else {
          this.colorWeek = "green-text"
        }
        this.startShow = start.slice(0, 10)
        this.endShow = end.slice(0, 10)
        this.labelsDates = tools.getDaysList(start)
        this.chartData = {
          labels: this.labelsDates,
              datasets: [ { 
                data: this.weekWorkingTime,
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
                borderWidth: 1,
              }]
            }
        this.chartOptions = {
          responsive: true,
          maintainAspectRatio: false,       
          plugins: {
            legend: {
                display: false,
            }
          }
        }



      }

      
      
    },
  },
  async mounted () {
    this.loaded = false

    try {
      const thisWeekStart = tools.getThisWeekLimits()
      this.startV=thisWeekStart.utcStart
      this.endV=thisWeekStart.utcEnd
      await this.show(this.startV, this.endV)
      this.timer = setInterval(() => {
        this.show(this.startV, this.endV)
      }, 60000)
      this.loaded = true
    } catch (e) {
      console.error(e)
    }
  },
  beforeUnmount() {
    clearInterval(this.timer)
  }
}
</script>

<style scoped lang="scss">
  .app-button {
    border: none;
    border-radius: 5px;
    padding: 5px;
    background-color: var(--color-1);
    color: var(--color-2);
    width: 40px;
    height: 25px;
    font-size: 12px;
    font-weight: 400;
    text-align: center;
    color: white;
    &:hover {
    filter: brightness(1.25);
    cursor: pointer;
    }
    svg {
      fill: var(--color-2);
      width: 10px;
    }
  }
  .card-chart {
    background-color: var(--bg-4);
    color: var(--color-2);
    border-radius: 10px !important;
    padding: 0px;
    margin: 5px;
    .chart-card-title {
      font-size: 12px;
      font-weight: 500;
      margin-top: 5px;
    }
    .chart-card-info {
      font-size: 12px;
      font-weight: 400;
    }
    .bar-week-nav {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 15px;
    }
    .bar-chart-container {
      background-color: white;
      border-radius: 10px;
      overflow-x: auto;
    }
  }
</style>