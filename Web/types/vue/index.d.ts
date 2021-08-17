import { App } from '@/plugins/app';
import { AuthService } from '../../src/plugins/auth';
import { SocketIO } from '../../src/plugins/io';
declare module 'vue/types/vue' {
  // 3. Declare augmentation for Vue
  interface Vue {
    $auth: AuthService;
  }
}

declare module 'vue/types/vue' {
  // 3. Declare augmentation for Vue
  interface Vue {
    $io: SocketIO;
  }
}

declare module 'vue/types/vue' {
  // 3. Declare augmentation for Vue
  interface Vue {
    $app: App;
  }
}
