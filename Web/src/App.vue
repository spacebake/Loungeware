<template>
  <div class="app full-height">
    <AppHeader />
    <router-view class="flex-grow" />
    <AppFooter />
    <!-- </div> -->
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
::-webkit-scrollbar {
  width: 20px;
}

::-webkit-scrollbar-track {
  background: darken(#1a1721, 3);
}

::-webkit-scrollbar-thumb {
  background: lighten(#1a1721, 20);
}

::-webkit-scrollbar-thumb:hover {
  background: lighten(#1a1721, 30);
}

.app {
  display: flex;
  flex-direction: column;
  flex-shrink: 0;
  flex-grow: 1;
  overflow-y: scroll;
}
</style>
