import Vue from 'vue';
import _Vue from 'vue';

import firebase from 'firebase/app';

import 'firebase/auth';
import 'firebase/firestore';

const fb = firebase
  .initializeApp(JSON.parse(process.env.VUE_APP_FIREBASE_CONFIG as string))
  .auth();

export type AuthEvents = 'change' | 'login' | 'logout';

export class AuthService extends Vue {
  private isLoggedIn = false;
  private isInitialized = false;

  constructor() {
    super({
      data: {
        isLoggedIn: false,
        isInitialized: false,
      },
      computed: {
        oAuthLoginUrl() {
          return `${process.env.VUE_APP_OAUTH_LOGIN_URL}?destination=${process.env.VUE_APP_OAUTH_LOGIN_CALLBACK_URL}`;
        },
      },
    });

    this.isInitialized = false;
    fb.onAuthStateChanged(() => {
      this.isLoggedIn = fb.currentUser !== null;
      this.isInitialized = true;
    });
  }

  public async getToken(): Promise<string> {
    return fb?.currentUser?.getIdToken() || '';
  }

  public async logout(): Promise<void> {
    await fb.signOut();
  }

  public async handleCallback(state: string): Promise<boolean> {
    try {
      const { token } = JSON.parse(atob(state)) as { token: string };
      await fb.signInWithCustomToken(token);
      return true;
    } catch (err) {
      return false;
    }
  }
}

const auth = new AuthService();
export default auth;

export function AuthPlugin<AuthPluginOptions>(
  Vue: typeof _Vue,
  options?: AuthPluginOptions
): void {
  Vue.prototype.$auth = auth;
}

export class AuthPluginOptions {}

Vue.use(AuthPlugin);
