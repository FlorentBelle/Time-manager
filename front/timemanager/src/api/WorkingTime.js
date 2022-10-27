import Api from "./Api";

export default {
    
    getAllWorkingTimesUser: async function(userId) {
        const response = await fetch(`${Api}/workingtimes/${userId}`, {
        mode: 'cors',
        headers: {
            "Content-type": "application/json; charset=UTF-8"
        }
        });
        return response.json()
    },
    getOneWorkingTimesUser: async function() {
        const response = await fetch(`${Api}/workingtimes/${userId}/${workingTimeId}`, {
        mode: 'cors',
        headers: {
            "Content-type": "application/json; charset=UTF-8"
        }
        });
        return response.json()
    },
    createWorkingTimesUser: async function(userId, workingTime) {
        const response = await fetch(`${Api}/workingtimes/${userId}`, {
        method: 'POST',
        mode: 'cors',
        headers: {
            "Content-type": "application/json; charset=UTF-8"
        },
        body: JSON.stringify(workingTime)
        });
        return response.json()
    },
    updateWorkingTimesUser: async function(workingTimeId, workingTime) {
        const response = await fetch(`${Api}/workingtimes/${workingTimeId}`, {
        method: 'PUT',
        mode: 'cors',
        headers: {
            "Content-type": "application/json; charset=UTF-8"
        },
        body: JSON.stringify(workingTime)
        });
        return response.json()
    },
    deleteWorkingTimesUser: async function(workingTimeId) {
        const response = await fetch(`${Api}/workingtimes/${workingTimeId}`, {
        method: 'DELETE',
        mode: 'cors',
        headers: {
            "Content-type": "application/json; charset=UTF-8"
        }
        });
        return response.json()
    }
}