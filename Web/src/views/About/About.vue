<template>
  <div class="container">
    <div class="row center-xs">
      <div class="col-xs-12">
        <h2>Welcome To Loungeware</h2>
        <p>
          Loungeware is a collection of microgames in the style of Warioware
          that is made by volunteers all over the world in
          <strong>GameMaker Studio 2</strong>. Anyone can play for free or
          submit their own game. Checkout the video below or
          <router-link :to="{ name: 'play' }">
            play it now in your browser!
          </router-link>
        </p>
      </div>
    </div>
    <div class="row center-xs">
      <video height="400px" controls width="100%" poster="/video-preview.png">
        <source src="/lw-2nd-pass.mp4" type="video/mp4" />

        Sorry, your browser doesn't support embedded videos.
      </video>
    </div>

    <div class="row center-xs">
      <div class="col-xs-12">
        <h2>How To Play</h2>
        <p>
          Lorem ipsum dolor sit amet, consectetur adipisicing elit. Perspiciatis
          ad perferendis corrupti animi blanditiis repudiandae placeat, maxime
          molestias architecto, similique quaerat, consequatur laborum
          laboriosam eveniet unde in eligendi optio. Explicabo.
        </p>

        <div class="text-center">
          <router-link
            :to="{ name: 'play' }"
            class="btn btn-lg red solid mb-2 mt-2"
          >
            Play Now In HTML5
          </router-link>
        </div>
      </div>
    </div>

    <div class="border" />

    <div class="row center-xs">
      <div class="col-xs-12">
        <h2>Get Involved With A Vibrant Community</h2>
        <p>
          Lorem ipsum dolor sit amet, consectetur adipisicing elit. Perspiciatis
          ad perferendis corrupti animi blanditiis repudiandae placeat, maxime
          molestias architecto, similique quaerat, consequatur laborum
          laboriosam eveniet unde in eligendi optio. Explicabo.
        </p>

        <div class="text-center">
          <router-link
            :to="navItems.discord.to"
            class="btn btn-lg discord solid mb-2 mt-2"
          >
            {{ navItems.discord.label }}
          </router-link>
        </div>
      </div>
    </div>

    <div class="border" />

    <div class="row center-xs">
      <div class="col-xs-12">
        <h2>How To Contribute</h2>
        <p>
          Lorem ipsum dolor sit amet, consectetur adipisicing elit. Perspiciatis
          ad perferendis corrupti animi blanditiis repudiandae placeat, maxime
          molestias architecto, similique quaerat, consequatur laborum
          laboriosam eveniet unde in eligendi optio. Explicabo.
        </p>

        <div class="text-center">
          <router-link
            :to="navItems.github.to"
            class="btn btn-lg github solid mb-2 mt-2"
          >
            {{ navItems.github.label }}
          </router-link>
        </div>
      </div>
    </div>
  </div>
</template>

<script lang="ts">
import { Component, Vue } from 'vue-property-decorator';
import { RouteName, getLinkPath } from '@/router';

@Component
export default class About extends Vue {
  private navItems = {
    play: {
      to: {
        name: 'play' as RouteName,
      },
      label: 'play',
    },
    github: {
      to: getLinkPath('github'),
      label: 'Fork On Github',
    },
    discord: {
      to: getLinkPath('discord'),
      label: 'Join Our Discord',
    },
  };
}
</script>

<style scoped></style>
