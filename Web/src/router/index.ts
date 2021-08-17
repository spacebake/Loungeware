import Vue from 'vue';
import VueRouter, { RouteConfig } from 'vue-router';

Vue.use(VueRouter);

export type RouteName = 'home';

export type RouteData = {
  name: RouteName;
};

export function routeName(name: RouteName): string {
  return name;
}
const routes: Array<RouteConfig> = [
  {
    path: '/',
    name: routeName('home'),
    component: () =>
      import(/* webpackChunkName: "main" */ '../views/Home/Home.vue'),
  },
];

const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes,
});

export default router;
