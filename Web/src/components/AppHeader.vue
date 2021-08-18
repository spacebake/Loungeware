<template>
  <div class="app-header container full-width">
    <div class="border" />
    <div class="row center-xs">
      <div class="col-xs-4 text-right">
        <router-link :to="getRoute('about')" :class="getBtnClass('about')">
          About
        </router-link>
        <router-link :to="getRoute('play')" :class="getBtnClass('play')">
          Play
        </router-link>
      </div>
      <div class="col-xs-4 text-center">
        <div class="logo">
          <img src="@/assets/logo.png" />
        </div>
      </div>
      <div class="col-xs-4">
        <a href="#" class="btn">Github</a>
        <a href="#" class="btn">Discord</a>
      </div>
    </div>
  </div>
</template>

<script lang="ts">
import { Component, Vue } from 'vue-property-decorator';
import { RouteName } from '../router';

@Component
export default class AppHeader extends Vue {
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
  margin-top: 80px;
  margin-bottom: -140px;

  $logo-width: 300px;
  $logo-circle-padding: 20px;
  position: relative;

  > .border {
    width: 100%;
    height: 3px;
    background-color: #3f3031;
    position: absolute;
    top: 60px;
    z-index: 0;
  }

  & .logo {
    width: 100%;
    position: relative;
    top: -50%;
    > img {
      position: relative;
      width: 100%;
      margin-top: 30px;
    }
    &:before {
      content: '';
      position: absolute;
      background-color: red;
      width: 100%;
      height: 100%;
      border-radius: 30%;
      background-color: #1a1721;
    }
  }

  .btn {
    flex: 0 0 auto;
    position: relative;
    line-height: 1.3rem;
    vertical-align: middle;
    display: inline-block;
    padding-left: 16px;
    padding-right: 16px;
    margin-left: 2px;
    margin-right: 2px;
    transform: scale(1);

    &:not(.active) {
      color: #c8554e;
      &:hover {
        transform: scale(1.1);
      }
    }
    &.active {
      transform: scale(1.1);
    }
  }
}
</style>
