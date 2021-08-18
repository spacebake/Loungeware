<template>
  <div class="row center-xs">
    <div class="col-xs-12 col-md-9 col-xl-6">
      <div class="app-header pb-1">
        <div class="logo">
          <img src="@/assets/logo.png" />
        </div>
        <div class="border" />
        <nav class="mt-1">
          <div class="col text-right">
            <router-link :to="getRoute('about')" :class="getBtnClass('about')">
              About
            </router-link>
            <router-link :to="getRoute('play')" :class="getBtnClass('play')">
              Play
            </router-link>
          </div>
          <div class="logo-gap" />
          <div class="col">
            <a href="#" class="btn">Github</a>
            <a href="#" class="btn">Discord</a>
          </div>
        </nav>
      </div>
    </div>
  </div>
</template>

<script lang="ts">
import { Component, Vue } from 'vue-property-decorator';
import { RouteName } from '../router';

@Component
export default class AppHeader extends Vue {
  // private async mounted() {}
  // private async mounted(): Promise<void> {
  //   const email = prompt('Give me email');
  //   const password = prompt('Give me password');
  //   if (!email || !password) {
  //     alert('You suck');
  //     return this.mounted();
  //   }
  //   try {
  //     await this.$auth.loginWithEmailPassword(email, password);
  //   } catch (err) {
  //     alert(`${err}`);
  //   }
  //   this.$router.push(routeName('home'));
  //   return;
  // }

  private getRoute(routeName: RouteName) {
    return {
      name: routeName,
    };
  }

  private getBtnClass(routeName: string) {
    if (this.$route.name == routeName) {
      return 'btn solid active';
    } else {
      return 'btn';
    }
  }
}
</script>

<style scoped lang="scss">
.app-header {
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  margin-top: 90px;
  margin-bottom: 12px;

  $logo-width: 300px;
  $logo-circle-padding: 20px;
  position: relative;

  > .border {
    width: 100%;
    height: 3px;
    background-color: #3f3031;
    position: absolute;
    bottom: 5px;
    z-index: 1;
  }

  & .logo {
    position: absolute;
    top: -90px;
    text-align: center;
    width: $logo-width;

    > img {
      width: $logo-width;
      z-index: 4;
      position: relative;
    }

    &:before {
      content: '';
      position: absolute;
      width: ($logo-width * 1.3) + $logo-circle-padding;
      height: $logo-width + $logo-circle-padding;
      background-color: #1a1721;
      // background-color: red;
      border-radius: 50%;
      top: -60px;
      z-index: 2;
      left: -$logo-circle-padding/2 - 46px;
    }
  }

  & > nav {
    display: flex;
    width: 100%;
    background-color: rgba(0, 0, 0, 0.5);
    justify-content: center;
    align-items: center;
    background: none;

    > .logo-gap {
      width: 420px;
    }

    .btn {
      flex: 0 0 auto;
      position: relative;
      line-height: 2rem;
      vertical-align: middle;
      color: #c8554e;

      &:not(.active) {
        &:hover {
          font-size: 1.5em;
        }
      }
      &.active {
        font-size: 1.5rem;
      }
    }
  }
}
</style>
