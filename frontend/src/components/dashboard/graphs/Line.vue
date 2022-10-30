<template>
  <div class="row">
    <div class="col s12">
      <div class="card">
        <div class="card-content">
          <div class="row">
            <div class="col s12">
                  <span class="card-title"><strong>Working time during years</strong></span>
                  <span class="card-title"><strong>total:  {{totalWeekWorkTime}} hours </strong></span>
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
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>
  
<script>

  import { Line } from 'vue-chartjs'

  import WorkingTime from '../../../api/WorkingTime'
    import tools from '../../../utils/tools'

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
    },
    // async mounted () {
    //   this.loaded = false

    //   try {
    //     const thisWeekStart = tools.getThisWeekLimits()
    //     this.startV=thisWeekStart.start
    //     this.endV=thisWeekStart.end

    //     await this.show(this.startV, this.endV)
    //     this.timer = setInterval(() => {
    //       this.show(this.startV, this.endV)
    //     }, 60000)
    //     this.loaded = true
    //   } catch (e) {
    //     console.error(e)
    //   }
    // },
    // beforeDestroy() {
    //   clearInterval(this.timer)
    // }
  }
</script>