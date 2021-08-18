<template>
  <div class="app full-height">
    <AppHeader />
    <div class="scroll-box">
      <router-view class="full-height" />
    </div>
    <AppFooter />
  </div>
</template>

<script lang="ts">
import { Component, Vue } from 'vue-property-decorator';
import AppHeader from '@/components/AppHeader.vue';
import AppFooter from '@/components/AppFooter.vue';

@Component({
  components: { AppHeader, AppFooter },
})
export default class App extends Vue {}
</script>

<style lang="scss" scoped>
/* width */
::-webkit-scrollbar {
  width: 20px;
}

/* Track */
::-webkit-scrollbar-track {
  background: darken(#1a1721, 3);
}

/* Handle */
::-webkit-scrollbar-thumb {
  background: lighten(#1a1721, 20);
}

/* Handle on hover */
::-webkit-scrollbar-thumb:hover {
  background: lighten(#1a1721, 30);
}

.scroll-box {
  flex-grow: 1;
  flex-shrink: 1;
  scrollbar-color: dark;
  margin: 20px;
  overflow-y: scroll;
  z-index: 1;
}
</style>
