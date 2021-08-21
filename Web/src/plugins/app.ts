import Vue from 'vue';
import _Vue from 'vue';

export class App extends Vue {
  public get version(): string {
    return process.env.VUE_APP_VERSION as string;
  }
}

const inst = new App();
export default inst;

export class AppOptions {}

export function AppPlugin<AppOptions>(
  Vue: typeof _Vue,
  options?: AppOptions
): void {
  Vue.prototype.$app = inst;
}

Vue.use(AppPlugin);
