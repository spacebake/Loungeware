<template>
  <div class="container full-width">
    <div class="row center-xs">
      <div class="col-xs-12">
        <h2>
          <larold-img name="ghost larold" class="mr-1" />
          <router-link :to="{ name: 'browse' }">All Games</router-link>
          / by
          <strong> {{ $route.params.authorSlug }} </strong>
        </h2>
        <GameCollection :games="games" />
      </div>
    </div>
  </div>
</template>

<script lang="ts">
import LaroldImg from '@/components/LaroldImg.vue';
import GameCollection from './components/GameColletion.vue';
import { Component, Vue } from 'vue-property-decorator';
import * as common from '@/common/gamesList';

@Component({
  components: {
    LaroldImg,
    GameCollection,
  },
})
export default class Browse extends Vue {
  private get games() {
    return common.games.filter(
      (i) => i.name.indexOf(this.$route.params.authorSlug) == 0
    );
  }
}
</script>
