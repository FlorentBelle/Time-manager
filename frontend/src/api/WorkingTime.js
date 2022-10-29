export default {
 
    getAllWorkingTimesUser: async function(userId, start, end) {
        
        if (start && end) {
            const response = await fetch(`${import.meta.env.VITE_API_URL}/users/${userId}/working_times?start=${start}&end=${end}`, {
                mode: 'cors',
                headers: {
                    "Content-type": "application/json; charset=UTF-8"
                }
            });
            return response.json()
        } else if (start && !end) {
            const response = await fetch(`${import.meta.env.VITE_API_URL}/users/${userId}/working_times?start=${start}`, {
                mode: 'cors',
                headers: {
                    "Content-type": "application/json; charset=UTF-8"
                }
            });
            return response.json()
        } else if (end && !start) {
            const response = await fetch(`${import.meta.env.VITE_API_URL}/users/${userId}/working_times?end=${end}`, {
                mode: 'cors',
                headers: {
                    "Content-type": "application/json; charset=UTF-8"
                }
            });
            return response.json()
        } else {
            const response = await fetch(`${import.meta.env.VITE_API_URL}/users/${userId}/working_times`, {
                mode: 'cors',
                headers: {
                    "Content-type": "application/json; charset=UTF-8"
                }
            });
            return response.json()
        }
    },
    getOneWorkingTimesUser: async function(userId,workingTimeId) {
        const response = await fetch(`${import.meta.env.VITE_API_URL}/users/${userId}/workingtimes/${workingTimeId}`, {
        mode: 'cors',
        headers: {
            "Content-type": "application/json; charset=UTF-8"
        }
        });
        return response.json()
    },
    createWorkingTimesUser: async function(userId, workingTime) {
        const response = await fetch(`${import.meta.env.VITE_API_URL}/workingtimes/${userId}`, {
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
        const response = await fetch(`${import.meta.env.VITE_API_URL}/workingtimes/${workingTimeId}`, {
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
        const response = await fetch(`${import.meta.env.VITE_API_URL}/workingtimes/${workingTimeId}`, {
        method: 'DELETE',
        mode: 'cors',
        headers: {
            "Content-type": "application/json; charset=UTF-8"
        }
        });
        return response.json()
    }
}

// ci -dessous pour ma connection à mopn api perso


 // getAllWorkingTimesUser: async function(userId, start, end) {
        
    //     if (start && end) {
    //         const response = await fetch(`${import.meta.env.VITE_API_URL}/working_times/${userId}?start=${start}&end=${end}`, {
    //             mode: 'cors',
    //             headers: {
    //                 "Content-type": "application/json; charset=UTF-8"
    //             }
    //         });
    //         return response.json()
    //     } else if (start && !end) {
    //         const response = await fetch(`${import.meta.env.VITE_API_URL}/working_times/${userId}?start=${start}`, {
    //             mode: 'cors',
    //             headers: {
    //                 "Content-type": "application/json; charset=UTF-8"
    //             }
    //         });
    //         return response.json()
    //     } else if (end && !start) {
    //         const response = await fetch(`${import.meta.env.VITE_API_URL}/working_times/${userId}?end=${end}`, {
    //             mode: 'cors',
    //             headers: {
    //                 "Content-type": "application/json; charset=UTF-8"
    //             }
    //         });
    //         return response.json()
    //     } else {
    //         const response = await fetch(`${import.meta.env.VITE_API_URL}/working_times/${userId}`, {
    //             mode: 'cors',
    //             headers: {
    //                 "Content-type": "application/json; charset=UTF-8"
    //             }
    //         });
    //         return response.json()
    //     }
    // },