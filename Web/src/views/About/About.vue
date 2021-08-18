<template>
  <div>
    <div class="container" v-for="i in 3" :key="i">
      <div class="row center-xs">
        <div class="col-xs-12">
          <h2>Welcome To Loungeware</h2>
          <p>
            Lorem ipsum dolor sit amet, consectetur adipisicing elit.
            Perspiciatis ad perferendis corrupti animi blanditiis repudiandae
            placeat, maxime molestias architecto, similique quaerat, consequatur
            laborum laboriosam eveniet unde in eligendi optio. Explicabo.
          </p>
        </div>
      </div>
      <div class="row center-xs">
        <div class="col-xs-12 col-md-4">
          <h2>Welcome To Loungeware</h2>
          <p>
            Lorem ipsum dolor sit amet, consectetur adipisicing elit.
            Perspiciatis ad perferendis corrupti animi blanditiis repudiandae
            placeat, maxime molestias architecto, similique quaerat, consequatur
            laborum laboriosam eveniet unde in eligendi optio. Explicabo.
          </p>
        </div>
        <div class="col-xs-12 col-md-4">
          <h2>Welcome To Loungeware</h2>
          <p>
            Lorem ipsum dolor sit amet, consectetur adipisicing elit.
            Perspiciatis ad perferendis corrupti animi blanditiis repudiandae
            placeat, maxime molestias architecto, similique quaerat, consequatur
            laborum laboriosam eveniet unde in eligendi optio. Explicabo.
          </p>
        </div>
        <div class="col-xs-12 col-md-4">
          <h2>Welcome To Loungeware</h2>
          <p>
            Lorem ipsum dolor sit amet, consectetur adipisicing elit.
            Perspiciatis ad perferendis corrupti animi blanditiis repudiandae
            placeat, maxime molestias architecto, similique quaerat, consequatur
            laborum laboriosam eveniet unde in eligendi optio. Explicabo.
          </p>
        </div>
      </div>
    </div>
  </div>
</template>

<script lang="ts">
import { Component, Vue } from 'vue-property-decorator';

@Component
export default class About extends Vue {}
</script>

<style scoped></style>
