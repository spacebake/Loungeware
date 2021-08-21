import Vue from 'vue';
import VueApollo from 'vue-apollo';
import ApolloClient from 'apollo-boost';
import auth from '@/plugins/auth';

const apolloClient = new ApolloClient({
  uri: process.env.VUE_APP_GRAPHQL_ENDPOINT,
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
