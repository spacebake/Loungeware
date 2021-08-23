<template>
  <div class="container full-width">
    <div class="row center-xs">
      <div class="col-xs-12">
        <h2>
          <larold-img name="ghost larold" class="mr-1" />
          <router-link :to="{ name: 'browse' }">All Games</router-link>
          /
          <strong> {{ authorName }} </strong>
        </h2>
        <GameCollection viewType="list" :games="games" />
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
  metaInfo() {
    return {
      title: (this as any).authorName,
    };
  },
})
export default class Browse extends Vue {
  private get games() {
    return common.games.filter(
      (i) => i.author_slug == this.$route.params.author
    );
  }

  private get authorName() {
    return this.games.length > 0
      ? this.games[0].config.creator_name
      : 'no author';
  }
}
</script>
