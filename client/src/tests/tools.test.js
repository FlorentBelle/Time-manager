import tools from "../utils/tools"


const list = [
    {
        end: "2022-10-28T18:05:23",
        id: 12,
        start: "2022-10-28T14:05:23",
        user: 1
    },
    {
        end: "2022-10-28T12:05:23",
        id: 9,
        start: "2022-10-28T09:05:23",
        user: 1
    },
    {
        end: "2022-10-24T12:05:23",
        id: 5,
        start: "2022-10-24T09:05:23",
        user: 1
    }
]
/*-------------------------------------------------------*/ 
test('list of weeks', ()=>{

    const week_list = [
        [],
        [
            {
                end: "2022-10-24T12:05:23",
                id: 5,
                start: "2022-10-24T09:05:23",
                user: 1
            }
        ],
        [],
        [],
        [],
        [
            {
                end: "2022-10-28T18:05:23",
                id: 12,
                start: "2022-10-28T14:05:23",
                user: 1
            },
            {
                end: "2022-10-28T12:05:23",
                id: 9,
                start: "2022-10-28T09:05:23",
                user: 1
            }
        ],
        []
    ]
    expect(tools.getWeekList(list)).toEqual(week_list)
})
/*----------------------------------------------------------------------------*/ 

test('list of months', ()=>{
    expect(tools.getMonthList(list)[9]).toEqual(list)
})

/**-------------------------------------------------------------------------- */

test('list of days', ()=>{
    for(const element of list){
        expect(tools.getDaysList(element.start).length).toBe(7)
    }
    
})
