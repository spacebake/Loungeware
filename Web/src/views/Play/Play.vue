<template>
  <div class="text-center">
    <!-- <GamePlayer /> -->
    <iframe
      src="/game.html"
      style="width: 540px; height: 540px; margin-top: 40px"
    />
  </div>
</template>

<script lang="ts">
import { Component, Vue } from 'vue-property-decorator';
import GamePlayer from '@/components/GamePlayer.vue';
@Component({
  components: { GamePlayer },
})
export default class Play extends Vue {}
</script>

<style scoped></style>
