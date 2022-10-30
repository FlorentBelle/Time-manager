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
        }
        weekWorkTimeByDay[6] = safe
        return weekWorkTimeByDay
    },
    getThisWeekLimits: function() {
        let today = new Date()
        console.log("today", today)

        let day = today.getDay()
        console.log("getday", day)

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
    addDays: function (date, days) {
        let result = new Date(date);
        console.log("date addays init", result)
        result.setDate(result.getDate() + days);
        console.log("date days added", result)
        result = moment(result).tz(timezone).format()
        result = result.split('T')[0] + " " + result.split('T')[1].slice(0,8)
        return result;
    }
}



// console.log(getDaysList("2022-10-24 00:00:00", "2022-10-31 01:00:00"))
// function getThisWeekLimits() {
//     let today = new Date()
//     console.log("today", today)
//     let day = today.getDay()
//     let start = new Date()
//     let end = new Date()
//     start.setDate(today.getDate() - day +1)
//     end.setDate(today.getDate() + 6 - day+1)
//     start.setHours(0,0,0,0)
//     end.setHours(0,0,0,0)
//     return [start, end]
// }

// console.log(getThisWeekDates())
// const test = [
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
//         end: "2022-10-28T12:05:23",
//         id: 9,
//         start: "2022-10-28T09:05:23",
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
//         end: "2022-10-28T18:05:23",
//         id: 12,
//         start: "2022-10-28T14:05:23",
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

// // console.log(getWeekList(test))

// console.log(getWeekWorkTime(getWeekList(test)))
