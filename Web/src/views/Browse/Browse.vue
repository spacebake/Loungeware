<template>
  <div class="container full-width">
    <div class="row center-xs">
      <div class="col-xs-12">
        <h2><larold-img name="ghost larold" class="mr-1" /> All Games</h2>
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
  metaInfo: {
    title: 'Browse All Games',
  },
})
export default class Browse extends Vue {
  private get games() {
    return common.games;
  }
}
</script>
