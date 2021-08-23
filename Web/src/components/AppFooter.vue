<template>
  <footer>
    <div class="footer-background-container">
      <div class="footer-fade" />
      <div class="footer-moon" />
      <div class="footer-bg footer-bg-1" />
      <div class="footer-bg footer-bg-3" />
      <div class="footer-bg footer-bg-2" />
      <div class="footer-bg footer-bg-4" />
    </div>
    <div class="container">
      <div class="row center-xs mb-2">
        <div class="col-xs-12 col-sm-4">
          <div class="humble-brag">
            <div class="big">{{ numGames }}</div>
            <div class="small">Games</div>
          </div>
        </div>
        <div class="col-xs-12 col-sm-4">
          <div class="humble-brag">
            <div class="big">{{ numContributors }}</div>
            <div class="small">Contributors</div>
          </div>
        </div>
        <div class="col-xs-12 col-sm-4">
          <div class="humble-brag">
            <div class="big">
              <img src="/static/footer/gms2logo.png" />
            </div>
            <div class="small">GMS2</div>
          </div>
        </div>
      </div>
    </div>

    <div class="container links">
      <div class="row center-xs">
        <div class="col-xs-12 col-sm-4">
          <router-link :to="navItems.about.to" class="d-block">
            {{ navItems.about.label }}
          </router-link>
          <a class="d-block" :href="navItems.discord.to">
            {{ navItems.discord.label }}
          </a>
          <a class="d-block" :href="navItems.github.to">
            {{ navItems.github.label }}
          </a>
          <a class="d-block" :href="navItems.wiki.to">
            {{ navItems.wiki.label }}
          </a>
          <a class="d-block" :href="navItems.wikiLarold.to">
            {{ navItems.wikiLarold.label }}
          </a>
        </div>
        <div class="col-xs-12 col-sm-8">
          <div class="shoutout">
            <img
              class="img-pixel"
              src="/static/images/heart.png"
              alt="A picture of a heart wearing sunglasses"
            />
            <p>
              Special thanks to our contributor
              <strong>{{ contributorName }}</strong>
              for
              <strong>{{ gameName }}</strong>
            </p>
          </div>
          <div v-if="pageVisits" class="mt-1 text-right">
            You are visitor {{ pageVisits.visits }}
          </div>
        </div>
      </div>
    </div>

    <div class="container bottom mt-2">
      <div class="row center-xs">
        <div class="col text-center">
          Made with Vue & Firebase By
          <a :href="navItems.gmDiscord.to">{{ navItems.gmDiscord.label }}</a>

          <div>
            <a :href="navItems.githubWeb.to">{{ navItems.githubWeb.label }}</a>
          </div>
        </div>
      </div>
    </div>
  </footer>
</template>

<script lang="ts">
import { Component, Vue } from 'vue-property-decorator';
import { RouteName, getLinkPath } from '../router';
import { numGames, numContributors } from '../common/gamesList';
import gql from 'graphql-tag';
import * as schema from '@/gql/schema';

//https://stackoverflow.com/questions/2450954/how-to-randomize-shuffle-a-javascript-array
function shuffle(array: any[]) {
  var currentIndex = array.length,
    randomIndex;

  // While there remain elements to shuffle...
  while (currentIndex != 0) {
    // Pick a remaining element...
    randomIndex = Math.floor(Math.random() * currentIndex);
    currentIndex--;

    // And swap it with the current element.
    [array[currentIndex], array[randomIndex]] = [
      array[randomIndex],
      array[currentIndex],
    ];
  }

  return array;
}

@Component({
  apollo: {
    pageVisits: {
      fetchPolicy: 'no-cache',
      query: gql`
        query AppFooter_pageVisits($route: String!) {
          pageVisits(route: $route) {
            id
            route
            visits
          }
        }
      `,
      skip() {
        return !this.$route?.name;
      },
      variables() {
        return {
          route: this.$route.name,
        };
      },
    },
  },
})
export default class AppFooter extends Vue {
  private contributorName = '';
  private gameName = '';

  private numGames = numGames;
  private numContributors = numContributors;

  private pageVisits?: schema.PageVisit;

  private items = [
    ['@net8floz', 'making Admin Sim'],
    ['@katsaii', 'making Witch Wanda'],
    ['@zandy', 'making music'],
    ['@meseta', 'making music'],
    ['@nahoo', 'fixing Beenade'],
  ];

