import Vue from 'vue';
import _Vue from 'vue';

export class App extends Vue {
  public get version(): string {
    return (process.env.VUE_APP_VERSION as string) || '0.0.0';
  }

  public get gqlUrl() {
    return (
      (process.env.VUE_APP_GRAPHQL_URL as string) ||
      'https://loungeware-95658.uc.r.appspot.com/graphql'
    );
  }

  public get oAuthLoginUrl() {
    return (
      (process.env.VUE_APP_OAUTH_LOGIN_URL as string) ||
      'https://loungeware-95658.uc.r.appspot.com/oauth/login'
    );
  }

  public get oAuthLoginCallbackUrl() {
    return (
      (process.env.VUE_APP_OAUTH_LOGIN_CALLBACK_URL as string) ||
      'https://loungeware.games/oauth/login/callback'
    );
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
