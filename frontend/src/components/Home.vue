<script setup>
  import { RouterLink } from 'vue-router'
</script>

<template >
  <div class="menu-title-container">
    <div class="greeting-card">
      <h1 class="menu-title">Welcome {{this.$store.state.userConnected.username}} !</h1>
    </div>
  </div>
  <div class="card-menu-container">
    <div class="card-menu">
      <h2 class="card-menu-title">Working times</h2>
      <p class="card-menu-description">View and manage your working times</p>
      <div class="card-menu-icon">
        <svg viewBox="0 0 24 24">
          <path d="m12 1.25a10.75 10.75 0 1 0 10.75 10.75 10.762 10.762 0 0 0 -10.75-10.75zm-6.25 10.75a.75.75 0 0 1 -1.5 0 7.759 7.759 0 0 1 7.75-7.75 7.651 7.651 0 0 1 2.991.6.75.75 0 1 1 -.582 1.382 6.174 6.174 0 0 0 -2.409-.482 6.257 6.257 0 0 0 -6.25 6.25zm11.86-4.564-4.247 5.945a1.5 1.5 0 1 1 -1.363-.881c.048 0 .093.01.14.014l4.25-5.95a.75.75 0 1 1 1.22.872zm1.39 5.314a.75.75 0 0 1 -.75-.75 5.909 5.909 0 0 0 -.2-1.556.75.75 0 1 1 1.449-.388 7.486 7.486 0 0 1 .251 1.944.75.75 0 0 1 -.75.75z"/>
        </svg>
      </div>
      <RouterLink :to="'/working_times/' + this.$store.state.userConnected.id">
        <button class="card-menu-button">Go to</button>
      </RouterLink>
    </div>

    <div class="card-menu">
      <h2 class="card-menu-title">Dashboard</h2>
      <p class="card-menu-description">Visualize your working times with charts and graphs</p>
      <div class="card-menu-icon">
        <svg viewBox="0 0 512 512">
          <g>
            <g>
              <path d="M256,0C114.844,0,0,114.844,0,256s114.844,256,256,256s256-114.844,256-256S397.156,0,256,0z M256,74.667
                c67.635,0,122.667,55.031,122.667,122.667S323.635,320,256,320s-122.667-55.031-122.667-122.667S188.365,74.667,256,74.667z
                M256,469.333c-69.707,0-131.52-33.755-170.473-85.615c42.676-20.534,103.621-42.385,170.473-42.385
                c66.857,0,127.807,21.854,170.474,42.383C387.521,435.577,325.708,469.333,256,469.333z"/>
            </g>
          </g>
        </svg>
      </div>
      <RouterLink :to="'/chart_manager/' + this.$store.state.userConnected.id">
        <button class="card-menu-button">Go to</button>
      </RouterLink>
    </div>

    <div class="card-menu">
      <h2 class="card-menu-title">Profile</h2>
      <p class="card-menu-description">Update your user informations</p>
      <div class="card-menu-icon">
        <svg viewBox="0 0 512 512">
          <g>
            <path d="m256 121.538c-72.642 0-131.74 59.099-131.74 131.741s59.099 131.739 131.74 131.739 131.74-59.098 131.74-131.739c0-72.642-59.098-131.741-131.74-131.741zm67.469 146.74h-82.469v-82.468h30v52.469h52.469z"/>
            <path d="m512 219.617h-52.861l-2.744-11.525c-5.04-21.168-13.394-41.321-24.829-59.902l-6.21-10.091 37.392-37.392-51.455-51.454-37.391 37.392-10.091-6.21c-18.58-11.436-38.734-19.789-59.901-24.829l-11.525-2.744v-52.862h-72.768v52.861l-11.525 2.744c-21.167 5.04-41.321 13.394-59.901 24.829l-10.091 6.21-37.391-37.392-51.454 51.454 37.391 37.392-6.21 10.091c-11.436 18.581-19.79 38.735-24.832 59.903l-2.744 11.525h-52.86v72.766h52.86l2.744 11.525c5.041 21.168 13.396 41.322 24.83 59.902l6.21 10.091-37.391 37.391 51.454 51.454 37.391-37.391 10.091 6.21c18.58 11.436 38.734 19.789 59.901 24.829l11.525 2.744v52.862h72.768v-52.861l11.525-2.744c21.167-5.04 41.321-13.394 59.901-24.829l10.091-6.21 37.391 37.392 51.455-51.455-37.392-37.391 6.21-10.091c11.436-18.581 19.789-38.734 24.829-59.902l2.744-11.525h52.863zm-256 195.402c-89.184 0-161.74-72.556-161.74-161.739 0-89.185 72.557-161.741 161.74-161.741s161.74 72.557 161.74 161.741c0 89.183-72.556 161.739-161.74 161.739z"/>
          </g>
        </svg>
      </div>
      <RouterLink :to="'/users/' + this.$store.state.userConnected.id">
        <button class="card-menu-button">Go to</button>
      </RouterLink>
    </div>
    </div>
</template>
  
<script>
</script>

<style scoped lang="scss">
  .menu-title-container {
    display: flex;
    justify-content: center;
    align-items: center;
    width: 100%;
    height: 20%;
    margin-bottom: 2.5%;
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
  .card-menu-container {
    width: 100%;
    height: 45%;
    display: flex;
    justify-content: space-evenly;
    align-items: center;
    .card-menu {
      width: 220px;
      height: 270px;
      display: flex;
      flex-direction: column;
      justify-content: center;
      align-items: center;
      background-color: var(--bg-4);
      box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
      text-align: center;
      border-radius: 15px;
      .card-menu-title {
        font-size: 18px;
        font-weight: 400;
        margin-top: 0px;
        margin-bottom: 15px;
        color: var(--color-2);
      }
      .card-menu-description {
        margin-bottom: 12px;
        color: var(--color-2);
        padding: 5px;
        font-size: 12px;
      }
      .card-menu-icon {
        margin-top: 5px;
        margin-bottom: 20px;
        svg {
          width: 36px;
          fill: var(--color-2);
        }
      }
      .card-menu-button {
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
          &:hover {
            filter: brightness(1.25);
            cursor: pointer;
          }
      }
    }
  }
</style>
  