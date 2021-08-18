<template>
  <footer>
    <div class="footer-fade" />
    <div class="footer-moon" />
    <div class="footer-bg footer-bg-1" />
    <div class="footer-bg footer-bg-3" />
    <div class="footer-bg footer-bg-2" />
    <div class="footer-bg footer-bg-4" />
    <div class="container">
      <div class="row center-xs full-height">
        <div class="col col-xs-3">
          <div class="humble-brag">
            <div class="big">19</div>
            <div class="small">Games</div>
          </div>
        </div>
        <div class="col col-xs-3">
          <div class="humble-brag">
            <div class="big">15</div>
            <div class="small">Contributors</div>
          </div>
        </div>
        <div class="col col-xs-3">
          <div class="humble-brag">
            <div class="big">
              <img src="/footer/gms2logo.png" />
            </div>
            <div class="small">
              <!-- Made In <br /> -->
              GMS2
            </div>
          </div>
        </div>
      </div>
    </div>
  </footer>
</template>

<script lang="ts">
import { Component, Vue } from 'vue-property-decorator';

@Component
export default class AppFooter extends Vue {}
</script>

<style scoped lang="scss">
footer {
  position: relative;
  z-index: 0;

  $footer-height: 220px;

  // flex-grow: 1;
  height: $footer-height;
  max-height: $footer-height;
  min-height: $footer-height;
  flex-grow: 0;
  flex-shrink: 0;

  > .container {
    z-index: 2;
    position: relative;
    width: 100%;
    height: 100%;
    top: 0px;
    left: 0;

    $humble-brag-size: 180px;
    .humble-brag {
      text-align: center;
      background-color: rgba(40, 40, 50, 0.8);
      height: $humble-brag-size;
      border-radius: 100%;
      width: $humble-brag-size;
      margin: auto;
      position: relative;

      &:before {
        content: '';
        text-align: center;
        background-color: rgba(0, 0, 0, 0.5);
        height: $humble-brag-size;
        border-radius: 100%;
        width: $humble-brag-size;
        margin: auto;
        position: absolute;
        top: 2px;
        left: 2px;
        z-index: -1;
      }

      .big {
        text-align: center;
        padding-top: 2rem;
        font-size: 4rem;
        font-family: 'Dosis', sans-serif;
        font-weight: bold;
        color: darken(#c8554e, 20);

        > img {
          width: 80px;
          height: 80px;
        }
      }
      .small {
        font-size: 1.5rem;
        text-align: center;
        font-family: 'Dosis', sans-serif;
        font-weight: bold;
      }
    }
  }

  > .footer-fade {
    width: 100%;
    height: 50px;
    position: absolute;
    top: -40px;
    left: 0;
    background-image: linear-gradient(#1a1721, #332d3d);
    z-index: 2;
  }

  > .footer-moon {
    background-image: url('/footer/footer-moon.png');
    background-repeat: no-repeat;
    width: 100px;
    height: 100px;
    position: absolute;
    z-index: 100;
    left: 30px;
    top: 5px;
  }

  > .footer-bg {
    background-size: 400px;
    background-repeat: repeat-x;
    background-position-y: bottom;
    width: 100%;
    height: 100%;
    position: absolute;
    top: 0;
    left: 0;

    &.footer-bg-1 {
      background-image: url('/footer/footer-bg-1.png');
      background-position-x: 200px;
    }
    &.footer-bg-2 {
      background-image: url('/footer/footer-bg-2.png');
      background-position-x: 300px;
    }
    &.footer-bg-3 {
      background-image: url('/footer/footer-bg-3.png');
      background-position-x: 400px;
    }
    &.footer-bg-4 {
      background-image: url('/footer/footer-bg-4.png');
      background-position-x: 500px;
    }
  }
}
</style>
