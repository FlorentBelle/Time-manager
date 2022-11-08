import { RegExp } from "core-js"
import tools from "../utils/tools"
import {jest} from '@jest/globals'



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
/*-------------------------------------------------------*/ 
test('list of weeks', ()=>{

    expect(tools.getWeekList(list)).toEqual(week_list)
})
/*----------------------------------------------------------------------------*/ 

test('list of months', ()=>{
    expect(tools.getMonthList(list)[9]).toEqual(list)
})

/**-------------------------------------------------------------------------- */

test('list of days', ()=>{
    const re = new RegExp("[a-zA-Z]{3,8},.[0-9]{2,4}.[0-9]{2,4}.[0-9]{2,4}",'i')
    for(const element of list){
        for (const date of tools.getDaysList(element.start)){
            expect(date).toMatch(re)
        }
        
    }
    
})

/**-------------------------------------------------------------------------- */
/* test('getWeekWorkTime',()=>{
    const mockGetWeekList = jest.fn().mockReturnValue(week_list)
    tools.getWeekWorkTime(mockGetWeekList)
    expect(mockGetWeekList).toHaveBeenCalled();
    expect(tools.getWeekWorkTime(list,mockGetWeekList)["weekWorkTimeByDay"].length).toEqual(7)
    expect(tools.getWeekWorkTime(list,mockGetWeekList)).toBeDefined()
    expect(Object.keys(tools.getWeekWorkTime(list,mockGetWeekList)).length).toEqual(2)
})
 */

test('getWeekWorkTime', ()=>{
    
    const spy =jest.spyOn(tools, 'getWeekList')
    spy.mockReturnValue(week_list)

    tools.getWeekWorkTime(list)

    expect(spy).toHaveBeenCalled()
    expect(tools.getWeekWorkTime(list)["weekWorkTimeByDay"].length).toEqual(7)
    expect(tools.getWeekWorkTime(list)).toBeDefined()
    expect(Object.keys(tools.getWeekWorkTime(list)).length).toEqual(2)
    
    spy.mockRestore();

})

test('getThisWeekLimits', ()=>{
    const re = new RegExp("\"([0-9]{2,4}.){3}([0-9]{2}.*){3}",'i')

    expect(Object.keys(tools.getThisWeekLimits()).length).toEqual(4)
    for(let key in tools.getThisWeekLimits()){
        expect(tools.getThisWeekLimits()[key]).toBeDefined()
    }
    
    
})
