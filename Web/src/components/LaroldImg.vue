<template>
  <div class="larold">
    <div
      v-tooltip.bottom="{ content: name, offset: 40 }"
      v-bind="$props"
      :style="`background-image: url('${src}');`"
    />
  </div>
</template>

<script lang="ts">
import { Component, Vue } from 'vue-property-decorator';

@Component
export default class AppHeader extends Vue {
  private get alt() {
    return 'larold';
  }

  private get src() {
    return '/larolds/rad-larold.png';
  }

  private get name() {
    return 'rad larold';
  }
}
</script>

<style scoped lang="scss">
div.larold {
  $size: 50px;
  width: $size;
  height: $size;
  position: relative;
  transition: all 0.5s;
  display: inline-block;

  &:before {
    width: $size * 1.3;
    height: $size * 1.3;
    content: '';
    top: -19%;
    left: -20%;
    position: absolute;
    border-radius: 50%;
    background-color: #1a1721;
  }

  &:hover {
    transform: scale(2);
    cursor: zoom-in;
  }

  > div {
    width: 50px;
    height: 50px;
    background-size: cover;
    position: relative;
    z-index: 1;
  }
}
</style>
