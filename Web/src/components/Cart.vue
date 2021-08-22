<template>
  <div class="cart">
    <canvas ref="primaryCanvas" />
    <canvas ref="secondaryCanvas" />
    <div :style="`background-image: url('${label}');`" />
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
  @Ref('primaryCanvas') private primaryCanvas!: HTMLCanvasElement;
  @Ref('secondaryCanvas') private secondaryCanvas!: HTMLCanvasElement;

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
    return `/games/${this.name}.png`;
  }

  private mounted() {
    if (this.primaryCanvas) {
      const ctx = this.primaryCanvas.getContext('2d');

      this.primaryCanvas.width = 174;
      this.primaryCanvas.height = 152;
      const primaryImage = new Image();
      primaryImage.src = '/images/cart/cart-primary.png';

      primaryImage.addEventListener('load', () => {
        if (ctx) {
          ctx.drawImage(primaryImage, 0, 0);

          ctx.fillStyle = this.primaryColor;
          ctx.globalCompositeOperation = 'multiply';
          ctx.fillRect(
            0,
            0,
            this.primaryCanvas.width,
            this.primaryCanvas.height
          );

          ctx.globalCompositeOperation = 'destination-in';
          ctx.drawImage(primaryImage, 0, 0);
        }
      });
    }

    if (this.secondaryCanvas) {
      const ctx = this.secondaryCanvas.getContext('2d');

      this.secondaryCanvas.width = 174;
      this.secondaryCanvas.height = 152;
      const secondaryImage = new Image();
      secondaryImage.src = '/images/cart/cart-secondary.png';

      secondaryImage.addEventListener('load', () => {
        if (ctx) {
          ctx.drawImage(secondaryImage, 0, 0);

          ctx.fillStyle = this.secondaryColor;
          ctx.globalCompositeOperation = 'multiply';
          ctx.fillRect(
            0,
            0,
            this.secondaryCanvas.width,
            this.secondaryCanvas.height
          );

          ctx.globalCompositeOperation = 'destination-in';
          ctx.drawImage(secondaryImage, 0, 0);
        }
      });
    }
  }
}
</script>

<style scoped lang="scss">
.cart {
  width: 174px;
  height: 152px;
  position: relative;
  //   border-radius: 5px;
  //   background-color: red;
  > canvas {
    width: 174px !important;
    height: 152px !important;
    top: 0;
    left: 0;
    position: absolute;
    image-rendering: -moz-crisp-edges;
    image-rendering: -webkit-crisp-edges;
    image-rendering: pixelated;
    image-rendering: crisp-edges;
  }

  > div {
    width: 152px;
    height: 72px;
    top: 62px;
    left: 13px;
    position: relative;
    z-index: 1;
    image-rendering: -moz-crisp-edges;
    image-rendering: -webkit-crisp-edges;
    image-rendering: pixelated;
    image-rendering: crisp-edges;
  }
}
</style>
