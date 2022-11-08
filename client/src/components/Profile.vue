
<template>
    <div class="profile-container">
        <div v-if="user" class="profile-form">
            <div class="profile-picture">
                <span>{{ user && (user.username[0] + user.username[1]).toUpperCase() }}</span>
            </div>
            <div class="profile-field">
                <label for="username" class="">Username</label>
                <input type="text" name="username" id="username" v-model="updatedUser.username" class="mt-1 block w-full rounded-md border border p-2" />
            </div>
            <div class="profile-field">
                <label for="email" class="">Email</label>
                <input type="text" name="email" id="email" v-model="updatedUser.email" class="mt-1 block w-full rounded-md border border p-2" />
            </div>
            <div class="profile-field">
                <label for="role" class="">Role</label>
                <input type="text" name="role" id="role" v-model="user.role_name" class="mt-1 block w-full rounded-md border border p-2" disabled/>
            </div>
            <button class="submit-button" @click="updateUser()">Submit</button>
        </div>
    </div>
</template>

<script>
  export default {
    data() {
      return {
        user: null,
        updatedUser: {
            username: this.user ? this.user.username : null,
            email: this.user ? this.user.email : null
        }
      }
    },
    async created () {
      await this.getUser()
    },
    methods: {
        getUser: async function() {
            const response = await fetch(process.env.VUE_APP_API_URL + "/users/" + this.$route.params.userID,
                {
                    mode: 'cors',
                    headers: {
                        "Content-type": "application/json; charset=UTF-8",
                        "Authorization": JSON.parse(localStorage.session).token
                    }
                }
            )

            const { content: user, success: success, message: message } = await response.json()

            if(success && user) {
                this.user = user
                this.updatedUser.username = user.username
                this.updatedUser.email = user.email
            } else {
                this.$toast.error(response.error, {
                    position: "top-right"
                });
            }
        },
        updateUser: async function() {
            const response = await fetch(process.env.VUE_APP_API_URL + "/users/" + this.$route.params.userID,
                {
                    mode: 'cors',
                    headers: {
                        "Content-type": "application/json; charset=UTF-8",
                        "Authorization": JSON.parse(localStorage.session).token
                    },
                    method: "PUT",
                    body: JSON.stringify({
                        username: this.updatedUser.username,
                        email: this.updatedUser.email
                    }),
                }
            )

            const { success: success, message: message } = await response.json()

            if(success) {
                this.$toast.success(message, {position: "top-right"})
                await this.getUser()
            } else {
                this.$toast.error(message, {position: "top-right"})
            }
        }
    }
}
</script>

<style scoped lang="scss">
    .profile-container {
        display: flex;
        justify-content: center;
        align-items: center;
        margin-top: 10vh;
        .profile-form {
            width: 50%;
            max-width: 500px;
            margin: auto;
            .profile-picture {
                background-color: var(--bg-4);
                width: 125px;
                height: 125px;
                border-radius: 50%;
                margin: auto;
                margin-bottom: 50px;
                color: var(--color-2);
                display: flex;
                justify-content: center;
                align-items: center;
                font-size: 22px;
            }
            .profile-field {
                background-color: var(--bg-4);
                padding: 15px 25px;
                margin-bottom: 50px;
                border-radius: 10px;
                height: 80px;
                label {
                    color: var(--color-2);
                    filter: brightness(75%);
                }
                input {
                    color: var(--color-2);
                    border: none;
                    height: fit-content;
                }
            }
            
            .submit-button {
                border: none;
                border-radius: 10px;
                padding: 7.5px;
                background-color: var(--color-1);
                color: var(--color-2);
                margin: auto;
                width: 120px;
                height: 40px;
                font-size: 16px;
                font-weight: 400;
                text-align: center;
                color: white;
                display: flex;
                align-items: center;
                justify-content: center;
                &:hover {
                    filter: brightness(1.25);
                    cursor: pointer;
                }
            }
    }
}
</style>
