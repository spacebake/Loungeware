<template>
  <div class="larold">
    <div
      v-tooltip.bottom="{ content: alt, offset: 40 }"
      v-bind="$props"
      :style="`background-image: url('${src}');`"
    />
  </div>
</template>

<script lang="ts">
import { Component, Prop, Vue } from 'vue-property-decorator';

type Larold = {
  name: string;
  path: string;
  author: string;
};

@Component
export default class LaroldImg extends Vue {
  @Prop(String) name?: string;

  private larolds: Larold[] = [
    {
      name: 'rad larold',
      path: '/static/hand-picked-larolds/rad-larold.png',
      author: '@katsaii',
    },
    {
      name: 'headphone larold',
      path: '/static/hand-picked-larolds/headphone-larold.png',
      author: '@baku',
    },
    {
      name: 'artist larold',
      path: '/static/hand-picked-larolds/artist-larold.png',
      author: '@baku',
    },
    {
      name: 'helicopter larold',
      path: '/static/hand-picked-larolds/helicopter-larold.png',
      author: '@baku',
    },
    {
      name: 'ghost larold',
      path: '/static/hand-picked-larolds/ghost-larold.png',
      author: '@baku',
    },
    {
      name: 'awesome larold',
      path: '/static/hand-picked-larolds/awesome-larold.png',
      author: '@nahoo',
    },
    {
      name: 'bunny larold',
      path: '/static/hand-picked-larolds/bunny-larold.png',
      author: 'unknown',
    },
    {
      name: 'frog larold',
      path: '/static/hand-picked-larolds/frog-larold.png',
      author: '@frog',
    },
  ];

  private get alt() {
    if (!this.larold) {
      return '';
    }
    return this.larold
      ? `${this.larold.name} by ${this.larold.author}`
      : 'beewut';
  }

  private get src() {
    return this.larold?.path || '';
  }

  private get larold() {
    const index = this.larolds.findIndex((i) => i.name == this.safeName);
    if (index < 0) {
      return undefined;
    }
    return this.larolds[index];
  }

  private get safeName() {
    return this.name || 'rad larold';
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
  z-index: 2;
  top: 12px;
  margin-right: 2px;

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
    position: relative;
    // top: 12px;
  }
}
</style>
