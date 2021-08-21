import Vue from 'vue';
import _Vue from 'vue';

import firebase from 'firebase/app';

import 'firebase/auth';
import 'firebase/firestore';

import app from '@/plugins/app';

type FBState = {
  fb?: firebase.app.App;
  auth?: firebase.auth.Auth;
};

const fbState: FBState = {};

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
          return `${app.oAuthLoginUrl}?destination=${app.oAuthLoginCallbackUrl}`;
        },
      },
    });

    try {
      const fbCreds = app.fbConfig;
      if (fbCreds) {
        fbState.fb = firebase.initializeApp(JSON.parse(fbCreds));
        if (fbState.fb) {
          fbState.auth = fbState.fb.auth();
        }
      }
    } catch (err) {
      console.error(err);
    }

    this.isInitialized = false;
    if (fbState.auth) {
      fbState.auth.onAuthStateChanged(() => {
        this.isLoggedIn = fbState?.auth?.currentUser !== null;
        this.isInitialized = true;
      });
    }
  }

  public async getToken(): Promise<string> {
    return fbState?.auth?.currentUser?.getIdToken() || '';
  }

  public async logout(): Promise<void> {
    if (fbState?.auth) {
      await fbState.auth.signOut();
    }
  }

  public async handleCallback(state: string): Promise<boolean> {
    if (fbState?.auth) {
      try {
        const { token } = JSON.parse(atob(state)) as { token: string };
        await fbState?.auth.signInWithCustomToken(token);
        return true;
      } catch (err) {
        return false;
      }
    }
    return false;
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
