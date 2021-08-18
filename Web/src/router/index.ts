import Vue from 'vue';
import VueRouter, { RouteConfig } from 'vue-router';

Vue.use(VueRouter);

export type RouteName = 'about' | 'play';

export function routeName(name: RouteName): string {
  return name;
}
const routes: Array<RouteConfig> = [
  {
    path: '/',
    name: routeName('about'),
    component: () =>
      import(/* webpackChunkName: "main" */ '../views/About/About.vue'),
  },
  {
    path: '/play',
    name: routeName('play'),
    component: () =>
      import(/* webpackChunkName: "main" */ '../views/Play/Play.vue'),
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
