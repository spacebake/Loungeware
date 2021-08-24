<template>
  <div class="container full-width">
    <div class="row center-xs">
      <div class="col-xs-12">
        <div v-if="!game">Could not find game</div>
        <div v-else>
          <h2>
            <larold-img name="ghost larold" class="mr-1" />
            <router-link :to="{ name: 'browse' }"> All Games </router-link>
            /
            {{ displayName }}
          </h2>
          <img class="cart" :src="cartLabelSrc" />
          <div>{{ displayName }} by {{ authorName }}</div>
          <div v-if="credits.length > 0">
            <div>Featuring</div>
            <div v-for="(item, i) in credits" :key="i">
              {{ item }}
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
  private get game() {
    return common.games.find(
      (i) => i.name.replaceAll('_', '-') == this.$route.params.gameSlug
    );
  }

  private get cartLabelSrc() {
    return this.game ? `/games/${this.game.name}.png` : '';
  }

  private get displayName() {
    return this.game?.config?.game_name || '';
  }

  private get authorName() {
    return this.game?.config?.creator_name || '';
  }

  private get credits() {
    const credits = this.game?.config.credits || [];
    const index = credits.findIndex((i) => i == this.authorName);
    if (index >= 0) {
      credits.splice(index, 1);
    }
    return credits;
  }
}
</script>

<style lang="scss" scoped>
.cart {
  width: 300px;
  height: 155px;
}
</style>
