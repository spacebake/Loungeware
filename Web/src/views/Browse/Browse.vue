<template>
  <div class="container">
    <div class="row center-xs">
      <div class="col-xs-12">
        <h2><larold-img class="mr-1" /> How To Play</h2>
        <p>
          Lorem ipsum dolor sit amet, consectetur adipisicing elit. Perspiciatis
          ad perferendis corrupti animi blanditiis repudiandae placeat, maxime
          molestias architecto, similique quaerat, consequatur laborum
          laboriosam eveniet unde in eligendi optio. Explicabo.
        </p>
      </div>
    </div>
  </div>
</template>

<script lang="ts">
import LaroldImg from '@/components/LaroldImg.vue';
import { Component, Vue } from 'vue-property-decorator';
// import { RouteName, getLinkPath } from '@/router';

@Component({
  components: {
    LaroldImg,
  },
})
export default class Browse extends Vue {}
</script>
