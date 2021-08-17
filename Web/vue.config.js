module.exports = {
  lintOnSave: false,
  transpileDependencies: ['vuetify'],
  chainWebpack: (config) => {
    // GraphQL Loader
    config.module
      .rule('graphql')
      .test(/\.(graphql|gql)$/)
      .use('graphql-tag/loader')
      .loader('graphql-tag/loader')
      .end();
  },
  // devServer: {
  //   proxy: {
  //     '^/html5game': {
  //       target: '/Games/html5game',
  //       ws: false,
  //       changeOrigin: false
  //     },
  //   }
  // }
};
