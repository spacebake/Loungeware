<template>
  <div class="text-center">
    <iframe
      src="/game.html"
      style="width: 540px; height: 540px; margin-top: 80px"
    />
  </div>
</template>

<script lang="ts">
import { Component, Vue } from 'vue-property-decorator';

@Component({})
export default class Play extends Vue {}
</script>

<style scoped lange="scss">
iframe {
  overflow: hidden;
  border: solid 3px rgba(0, 0, 0, 0.3);
}
</style>
