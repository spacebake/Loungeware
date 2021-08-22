<template>
  <div class="text-center">
    <div class="title">404</div>
    <p>This page was not found</p>
  </div>
</template>

<script lang="ts">
import { Component, Vue } from 'vue-property-decorator';

@Component({
  metaInfo: {
    title: 'Page Nout Found',
  },
})
export default class Home extends Vue {}
</script>

<style scoped></style>
