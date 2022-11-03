import moment from "moment-timezone";

const timezone = 'Europe/Amsterdam'

export default {
    convertLocalToGMT: function (uctLocalDate, withMicro) {
        const isoDate = new Date(uctLocalDate).toISOString()
        return withMicro ? isoDate.toString() : isoDate.toString().replace('.' + isoDate.toString().split('.')[1], 'Z')
    },
    getWeekList: function (list) {
        let weekList = [[],[],[],[],[],[],[]];
        if(list) {
        for (const element of list) {
            let day = new Date(element.start)
            day = day.getDay()
            weekList[day].push(element)
        }
    }
        return weekList
    },
    getMonthList: function (list) {
        let monthList = [[],[],[],[],[],[],[],[],[],[],[],[]];
        for (const element of list) {
            let day = new Date(element.start)
            day = day.getMonth()
            monthList[day].push(element)
        }
        return monthList
    },
    getDaysList: function (start) {
        let daysList = []
        const week = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday']
        
        for (let i = 0; i < 7; i++) {
            let day = new Date(start)
            day.setDate(day.getDate() + i)
            day = moment(day).tz(timezone).format()
            daysList.push(week[i] + ', ' + day.split('T')[0])
        }
        return daysList
    },
    getWeekWorkTime: function (list) {
        const weekList= this.getWeekList(list)
        let weekWorkTimeByDay = [];
        let totalWeekWorkTime = 0;
        for (let i = 0; i < weekList.length; i++) {
            weekWorkTimeByDay[i] = 0;
            for (const element of weekList[i]) {
                let start = new Date(element.start)
                let end = new Date(element.end)
                let time = end - start
                weekWorkTimeByDay[i] = weekWorkTimeByDay[i] + time
            }

            // weekWorkTimeByDay[i] = new Date(weekWorkTimeByDay[i]).toISOString().slice(-13, -5)
            weekWorkTimeByDay[i] = weekWorkTimeByDay[i]/3.6e+6
        }
        const safe = weekWorkTimeByDay[0]
        for (let i = 1; i < weekWorkTimeByDay.length; i++) {
            weekWorkTimeByDay[i-1] = weekWorkTimeByDay[i]
            totalWeekWorkTime = totalWeekWorkTime + weekWorkTimeByDay[i]
        }
        weekWorkTimeByDay[6] = safe
        totalWeekWorkTime = (totalWeekWorkTime + safe).toFixed(1)
        weekWorkTimeByDay = weekWorkTimeByDay.map(item => item.toFixed(1))

        return {weekWorkTimeByDay: weekWorkTimeByDay, totalWeekWorkTime:totalWeekWorkTime}
    },
    getThisWeekLimits: function() {
        let today = new Date()
        let day = today.getDay()

        let start = new Date()
        let end = new Date()
        if (day ==0) {
            start.setDate(start.getDate() -6)
        } else {
            start.setDate(start.getDate() - day + 1)
            end.setDate(today.getDate() + 6 - day + 1)
        }

        start.setHours(0,0,0,0)
        end.setHours(23,59,59,0)
        
        start= moment(start).tz(timezone).format()
        end= moment(end).tz(timezone).format()

        const utcStart = this.convertLocalToGMT(start, false)
        const utcEnd = this.convertLocalToGMT(end, false)

        start = start.split('T')[0] + " " + start.split('T')[1].slice(0,8)
        end = end.split('T')[0] + " " + end.split('T')[1].slice(0,8)

        return ({
            start: start,
            end: end,
            utcStart: utcStart,
            utcEnd: utcEnd
        })
    },
    getThisYearLimits: function() {
        let today = new Date()
        let thisYear = today.getFullYear()
        let startThisYear = new Date(thisYear, 0, 1)
        let endThisYear = new Date(thisYear, 11, 31)
        endThisYear.setHours(23, 59, 59, 0)
      
        startThisYear = moment(startThisYear).tz(timezone).format()
        endThisYear = moment(endThisYear).tz(timezone).format()
      
        const utcStartThisYear = this.convertLocalToGMT(startThisYear, false)
        const utcEndThisYear = this.convertLocalToGMT(endThisYear, false)

        startThisYear = startThisYear.split('T')[0] + " " + startThisYear.split('T')[1].slice(0,8)
        endThisYear = endThisYear.split('T')[0] + " " + endThisYear.split('T')[1].slice(0,8)

        return ({
            startThisYear: startThisYear, 
            endThisYear: endThisYear, 
            utcStartThisYear: utcStartThisYear, 
            utcEndThisYear: utcEndThisYear
        })
    },
    getDayLimits: function() {
        let today = new Date()
        let start = today.setHours(0,0,0,0)
        let end = today.setHours(23,59,59,0)

        start = moment(start).tz(timezone).format()
        end = moment(end).tz(timezone).format()

        const utcStart = this.convertLocalToGMT(start, false)
        const utcEnd = this.convertLocalToGMT(end, false)

        start = start.split('T')[0] + " " + start.split('T')[1].slice(0,8)
        end = end.split('T')[0] + " " + end.split('T')[1].slice(0,8)

        return ({
            start: start, 
            end: end, 
            utcStart: utcStart,
            utcEnd: utcEnd
        })
    },
    addDays: function (date, days) {
        let result = new Date(date);
        result.setDate(result.getDate() + days);
        result = moment(result).tz(timezone).format()
        result = result.split('T')[0] + " " + result.split('T')[1].slice(0,8)
        return this.convertLocalToGMT(result, false);
    },
    isSameDate(date1, date2) {
        const x = date1.getDate()
        const y = date1.getMonth()
        const z = date1.getFullYear()
        const a = date2.getDate()
        const b = date2.getMonth()
        const c = date2.getFullYear()
        return (x === a && y === b && z === c);
    },
    getDayStartTimes(list) {

        let onlyStarts = []
        let dayStartTimes = []
    
        for (const element of list) {
            if (!(onlyStarts.includes(element.start))) {
                onlyStarts.push(element.start)
            }
        }
        onlyStarts = onlyStarts.sort()
    
        dayStartTimes.push(onlyStarts[0])
    
        for (let i=1; i<onlyStarts.length; i++) {
            const date1 = new Date(onlyStarts[i-1])
            const date2 = new Date(onlyStarts[i])
            
            if (!this.isSameDate(date1, date2)) {
                dayStartTimes.push(onlyStarts[i])
            } else if (date2 < date1) {
                dayStartTimes[i-1] = onlyStarts[i]
            } 
            dayStartTimes = dayStartTimes.sort()
        }
        return dayStartTimes
    },
    getDayEndTimes(list) {

        let onlyEnds = []
        let dayEndTimes = []
    
        for (const element of list) {
            if (!(onlyEnds.includes(element.end))) {
                onlyEnds.push(element.end)
            }
        }
        onlyEnds = onlyEnds.sort()
    
        dayEndTimes.push(onlyEnds[0])
    
        for (let i=1; i<onlyEnds.length; i++) {
            const date1 = new Date(onlyEnds[i-1])
            const date2 = new Date(onlyEnds[i])
            
            if (!this.isSameDate(date1, date2)) {
                dayEndTimes.push(onlyEnds[i])
            } else if (date2 > date1) {
                dayEndTimes[i-1] = onlyEnds[i]
            } 
        }
        return dayEndTimes
    },
    getWorkingTimeByMonth: function (list) {
        const monthList= this.getMonthList(list)
        let weekWorkTimeByMonth = [];
        let totalYearTime = 0;
        for (let i = 0; i < monthList.length; i++) {
            weekWorkTimeByMonth[i] = 0;
            for (const element of monthList[i]) {
                let start = new Date(element.start)
                let end = new Date(element.end)
                let time = end - start
                weekWorkTimeByMonth[i] = weekWorkTimeByMonth[i] + time
            }
            weekWorkTimeByMonth[i] = weekWorkTimeByMonth[i]/3.6e+6/7
        }
        for (const element of weekWorkTimeByMonth) {
            totalYearTime = totalYearTime + element
        }
        totalYearTime = totalYearTime.toFixed(1)
        weekWorkTimeByMonth = weekWorkTimeByMonth.map(el => el.toFixed(1))

        return {weekWorkTimeByMonth: weekWorkTimeByMonth, totalYearTime:totalYearTime}
    },
    getDayStats: function (list) {
        let off = 0;
        let breakTime = 0;
        let workTime = 0;
        let endDay = new Date(list[0].end)
        let startDay = new Date(list[0].start)

        for (const element of list) {
            let start = new Date(element.start)
            let end = new Date(element.end)
            if (start <= startDay) {
                startDay = start
            } 
            if (end >= endDay) {
                endDay = end
            }
        }
        for (const element of list) {
            let start = new Date(element.start)
            let end = new Date(element.end)
            let time = end - start
            workTime = workTime + time
        }

        let dayTime = endDay - startDay

        dayTime = dayTime/3.6e+6

        workTime = workTime/3.6e+6

        breakTime = dayTime - workTime

        off = 24 - dayTime

        return ({work: workTime, off: off, break: breakTime})
    },
    timezone: timezone
}