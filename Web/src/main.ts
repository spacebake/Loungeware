import Vue from 'vue';
import App from '@/App.vue';
import router from '@/router';
import store from '@/store';
import '@/plugins/v-tooltip';
import '@/plugins/mdi-vue';
import '@/plugins/app';
import '@/plugins/auth';
import '@/scss/main.scss';

Vue.config.productionTip = false;

new Vue({
  router,
  store,
  render: (h) => h(App),
}).$mount('#app');
