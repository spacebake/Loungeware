<template>
  <div class="container">
    <div class="row center-xs">
      <div class="col-xs-12">
        <h2><larold-img name="ghost larold" class="mr-1" /> All Games</h2>
        <div class="game-previews">
          <div
            class="game-preview"
            :style="`background-image: url('/games/${game.name}.png')`"
            v-for="(game, i) in things"
            :key="i"
          >
            <div class="text">
              {{ game.config.game_name }} by {{ game.config.creator_name }}
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script lang="ts">
import LaroldImg from '@/components/LaroldImg.vue';
import { Component, Vue } from 'vue-property-decorator';
// import { RouteName, getLinkPath } from '@/router';
import * as common from '@/common/gamesList';

@Component({
  components: {
    LaroldImg,
  },
})
export default class Browse extends Vue {
  private get things() {
    return common.games;
  }
}
</script>

<style lang="scss" scoped>
.game-previews {
  display: flex;
  flex-wrap: wrap;
  justify-content: space-between;
  align-content: space-between;
  align-self: center;
}

.game-preview {
  width: 250px;
  height: 118px;
  border: solid 2px #322c3f;
  margin-bottom: 32px;
  background-size: contain;
  background-repeat: no-repeat;
  position: relative;
  transition: all 0.5s;

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
    &:after {
      opacity: 0;
    }
  }

  .text {
    background-color: rgba(0, 0, 0, 0.3);
    position: absolute;
    bottom: 0;
    opacity: 0;
    width: 100%;
    text-align: center;
    transition: opacity 0.5s;
  }

  &:hover {
    .text {
      opacity: 1;
      background-color: rgba(0, 0, 0, 0.8);
    }
  }
}
</style>
