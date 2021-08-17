<template>
  <v-app>
    <v-main>
      <div class="d-flex flex-column main-container">
        <router-view style="height: 100%" />
      </div>
    </v-main>
  </v-app>
</template>

<script lang="ts">
import { Component, Vue } from 'vue-property-decorator';

@Component({
  components: {},
})
export default class App extends Vue {}
</script>
