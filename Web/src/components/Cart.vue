<template>
  <div :style="`width: ${width}px; height:${height}px`" class="cart">
    <svg
      viewBox="0 0 87 76"
      xmlns="http://www.w3.org/2000/svg"
      style="
        fill-rule: evenodd;
        clip-rule: evenodd;
        stroke-linejoin: round;
        stroke-miterlimit: 2;
      "
    >
      <path
        d="M1,76L1,75L0,75L0,2L1,2L1,1L2,1L2,0L85,0L85,1L86,1L86,2L87,2L87,75L86,75L86,76L1,76Z"
        :style="`fill: ${primaryColor}`"
      />
      <path
        d="M10,26L10,25L9,25L9,24L8,24L8,23L7,23L7,22L6,22L6,12L7,12L7,11L8,11L8,10L9,10L9,9L10,9L10,8L78,8L78,9L79,9L79,10L80,10L80,11L81,11L81,12L82,12L82,22L81,22L81,23L80,23L80,24L79,24L79,25L78,25L78,26L10,26Z"
        :style="`fill: ${secondaryColor}`"
      />
      <path
        d="M42,73L43,73L43,74L45,74L45,73L46,73L46,72L47,72L47,71L41,71L41,72L42,72L42,73Z"
        :style="`fill: ${secondaryColor}`"
      />
      <rect
        x="6"
        y="33"
        width="76"
        height="36"
        :style="`fill: ${secondaryColor}; background-image:url('${label}')`"
      />
    </svg>
    <div
      :style="`width: ${labelWidth}px; height: ${labelHeight}px;background-image: url('${label}'); top: ${labelY}px; left: ${labelX}px;`"
    />
  </div>
</template>

<script lang="ts">
import { Component, Prop, Ref, Vue } from 'vue-property-decorator';
import * as common from '../common/gamesList';

// https://campushippo.com/lessons/how-to-convert-rgb-colors-to-hexadecimal-with-javascript-78219fdb
const rgbToHex = function (rgb: number) {
  var hex = Number(rgb).toString(16);
  if (hex.length < 2) {
    hex = '0' + hex;
  }
  return hex;
};

const fullColorHex = function (r: number, g: number, b: number) {
  var red = rgbToHex(r);
  var green = rgbToHex(g);
  var blue = rgbToHex(b);
  return '#' + red + green + blue;
};

const getColor = function (color: string | number[]): string {
  try {
    if (typeof color === 'string') {
      const c = color.substr(2, color.length - 2);
      console.log(c);
      return '#' + c;
    }
    if (Array.isArray(color)) {
      return fullColorHex(color[0], color[1], color[2]);
    }
  } catch (err) {
    //
  }
  return '#ff0ff0';
};

@Component
export default class Cart extends Vue {
  @Prop(String) name?: string;
  @Prop(Number) size?: number;

  private get game() {
    return common.games.find((i) => i.name == this.name);
  }

  private get primaryColor() {
    return getColor(this.game?.config.cartridge_col_primary || '#ff0000');
  }

  private get secondaryColor() {
    return getColor(this.game?.config.cartridge_col_secondary || '#ff0000');
  }

  private get label() {
    return `/static/games/${this.name}.png`;
  }

  private get width() {
    return 174 * (this.size || 1);
  }

  private get height() {
    return 152 * (this.size || 1);
  }

  private get labelWidth() {
    return 152 * (this.size || 1);
  }

  private get labelHeight() {
    return 72 * (this.size || 1);
  }

  private get labelX() {
    return 12 * (this.size || 1);
  }

  private get labelY() {
    return 66 * (this.size || 1);
  }
}
</script>

<style scoped lang="scss">
.cart {
  position: relative;

  > div {
    position: absolute;
    z-index: 1;
    image-rendering: -moz-crisp-edges;
    image-rendering: -webkit-crisp-edges;
    image-rendering: pixelated;
    image-rendering: crisp-edges;
    background-repeat: no-repeat;
    background-size: cover;
  }
}
</style>
