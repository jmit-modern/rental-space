export default {
  ssr: true,
  /*
   ** Nuxt target
   ** See https://nuxtjs.org/api/configuration-target
   */
  target: 'server',
  head: {
    title: 'Rental Himitsukichi',
    htmlAttrs: {
      lang: 'ja',
    },
    meta: [
      { charset: 'utf-8' },
      { name: 'viewport', content: 'width=device-width, initial-scale=1' },
      {
        hid: 'description',
        name: 'description',
        content: 'Rental Himitsukichi',
      },
    ],
    script: [{ src: 'https://js.stripe.com/v3' }],
    link: [{ rel: 'icon', type: 'image/x-icon', href: '/favicon.ico' }],
  },
  /*
   ** Auto import components
   ** See https://nuxtjs.org/api/configuration-components
   */
  components: true,
  plugins: [
    '@/plugins/api',
    '@/plugins/axios',
    '@/plugins/loading',
    '@/plugins/cache',
    { src: '~/plugins/infiniteloading', ssr: false },
    { src: '~plugins/vue-quill-editor.js', ssr: false },
    { src: '@/plugins/vee-validate', ssr: true },
    { src: '@/plugins/countdown-timer', ssr: false },
    { src: '@/plugins/google-map', ssr: false },
  ],
  css: [
    '@/assets/css/main.css',
    'quill/dist/quill.snow.css',
    'quill/dist/quill.bubble.css',
    'quill/dist/quill.core.css',
  ],
  auth: {
    strategies: {
      local: {
        endpoints: {
          login: {
            url: '/auth/login',
            method: 'post',
            propertyName: 'jwt',
          },
          user: {
            url: '/auth/me',
            method: 'get',
            propertyName: false,
          },
          logout: {
            url: '/auth/logout',
            method: 'post',
          },
        },
      },
    },
    redirect: {
      login: '/login',
      logout: '/',
      callback: '/mypage',
      home: '/',
    },
    watchLoggedIn: true,
  },
  watchers: {
    webpack: {
      poll: true,
    },
  },
  /*
   ** Build configuration
   ** See https://nuxtjs.org/api/configuration-build/
   */
  build: {
    /*
     ** You can extend webpack config here
     */
    extend(config, { isDev, isClient }) {
      if (!isDev) {
        // config.output.publicPath = './nuxt/'
      }
      // リリース前にはコメントアウトする
      //   config.devtool = 'source-map'
    },
    transpile: ['vee-validate/dist/rules', /^vue2-google-maps($|\/)/],
  },
  buildModules: [
    '@nuxtjs/tailwindcss',
    // Doc: https://github.com/nuxt-community/eslint-module
    '@nuxtjs/eslint-module',
    // Doc: https://github.com/nuxt-community/stylelint-module
    '@nuxtjs/stylelint-module',
    // Doc: https://github.com/whardier/nuxt-hero-icons
    '@nuxt-hero-icons/solid/nuxt',
    '@nuxt-hero-icons/outline/nuxt',
  ],
  modules: [
    '@nuxtjs/axios',
    '@nuxtjs/proxy',
    '@nuxtjs/auth',
    '@nuxt/http',
    '@nuxtjs/dayjs',
    [
      'nuxt-vuex-localstorage',
      {
        // mode: 'cookie',
        expireHours: 24,
      },
    ],
    [
      'nuxt-i18n',
      {
        locales: [
          {
            name: '日本語',
            code: 'jp',
            iso: 'ja',
            file: 'ja.js',
          },
          {
            name: 'English',
            code: 'en',
            iso: 'en',
            file: 'en.js',
          },
          {
            name: '简体中文',
            code: 'zh',
            iso: 'zh',
            file: 'zh.js',
          },
        ],
        langDir: 'lang/',
        defaultLocale: 'jp',
        parsePages: false, // Disable acorn parsing
        pages: {
          // about: {
          //   it: '/chi-siamo', // -> mydomain.com/chi-siamo
          //   en: '/about', // -> mydomain.com/en/about
          // },
        },
      },
    ],
    // [
    //   'nuxt-stripe-module',
    //   {
    //     publishableKey: 'pk_test_96VdHv5Gjl38b6EEGfzpx8uU008PQXpGNp',
    //   },
    // ],
  ],
  axios: {
    baseURL: 'http://localhost:3000/api/v1/front',
  },
  tailwindcss: {
    cssPath: '~/assets/css/tailwind.css',
    configPath: 'tailwind.config.js',
    exposeConfig: false,
    viewer: false,
    config: {},
  },
  dayjs: {
    locales: ['ja'],
    defaultLocale: 'ja',
    defaultTimeZone: 'Asia/Tokyo',
    plugins: [
      'utc', // import 'dayjs/plugin/utc'
      'timezone', // import 'dayjs/plugin/timezone'
    ], // Your Day.js plugin
  },
  extractCSS: true,
  env: {
    baseUrl: process.env.BASE_URL,
    apiUrl: process.env.API_URL,
    apiUrlBrowser: process.env.API_URL_BROWSER,
    stripeKey: process.env.STRIPE_PUBLIC_KEY,
  },
  server: {
    port: process.env.PORT, // デフォルト: 3000
    host: '0.0.0.0', // デフォルト: localhost
  },
}
