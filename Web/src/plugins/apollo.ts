import Vue from 'vue';
import VueApollo from 'vue-apollo';
import ApolloClient from 'apollo-boost';
import auth from '@/plugins/auth';
import app from '@/plugins/app';

const apolloClient = new ApolloClient({
  uri: app.gqlUrl,
  request: async (operation) => {
    operation.setContext({
      headers: {
        Authorization: await auth.getToken(),
      },
    });
  },
});

Vue.use(VueApollo);

export default new VueApollo({
  defaultClient: apolloClient,
});
