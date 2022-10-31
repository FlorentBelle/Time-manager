<template>
  <div class="row">
    <div class="col s12">
      <div class="card">
        <div class="card-content">
          <div class="row">
            <div class="col s12">
                <span class="card-title"><strong>Day Working time</strong></span>
                <span class="card-title"><strong>{{dayShow}} </strong></span>

            </div>
            <div class="col s12">
              <button class="btn waves-effect waves-light" v-on:click="changeDay"> change date</button>
            </div>
            <div class="col s12">
              <input type="date" v-model="day"/>
            </div>
          </div>
          <div class="row">
            <div class="col s12">
              <Doughnut v-if="loaded"
                :chartData = "chartData"
                :chartOptions = "chartOptions"
                :chartId = "chartId"
                :width ="width"
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

  import { Doughnut } from 'vue-chartjs'
  import moment from "moment-timezone";
  import WorkingTime from '../../../api/WorkingTime'
  import tools from '../../../utils/tools'

  import {
    Chart as ChartJS,
    Title,
    Tooltip,
    Legend,
    ArcElement,
    CategoryScale,
  } from 'chart.js'
  

  ChartJS.register(Title, Tooltip, Legend, ArcElement, CategoryScale)

  export default {
    name: 'DoughnutChart',
    components: {
      Doughnut
    },
    props: {
      chartId: {
        type: String,
        default: 'doughnut-chart'
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
        type: Array,
        default: () => []
      }
    },
    data: () => ({
        loaded: false,
        chartData: null,
        startV: null,
        endV: null,
        dayShow: null,
        day: null,
        break: null,
        work: null,
        off: null
    }),
    methods : {
      async changeDay() {
        this.dayShow = this.day
        this.startV = this.day+" 00:00:00"
        this.endV = this.day+" 23:59:59"
        await this.show(this.startV, this.endV)
      },
      async show(start, end) {
        const userID=this.$route.params.userID
        const res = await WorkingTime.getAllWorkingTimesUser(userID, start, end)
        const getDayStatsResult = tools.getDayStats(res.data)
        this.break = getDayStatsResult.break
        this.work = getDayStatsResult.work
        this.off = getDayStatsResult.off
        this.chartData = {
          labels: ['Working', 'Break', 'Off'],
          datasets: [
            {
              backgroundColor: ['#41B883', '#E46651', '#00D8FF'],
              data: [this.work, this.break, this.off]
            }
          ]
        }
        this.chartOptions = {
          responsive: true,
          maintainAspectRatio: false
        }
      },
    },
    async mounted() {
      this.loaded = false

      try {
        const today = new Date()
        const todayLimits = tools.getDayLimits()
        this.dayShow = moment(today).tz(tools.timezone).format()
        this.dayShow = this.dayShow.split('T')[0]

        this.startV = todayLimits.start
        this.endV = todayLimits.end

        await this.show(this.startV, this.endV)
        this.timer = setInterval(() => {
          this.show(this.startV, this.endV)
        }, 60000)
        this.loaded = true
      } catch (err) {
        console.log(err)
      }
    }
  }

</script>
