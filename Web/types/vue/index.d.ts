import { App } from '@/plugins/app';

declare module 'vue/types/vue' {
  // 3. Declare augmentation for Vue
  interface Vue {
    $app: App;
  }
}
