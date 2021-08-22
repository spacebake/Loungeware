<template>
  <div class="game-previews">
    <router-link
      class="game-preview"
      :style="`background-image: url('/games/${game.name}.png')`"
      v-for="(game, i) in games"
      :key="i"
      :to="getRoute(game.name)"
    >
      <div class="text">
        {{ game.config.game_name }} by {{ game.config.creator_name }}
      </div>
    </router-link>
  </div>
</template>

<script lang="ts">
import LaroldImg from '@/components/LaroldImg.vue';
import { Component, Prop, Vue } from 'vue-property-decorator';
import { routeName } from '@/router';

@Component({
  components: {
    LaroldImg,
  },
})
export default class Browse extends Vue {
  @Prop(Array) games!: [];

  private getRoute(gameSlug: string) {
    return {
      name: routeName('game-page'),
      params: {
        gameSlug: gameSlug.replaceAll('_', '-').replaceAll(' ', '-'),
      },
    };
  }
}
</script>

<style lang="scss" scoped>
.game-previews {
  display: flex;
  flex-wrap: wrap;
  justify-content: space-around;
  align-content: space-around;
  align-self: center;
  max-width: 720px;
  margin: auto;
}

.game-preview {
  width: 152px;
  height: 72px;
  border: solid 2px #322c3f;
  margin-bottom: 32px;
  margin-left: 2px;
  margin-right: 2px;
  background-size: contain;
  background-repeat: no-repeat;
  position: relative;
  transition: all 0.5s;
  image-rendering: pixelated;
  image-rendering: -moz-crisp-edges;
  image-rendering: crisp-edges;
  z-index: 2;

  // &:after {
  //   position: absolute;
  //   content: '';
  //   width: 100%;
  //   height: 100%;
  //   background-color: rgba(0, 0, 0, 0.2);
  //   z-index: 2;
  //   transition: all 0.5s;
  // }

  &:hover {
    transform: scale(2);
    z-index: 4;
    &:after {
      opacity: 0;
    }
  }

  .text {
    background-color: rgba(0, 0, 0, 0.3);
    position: absolute;
    top: 60px;
    opacity: 0;
    width: 100%;
    text-align: center;
    transition: opacity 0.5s;
    transform: scale(0.5);
    z-index: 5;
    pointer-events: none;
    padding: 16px;
    margin-left: -16px;
  }

  &:hover {
    .text {
      opacity: 1;
      background-color: rgba(0, 0, 0, 0.8);
    }
  }
}
</style>
