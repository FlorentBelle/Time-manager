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
    getWeekWorkTime: function (list) {

        let weekWorkTimeByDay = [];
        for (let i = 0; i < list.length; i++) {
            weekWorkTimeByDay[i] = 0;
            for (const element of list[i]) {
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
    }
}

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
