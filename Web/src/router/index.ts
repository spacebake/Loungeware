import Vue from 'vue';
import VueRouter, { RouteConfig } from 'vue-router';
import auth from '@/plugins/auth';

Vue.use(VueRouter);

export type RouteName = 'about' | 'guestbook' | 'play' | 'browse' | 'game-page' | 'logout';

export type LinkName =
  | 'discord'
  | 'github'
  | 'github-web'
  | 'wiki'
  | 'wiki-larold'
  | 'gm-discord';

export function routeName(name: RouteName): string {
  return name;
}

export function getLinkPath(name: LinkName): string {
  switch (name) {
    case 'discord':
      return 'https://discord.gg/cwWns2fdXF';
    case 'github':
      return 'https://github.com/spacebake/loungeware';
    case 'github-web':
      return 'https://github.com/spacebake/Loungeware/tree/html5_bitches/Web';
    case 'wiki':
      return 'https://github.com/spacebake/Loungeware/wiki';
    case 'wiki-larold':
      return 'https://github.com/spacebake/Loungeware/wiki/Draw-A-Larold';
    case 'gm-discord':
      return 'https://discord.gg/gamemaker';
    default:
      return '#';
  }
}

const routes: Array<RouteConfig> = [
  {
    path: '',
    name: routeName('about'),
    component: () =>
      import(/* webpackChunkName: "main" */ '../views/About/About.vue'),
  },
  {
    path: '/guestbook',
    name: routeName('guestbook'),
    component: () =>
      import(
        /* webpackChunkName: "guestbook" */ '../views/Guestbook/Guestbook.vue'
      ),
  },
  {
    path: '/play',
    name: routeName('play'),
    component: () =>
      import(/* webpackChunkName: "game" */ '../views/Play/Play.vue'),
  },
  {
    path: '/browse',
    name: routeName('browse'),
    component: () =>
      import(/* webpackChunkName: "browse" */ '../views/Browse/Browse.vue'),
  },
  {
    path: '/browse/:gameSlug',
    name: routeName('game-page'),
    component: () =>
      import(/* webpackChunkName: "browse" */ '../views/Browse/Game.vue'),
  },
  {
    path: '/logout',
    name: routeName('logout'),
    beforeEnter: async (to, from, next) => {
      try {
        await auth.logout();
        window.location.reload();
      } catch (err) {
        window.location.reload();
      }
    },
  },
  {
    path: '/oauth/login/callback',
    name: 'oauth-login-callback',
    beforeEnter: async (to, from, next) => {
      try {
        await auth.handleCallback(to.query.state as string);
        next({ name: 'home' as RouteName });
        window.location.reload();
      } catch (err) {
        next({ name: 'home' as RouteName });
        window.location.reload();
      }
    },
  },
  {
    path: '*',
    component: () =>
      import(/* webpackChunkName: "errors" */ '../views/Errors/Error404.vue'),
  },
];

const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes,
});

export default router;
