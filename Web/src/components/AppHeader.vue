<template>
  <div class="app-header container full-width">
    <div class="border" />
    <div class="full">
      <div
        class="top"
        v-if="isAuthInitialized && $apollo.queries.me.loading == false"
      >
        <div class="row center-xs">
          <div class="col-xs-6">
            <a
              :href="navItems.discord.to"
              target="__blank"
              v-tooltip="navItems.discord.tooltip"
              class="btn icon"
            >
              <mdicon name="discord" />
            </a>

            <a
              :href="navItems.github.to"
              target="__blank"
              v-tooltip="navItems.github.tooltip"
              class="btn icon"
            >
              <mdicon name="github" />
            </a>
          </div>
          <div class="col-xs-6 text-right">
            <a
              v-if="isLoggedIn"
              @click="logout"
              v-tooltip="'Click to sign out of your account'"
              class="btn account-btn"
            >
              <mdicon name="account" /> {{ username }} | Sign Out
            </a>
            <a
              v-else
              @click="login"
              v-tooltip="'Click to sign in with Discord'"
              class="btn account-btn"
            >
              <mdicon name="discord" /> Sign In
            </a>
          </div>
        </div>
      </div>
      <div class="row full-width center-xs">
        <div class="col-xs-4 text-right">
          <router-link
            v-tooltip.bottom="navItems.play.tooltip"
            active-class="active solid"
            :to="navItems.play.to"
            class="btn"
          >
            {{ navItems.play.label }}
          </router-link>

          <router-link
            v-tooltip.bottom="navItems.browse.tooltip"
            active-class="active solid"
            :to="navItems.browse.to"
            class="btn"
          >
            {{ navItems.browse.label }}
          </router-link>
        </div>
        <div class="col-xs-4 text-center">
          <router-link :to="navItems.about.to">
            <div class="logo">
              <img v-tooltip="navItems.about.tooltip" src="@/assets/logo.png" />
            </div>
          </router-link>
        </div>
        <div class="col-xs-4">
          <router-link
            v-tooltip.bottom="navItems.guestbook.tooltip"
            active-class="active solid"
            :to="navItems.guestbook.to"
            class="btn"
          >
            {{ navItems.guestbook.label }}
          </router-link>

          <!-- <a
            v-tooltip.bottom="navItems.github.tooltip"
            :href="navItems.github.to"
            target="__blank"
            class="btn"
          >
            {{ navItems.github.label }}
          </a>
          <a
            v-tooltip.bottom="navItems.discord.tooltip"
            :href="navItems.discord.to"
            target="__blank"
            class="btn"
          >
            {{ navItems.discord.label }}
          </a> -->
        </div>
      </div>
    </div>
    <div class="mobile">
      <router-link :to="navItems.about.to" class="logo">
        <img src="@/assets/logo.png" />
      </router-link>
    </div>
  </div>
</template>

<script lang="ts">
import gql from 'graphql-tag';
import { Component, Vue } from 'vue-property-decorator';
import { RouteName, getLinkPath } from '../router';
import * as schema from '@/gql/schema';

@Component({
  apollo: {
    me: {
      skip: function () {
        return this.isLoggedIn == false || this.isAuthInitialized == false;
      },
      query: gql`
        query AppHeader_me {
          me {
            id
            displayName
            profilePictureUrl
            roles {
              colorHex
              displayName
              id
            }
          }
        }
      `,
    },
  },
})
export default class AppHeader extends Vue {
  private me?: schema.User;

  private navItems = {
    about: {
      to: {
        name: 'about' as RouteName,
      },
      tooltip: {
        offset: 20,
        content: 'Click to learn more',
      },
      label: 'about',
    },
    browse: {
      to: {
        name: 'browse' as RouteName,
      },
      tooltip: 'Browse all Loungeware games',
      label: 'browse',
    },
    guestbook: {
      to: {
        name: 'guestbook' as RouteName,
      },
      tooltip: 'Sign our guestbook',
      label: 'Guestbook',
    },
    play: {
      to: {
        name: 'play' as RouteName,
      },
      tooltip: 'Play Loungeware in your browser',
      label: 'play',
    },
    github: {
      to: getLinkPath('github'),
      tooltip: 'Fork Loungeware on Github',
      label: 'github',
    },
    discord: {
      to: getLinkPath('discord'),
      tooltip: 'Join the Loungeware Discord',
      label: 'discord',
    },
  };

  private login() {
    window.location = this.$auth.oAuthLoginUrl;
  }

  private logout() {
    this.$auth.logout();
  }

  private get username() {
    return this?.me?.displayName || 'Unknown';
  }

  private get isLoggedIn() {
    return this.$auth.isLoggedIn;
  }

  private get isAuthInitialized() {
    return this.$auth.isInitialized;
  }
}
</script>

<style scoped lang="scss">
@media only screen and (max-width: 799px) {
  .app-header {
    .logo {
      text-align: center;
      margin: auto;
      display: block;
    }
    .full {
      display: none;
    }
  }
}

@media only screen and (min-width: 800px) {
  .app-header {
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    padding-top: 80px;

    $logo-width: 300px;
    $logo-circle-padding: 20px;
    position: relative;

    .top {
      width: 100%;
      position: absolute;
      top: 0;
      // display: none;
      // text-align: right;
    }

    & .logo {
      // display: none;
      width: 100%;
      position: relative;
      margin-top: -50%;
      // top: -50%;

      > img {
        position: relative;
        width: 100%;
        top: 30px;
      }
      &:before {
        content: '';
        position: absolute;
        background-color: red;
        width: 100%;
        height: 100%;
        border-radius: 30%;
        top: 30px;
        background-color: #1a1721;
      }
    }

    > .border {
      position: absolute;
      top: 140px;
      z-index: 0;
    }
    .full {
      display: block;
    }
    .mobile {
      display: none;
    }
  }
}

.app-header {
  .logo {
    transition: all 0.5s;
    &:hover {
      transform: scale(1.1);
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

    &.account-btn {
      font-size: 0.8em;
      opacity: 0.5;
      &:hover {
        opacity: 1;
      }
    }
  }
}
</style>
