<template>
  <div class="game-previews">
    <router-link
      v-for="(game, i) in games"
      :key="i"
      :to="getRoute(game.author_slug, game.game_slug)"
    >
      <Cart class="cart-item" :name="game.name" />
    </router-link>
  </div>
</template>

<script lang="ts">
import LaroldImg from '@/components/LaroldImg.vue';
import Cart from '@/components/Cart.vue';
import { Component, Prop, Vue } from 'vue-property-decorator';
import { routeName } from '@/router';

@Component({
  components: {
    LaroldImg,
    Cart,
  },
})
export default class Browse extends Vue {
  @Prop(Array) games!: [];

  private getRoute(authorSlug: string, gameSlug: string) {
    return {
      name: routeName('game-page'),
      params: {
        author: authorSlug,
        game: gameSlug,
      },
    };
  }
}
</script>

<style lang="scss" scoped>
.game-previews {
  display: flex;
  flex-wrap: wrap;
  justify-content: center;
  // justify-content: space-around;
  // align-content: space-around;
  align-self: center;
  margin: auto;
}

.cart-item {
  margin: 32px;

  transition: transform 0.5s;

  &:hover {
    transform: scale(2);
    z-index: 4;
    &:after {
      opacity: 0;
    }
  }
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

  // background-image: url('/images/cart/cart-primary.png') !important;

  //background-color: red;

  width: 174px;
  height: 152px;

  // &:before {
  // content: '';
  // background-color: blue;
  opacity: 1;
  width: 174px;
  height: 152px;
  // position: absolute;

  background-image: linear-gradient(
      rgba(255, 0, 0, 0.45),
      rgba(255, 0, 0, 0.45)
    ),
    url('/images/cart/cart-primary.png') !important;
  // background-blend-mode: darken;
  // background-color: blue;

  // }

  &:after {
    opacity: 1;
    width: 174px;
    height: 152px;
    position: absolute;
    content: '';
    // background-image: url('/images/cart/cart-secondary.png') !important;
    // background-blend-mode: luminosity;
    // background-color: red;
  }

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
