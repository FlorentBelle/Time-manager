<template>
      <div class="row">
        <div class="col s12">
          <div class="card">
            <div class="card-content">
              <div class="row">
                <div class="col s12">
                      <span class="card-title"><strong>Week Working time ({{contract}} hours contract)</strong></span>
                      <span class="card-title" v-bind:class=(colorWeek)><strong>total:  {{totalWeekWorkTime}} hours </strong></span>
                </div>
              </div>
              <div class="row">
                <div class="col s2">
                      <button class="btn waves-effect waves-light left " v-on:click="getPreviousWeek"><i class="material-icons">chevron_left</i></button>
                </div>
                <div class="col s8 center">
                      <span class="card-title">from <strong>{{startShow}}</strong> to <strong>{{endShow}}</strong></span>
                </div>
                <div class="col s2">
                      <button class="btn waves-effect waves-light right" v-on:click="getNextWeek"><i class="material-icons">chevron_right</i></button>
                </div>
              </div>
              <div class="row">
                <div class="col s12">
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
          console.log("this", this.startV, this.endV)
        },
        async getNextWeek() {
          this.startV = tools.addDays(this.startV, 7)
          this.endV = tools.addDays(this.endV, 7)
          await this.show(this.startV, this.endV)
          console.log("this", this.startV, this.endV)
        },
        async show(start, end) {
          const userID=this.$route.params.userID
          const res = await WorkingTime.getAllWorkingTimesUser(userID, start, end)
          this.weekWorkingTime = tools.getWeekWorkTime(res.data).weekWorkTimeByDay
          this.totalWeekWorkTime = tools.getWeekWorkTime(res.data).totalWeekWorkTime
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
        },
      },
      async mounted () {
        this.loaded = false
  
        try {
          const thisWeekStart = tools.getThisWeekLimits()
          this.startV=thisWeekStart.start
          this.endV=thisWeekStart.end

          await this.show(this.startV, this.endV)
          this.timer = setInterval(() => {
            this.show(this.startV, this.endV)
          }, 60000)
          this.loaded = true
        } catch (e) {
          console.error(e)
        }
      },
      beforeDestroy() {
        clearInterval(this.timer)
      }
    }
    </script>
    