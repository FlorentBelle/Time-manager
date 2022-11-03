<template>
    <div class="dashboard-container">
        <div class="menu-title-container">
            <div class="greeting-card">
            <h1 class="menu-title">Dashboard</h1>
            </div>
        </div>
        <div class="nav-dashboard">
            <router-link :to="{path: `/chart_manager/${userID}`}">
                <button class="app-button">
                    All
                </button>
            </router-link>
            <router-link :to="{path: `/chart_manager/${userID}/bar`}">
                <button class="app-button">
                    Week
                </button>
            </router-link>
            <router-link :to="{path: `/chart_manager/${userID}/line`}">
                <button class="app-button">
                    Year
                </button>
            </router-link>
            <router-link :to="{path: `/chart_manager/${userID}/doughnut`}">
                <button class="app-button">
                    Day
                </button>
            </router-link>
        </div>
        <router-view></router-view>
    </div>
</template>

<script>
export default {
  data: function() {
       return {
            userID: JSON.parse(localStorage.session).id
        }
    }
}
</script>

<style scoped lang="scss">
  .app-button {
    border: none;
    border-radius: 10px;
    padding: 5px;
    background-color: var(--color-1);
    color: var(--color-2);
    margin-top: 10px;
    width: 80px;
    height: 25px;
    font-size: 12px;
    font-weight: 400;
    text-align: center;
    color: white;
    margin-right: 10px;
    &:hover {
    filter: brightness(1.25);
    cursor: pointer;
    }
  }

  .dashboard-container {
    overflow: auto;
    max-height: 100%;
    .menu-title-container {
        display: flex;
        justify-content: center;
        align-items: center;
        width: 100%;
        height: 15%;
        margin-bottom: 0;
        .greeting-card {
        width: 25%;
        display: flex;
        justify-content: center;
        background: rgb(170,111,207);
        background: linear-gradient(90deg, rgba(170,111,207,1) 0%, rgba(28,28,32,0.2861519607843137) 50%);
        padding: 15px;
        border-radius: 15px;
        .menu-title {
            color: var(--color-2);
            margin: 0;
            font-size: 24px;
        }
        }
    }
    .nav-dashboard {
        display: flex;
        justify-content: center;
        align-items: center;
        margin-top: 25px;
        margin-bottom: 25px;
    }
  }
</style>
