export default {

    getAllUsers: async function() {
        const response = await fetch(`${process.env.VUE_APP_API_URL}/users`, {
        mode: 'cors',
        headers: {
            "Content-type": "application/json; charset=UTF-8",
            "Authorization": JSON.parse(localStorage.session).token
        }
        });
        return response.json()
    },

    getOneUser: async function(userId) {
        const response = await fetch(`${process.env.VUE_APP_API_URL}/users/${userId}`, {
        mode: 'cors',
        headers: {
            "Content-type": "application/json; charset=UTF-8",
            "Authorization": JSON.parse(localStorage.session).token
        }
        });
        return response.json()
    },

    createUser: async function(user) {
        const response = await fetch(`${process.env.VUE_APP_API_URL}/users`, {
        method: 'POST',
        mode: 'cors',
        headers: {
            "Content-type": "application/json; charset=UTF-8",
            "Authorization": JSON.parse(localStorage.session).token
        },
        body: JSON.stringify(user)
        });
        return response.json()
    }, 

    updateUser: async function(userId, user) {
        const response = await fetch(`${process.env.VUE_APP_API_URL}/users/${userId}`, {
        method: 'PUT',
        mode: 'cors',
        headers: {
            "Content-type": "application/json; charset=UTF-8",
            "Authorization": JSON.parse(localStorage.session).token
        },
        body: JSON.stringify(user)
        });
        return response.json()
    },

    deleteUser: async function(userId) {
        const response = await fetch(`${process.env.VUE_APP_API_URL}/users/${userId}`, {
        method: 'DELETE',
        mode: 'cors',
        headers: {
            "Content-type": "application/json; charset=UTF-8",
            "Authorization": JSON.parse(localStorage.session).token
        }
        });
        return response.json()
    },
    
    getUserByEmailAndUsername: async function(email, username) {
        const response = await fetch(`${process.env.VUE_APP_API_URL}/users?email=${email}&username=${username}`, {
        mode: 'cors',
        headers: {
            "Content-type": "application/json; charset=UTF-8",
            "Authorization": JSON.parse(localStorage.session).token
        }
        });
        return response.json()
    },

    getRoles: async function () {
        const response = await fetch(`${process.env.VUE_APP_API_URL}/roles`, {
            mode: 'cors',
            headers: {
                "Content-type": "application/json; charset=UTF-8",
                "Authorization": JSON.parse(localStorage.session).token
            }
            });
            return response.json() 
    },

    getUserTeams: async function (id) {
        const response = await fetch(`${process.env.VUE_APP_API_URL}/teams/${id}`, {
            mode: 'cors',
            headers: {
                "Content-type": "application/json; charset=UTF-8",
                "Authorization": JSON.parse(localStorage.session).token
            }
            });
            return response.json() 
    },
    getUsersInTeam: async function (teamID) {
        const response = await fetch(`${process.env.VUE_APP_API_URL}/teamMember/${teamID}`, {
            mode: 'cors',
            headers: {
                "Content-type": "application/json; charset=UTF-8",
                "Authorization": JSON.parse(localStorage.session).token
            }
            });
            return response.json() 
    },

    createTeam: async function(userID, newTeam) {
        const response = await fetch(`${process.env.VUE_APP_API_URL}/teams/${userID}`, {
            method: 'POST',
            mode: 'cors',
            headers: {
                "Content-type": "application/json; charset=UTF-8",
                "Authorization": JSON.parse(localStorage.session).token
            },
            body: JSON.stringify({
                team_name: newTeam,
            })
        });
        return response.json()
    }, 
    addMemberInTeam: async function(userID, teamID) {
        const response = await fetch(`${process.env.VUE_APP_API_URL}/teamMember/${userID}/${teamID}`, {
            method: 'POST',
            mode: 'cors',
            headers: {
                "Content-type": "application/json; charset=UTF-8",
                "Authorization": JSON.parse(localStorage.session).token
            }
        });
        return response.json()
    },

    deleteUserInTeam: async function(userID, teamID) {
        const response = await fetch(`${process.env.VUE_APP_API_URL}/teamMember/${userID, teamID}`, {
        method: 'DELETE',
        mode: 'cors',
        headers: {
            "Content-type": "application/json; charset=UTF-8",
            "Authorization": JSON.parse(localStorage.session).token
        }
        });
        return response.json()
    }, 

    

}