  private navItems = {
    about: {
      to: {
        name: 'about' as RouteName,
      },
      label: 'About',
    },
    github: {
      to: getLinkPath('github'),
      label: 'Fork On Github',
    },
    githubWeb: {
      to: getLinkPath('github-web'),
      label: 'View the source',
    },
    discord: {
      to: getLinkPath('discord'),
      label: 'Join Our Discord',
    },
    wiki: {
      to: getLinkPath('wiki'),
      label: 'Read The Wiki',
    },
    wikiLarold: {
      to: getLinkPath('wiki-larold'),
      label: 'Draw A Larold',
    },
    gmDiscord: {
      to: getLinkPath('gm-discord'),
      label: 'GameMaker Discord',
    },
  };

  private index = 0;
  private timeout: any = undefined;

  private mounted() {
    this.nextItem();
  }

  private beforeDestroy() {
    if (this.timeout) {
      clearTimeout(this.timeout);
    }
    this.timeout = undefined;
  }

  private nextItem() {
    this.index += 1;
    if (this.index >= this.items.length) {
      this.index = 0;
      this.items = shuffle(this.items);
    }
    this.contributorName = this.items[this.index][0];
    this.gameName = this.items[this.index][1];

    this.timeout = setTimeout(() => {
      this.nextItem();
    }, 7000);
  }
}
</script>

<style scoped lang="scss">
$footer-height: 490px;
$footer-mobile-height: 960px;

footer {
  position: relative;
  margin-top: 200px;
  z-index: 0;

  max-height: $footer-height;
  min-height: $footer-height;
  flex-grow: 0;
  flex-shrink: 0;

  .links {
    a {
      padding: 4px;
      font-weight: bold;
      text-decoration: none;
    }
  }

  .bottom {
    padding: 18px;
    font-size: 0.8rem;
  }

  .shoutout {
    border: dotted 3px #c8554e;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.6);
    display: flex;
    position: relative;

    img {
      padding-top: 32px;
      padding-left: 24px;
      padding-right: 12px;
      width: 64px;
      height: 64px;
    }

    p {
      padding-top: 24px;
    }
  }

  > .container {
    z-index: 2;
    position: relative;
    width: 100%;

    $humble-brag-size: 140px;
    .humble-brag {
      text-align: center;
      background-color: #1a1721;
      height: $humble-brag-size;
      border-radius: 100%;
      width: $humble-brag-size;
      margin: auto;
      position: relative;

      &:before {
        content: '';
        text-align: center;
        background-color: #c8554e;
        height: $humble-brag-size + 10;
        border-radius: 100%;
        width: $humble-brag-size + 10;
        margin: auto;
        position: absolute;
        top: -5px;
        left: -5px;
        z-index: -1;
      }

      .big {
        text-align: center;
        padding-top: 1.4rem;
        font-size: 4rem;
        font-family: 'Dosis', sans-serif;
        font-weight: bold;
        color: darken(#c8554e, 10);
        line-height: 4rem;

        > img {
          width: 64px;
          height: 64px;
        }
      }
      .small {
        font-size: 1.2rem;
        text-align: center;
        font-family: 'Dosis', sans-serif;
        font-weight: bold;
      }
    }
  }

  > .footer-background-container {
    position: absolute;
    height: 300px;
    width: 100%;
    bottom: 0;
    z-index: 0;

    > .footer-fade {
      width: 100%;
      height: 240px;
      position: absolute;
      top: -200px;
      left: 0;
      background-image: linear-gradient(#1a1721, #332d3d);
      z-index: 0;
      //   display: none;
    }

    > .footer-moon {
      background-image: url('/footer/footer-moon.png');
      background-repeat: no-repeat;
      width: 100px;
      height: 100px;
      position: absolute;
      z-index: 100;
      left: 100px;
      top: -40px;
      image-rendering: pixelated;
      image-rendering: -moz-crisp-edges;
      image-rendering: crisp-edges;
    }

    > .footer-bg {
      background-size: 400px;
      background-repeat: repeat-x;
      background-position-y: bottom;
      width: 100%;
      height: 100%;
      position: absolute;
      top: 0;
      left: 0;
      image-rendering: pixelated;
      image-rendering: -moz-crisp-edges;
      image-rendering: crisp-edges;

      &.footer-bg-1 {
        background-image: url('/static/footer/footer-bg-1.png');
        background-position-x: 200px;
      }
      &.footer-bg-2 {
        background-image: url('/staticfooter/footer-bg-2.png');
        background-position-x: 300px;
      }
      &.footer-bg-3 {
        background-image: url('/static/footer/footer-bg-3.png');
        background-position-x: 400px;
      }
      &.footer-bg-4 {
        background-image: url('/static/footer/footer-bg-4.png');
        background-position-x: 500px;
      }
    }
  }
}

@media only screen and (max-width: 665px) {
  footer {
    min-height: $footer-mobile-height;
    max-height: $footer-mobile-height;
  }
}
</style>
