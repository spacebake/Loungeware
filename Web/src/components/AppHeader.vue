<template>
  <div class="app-header container full-width">
    <div class="border" />
    <div class="row center-xs">
      <div class="col-xs-4 text-right">
        <router-link :to="navItems.about.to" :class="getBtnClass('about')">
          {{ navItems.about.label }}
        </router-link>
        <router-link :to="navItems.play.to" :class="getBtnClass('play')">
          {{ navItems.play.label }}
        </router-link>
      </div>
      <div class="col-xs-4 text-center">
        <div class="logo">
          <img src="@/assets/logo.png" />
        </div>
      </div>
      <div class="col-xs-4">
        <a :href="navItems.github.to" target="__blank" class="btn">
          {{ navItems.github.label }}
        </a>
        <a :href="navItems.discord.to" target="__blank" class="btn">
          {{ navItems.discord.label }}
        </a>
      </div>
    </div>
  </div>
</template>

<script lang="ts">
import { Component, Vue } from 'vue-property-decorator';
import { RouteName, getLinkPath } from '../router';

@Component
export default class AppHeader extends Vue {
  private navItems = {
    about: {
      to: {
        name: 'about' as RouteName,
      },
      label: 'about',
    },
    play: {
      to: {
        name: 'play' as RouteName,
      },
      label: 'play',
    },
    github: {
      to: getLinkPath('github'),
      label: 'github',
    },
    discord: {
      to: getLinkPath('discord'),
      label: 'discord',
    },
  };

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
  margin-bottom: -120px;

  $logo-width: 300px;
  $logo-circle-padding: 20px;
  position: relative;

  > .border {
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
