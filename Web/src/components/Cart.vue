<template>
  <div :style="`width: ${width}px; height:${height}px`" class="cart">
    <canvas
      :style="`width: ${width}px; height:${height}px`"
      ref="primaryCanvas"
    />
    <canvas
      :style="`width: ${width}px; height:${height}px`"
      ref="secondaryCanvas"
    />
    <div
      :style="`
        width: ${labelWidth}px; 
        height: ${labelHeight}px; 
        background-image: url('${label}');
        top: ${labelY}px;
        left: ${labelX}px;
    `"
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
    return 13 * (this.size || 1);
  }

  private get labelY() {
    return 62 * (this.size || 1);
  }

  private mounted() {
    if (this.primaryCanvas) {
      const ctx = this.primaryCanvas.getContext('2d');

      this.primaryCanvas.width = this.width;
      this.primaryCanvas.height = this.height;
      const primaryImage = new Image(this.width, this.height);
      primaryImage.src = '/static/images/cart/cart-primary.png';

      primaryImage.addEventListener('load', () => {
        if (ctx) {
          ctx.drawImage(primaryImage, 0, 0, this.width, this.height);

          ctx.fillStyle = this.primaryColor;
          ctx.globalCompositeOperation = 'multiply';
          ctx.fillRect(
            0,
            0,
            this.primaryCanvas.width,
            this.primaryCanvas.height
          );

          ctx.globalCompositeOperation = 'destination-in';
          ctx.drawImage(primaryImage, 0, 0, this.width, this.height);
        }
      });
    }

    if (this.secondaryCanvas) {
      const ctx = this.secondaryCanvas.getContext('2d');

      this.secondaryCanvas.width = this.width;
      this.secondaryCanvas.height = this.height;
      const secondaryImage = new Image(this.width, this.height);
      secondaryImage.src = '/static/images/cart/cart-secondary.png';

      secondaryImage.addEventListener('load', () => {
        if (ctx) {
          ctx.drawImage(secondaryImage, 0, 0, this.width, this.height);

          ctx.fillStyle = this.secondaryColor;
          ctx.globalCompositeOperation = 'multiply';
          ctx.fillRect(
            0,
            0,
            this.secondaryCanvas.width,
            this.secondaryCanvas.height
          );

          ctx.globalCompositeOperation = 'destination-in';
          ctx.drawImage(secondaryImage, 0, 0, this.width, this.height);
        }
      });
    }
  }
}
</script>

<style scoped lang="scss">
.cart {
  position: relative;
  //   border-radius: 5px;
  //   background-color: red;
  > canvas {
    top: 0;
    left: 0;
    position: absolute;
    image-rendering: -moz-crisp-edges;
    image-rendering: -webkit-crisp-edges;
    image-rendering: pixelated;
    image-rendering: crisp-edges;
  }

  > div {
    position: relative;
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
