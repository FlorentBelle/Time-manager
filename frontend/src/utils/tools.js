import moment from "moment-timezone";

const timezone = 'Europe/Amsterdam'

export default {
    getWeekList: function (list) {
        let weekList = [[],[],[],[],[],[],[]];
        for (const element of list) {
            let day = new Date(element.start)
            day = day.getDay()
            weekList[day].push(element)
        }
        return weekList
    },
    getMonthList: function (list) {
        let monthList = [[],[],[],[],[],[],[],[],[],[],[],[]];
        for (const element of list) {
            let day = new Date(element.start)
            day = day.getMonth()
            console.log(day)
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
        totalWeekWorkTime = Math.round((totalWeekWorkTime + safe)*100)/100

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
        console.log("getThisWeekLimits", start, end)

        start = start.split('T')[0] + " " + start.split('T')[1].slice(0,8)
        end = end.split('T')[0] + " " + end.split('T')[1].slice(0,8)
        console.log("getThisWeekLimits", start, end)

        return {start: start, end: end}
    },
    getThisYearLimits: function() {
        let today = new Date()
        let thisYear = today.getFullYear()
        let startThisYear = new Date(thisYear, 0, 1)
        let endThisYear = new Date(thisYear, 11, 31)
        endThisYear.setHours(23, 59, 59, 0)
      
        startThisYear = moment(startThisYear).tz(timezone).format()
        endThisYear = moment(endThisYear).tz(timezone).format()

        startThisYear = startThisYear.split('T')[0] + " " + startThisYear.split('T')[1].slice(0,8)
        endThisYear = endThisYear.split('T')[0] + " " + endThisYear.split('T')[1].slice(0,8)

        return {startThisYear: startThisYear, endThisYear: endThisYear}
    },
    getDayLimits: function() {
        let today = new Date()
        let start = today.setHours(0,0,0,0)
        let end = today.setHours(23,59,59,0)
        start = moment(start).tz(timezone).format()
        end = moment(end).tz(timezone).format()

        start = start.split('T')[0] + " " + start.split('T')[1].slice(0,8)
        end = end.split('T')[0] + " " + end.split('T')[1].slice(0,8)

        return {start: start, end: end}
    },
    addDays: function (date, days) {
        let result = new Date(date);
        console.log("date addays init", result)
        result.setDate(result.getDate() + days);
        console.log("date days added", result)
        result = moment(result).tz(timezone).format()
        result = result.split('T')[0] + " " + result.split('T')[1].slice(0,8)
        return result;
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
        totalYearTime = Math.round((totalYearTime)*100)/100

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
        console.log("dayTime", dayTime)

        workTime = workTime/3.6e+6
        console.log("workTime", workTime)

        breakTime = dayTime - workTime
        console.log("breakTime", breakTime)

        off = 24 - dayTime
        console.log("off", off)


        return ({work: workTime, off: off, break: breakTime})
    },
    timezone: timezone
}


// const test = [
//     {
//         end: "2022-10-28T18:05:23",
//         id: 12,
//         start: "2022-10-28T14:05:23",
//         user: 1
//     },
//     {
//         end: "2022-10-28T12:05:23",
//         id: 9,
//         start: "2022-10-28T09:05:23",
//         user: 1
//     },
//     {
//         end: "2022-10-24T12:05:23",
//         id: 5,
//         start: "2022-10-24T09:05:23",
//         user: 1
//     },
//     {
//         end: "2022-10-25T12:05:23",
//         id: 6,
//         start: "2022-10-25T09:05:23",
//         user: 1
//     },
//     {
//         end: "2022-10-25T18:05:23",
//         id: 12,
//         start: "2022-10-25T14:05:23",
//         user: 1
//     },
//     {
//         end: "2022-10-26T12:05:23",
//         id: 7,
//         start: "2022-10-26T09:05:23",
//         user: 1
//     },
//     {
//         end: "2022-10-27T12:05:23",
//         id: 8,
//         start: "2022-10-27T09:05:23",
//         user: 1
//     },
//     {
//         end: "2022-10-29T12:05:23",
//         id: 10,
//         start: "2022-10-29T09:05:23",
//         user: 1
//     },
//     {
//         end: "2022-10-30T12:05:23",
//         id: 11,
//         start: "2022-10-30T09:05:23",
//         user: 1
//     },
//     {
//         end: "2022-10-27T18:05:23",
//         id: 13,
//         start: "2022-10-27T14:05:23",
//         user: 1
//     },
//     {
//         end: "2022-10-26T18:05:23",
//         id: 14,
//         start: "2022-10-26T14:05:23",
//         user: 1
//     },
//     {
//         end: "2022-10-25T18:05:23",
//         id: 15,
//         start: "2022-10-25T14:05:23",
//         user: 1
//     },
//     {
//         end: "2022-10-24T18:05:23",
//         id: 16,
//         start: "2022-10-24T14:05:23",
//         user: 1
//     }
// ]

// let result = getDayEndTimes(test)
// console.log(result)
