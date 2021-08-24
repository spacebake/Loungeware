import { App } from '@/plugins/app';
import { Auth } from '@/plugins/auth';

declare module 'vue/types/vue' {
  // 3. Declare augmentation for Vue
  interface Vue {
    $app: App;
    $auth: Auth;
  }
}
