<template>
  <div class="app full-height">
    <AppHeader />
    <router-view class="flex-grow" />
    <AppFooter />
  </div>
</template>

<script lang="ts">
import { Component, Vue } from 'vue-property-decorator';
import AppHeader from '@/components/AppHeader.vue';
import AppFooter from '@/components/AppFooter.vue';
import gql from 'graphql-tag';

@Component({
  components: { AppHeader, AppFooter },
  metaInfo: {
    titleTemplate: '%s  |  Loungeware',
  },
  apollo: {
    clientVersion: {
      query: gql`
        query App_clientVersion {
          clientVersion
        }
      `,
    },
  },
})
export default class App extends Vue {
  clientVersion = -1;
}
</script>

<style lang="scss" scoped>
@media only screen and (min-width: 666px) {
  // @TODO can be done for FireFox too?
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
}

.app {
  display: flex;
  flex-direction: column;
  flex-shrink: 0;
  flex-grow: 1;
  overflow-y: scroll;
  overflow-x: hidden;
}
</style>
