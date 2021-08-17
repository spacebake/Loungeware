<template>
  <div>
    <div class="gm4html5_div_class d-flex justify-center" id="gm4html5_div_id">
      <!-- Create the canvas element the game draws to -->
      <canvas id="canvas" width="640" height="360">
        <p>Your browser doesn't support HTML5 canvas.</p>
      </canvas>
    </div>
  </div>
</template>

<script lang="ts">
import { Component, Vue } from 'vue-property-decorator';
import { routeName } from '../../router';
// import * as LoungewareJs from '@/assets/Game/html5game/Loungeware';
@Component
export default class ManualLogin extends Vue {
  private async mounted() {
    // const lw = await require(/* webpackChunkName: "game" */ '@/assets/Loungeware.js');
    // console.log(lw);
    // var init = (window as any).GameMaker_Init;
    // init();
    var range = Math.random() * 10000000;
    let externalScript = document.createElement('script');
    externalScript.setAttribute('src', '/html5game/Loungeware.js?lol=' + range);
    document.head.appendChild(externalScript);

    let didInit = false;
    while (didInit == false) {
      await new Promise((r) => {
        setTimeout(() => {
          if ((window as any).GameMaker_Init) {
            didInit = true;
            (window as any).GameMaker_Init();
          }
          r(0);
        }, 100);
      });
    }

    // window.GameMaker_Init();
  }

  // private async mounted(): Promise<void> {
  //   const email = prompt('Give me email');
  //   const password = prompt('Give me password');
  //   if (!email || !password) {
  //     alert('You suck');
  //     return this.mounted();
  //   }
  //   try {
  //     await this.$auth.loginWithEmailPassword(email, password);
  //   } catch (err) {
  //     alert(`${err}`);
  //   }
  //   this.$router.push(routeName('home'));
  //   return;
  // }
}
</script>

<style scoped>
#canvas {
  background-color: white;
}
</style>
