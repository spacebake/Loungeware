import Vue from 'vue';
import _Vue from 'vue';

export class App extends Vue {
  public get version(): string {
    return (process.env.VUE_APP_VERSION as string) || '0.0.0';
  }

  public get gqlUrl() {
    return (
      (process.env.VUE_APP_GRAPHQL_URL as string) ||
      'https://loungeware.games/graphql'
    );
  }

  public get oAuthLoginUrl() {
    return (
      (process.env.VUE_APP_OAUTH_LOGIN_URL as string) ||
      'https://loungeware.games/oauth/login'
    );
  }

  public get oAuthLoginCallbackUrl() {
    return (
      (process.env.VUE_APP_OAUTH_LOGIN_CALLBACK_URL as string) ||
      'https://loungeware.games/oauth/login/web/callback'
    );
  }

  public get fbConfig() {
    return atob(
      (process.env.VUE_APP_FIREBASE_CONFIG as string) ||
        'eyJhcGlLZXkiOiAiQUl6YVN5RGx2dnprU1VJdUhmQWRMSzZaQlh1WURvdXVxOEJ4LVh3IiwiYXV0aERvbWFpbiI6ICJsb3VuZ2V3YXJlLTk1NjU4LmZpcmViYXNlYXBwLmNvbSIsInByb2plY3RJZCI6ICJsb3VuZ2V3YXJlLTk1NjU4Iiwic3RvcmFnZUJ1Y2tldCI6ICJsb3VuZ2V3YXJlLTk1NjU4LmFwcHNwb3QuY29tIiwibWVzc2FnaW5nU2VuZGVySWQiOiAiODU5NzI1NzY5NTc4IiwiYXBwSWQiOiAiMTo4NTk3MjU3Njk1Nzg6d2ViOjMzYmQ4Yjk3YzJkY2YxOGUxNDEzMTMifQ=='
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
